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

+(NSString*)stringFromDate:(NSDate*)date
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MM-yyyy hh:mm a"];
/*
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    NSTimeZone* destinationTimeZone = [NSTimeZone systemTimeZone];
    
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:date];
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:date];
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    NSDate* destinationDate = [[NSDate alloc] initWithTimeInterval:interval sinceDate:date];
*/
    [formatter setTimeZone:[NSTimeZone systemTimeZone]];
    return [formatter stringFromDate:date];
}

+ (NSString *)encodeToBase64String:(UIImage *)image {
    return [UIImageJPEGRepresentation(image, 0.3) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

+ (UIImage *)decodeBase64ToImage:(NSString *)strEncodeData {
    NSData *data = [[NSData alloc]initWithBase64EncodedString:strEncodeData options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return [UIImage imageWithData:data];
}

+(NSString *)encodeAudioToBase64String:(NSString *)fileURL
{
    NSData *audioData = [NSData dataWithContentsOfFile:fileURL];
    return [audioData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

+(BOOL)isValideEmail:(NSString *)email
{
    NSString *emailRegex = @"^\\w+(?:\\.\\w+)*@\\w+(?:\\.\\w+)+$";
    //@"^[_a-zA-Z0-9-]+([_.a-zA-Z0-9-]+)*@[a-zA-Z0-9-]+\\.([a-zA-Z0-9-]+)*([a-zA-Z]$)";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:email];
}

+(BOOL) isValideNumeric: (NSString *) text
{
    NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
    NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:text];
    return [alphaNums isSupersetOfSet:inStringSet];
}

+(BOOL)isValideMobileNumber:(NSString *)mobile
{
//    NSString *mobileRegex = @"[0-9]{10, 14}";//@"[0-9]{1,5}+[0-9]{9}";
//    NSPredicate *mobileTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobileRegex];
//    
//    return [mobileTest evaluateWithObject:mobile];
    BOOL found = NO;

    if (mobile != nil)
    {
        NSError *error = NULL;
        NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypePhoneNumber error:&error];
        NSArray *matches = [detector matchesInString:mobile options:0 range:NSMakeRange(0, [mobile length])];
        if (matches != nil)
        {
            for (NSTextCheckingResult *match in matches)
            {
                if ([match resultType] == NSTextCheckingTypePhoneNumber)
                    found = YES;
            }
        }
    }
    
    return found;
}

+(void)registerForNotification
{
    //-- Set Notification
    if ([[UIApplication sharedApplication]  respondsToSelector:@selector(isRegisteredForRemoteNotifications)])
    {
        // iOS 8 Notifications
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        
        [[UIApplication sharedApplication]  registerForRemoteNotifications];
    }
}
+(void)startActivityIndicatorOnTopMainViewCotroler
{
//    if(![YCWCApi checkIsHostReachible])
//    {
//        [[[UIAlertView alloc]
//                    initWithTitle:@"Error" message:@"Failed to Connect To the Internet, Please check your conniction !" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil]show];
//        [self stopActivityIndicator];
//        return;
//    }
//    
    dispatch_async(dispatch_get_main_queue(), ^{
        UIView *activityIndicatorView;
   
    if([UIVisualEffectView class])
    {
        
    activityIndicatorView=(UIVisualEffectView*)[[[Func topMostController]view]viewWithTag:99];
   
    if(activityIndicatorView){
       [activityIndicatorView removeFromSuperview];
       activityIndicatorView=nil;
    }

    if(![self topMostController])
        return;

    //initialize the activity indicator
    UIBlurEffect *blurEffect;
    blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
  //  UIVibrancyEffect *vibrancyEffect = [UIVibrancyEffect effectForBlurEffect:blurEffect];
    
    activityIndicatorView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];

    }
    else
    {
        activityIndicatorView=(UIView*)[[[Func topMostController]view]viewWithTag:99];
        
        if(activityIndicatorView){
            [activityIndicatorView removeFromSuperview];
            activityIndicatorView=nil;
        }
        
        if(![self topMostController])
            return;
        
        activityIndicatorView = [[UIView alloc] init];
        [activityIndicatorView setBackgroundColor:color_main_navigation_bg];
    }
    
        [activityIndicatorView setTag:99];
        CGRect frame=[self topMostController].view.bounds;
        frame.size.height/=4.5;
        frame.size.width-=40;;
        
        activityIndicatorView.frame=frame;
        
        [activityIndicatorView setCenter:[self topMostController].view.center];
        
        // border radius
        [activityIndicatorView.layer setCornerRadius:10.0f];
        
        // border
        //      [activityIndicatorView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
        //      [activityIndicatorView.layer setBorderWidth:1.5f];
        
        // drop shadow
        [activityIndicatorView.layer setShadowColor:[UIColor blackColor].CGColor];
        [activityIndicatorView.layer setShadowOpacity:0.8];
        [activityIndicatorView.layer setShadowRadius:3.0];
        [activityIndicatorView.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
        
        [activityIndicatorView setClipsToBounds:YES];
        
        //  [activityIndicatorView setBackgroundColor:[UIColor blackColor]];
        [activityIndicatorView setUserInteractionEnabled:NO];
        //   [activityIndicatorView setAlpha:0.5];
        
        //    [imageView addSubview:visualEffectView];
        UIActivityIndicatorView *activityIndicator=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        
        //Change the color of the indicator, this override the color set by UIActivityIndicatorViewStyleWhiteLarge
        activityIndicator.color=UIColorFromRGB(color_main_navigation_btn_bg);
        
        //Put the indicator on the center of the webview
        //[activityIndicator setCenter://[self topMostController].view.center];
        [activityIndicator setCenter:CGPointMake(frame.size.width/2,frame.size.height/2)];
        [activityIndicator setUserInteractionEnabled:NO];
        
        //Add the indicator to the webView to make it visible
        [activityIndicatorView addSubview:activityIndicator];
        [[Func topMostController].view addSubview:activityIndicatorView];
   
    [activityIndicator startAnimating];
    [activityIndicatorView setUserInteractionEnabled:NO];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [[UIApplication sharedApplication]beginIgnoringInteractionEvents];
    
    });

    
//    NSLog(@"start ");
}
+(void)stopActivityIndicator{
 //   [[UIApplication sharedApplication]endIgnoringInteractionEvents];
    dispatch_async(dispatch_get_main_queue(), ^{
   // NSLog(@"stop ");
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [[UIApplication sharedApplication]endIgnoringInteractionEvents];

    UIView *activityIndicatorView;
    
    if([UIVisualEffectView class])
    {
    activityIndicatorView=(UIVisualEffectView*)[[[Func topMostController]view]viewWithTag:99];
    }else
    {
        activityIndicatorView=(UIView*)[[[Func topMostController]view]viewWithTag:99];
    }
    
        
    if(!activityIndicatorView)
        return;
    [activityIndicatorView removeFromSuperview];
    activityIndicatorView=nil;
    });
}

+(void)showAlertWithTitle:(NSString*)title andMessage:(NSString*)message andCancelButtonTitle:(NSString*)cancelTitle withAlertAction:(void (^)(UIAlertAction *action))cancelAction andOtherButtonTitle:(nullable NSString*)otherTitle withAlertAction:(nullable void (^)(UIAlertAction *action))otherAction
{
//    LGAlertView *alert = [FACustomAlertView alertWithTitle:title andMessage:message andCancelButtonTitle:cancelTitle withAlertAction:cancelAction andOtherButtonTitle:otherTitle withAlertAction:otherAction];
//    [alert showAnimated:YES completionHandler:nil];
    
    UIViewController *presenter = [self topMostController];
    UIAlertController *vc = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
//    vc.view.tintColor = UIColorFromRGB(color_main_navigation_bg);
    
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

/*
+(void)showAlertWithTitle:(NSString*)title andMessage:(NSString*)message andCancelButtonTitle:(NSString*)cancelTitle withAlertAction:(void (^)(UIAlertAction *action))cancelAction andOtherButtonTitle:(NSString*)otherTitle withAlertAction:(void (^)(UIAlertAction *action))otherAction
{
    UIViewController *presenter = [self topMostController];
    UIAlertController *vc = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    vc.view.tintColor = UIColorFromRGB(color_main_navigation_bg);
    
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
}*/

+(UIAlertController*)showActionSheetFrom:(UIViewController*)controller title:(NSString*)title action1:(NSString*)action1 action1Handler:(void(^)(UIAlertAction * _Nonnull action))action1Handler action2:(nullable NSString*)action2 action2Handler:(nullable void(^)(UIAlertAction * _Nonnull action))action2Handler destructiveTitle:(nullable NSString*)destructiveTitle destructiveHandler:(nullable void(^)(UIAlertAction * _Nonnull action))destructiveHandler
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:destructiveTitle == nil ? LOCALIZED_STRING(@"Cancel") : destructiveTitle style:UIAlertActionStyleDestructive handler:destructiveHandler];
    
    UIAlertAction *alertAction1 = [UIAlertAction actionWithTitle:action1 style:UIAlertActionStyleDefault handler:action1Handler];
    objc_setAssociatedObject(alert, PARENT_UIALERTCONTROLER, alertAction1, OBJC_ASSOCIATION_RETAIN);
    
    [alert addAction:alertAction1];
    
    if(action2 && action2.length != 0)
    {
        UIAlertAction *alertAction2 = [UIAlertAction actionWithTitle:action2 style:UIAlertActionStyleDefault handler:action2Handler];
        objc_setAssociatedObject(alert, PARENT_UIALERTCONTROLER, alertAction2, OBJC_ASSOCIATION_RETAIN);
        [alert addAction:alertAction2];
    }
    
    [alert addAction:cancel];
    
    __weak UIAlertController *weakSelf = alert;
    [controller presentViewController:alert animated:YES completion:^{
        weakSelf.view.tintColor = color_main;
    }];
    
    return alert;
}

+(UIAlertController*)showActionSheetFrom:(UIViewController*)controller title:(NSString*)title destructiveTitle:(NSString*)destructiveTitle destructiveHandler:(void(^)(UIAlertAction * _Nonnull action))destructiveHandler actions:(id)actions, ... NS_REQUIRES_NIL_TERMINATION
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:destructiveTitle == nil ? LOCALIZED_STRING(@"Cancel") : destructiveTitle style:UIAlertActionStyleDestructive handler:destructiveHandler];
    
    if(actions)
        [alert addAction:actions];
    
    va_list args;
    va_start(args, actions);
    
    id obj = nil;
    while((obj = va_arg(args, id)))
    {
        if(obj && obj != nil)
            [alert addAction:obj];
    }
    va_end(args);
    
    [alert addAction:cancel];
    
    __weak UIAlertController *weakSelf = alert;
    [controller presentViewController:alert animated:YES completion:^{
        weakSelf.view.tintColor = color_main;
    }];
    
    return alert;
}

