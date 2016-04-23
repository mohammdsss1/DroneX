//
//  FALocationManager.m
//  AlFardan
//
//  Created by Mohammad Salah on 8/6/15.
//  Copyright (c) 2015 smarteletec Sports. All rights reserved.
//

#import "FALocationManager.h"

#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>

static const NSInteger kTimeStamp = 5;
static const NSInteger kSignificantDistanceChange = 15;//30;

static const NSUInteger kHeadingFilter = 10; // the minimum angular change (degrees) for which we want to receive heading updates (see docs for CLLocationManager.headingFilter)
static const NSUInteger kDistanceAndSpeedCalculationInterval = 3; // the interval (seconds) at which we calculate the user's distance and speed
static const NSUInteger kMinimumLocationUpdateInterval = 20; // the interval (seconds) at which we ping for a new location if we haven't received one yet
static const NSUInteger kNumLocationHistoriesToKeep = 5; // the number of locations to store in history so that we can look back at them and determine which is most accurate
static const NSUInteger kValidLocationHistoryDeltaInterval = 3; // the maximum valid age in seconds of a location stored in the location history
//static const NSUInteger kNumSpeedHistoriesToAverage = 2; // the number of speeds to store in history so that we can average them to get the current speed
//static const NSUInteger kPrioritizeFasterSpeeds = 1; // if > 0, the currentSpeed and complete speed history will automatically be set to to the new speed if the new speed is faster than the averaged speed
static const NSUInteger kMinLocationsNeededToUpdateDistanceAndSpeed = 1; // the number of locations needed in history before we will even update the current distance and speed
static const CGFloat kRequiredHorizontalAccuracy = kDistanceFilter; // the required accuracy in meters for a location.  if we receive anything above this number, the delegate will be informed that the signal is weak
static const CGFloat kMaximumAcceptableHorizontalAccuracy = kDistanceFilter * 1.5f; // the maximum acceptable accuracy in meters for a location.  anything above this number will be completely ignored
static const NSUInteger kGPSRefinementInterval = 15; // the number of seconds at which we will attempt to achieve kRequiredHorizontalAccuracy before giving up and accepting kMaximumAcceptableHorizontalAccuracy

static const CGFloat kSpeedNotSet = -1.0;

@interface FALocationManager () <CLLocationManagerDelegate>

@property (nonatomic) CLLocationManager *locationManager;
@property (nonatomic) CLLocation *lastRecordedLocation;

@property (nonatomic, strong) CLLocation *oldLocation;
@property (nonatomic, strong) NSTimer *locationPingTimer;
@property (nonatomic) FALocationManagerGPSSignalStrength signalStrength;
@property (nonatomic) CLLocationDistance totalDistance;
@property (nonatomic, strong) NSMutableArray *locationHistory;
@property (nonatomic, strong) NSDate *startTimestamp;
@property (nonatomic) double currentSpeed;
@property (nonatomic) NSUInteger lastDistanceAndSpeedCalculation;
@property (nonatomic) BOOL forceDistanceAndSpeedCalculation;
@property (nonatomic) BOOL readyToExposeDistanceAndSpeed;
@property (nonatomic) BOOL checkingSignalStrength;
@property (nonatomic) BOOL allowMaximumAcceptableAccuracy;

- (void)checkSustainedSignalStrength;
- (void)requestNewLocation;

@end

@implementation FALocationManager
{
    __weak FALocationManager *weakSelf;
}

#pragma mark - Init

+(instancetype)shared
{
    static FALocationManager *instance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        instance = [[[self class] alloc] init];
    });
    
    return instance;
}

-(instancetype)init
{
    if(self = [super init])
    {
        _locationManager = [CLLocationManager new];
        _locationManager.delegate = self;
        
//#if DriverApp
        _locationManager.allowsBackgroundLocationUpdates = YES;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
        _locationManager.distanceFilter = kCLDistanceFilterNone;
        _locationManager.headingFilter = kHeadingFilter;
        _locationManager.activityType =  CLActivityTypeAutomotiveNavigation;
        
        self.locationHistory = [NSMutableArray arrayWithCapacity:kNumLocationHistoriesToKeep];
        [self resetLocationUpdates];
//#else
//        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
//        _locationManager.distanceFilter = kDistanceFilter;
//#endif
        
        weakSelf = self;
        
        return self;
    }
    
    return nil;
}

#pragma mark - Methods

-(void)startLocationService
{
//    NSAssert(self.setDelegates.count != 0, @"Delegate is nil, please set your class as delegate");
    
    if([self isLocationDisabled])
    {
        [FAAlert alertWithType:LOCATION_DENIED];
    }
    else
    {
        [self.locationManager requestWhenInUseAuthorization];
        [self.locationManager startUpdatingLocation];
    }
}

-(void)stopLocationService
{
    [self.locationManager stopUpdatingLocation];
}

