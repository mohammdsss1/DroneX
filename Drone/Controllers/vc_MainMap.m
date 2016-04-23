//
//  ViewController.m
//  Drone
//
//  Created by Mohammad Salah on 4/19/16.
//  Copyright © 2016 Hammoda. All rights reserved.
//

#import "vc_MainMap.h"

#import "CoordsList.h"
#import "v_DataInfo.h"
#import "v_Notifications.h"
#import "NotificationsDataSource.h"

static CGFloat kOverlayHeight = 140.0f;
static NSInteger kCameraZoom = 12;
static NSArray *arrLocations = nil;

@interface vc_MainMap () 

@property (nonatomic) NSLayoutConstraint *constInfoHeight;
@property (nonatomic) NSLayoutConstraint *constNotifHeight;

//@property (nonatomic) GMSMapView *mapView;
@property (nonatomic, weak) IBOutlet GMSMapView *mapView;
@property (nonatomic, weak) IBOutlet UIButton *btnInfo;
@property (nonatomic, weak) IBOutlet UIButton *btnDownArrow;
@property (nonatomic, strong) IBOutlet v_DataInfo * dataInfo;
@property (nonatomic, strong) IBOutlet v_Notifications *notifications;

@property (nonatomic, assign) NSInteger opendWindo;
@property (nonatomic) NotificationsDataSource *dataSource;

@end

@implementation vc_MainMap

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSource = [[NotificationsDataSource alloc] initWithController:self tableView:self.notifications.tableView notificationView:self.notifications];
    self.opendWindo = 0;
    
    [self setupMap];
    [self setupBottomView:self.dataInfo isInfo:YES];
    [self setupBottomView:self.notifications isInfo:NO];
    [self setupNoFlyZone];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self setupDronMovements];
    });
    
}

#pragma mark - Map Setup

-(void)setupMap
{
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:31.88542
                                                            longitude:35.854301
                                                                 zoom:kCameraZoom];
//    _mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    _mapView.camera = camera;
    
    // Enable my location button to show more UI components updating.
    _mapView.settings.myLocationButton = NO;
    _mapView.myLocationEnabled = NO;
    _mapView.padding = UIEdgeInsetsMake(0, 0, 50, 0);
}

#pragma mark - Views

- (void)animateBottomView:(UIButton*)sender
{
    BOOL isInfo = self.opendWindo == 1;
    
    BOOL hide = [sender isEqual:self.btnDownArrow];
    
//    if(isInfo)
//        self.constInfoHeight.constant = hide? 0 : kOverlayHeight;
//    else
//        self.constNotifHeight.constant = hide ? 0 : kOverlayHeight;
    
    [UIView animateWithDuration:0.3 animations:^{
//        [isInfo ? self.dataInfo : self.notifications layoutIfNeeded];
        if (hide) {
            _mapView.padding = UIEdgeInsetsMake(0, 0, 50, 0);
        } else {
            _mapView.padding = UIEdgeInsetsMake(0, 0, kOverlayHeight, 0);
        }
    }completion:^(BOOL finished) {
        [self.view layoutIfNeeded];
        if(isInfo)
            self.constInfoHeight.constant = hide? 0 : kOverlayHeight;
        else
            self.constNotifHeight.constant = hide ? 0 : kOverlayHeight;
        
        [UIView animateWithDuration:0.3 animations:^{
            [self.view layoutIfNeeded];
        }];
    }];
}

-(void)setupBottomView:(UIView*)view isInfo:(BOOL)isInfo
{
    if(view.superview)return;
    
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view insertSubview:view atIndex:5];
    
    NSString *key = isInfo ? @"viewBottom1" : @"viewBottom2";
    NSDictionary *dicView = @{key : view};
    NSLayoutConstraint *constBottom = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    NSLayoutConstraint *constHeight = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight relatedBy:0 toItem:0 attribute:0 multiplier:1 constant:0];
    
    NSArray *arrH = [NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|-0-[%@]-0-|", key] options:0 metrics:nil views:dicView];
    [self.view addConstraints:@[constBottom, constHeight]];
    [self.view addConstraints:arrH];
    
    if(isInfo)
        self.constInfoHeight = constHeight;
    else
        self.constNotifHeight = constHeight;
}

-(void)showHideButtons:(BOOL)show
{
    [UIView animateWithDuration:0.3 animations:^{
        self.btnNotif.alpha = show;
        self.btnInfo.alpha = show;
        self.btnDownArrow.alpha = !show;
    }];
}

-(void)manageButtonsAndBottomViews:(UIButton*)sender
{
    BOOL showButtons = [sender isEqual:self.btnDownArrow];
    
    UIView *viewToPop = self.opendWindo == 1 ? self.dataInfo : self.notifications;
    
    if(!showButtons)
    {
        [self setupBottomView:viewToPop isInfo:self.opendWindo == 1];
        viewToPop.hidden = NO;
    }
    else
    {
        self.dataInfo.hidden = YES;
        self.notifications.hidden = YES;
    }
        
    [self animateBottomView:sender];
    
//    viewToPop.hidden = !showButtons;
}

#pragma mark - UI Actions

-(IBAction)tapOnOption:(UIButton*)sender
{
    self.opendWindo = sender.tag == 10 ? 1 : 2;
    [self manageButtonsAndBottomViews:sender];
    [self showHideButtons:NO];
}