+(void)smsTo:(NSString*)number fromController:(UIViewController*)controller subject:(NSString*)subject
{
//    if([MFMessageComposeViewController canSendText])
//    {
//        MFMessageComposeViewController *messageCont = [[MFMessageComposeViewController alloc] init];
//        messageCont.messageComposeDelegate = (id)controller;
//        messageCont.modalPresentationStyle = UIModalPresentationCurrentContext;
//        [messageCont setRecipients:@[number]];
//        [messageCont setSubject:subject];
//        [messageCont setTitle:@""];
//        [messageCont setBody:@""];
//        [messageCont.navigationBar setTintColor:[UIColor whiteColor]];
//        [controller presentViewController:messageCont animated:YES completion:^{
//            [controller setNeedsStatusBarAppearanceUpdate];
//        }];
//    }
//    else
//        [Func showMessage:LOCALIZED_STRING(@"This option is available only for device that can send SMS")];
}

+(void)showLabelOnScreenCenterWithTitle:(NSString*)title andImage:(nullable UIImage*)image onView:(UIView*)parentView
{
    UIView *emptyView =(UIView*)[parentView viewWithTag:111];
    UIImageView *emptyImageView;
    UILabel *emptyLabel;
    
    if(emptyView)
    {
        emptyLabel=(UILabel*)[emptyView viewWithTag:112];
        emptyImageView=(UIImageView*)[emptyView viewWithTag:113];
    }
    else
    {
        emptyView=[[UIView alloc] init];
        [emptyView setTag:111];
        emptyLabel=[[UILabel alloc] init];
        emptyImageView=[[UIImageView alloc] init];
    }
    
    emptyImageView.image=image;
    emptyImageView.contentMode=UIViewContentModeScaleAspectFit;
    emptyImageView.backgroundColor=[UIColor clearColor];
    [emptyImageView setTag:113];

    CGRect imageRect= parentView.bounds;

    imageRect.origin.x=parentView.center.x-100;
    imageRect.size.width=200;
    imageRect.size.height=150;
    imageRect.origin.y=parentView.center.y-imageRect.size.height;
    
    emptyImageView.frame=imageRect;
    
    emptyLabel.lineBreakMode=NSLineBreakByWordWrapping;
    emptyLabel.numberOfLines=0;
    emptyLabel.textAlignment=NSTextAlignmentCenter;
    emptyLabel.backgroundColor=[UIColor clearColor];//[parentView backgroundColor];//[UIColor whiteColor];
    emptyLabel.alpha=0.86f;
    
    emptyLabel.frame = parentView.bounds;

    emptyLabel.text = title;
    emptyLabel.textColor = color_main;
    
    [emptyLabel setTag:112];
    
    emptyLabel.font = [Func boldFont:16];

    if(image && title)
    {
        [emptyView addSubview:emptyImageView];
        [emptyView addSubview:emptyLabel];

        [emptyLabel sizeToFit];
        CGRect labelRect= emptyLabel.bounds;
        labelRect.origin.x=0;
        labelRect.origin.y=imageRect.origin.y+imageRect.size.height;
        labelRect.size.width=parentView.bounds.size.width;
        emptyLabel.frame=labelRect;
    }
    else  if(image && !title)
    {
        [emptyView addSubview:emptyImageView];

        emptyImageView.center = parentView.center;
    }
    else if(title && !image)
    {
        [emptyView addSubview:emptyLabel];

        emptyLabel.center = parentView.center;
    }
    
    [parentView addSubview:emptyView];
}

