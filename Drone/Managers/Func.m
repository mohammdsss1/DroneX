//
//  Func.m
//  AlFardan
//
//  Created by Mahran Bayed on 6/9/15.
//  Copyright (c) 2015 Smarteletec. All rights resferved.
//

#import "Func.h"

#import <QuartzCore/QuartzCore.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>

#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))
#define DEGREES_TO_RADIANS(degree) { degree * M_PI / 180 }

@implementation Func

+(void)showMessage:(NSString*)message completion:(void(^)(void))completion
{
    [Func showAlertWithTitle:LOCALIZED_STRING(@"Alert") andMessage:message andCancelButtonTitle:LOCALIZED_STRING(@"Ok") withAlertAction:^(UIAlertAction *action) {
        if(completion)
            completion();
    } andOtherButtonTitle:nil withAlertAction:nil];
}

+(void)showAlertWithTitle:(NSString*)title andMessage:(NSString*)message andCancelButtonTitle:(NSString*)cancelTitle withAlertAction:(void (^)(UIAlertAction *action))cancelAction andOtherButtonTitle:(NSString*)otherTitle withAlertAction:(void (^)(UIAlertAction *action))otherAction
{
    UIViewController *presenter = [self topMostController];
    UIAlertController *vc = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    vc.view.tintColor = color_main_navigation_bg;
    
    if(cancelTitle.length > 0)
    {
        UIAlertAction* cancel = [UIAlertAction
                                 actionWithTitle:cancelTitle
                                 style:UIAlertActionStyleCancel
                                 handler:
                                 cancelAction
                                 ];
        
        [vc addAction:cancel];
        //        objc_setAssociatedObject(cancel, PARENT_UIALERTCONTROLER, presenter, OBJC_ASSOCIATION_RETAIN);
        objc_setAssociatedObject(vc, PARENT_UIALERTCONTROLER, cancel, OBJC_ASSOCIATION_RETAIN);
    }
    
    
    if(otherTitle.length > 0)
    {
        UIAlertAction* other = [UIAlertAction
                                actionWithTitle:otherTitle
                                style:UIAlertActionStyleDefault
                                handler:
                                otherAction
                                ];
        [vc addAction:other];
        //        objc_setAssociatedObject(other, PARENT_UIALERTCONTROLER, presenter, OBJC_ASSOCIATION_RETAIN);
        objc_setAssociatedObject(vc, PARENT_UIALERTCONTROLER, other, OBJC_ASSOCIATION_RETAIN);
    }
    
    [presenter presentViewController:vc animated:YES completion:nil];
}

+(UIWindow *) returnWindowWithWindowLevelNormal
{
    NSArray *windows = [UIApplication sharedApplication].windows;
    for(UIWindow *topWindow in windows)
    {
        if (topWindow.windowLevel == UIWindowLevelNormal)
            return topWindow;
    }
    return [UIApplication sharedApplication].keyWindow;
}

+ (UIViewController*)topMostController
{
    
    UIWindow *topWindow = [UIApplication sharedApplication].keyWindow;
    if (topWindow.windowLevel != UIWindowLevelNormal)
    {
        topWindow = [self returnWindowWithWindowLevelNormal];
    }
    
    UIViewController *topController = topWindow.rootViewController;
    if(topController == nil)
    {
        topWindow = [UIApplication sharedApplication].delegate.window;
        if (topWindow.windowLevel != UIWindowLevelNormal)
        {
            topWindow = [self returnWindowWithWindowLevelNormal];
        }
        topController = topWindow.rootViewController;
    }
    
    while(topController.presentedViewController)
    {
        topController = topController.presentedViewController;
    }
    
    if([topController isKindOfClass:[UINavigationController class]])
    {
        UINavigationController *nav = (UINavigationController*)topController;
        topController = [nav.viewControllers lastObject];
        
        while(topController.presentedViewController)
        {
            topController = topController.presentedViewController;
        }
    }
    
    //    if([topController isKindOfClass:[AMSlideMenuMainViewController class]])
    //    {
    //        UINavigationController *nav = [(AMSlideMenuMainViewController*)topController currentActiveNVC];
    //        topController = [nav.viewControllers lastObject];
    //
    //        while(topController.presentedViewController)
    //        {
    //            topController = topController.presentedViewController;
    //        }
    //
    //    }
    
    if([UIAlertController class] && [topController isKindOfClass:[UIAlertController class]])
    {
        topController=[topController presentingViewController];
    }
    
    //   NSLog(@"top cont is %@",topController);
    
    
    return topController;
    /*
     // Handling UITabBarController
     if ([rootViewController isKindOfClass:[UITabBarController class]]) {
     UITabBarController* tabBarController = (UITabBarController*)rootViewController;
     return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
     }
     // Handling UINavigationController
     else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
     UINavigationController* navigationController = (UINavigationController*)rootViewController;
     return [self topViewControllerWithRootViewController:navigationController.visibleViewController];
     }
     // Handling Modal views
     else if (rootViewController.presentedViewController) {
     UIViewController* presentedViewController = rootViewController.presentedViewController;
     return [self topViewControllerWithRootViewController:presentedViewController];
     }
     // Handling UIViewController's added as subviews to some other views.
     else {
     for (UIView *view in [rootViewController.view subviews])
     {
     id subViewController = [view nextResponder];    // Key property which most of us are unaware of / rarely use.
     if ( subViewController && [subViewController isKindOfClass:[UIViewController class]])
     {
     return [self topViewControllerWithRootViewController:subViewController];
     }
     }
     return rootViewController;
     }
     */
    /*
     UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
     #warning error handle navigaion not presentaion only
     while (topController.presentedViewController) {
     topController = topController.presentedViewController;
     NSLog(@"top is %@",topController);
     }
     
     return topController;
     */
}

