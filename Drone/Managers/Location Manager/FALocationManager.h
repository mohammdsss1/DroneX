//
//  FALocationManager.h
//  AlFardan
//
//  Created by Mohammad Salah on 8/6/15.
//  Copyright (c) 2015 smarteletec Sports. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreLocation/CoreLocation.h>

static const NSUInteger kDistanceFilter = 10;

#define LOCATION_DID_CHANGED_NOTIFICATION @"LOCATION_DID_CHANGED_NOTIFICATION"
#define LOCATION_DID_FAILED_NOTIFICATION @"LOCATION_DID_FAILED_NOTIFICATION"
#define LOCATION_AUTHORIZATION_STATUS_CHANGED_NOTIFICATION @"LOCATION_AUTHORIZATION_STATUS_CHANGED_NOTIFICATION"

typedef enum {
    FALocationManagerGPSSignalStrengthInvalid = 0
    , FALocationManagerGPSSignalStrengthWeak
    , FALocationManagerGPSSignalStrengthStrong
} FALocationManagerGPSSignalStrength;

@class FALocationManager;

@protocol FALocationManagerDelegate <NSObject>

@optional

/*!
 @brief Get called once a new location is found
 @param location the most recent retreived location
 */
-(void)didFindLocation:(CLLocation*)location;

/*!
 @brief Once a new location is found; a check will be done to determine whether if its valid or not (async)
 @param locationInfo location's information
 */
-(void)didCheckLocation:(CLLocation*)locationInfo;

/*!
 @brief When the user turned off the location service this will be triggered
 @param locationManager locationManager shared instance
 */
//-(void)locationManagerDidTurnedOffLocationService:(BELocationManager*)locationManager;

/*!
 @brief When location service encounter any error this will trigger
 @param locationManager locationManager shared instance
 @param error The error returned from Core Location service
 */
-(void)locationManager:(FALocationManager*)locationManager didFailedWithError:(NSError*)error;

@optional
- (void)locationManager:(FALocationManager *)locationManager signalStrengthChanged:(FALocationManagerGPSSignalStrength)signalStrength;
- (void)locationManagerSignalConsistentlyWeak:(FALocationManager *)locationManager;
- (void)locationManager:(FALocationManager *)locationManager distanceUpdated:(CLLocationDistance)distance;
- (void)locationManager:(FALocationManager *)locationManager waypoint:(CLLocation *)waypoint calculatedSpeed:(double)calculatedSpeed;
- (void)locationManager:(FALocationManager *)locationManager error:(NSError *)error;

@end

/*!
 @brief Use this class to retreive current user's location, its singleton
 */
@interface FALocationManager : NSObject

/*! Last recorded location */
@property (nonatomic, readonly) CLLocation *lastRecordedLocation;

@property (nonatomic, weak) id<FALocationManagerDelegate> delegate;
@property (nonatomic, readonly) FALocationManagerGPSSignalStrength signalStrength;
@property (nonatomic, readonly) CLLocationDistance totalDistance; // In KM
@property (nonatomic, readonly) NSTimeInterval totalSeconds;
@property (nonatomic, readonly) double currentSpeed;


+(instancetype)shared;

/*!
 @brief This will fire the location manager to start fetching current user's location, if the permsision is not granted; an alert will show to tell the user to enable the location servive on his device.
 */
-(void)startLocationService;

-(void)stopLocationService;

/*!
 @brief Is locations service disabled for this app
 */
-(BOOL)isLocationDisabled;

/*!
 @brief Prompt the user to enable the location service
 */
-(void)requestLocationAuthorization;

- (BOOL)prepLocationUpdates; // this must be called before startLocationUpdates (best to call it early so we can get an early lock on location)
- (BOOL)startLocationUpdates;
- (void)stopLocationUpdates;
- (void)resetLocationUpdates;

@end