-(IBAction)tapOnArrow:(UIButton*)sender
{
    self.opendWindo = 0;
    [self manageButtonsAndBottomViews:sender];
    [self showHideButtons:YES];
}

#pragma mark - Notifications

-(void)showNotification:(NSInteger)ID
{
    DRNotification *notif = nil;
    switch (ID) {
        case 0:
            notif = [[DRNotification alloc] init:@"Slow down. You might lose control at such weather conditions."];
            break;
        case 1:
            notif = [[DRNotification alloc] init:@"A sudden strong wind might be pushing your drones to a closer building."];
            break;
        case 2:
            notif = [[DRNotification alloc] init:@"Be careful. No-fly zone is near."];
            break;
        default:
            break;
    }
    
    [self.dataSource addEelemnt:notif];
}

#pragma mark - Drone

- (void)setupDronMovements
{
    GMSMutablePath *coords;
    GMSMarker *marker;
    
    // Create a plane that flies to several airports around western Europe.
    coords = [GMSMutablePath path];
    [coords addLatitude:31.88542 longitude:35.854301];
    [coords addLatitude:31.89299 longitude:35.893139];
    [coords addLatitude:31.95126 longitude:35.81979];
    [coords addLatitude:31.85247 longitude:35.939281];
    [coords addLatitude:31.9167 longitude:35.950001];
    [coords addLatitude:31.955219 longitude:35.94503];
    [coords addLatitude:31.87207 longitude:36.005009];
    [coords addLatitude:32.02581 longitude:35.864578];
    [coords addLatitude:31.98333 longitude:35.98333];
    [coords addLatitude:31.978451 longitude:35.694729];
    marker = [GMSMarker markerWithPosition:[coords coordinateAtIndex:0]];
    marker.icon = [UIImage imageNamed:@"aeroplane"];
    marker.groundAnchor = CGPointMake(0.5f, 0.5f);
    marker.flat = YES;
    marker.map = _mapView;
    marker.userData = [[CoordsList alloc] initWithPath:coords];
    [self animateToNextCoord:marker];
}

- (GMSPath *)pathOfAmman
{
    GMSMutablePath *path = [GMSMutablePath path];
    
    arrLocations = @[[[CLLocation alloc] initWithLatitude:31.923444 longitude:35.822538],
                     [[CLLocation alloc] initWithLatitude:31.921994 longitude:35.829732],
                     [[CLLocation alloc] initWithLatitude:31.923214 longitude:35.837729],
                     [[CLLocation alloc] initWithLatitude:31.916749 longitude:35.830147],
                     [[CLLocation alloc] initWithLatitude:31.918796 longitude:35.818470]];
    
    for(CLLocation *location in arrLocations)
        [path addCoordinate:location.coordinate];
    
    return path;
}

-(void)setupNoFlyZone
{
    GMSPolygon *polygon = [[GMSPolygon alloc] init];
    polygon.path = [self pathOfAmman];
    polygon.title = @"Amman";
    polygon.fillColor = [UIColor colorWithWhite:1 alpha:0.5];
    polygon.strokeColor = UIColorFromRGB(0xe91e63);
    polygon.strokeWidth = 2;
    polygon.tappable = YES;
    polygon.map = self.mapView;
    
//    CLLocationCoordinate2D center = [Func centerCoordinateForCoordinates:arrLocations];
//    center.longitude -= 0.2;
//    GMSMarker *marker = [GMSMarker markerWithPosition:center];
//    marker.icon = [UIImage imageNamed:@"No_Fly"];
//    marker.map = self.mapView;
}

- (void)animateToNextCoord:(GMSMarker *)marker
{
    CoordsList *coords = marker.userData;
    
    DRWeatherInfo *weather = [[[[DRData shared] weatherList] arrList] objectAtIndex:coords.target];
    [self.dataInfo fill:weather];
    
    if(coords.target == 3)
        [self showNotification:0];
    else if(coords.target == 1)
    {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self showNotification:2];
        });
    }
    else if(coords.target == 2)
        [self showNotification:1];
        
    CLLocationCoordinate2D coord = [coords next];
    CLLocationCoordinate2D previous = marker.position;
    
    CLLocationDirection heading = GMSGeometryHeading(previous, coord);
    CLLocationDistance distance = GMSGeometryDistance(previous, coord);
    
    // Use CATransaction to set a custom duration for this animation. By default, changes to the
    // position are already animated, but with a very short default duration. When the animation is
    // complete, trigger another animation step.
    
    [CATransaction begin];
    [CATransaction setAnimationDuration:(distance / (400 * 1))]; //  // custom duration, 50km/sec
    
    __weak typeof(self) weakSelf = self;
    [CATransaction setCompletionBlock:^{
        [weakSelf animateToNextCoord:marker];
    }];
    
    marker.position = coord;
    
    [CATransaction commit];
    
    // If this marker is flat, implicitly trigger a change in rotation, which will finish quickly.
    if (marker.flat)
    {
        marker.rotation = heading;
        [self.dataInfo fillDroneDirection:heading];
    }
    
//    GMSCameraPosition *pickupLocation = [GMSCameraPosition cameraWithLatitude:coord.latitude longitude:coord.longitude zoom:kCameraZoom];
//    [self.mapView animateToCameraPosition:pickupLocation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