+(void)hideLabelOnScreenCenterWithTitleAndImageOnView:(UIView*)parentView

{

    UIView *emptyView =(UIView*)[parentView viewWithTag:111];

    if(!emptyView)
        return;
    
    [emptyView removeFromSuperview];
    emptyView=nil;
}

+(void)showPageControlOnScreenWithNumberOfPages:(int)pagesCount andCurrentPageNo:(int)pageNo withClearColor:(BOOL)isCleardColor onViewController:(UIViewController*)parentController;
{
    
    UIPageControl *pageControl;
    
    pageControl=(UIPageControl*)[parentController.view viewWithTag:115];
    
    if(!pageControl)
        pageControl=(UIPageControl*)[parentController.navigationController.navigationBar viewWithTag:115];
    
    if(!pageControl)
        pageControl=[[UIPageControl alloc] initWithFrame:CGRectMake(0,0,parentController.view.frame.size.width,20)];
    
    pageControl.numberOfPages = pagesCount;
    pageControl.currentPage = pageNo;
    pageControl.pageIndicatorTintColor= color_main_navigation_bg;
    pageControl.currentPageIndicatorTintColor =UIColorFromRGB(color_main_navigation_btn_bg);
    [pageControl setTag:115];
    [pageControl setClipsToBounds:NO];
    pageControl.userInteractionEnabled=NO;
  //  [pageControl addTarget:self action:nil forControlEvents:UIControlEventValueChanged];
    
    if(isCleardColor)
    {
        pageControl.backgroundColor=[UIColor clearColor];
    }
    else
    {
    pageControl.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"WhiteBg_3"]];
    }
    if([parentController isKindOfClass:[UITableViewController class]])
    {
        UITableView* tView=[(UITableViewController*)parentController tableView];
        tView.tableHeaderView = pageControl;
    }
    else
    {
        
    CGRect frame=pageControl.frame;
        
    frame.origin.y=parentController.navigationController.navigationBar.frame.size.height;
    pageControl.frame=frame;

    [parentController.navigationController.navigationBar addSubview:pageControl];
    }
}