+(void)initToolBarOnTextField:(UITextField*)tfield andActiveClass:(id)activeTarget withPrevSelector:(nullable SEL)preSelector andNextSelect:(nullable SEL)nexSelector andDoneSelect:(SEL)doneSeletor andHasNext:(bool)haveNext andHasPrev:(bool)havaPrev
{
    UIBarButtonItem *PrevButton;
    UIBarButtonItem *NextButton;
    UIBarButtonItem *flexibleSpace,*fixedSpace;
    UIBarButtonItem *doneButton;
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, [Func topMostController].view.bounds.size.height,//320
                                                                     [Func topMostController].view.bounds.size.width, 44)];
    toolBar.barStyle = UIBarStyleDefault;
    toolBar.translucent = YES;
    toolBar.tintColor = color_main;//color_main_navigation_bg;
    
    BOOL onlyDone = YES;
    
    flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:activeTarget action:doneSeletor];
    
    if(onlyDone)
        [toolBar setItems:[NSArray arrayWithObjects:flexibleSpace,doneButton, nil]];
    else
        [toolBar setItems:[NSArray arrayWithObjects:PrevButton,fixedSpace,NextButton,flexibleSpace,doneButton, nil]];
    
    tfield.inputAccessoryView = toolBar;
    
    NextButton.enabled = haveNext;
    PrevButton.enabled = havaPrev;
}

+(id)instantiateControllerFromClass:(Class)myClass
{
    return [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:NSStringFromClass(myClass)];
}

+(NSString*)directionStringFromDeg:(double)fNumber
{
    NSString *stDesc = @"";
    if(fNumber == 0)
        stDesc = @"N";
    else if(fNumber > 0 && fNumber < 90)
        stDesc = @"NE";
    else if(fNumber == 90)
        stDesc = @"E";
    else if(fNumber > 90 && fNumber < 180)
        stDesc = @"ES";
    else if(fNumber == 180)
        stDesc = @"S";
    else if(fNumber > 180 && fNumber < 270)
        stDesc = @"SW";
    else if(fNumber == 270)
        stDesc = @"W";
    else if(fNumber > 270 && fNumber < 360)
        stDesc = @"NW";
    
    return stDesc;
}

+(void)shake:(NSInteger)times direction:(NSInteger)direction currentTimes:(NSInteger)current withDelta:(CGFloat)delta speed:(NSTimeInterval)interval textField:(UIView*)textField
{
    [UIView animateWithDuration:interval animations:^{
        textField.transform = CGAffineTransformMakeTranslation(delta * direction, 0);
    } completion:^(BOOL finished) {
        if(current >= times) {
            [UIView animateWithDuration:interval animations:^{
                textField.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
            }];
            return;
        }
        [self shake:times - 1
          direction:direction * -1
       currentTimes:current + 1
          withDelta:delta
              speed:interval
          textField:textField];
    }];
}

+ (CLLocationCoordinate2D)centerCoordinateForCoordinates:(NSArray <CLLocation*>*)coordinateArray
{
    /*
    double x = 0;
    double y = 0;
    double z = 0;
    
    for(CLLocation *coordinateValue in coordinateArray)
    {
        CLLocationCoordinate2D coordinate = [coordinateValue coordinate];
        
        double lat = DEGREES_TO_RADIANS(coordinate.latitude);
        double lon = DEGREES_TO_RADIANS(coordinate.longitude);
        x += cos(lat) * cos(lon);
        y += cos(lat) * sin(lon);
        z += sin(lat);
    }
    
    x = x / (double)coordinateArray.count;
    y = y / (double)coordinateArray.count;
    z = z / (double)coordinateArray.count;
    
    double resultLon = atan2(y, x);
    double resultHyp = sqrt(x * x + y * y);
    double resultLat = atan2(z, resultHyp);
    
    CLLocationCoordinate2D result = CLLocationCoordinate2DMake(RADIANS_TO_DEGREES(resultLat), RADIANS_TO_DEGREES(resultLon));
    return result;*/
    
    float maxLat = -200;
    float maxLong = -200;
    float minLat = MAXFLOAT;
    float minLong = MAXFLOAT;
    
    for (int i=0 ; i<[coordinateArray count] ; i++) {
        CLLocationCoordinate2D location = [[coordinateArray objectAtIndex:i] coordinate];
        
        if (location.latitude < minLat) {
            minLat = location.latitude;
        }
        
        if (location.longitude < minLong) {
            minLong = location.longitude;
        }
        
        if (location.latitude > maxLat) {
            maxLat = location.latitude;
        }
        
        if (location.longitude > maxLong) {
            maxLong = location.longitude;
        }
    }
    
    //Center point
    
    CLLocationCoordinate2D center = CLLocationCoordinate2DMake((maxLat + minLat) * 0.5, (maxLong + minLong) * 0.5);
    return center;
}

@end