#pragma mark - CLLocationManager Delegate

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
//    POLog(@"%@", NSStringFromSelector(_cmd));
    if(status == kCLAuthorizationStatusDenied || status == kCLAuthorizationStatusRestricted)
        [FAAlert alertWithType:LOCATION_DENIED];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    if(locations.count == 0) return;
    
    CLLocation *location = [locations lastObject];
    
    if (location.horizontalAccuracy < 0) return;
    
    [self callDelegateForLocation:location];
    
    self.lastRecordedLocation = location;

    [self handleLocationsUpdate:locations];
}

#pragma mark - Delegates Management

-(void)callDelegateForLocation:(CLLocation*)location
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(didFindLocation:)])
        [self.delegate didFindLocation:location];
}

-(void)callDelegateForLocationInfo:(CLLocation *)locationInfo
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(didCheckLocation:)])
        [self.delegate didCheckLocation:locationInfo];
}

#pragma mark - Helpers

-(void)requestLocationAuthorization
{
    [FALocationManager.shared.locationManager requestWhenInUseAuthorization];
}

-(BOOL)isLocationDisabled
{
    return [CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusRestricted;
}

#pragma mark - Region Monitoring

+ (CLLocationDegrees)farestPointFromCoordinates:(NSArray <CLLocation*>*)coordinateArray center:(CLLocationCoordinate2D)center
{
    if(coordinateArray.count == 1)
        return 100;
    
    CLLocationDegrees max = 0;
    CLLocation *centerLocation = [[CLLocation alloc] initWithLatitude:center.latitude longitude:center.longitude];
    
    for(CLLocation *coordinateValue in coordinateArray)
    {
        CLLocationDistance distance = [coordinateValue distanceFromLocation:centerLocation];
        if(distance > max)
            max = distance;
    }
    
    return max;
}

-(void)monitoringRegionWithCoordinates:(NSArray <CLLocation*>*)coordinates andID:(NSString*)ID
{
    if(![CLLocationManager isMonitoringAvailableForClass:[CLCircularRegion class]])
    {
        NSLog(@"monitoringRegionWithCoordinate is not supported");
        return;
    }
    
    CLLocationCoordinate2D center = [[self class] centerCoordinateForCoordinates:coordinates];
    CLLocationDistance distance = [[self class] farestPointFromCoordinates:coordinates center:center];
    
    CLCircularRegion *geoRegion = [[CLCircularRegion alloc] initWithCenter:center radius:distance identifier:ID];
    [self.locationManager startMonitoringForRegion:geoRegion];
}

-(void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region
{
    NSLog(@"didStartMonitoringForRegion %@", region.identifier);
}

-(void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
    NSLog(@"didEnterRegion %@", region.identifier);
}

#pragma mark - Driver

-(BOOL)isSignificantChange:(CLLocation*)location
{
    if(self.lastRecordedLocation == nil) return YES;

    double distance = [self.lastRecordedLocation distanceFromLocation:location];
    
    NSDate *eventDate = location.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    
    BOOL isSignificantChange = distance > kSignificantDistanceChange && fabs(howRecent) < kTimeStamp;
    
    return isSignificantChange;
}

- (void)setTotalDistance:(CLLocationDistance)totalDistance {
    _totalDistance = totalDistance;
    
    if (self.currentSpeed != kSpeedNotSet) {
        if ([self.delegate respondsToSelector:@selector(locationManager:distanceUpdated:)]) {
            [self.delegate locationManager:self distanceUpdated:self.totalDistance];
        }
    }
}

- (void)checkSustainedSignalStrength
{
    if (!self.checkingSignalStrength) {
        self.checkingSignalStrength = YES;
        
        double delayInSeconds = kGPSRefinementInterval;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            self.checkingSignalStrength = NO;
            if (self.signalStrength == FALocationManagerGPSSignalStrengthWeak) {
                self.allowMaximumAcceptableAccuracy = YES;
                if ([self.delegate respondsToSelector:@selector(locationManagerSignalConsistentlyWeak:)]) {
                    [self.delegate locationManagerSignalConsistentlyWeak:self];
                }
            } else if (self.signalStrength == FALocationManagerGPSSignalStrengthInvalid) {
                self.allowMaximumAcceptableAccuracy = YES;
                self.signalStrength = FALocationManagerGPSSignalStrengthWeak;
                if ([self.delegate respondsToSelector:@selector(locationManagerSignalConsistentlyWeak:)]) {
                    [self.delegate locationManagerSignalConsistentlyWeak:self];
                }
            }
        });
    }
}

- (void)requestNewLocation
{
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager stopUpdatingLocation];
    [self.locationManager startUpdatingLocation];
}