+(void)hidePageControlOnScreenFromViewController:(UIViewController *)parentController
{
    UIPageControl *pageControl = (UIPageControl*)[parentController.view viewWithTag:115];
    
    if(pageControl)
    {
        [pageControl removeFromSuperview];
        pageControl=nil;
    }
    
    pageControl=(UIPageControl*)[parentController.navigationController.navigationBar viewWithTag:115];
    
    if(pageControl)
    {
        [pageControl removeFromSuperview];
        pageControl=nil;
    }
}

+(UIImage*)imageWithImage: (UIImage*) sourceImage scaledToWidth: (float) i_width
{
    float oldWidth = sourceImage.size.width;
    float scaleFactor = i_width / oldWidth;
    
    float newHeight = sourceImage.size.height * scaleFactor;
    float newWidth = oldWidth * scaleFactor;
    
    UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight));
    [sourceImage drawInRect:CGRectMake(0, 0, newWidth, newHeight)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
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
+(UIAlertController*)alertWithActivity
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"\n\n\n"
        preferredStyle:UIAlertControllerStyleAlert];
    
    UIActivityIndicatorView *loader = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    loader.center = alert.view.center;
//    loader.center = CGPointMake(self.view.bounds.size.width/2.0, self.view.bounds.size.height / 2.0);
    loader.color = [UIColor redColor];
    [loader startAnimating];
    //[alert setValue:loader forKey:@"accessoryView"];
    return alert;
}

+(NSString *) randomStringWithLength: (int) len {
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform((uint32_t)[letters length])]];
    }
    
    return randomString;
}

+(void)open:(UIViewController*)controler from:(UIViewController*)parent
{
    if (parent.navigationController!=nil)
        [parent.navigationController pushViewController:controler animated:YES];
    else
    {
        [controler setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [parent presentViewController:controler animated:YES completion:nil];
    }
}

+(void)registerForKeyboardShowNotificationsIn:(id)object withSelector:(SEL)sel
{
    [[NSNotificationCenter defaultCenter] addObserver:object
                                             selector:sel
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
}
+(void)registerForKeyboardHideNotificationsIn:(id)object withSelector:(SEL)sel
{
    [[NSNotificationCenter defaultCenter] addObserver:object
                                             selector:sel
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    

}
+(void)deRegisterForKeyboardNotificationsIn:(id)object
{
    [[NSNotificationCenter defaultCenter] removeObserver:object
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:object
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];

}

+(void)initToolBarOnTextField:(UITextField*)tfield andActiveClass:(id)activeTarget withPrevSelector:(nullable SEL)preSelector andNextSelect:(nullable SEL)nexSelector andDoneSelect:(SEL)doneSeletor andHasNext:(bool)haveNext andHasPrev:(bool)havaPrev
{
    UIBarButtonItem *PrevButton;
    UIBarButtonItem *NextButton;
    UIBarButtonItem *flexibleSpace,*fixedSpace;
    UIBarButtonItem *doneButton;

    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, [Func topMostController].view.bounds.size.height,//320
    [Func topMostController].view.bounds.size.width, KEYBOARD_TOOL_BAR_HEIGHT)];
    toolBar.barStyle = UIBarStyleDefault;
    toolBar.translucent = YES;
    toolBar.tintColor = UIColorFromRGB(0xe91e63);
    
    BOOL onlyDone = !havaPrev && !haveNext;
    if(!onlyDone)
    {
        PrevButton = [[UIBarButtonItem alloc] initWithImage:[Func imageFromIcon:FAIconAngleLeft withSize:KEYBOARD_TOOL_BAR_HEIGHT andColor:[UIColor whiteColor]] landscapeImagePhone:nil style:UIBarButtonItemStylePlain target:activeTarget action:preSelector];
        
        NextButton = [[UIBarButtonItem alloc] initWithImage:[Func imageFromIcon:FAIconAngleRight withSize:KEYBOARD_TOOL_BAR_HEIGHT andColor:[UIColor whiteColor]] landscapeImagePhone:nil style:UIBarButtonItemStylePlain target:activeTarget action:nexSelector];
        
        fixedSpace =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        fixedSpace.width = 10.0f;
    }
    
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

+(void)setTextField:(UITextField *)tfield placeHolderColor:(UIColor *)color
{
    if(!tfield)return;
    tfield.attributedPlaceholder = [[NSAttributedString alloc] initWithString:tfield.placeholder attributes:@{NSForegroundColorAttributeName: color}];
}


+(void)setActiveWindowOnDrawerMenue:(NSInteger)activeTag
{
//    tvc_LeftMenu *vc = AppDelegate.sharedAppDelegate.leftController;
//    vc.iSelectedCellTag = activeTag;
}

+(UIImage *)imageFromIcon:(FAIcon)icon withSize:(int)iconSize andColor:(UIColor*)color
{
    //   UIFont *font = [UIFont fontWithName:kFontAwesomeFamilyName size:iconSize];
    NSString *text = [NSString fontAwesomeIconStringForEnum:icon];
    CGSize size  = [text sizeWithAttributes:@{NSFontAttributeName: [UIFont fontWithName:kFontAwesomeFamilyName size:iconSize]}];
    // check if UIGraphicsBeginImageContextWithOptions is available (iOS is 4.0+)
    if (&UIGraphicsBeginImageContextWithOptions != NULL)
        UIGraphicsBeginImageContextWithOptions(size,NO,0.0);
    
    // optional: add a shadow, to avoid clipping the shadow you should make the context size bigger
    //
    // CGContextRef ctx = UIGraphicsGetCurrentContext();
    // CGContextSetShadowWithColor(ctx, CGSizeMake(1.0, 1.0), 5.0, [[UIColor grayColor] CGColor]);
    
    // draw in context, you can use also drawInRect:withFont:
    [text drawAtPoint:CGPointMake(0.0, 0.0) withAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"FontAwesome" size:iconSize],NSForegroundColorAttributeName:color}];
    
    // transfer image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+(UIImage*)resizeImage:(UIImage*)image newSize:(CGSize)size
{
    if(CGSizeEqualToSize(size, image.size))
        return image;
       
    if (&UIGraphicsBeginImageContextWithOptions != NULL)
        UIGraphicsBeginImageContextWithOptions(size,NO,0.0);
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    // transfer image
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

+(M13BadgeView*)attachedBadgeViewTo:(UIView*)superView
{
    M13BadgeView *badgeView;
    UIView *badgeContenerView;
    
//    if([superView viewWithTag:1234])
//        return [[[superView viewWithTag:1234] subviews]lastObject];
    
    CGFloat xAxis = 50;
    
    badgeContenerView = [UIView new];
    badgeContenerView.translatesAutoresizingMaskIntoConstraints = NO;
    [badgeContenerView setTag:1234];
    [superView addSubview:badgeContenerView];
    
    NSDictionary *dicView = @{@"badgeContenerView" : badgeContenerView};
    NSNumber *centerY = @(CGRectGetHeight(superView.frame)/2 - 10);
    NSNumber *leding = @(xAxis);
    NSArray *arrV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-y-[badgeContenerView(20)]" options:0 metrics:@{@"y" : centerY} views:dicView];
    NSArray *arrH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[badgeContenerView(30)]-leding-|" options:0 metrics:@{@"leding" : leding} views:dicView];
    
    [superView addConstraints:arrH];
    [superView addConstraints:arrV];
    
    badgeView = [M13BadgeView new];
    badgeView.translatesAutoresizingMaskIntoConstraints = NO;
    [badgeContenerView addSubview:badgeView];
    
    dicView = @{@"badgeView" : badgeView};
    arrV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[badgeView]-0-|" options:0 metrics:nil views:dicView];
    arrH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[badgeView]-0-|" options:0 metrics:nil views:dicView];
    
    badgeView.hidesWhenZero= YES;
    badgeView.verticalAlignment = M13BadgeViewVerticalAlignmentMiddle;
    badgeView.horizontalAlignment =M13BadgeViewHorizontalAlignmentRight;
    [badgeView setBadgeBackgroundColor:color_main_navigation_bg];
    [badgeView setBorderColor:UIColorFromRGB(color_main_navigation_btn_bg)];
    [badgeView setBorderWidth:1.0];
    
    [superView addConstraints:arrH];
    [superView addConstraints:arrV];
    
    return badgeView;
}

#ifdef CustomerApp
+(M13BadgeView*)attachedBadgeViewTo:(UIView*)superView
{
    M13BadgeView *badgeView;
    
    if([superView viewWithTag:1234])
        return [superView viewWithTag:1234];
    
    CGFloat xAxis = 50;
    NSNumber *centerY = @(CGRectGetHeight(superView.frame)/2 - 10);
    NSNumber *leading = @(xAxis);
    
    badgeView = [M13BadgeView new];
    badgeView.translatesAutoresizingMaskIntoConstraints = NO;
    [superView addSubview:badgeView];
    [badgeView setTag:1234];
    
    NSDictionary *dicView = @{@"badgeView" : badgeView};
    NSArray *arrV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-y-[badgeView(20)]" options:0 metrics:@{@"y" : centerY} views:dicView];
    NSArray *arrH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[badgeView(30)]-leading-|" options:0 metrics:@{@"leading" : leading} views:dicView];
    
    badgeView.hidesWhenZero = YES;
    badgeView.verticalAlignment = M13BadgeViewVerticalAlignmentMiddle;
    badgeView.horizontalAlignment = M13BadgeViewHorizontalAlignmentRight;
//    badgeView.pixelPerfectText = NO;
    [badgeView setBadgeBackgroundColor:color_main_navigation_bg];
    [badgeView setBorderColor:UIColorFromRGB(color_main_navigation_btn_bg)];
    [badgeView setBorderWidth:1.0];
    
    [superView addConstraints:arrH];
    [superView addConstraints:arrV];
    
    return badgeView;
}
#endif

+(void)callNumber:(NSString *)mobNum
{
    if(!mobNum || mobNum.length == 0)return;
    
    //Call The Office
    NSURL *url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"tel://%@",mobNum]];
    
    CTTelephonyNetworkInfo *netInfo = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [netInfo subscriberCellularProvider];
    
    if([[UIApplication sharedApplication]canOpenURL:url]&&carrier!=nil&&carrier.isoCountryCode)
    {
        [[UIApplication sharedApplication] openURL:url];
    }
    else
    {
        [Func showAlertWithTitle:NSLocalizedStringFromTable(@"Alert", @"Localizable", nil) andMessage:NSLocalizedStringFromTable(@"This option is available only for active sim cards with voice calling.",@"Localizable",nil) andCancelButtonTitle:NSLocalizedStringFromTable(@"Ok", @"Localizable", nil) withAlertAction:^(UIAlertAction *action) {
            [getPARENT_UIALERTCONTROLER(action) dismissViewControllerAnimated:YES completion:nil];
        } andOtherButtonTitle:nil withAlertAction:nil];
    }
}