- (BOOL)prepLocationUpdates
{
    if ([CLLocationManager locationServicesEnabled])
    {
        [self.locationHistory removeAllObjects];
        self.lastDistanceAndSpeedCalculation = 0;
        self.currentSpeed = 0;//kSpeedNotSet;
        self.readyToExposeDistanceAndSpeed = NO;
        self.signalStrength = FALocationManagerGPSSignalStrengthInvalid;
        self.allowMaximumAcceptableAccuracy = NO;
        
        self.forceDistanceAndSpeedCalculation = YES;
        
        [self checkSustainedSignalStrength];
        
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)startLocationUpdates
{
    if ([CLLocationManager locationServicesEnabled])
    {
        self.readyToExposeDistanceAndSpeed = YES;
        
        return YES;
    } else {
        return NO;
    }
}

- (void)stopLocationUpdates
{
    self.readyToExposeDistanceAndSpeed = NO;
    [self.locationPingTimer invalidate];
    
    /*
    self.lastRecordedLocation = nil;
    */
}

- (void)resetLocationUpdates
{
    self.totalDistance = 0;
    self.startTimestamp = [NSDate dateWithTimeIntervalSinceNow:0];
    self.forceDistanceAndSpeedCalculation = NO;
}

- (void)handleLocationsUpdate:(nonnull NSArray<CLLocation *> *)locations
{
    CLLocation *newLocation = locations.lastObject;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:LOCATION_DID_CHANGED_NOTIFICATION object:newLocation userInfo:@{@"location":newLocation}];
    
    // since the oldLocation might be from some previous use of core location, we need to make sure we're getting data from this run
    if (self.lastRecordedLocation == nil)
    {
        self.lastRecordedLocation = newLocation;
        self.oldLocation = newLocation;
        [self callDelegateForLocation:newLocation];
        
        return;
    }
    
    BOOL isStaleLocation = ([self.oldLocation.timestamp compare:self.startTimestamp] == NSOrderedAscending);
    
    [self.locationPingTimer invalidate];
    
    if (newLocation.horizontalAccuracy <= kRequiredHorizontalAccuracy) {
        self.signalStrength = FALocationManagerGPSSignalStrengthStrong;
    } else {
        self.signalStrength = FALocationManagerGPSSignalStrengthWeak;
    }
    
    double horizontalAccuracy = kMaximumAcceptableHorizontalAccuracy;
    
    if(!isStaleLocation && newLocation.horizontalAccuracy >= 0 && newLocation.horizontalAccuracy <= horizontalAccuracy)
    {
        [self.locationHistory addObject:newLocation];
        if ([self.locationHistory count] > kNumLocationHistoriesToKeep) {
            [self.locationHistory removeObjectAtIndex:0];
        }
        
        BOOL canUpdateDistanceAndSpeed = NO;
        if ([self.locationHistory count] >= kMinLocationsNeededToUpdateDistanceAndSpeed)
            canUpdateDistanceAndSpeed = self.readyToExposeDistanceAndSpeed;
        
        NSTimeInterval now = [NSDate timeIntervalSinceReferenceDate];
        if(self.forceDistanceAndSpeedCalculation || now - self.lastDistanceAndSpeedCalculation > kDistanceAndSpeedCalculationInterval)
        {
            self.forceDistanceAndSpeedCalculation = NO;
            self.lastDistanceAndSpeedCalculation = [NSDate timeIntervalSinceReferenceDate];
            
            CLLocation *lastLocation = (self.lastRecordedLocation != nil) ? self.lastRecordedLocation : self.oldLocation;
            
            CLLocation *bestLocation = nil;
            CGFloat bestAccuracy = kRequiredHorizontalAccuracy;
            for(CLLocation *location in self.locationHistory)
            {
                NSTimeInterval time = [NSDate timeIntervalSinceReferenceDate];
                if (time - [location.timestamp timeIntervalSinceReferenceDate] <= kValidLocationHistoryDeltaInterval) {
                    if (location.horizontalAccuracy <= bestAccuracy && location != lastLocation) {
                        bestAccuracy = location.horizontalAccuracy;
                        bestLocation = location;
                    }
                }
            }
            if (bestLocation == nil) bestLocation = newLocation;
            
            CLLocationDistance distance = [bestLocation distanceFromLocation:lastLocation] / 1000;
            if (canUpdateDistanceAndSpeed)
                self.totalDistance += distance;
            
            BOOL isSignificantChange = [self isSignificantChange:bestLocation];
            if(isSignificantChange)
                [self callDelegateForLocation:bestLocation];
            
            self.lastRecordedLocation = bestLocation;
        }
    }
    
    self.oldLocation = newLocation;
    
    // this will be invalidated above if a new location is received before it fires
    self.locationPingTimer = [NSTimer timerWithTimeInterval:kMinimumLocationUpdateInterval target:self selector:@selector(requestNewLocation) userInfo:nil repeats:NO];
    [[NSRunLoop mainRunLoop] addTimer:self.locationPingTimer forMode:NSRunLoopCommonModes];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading {
    // we don't really care about the new heading.  all we care about is calculating the current distance from the previous distance early if the user changed directions
    self.forceDistanceAndSpeedCalculation = YES;
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    if (error.code == kCLErrorDenied)
    {
        if ([self.delegate respondsToSelector:@selector(locationManager:error:)]) {
            [self.delegate locationManager:self error:error];
        }
        [self stopLocationUpdates];
    }
}

@end