+(BOOL)checkIsComplexPassword:(NSString*)Pass
{
    NSError *error = nil;
    NSInteger iCount = 0;
    NSRegularExpression *regex;
    NSTextCheckingResult *match;
    
    NSArray *arrRegex = @[@"^(?=.*[a-z]).{1,}$",
                          @"^(?=.*[A-Z]).{1,}$",
                          @"^(?=.*\\d).{1,}$",
                          @"^(?=.*(_|[-+_!@#$%^&*().,?])).{1,}$"];
    
    for(NSString *stRegex in arrRegex)
    {
        regex = [NSRegularExpression regularExpressionWithPattern:stRegex options:0 error:&error];
        match = [regex firstMatchInString:Pass options:0 range:NSMakeRange(0, [Pass length])];
        BOOL isMatch = match != nil;
        
        if(isMatch)
            iCount++;
    }
    
    regex = [NSRegularExpression regularExpressionWithPattern:@".{6,}" options:NSRegularExpressionCaseInsensitive error:&error];
    match = [regex firstMatchInString:Pass options:0 range:NSMakeRange(0, [Pass length])];
    BOOL isCountMatch = match != nil;
    
    NSArray *componentsSeparatedByWhiteSpace = [Pass componentsSeparatedByString:@" "];
    BOOL validPassword = isCountMatch && [componentsSeparatedByWhiteSpace count] == 1 && iCount >= 2;
    
//    NSLog(@"%@ %@", Pass, validPassword ? @"Yes" : @"NO");
    
    return validPassword;
}

+(NSString*)formatDoubleValue:(double)value
{
    return @"";//return [[NSString stringWithFormat:@"%.2f", value] addQAR];
}

+(CGSize)sizeFprText:(NSString*)text width:(CGFloat)width font:(UIFont*)font
{
    CGSize sizeOfText = [text boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                                        options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                                     attributes:@{ NSFontAttributeName : font }
                                                        context: nil].size;
    
    return sizeOfText;
}

#pragma mark - Font Selections

+(UIFont*)boldFont:(CGFloat)size
{
//    if(APP_ISARABIC)return [UIFont fontWithName:FONT_BOLD_EN_NAME size:size];
//    else if(APP_ISENGLISH)return [UIFont fontWithName:FONT_BOLD_EN_NAME size:size];
//    else return [UIFont fontWithName:FONT_BOLD_EN_NAME size:size];
    return nil;
}

+(UIFont*)mediumFont:(CGFloat)size
{
//    if(APP_ISARABIC) return [UIFont fontWithName:FONT_MEDIUM_EN_NAME size:size];
//    else if(APP_ISENGLISH) return [UIFont fontWithName:FONT_MEDIUM_EN_NAME size:size];
//    else return [UIFont fontWithName:FONT_MEDIUM_EN_NAME size:size];
    return nil;
}

+(UIFont*)lightFont:(CGFloat)size
{
//    if(APP_ISARABIC)return [UIFont fontWithName:FONT_LIGHT_EN_NAME size:size];
//    else if(APP_ISENGLISH)return [UIFont fontWithName:FONT_LIGHT_EN_NAME size:size];
//    else return [UIFont fontWithName:FONT_LIGHT_EN_NAME size:size];
    return nil;
}

+(void)setupRightButton:(UIViewController*)controller selector:(SEL)selector
{
//    UIBarButtonItem *btnCall = [[UIBarButtonItem alloc] initWithImage:[FAGeneralUtil getCallImage] style:UIBarButtonItemStylePlain target:controller action:selector];
//    btnCall.tintColor = UIColor.whiteColor;
    
//    UIImage *image = [FAGeneralUtil getCallImage];
//    FAButton *btn = [FAButton buttonWithType:UIButtonTypeCustom];
//    btn.frame = CGRectMake(0, 0, 25, 25);
//    [btn setImage:image forState:UIControlStateNormal];
//    [btn addTarget:controller action:selector forControlEvents:UIControlEventTouchUpInside];
//    FABarButtonItem *btnCall = [[FABarButtonItem alloc] initWithCustomView:btn];
//    
//    UINavigationController *nav = AppDelegate.sharedAppDelegate.homeNavigation;
//    if(!nav)
//        nav = controller.navigationController;
//    
////    if(APP_ISARABIC)
////        [nav.topViewController.navigationItem setLeftBarButtonItem:btnCall];
////    else
//        [nav.topViewController.navigationItem setRightBarButtonItem:btnCall];
}

+(void)addBarButtonForController:(UIViewController*)controller
{
//    UIImage *image = [UIImage imageNamed:@"SideMenu"];
//    FAButton *btn = [FAButton buttonWithType:UIButtonTypeCustom];
//    btn.frame = CGRectMake(0, 0, 25, 25);
//    [btn setImage:image forState:UIControlStateNormal];
//    [btn addTarget:self action:@selector(leftOpenDrawerButtonPress:) forControlEvents:UIControlEventTouchUpInside];
//    btn.controller = controller;
//    FABarButtonItem *leftDrawerButton = [[FABarButtonItem alloc] initWithCustomView:btn];
////    if(APP_ISARABIC)
////        [controller.navigationController.topViewController.navigationItem setRightBarButtonItem:leftDrawerButton animated:NO];
////    else
//        [controller.navigationController.topViewController.navigationItem setLeftBarButtonItem:leftDrawerButton animated:NO];
}

+(UIBarButtonItem*)setupIWillGuideDriverButton:(UIViewController*)controller selector:(nonnull SEL)selector
{
    UIButton *btnGuide = [UIButton buttonWithType:UIButtonTypeCustom];
    btnGuide.frame = CGRectMake(0, 0, 25, 30);
    [btnGuide setImage:[UIImage imageNamed:@"Guide2"] forState:UIControlStateNormal];
    [btnGuide addTarget:controller action:selector forControlEvents:UIControlEventTouchUpInside];
    btnGuide.tintColor = UIColor.whiteColor;
    UIBarButtonItem *btnGuideBar = [[UIBarButtonItem alloc] initWithCustomView:btnGuide];
    btnGuideBar.tintColor = UIColor.whiteColor;
    controller.navigationItem.rightBarButtonItem = btnGuideBar;
    
    return btnGuideBar;
}

+(void)removeLeftButton:(UIViewController*)controller
{
//    if(APP_ISARABIC)
//        [controller.navigationController.topViewController.navigationItem setRightBarButtonItem:nil animated:YES];
//    else
        [controller.navigationController.topViewController.navigationItem setLeftBarButtonItem:nil animated:YES];
}

+(void)openShareForController:(UIViewController*)controller message:(NSString*)message url:(NSURL*)url
{
    NSArray *arrActivities = nil;
    if(url)
        arrActivities = @[message, url];
    else
        arrActivities = @[message];
    
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:arrActivities applicationActivities:nil];
    activityViewController.view.tintColor = color_main;
    [controller presentViewController:activityViewController animated:YES completion:^
    {
//        activityViewController.view.tintColor = color_main;
        [[UINavigationBar appearance] setTintColor:color_main];
    }];
}

+(void)showMessage:(nonnull NSString*)title message:(nonnull NSString*)message completion:(nullable void(^)(void))completion
{
    [Func showAlertWithTitle:title andMessage:message andCancelButtonTitle:LOCALIZED_STRING(@"Ok") withAlertAction:^(UIAlertAction *action) {
        if(completion)
            completion();
    } andOtherButtonTitle:nil withAlertAction:nil];
}

+(void)showMessage:(NSString*)message
{
    [Func showMessage:LOCALIZED_STRING(@"Alert") message:message completion:nil];
}

+(void)showMessage:(NSString*)message completion:(void(^)(void))completion
{
    [Func showAlertWithTitle:LOCALIZED_STRING(@"Alert") andMessage:message andCancelButtonTitle:LOCALIZED_STRING(@"Ok") withAlertAction:^(UIAlertAction *action) {
        if(completion)
            completion();
    } andOtherButtonTitle:nil withAlertAction:nil];
}

+(void)drawLayerBorder:(UIView*)view
{
    view.layer.borderWidth = 1;
    view.layer.borderColor = color_6B6B6B.CGColor;
}

+(void)fillRatingView:(float)fRating images:(NSArray*)arrStars
{
    float remaining = fRating;
    for(NSInteger i = 0; i < arrStars.count; ++i)
    {
        if(remaining > 0.5)
            remaining--;
        
        UIImageView *imageView = [arrStars objectAtIndex:i];
        if(fRating >= i+1)
        {
            imageView.highlighted = YES;
            imageView.image = STAR_ON;
        }
        else if(remaining <= 0.5 && remaining > 0)
        {
            remaining = 0;
            imageView.highlighted = NO;
            imageView.image = STAR_ON_HALF;
        }
        else
        {
            imageView.highlighted = NO;
            imageView.image = STAR_OFF;
        }
    }
}

#ifdef CustomerApp
+(void)loadNotificationDeatilsViewFrom:(UIViewController *)controler message:(FAMessage*)message
{
    if(![controler isKindOfClass:vc_MessageDetails.class])
    {
        vc_MessageDetails *vc = [vc_MessageDetails instantiateFromStoryboard];
        vc.hideLeftButton = YES;
        vc.message = message;
        
        if (controler.navigationController!=nil)
            [controler.navigationController pushViewController:vc animated:YES];
    }
}

+(void)loadBookingReminder:(UIViewController *)controler requestID:(NSString*)requestID
{
    if(![controler isKindOfClass:tvc_BookingReminder.class])
    {
        tvc_BookingReminder *vc = [tvc_BookingReminder instantiateFromStoryboard];
        vc.hideLeftButton = YES;
        vc.requestID = requestID;
        
        if (controler.navigationController!=nil)
            [controler.navigationController pushViewController:vc animated:YES];
    }
}
#endif

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

#pragma mark - Dispatcher Helpers

void perormOnMainQueueAfter(int seconds, block block)
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(seconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if(block)
            block();
    });
}

@end
