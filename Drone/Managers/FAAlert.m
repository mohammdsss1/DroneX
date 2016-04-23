//
//  FAAlert.m
//  AlFardan
//
//  Created by Mohammad Salah on 8/6/15.
//  Copyright (c) 2015 smarteletec. All rights reserved.
//

#import "FAAlert.h"

@implementation FAAlert

+(void)alertWithType:(enum BE_ALERT_TYPE)alertType
{
    NSString *stTitle;
    NSString *stMessage;
    
    switch (alertType) {
        case LOCATION_DENIED:
        {
            [Func showAlertWithTitle:LOCALIZED_STRING(@"Location Service is Disabled") andMessage:LOCALIZED_STRING(@"Prestige Cars needs access to your location to able to use the app. Please turn on Location Services in your device settings.") andCancelButtonTitle:LOCALIZED_STRING(@"Go To Settings") withAlertAction:^(UIAlertAction *action)
             {
                 [getPARENT_UIALERTCONTROLER(action) dismissViewControllerAnimated:YES completion:nil];
                 [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
             } andOtherButtonTitle:LOCALIZED_STRING(@"No Thanks") withAlertAction:^(UIAlertAction *action)
             {
                 [getPARENT_UIALERTCONTROLER(action) dismissViewControllerAnimated:YES completion:nil];
             }];
        }
        case FACE_DETECTION_FAILED:
            stTitle = LOCALIZED_STRING(@"Alert");
            stMessage = LOCALIZED_STRING(@"The captured photo is corrupted. Please retake it again.");
            break;
        /*case SMS_SENT:
            stTitle = NSLocalizedStringFromTable(@"SMS_SENT", @"Localizable", nil);
            stMessage = NSLocalizedStringFromTable(@"SMS_MESSAGE", @"Localizable", nil);
            break;*/
        /*case MOBILE_SUCCESS_ACTIVATION:
            stTitle = NSLocalizedStringFromTable(@"success", @"Localizable", nil);
            stMessage = NSLocalizedStringFromTable(@"MOBILE_ACTIVATION_SUCCESS", @"Localizable", nil);
            break;*/
        case NO_INTERNET_ACCESS :
            stTitle = LOCALIZED_STRING(@"Mobile Data is Turned Off");
            stMessage = LOCALIZED_STRING(@"Turn on mobile data or use Wi-Fi to access data.");
            break;
        default:
            break;
    }
    
    if(alertType != LOCATION_DENIED)
        [[self class] showAlertWithTitle:stTitle message:stMessage];
}

+(void)showAlertWithTitle:(NSString*)title message:(NSString*)message
{
    NSString *stOkTitle = NSLocalizedStringFromTable(@"Ok", @"Localizable", nil);
    [Func showAlertWithTitle:title andMessage:message andCancelButtonTitle:stOkTitle withAlertAction:^(UIAlertAction *action) {
        
    } andOtherButtonTitle:nil withAlertAction:NULL];
}

+(void)serverAlertWithType:(FAResponse*)response
{
    NSString *stTitle = NSLocalizedStringFromTable(@"Alert", @"Localizable", nil);
    NSString *stOK = NSLocalizedStringFromTable(@"Ok", @"Localizable", nil);
    
//    NSNumber *errorCode = (NSNumber*)response.errorCode;
//    NSInteger iCode = errorCode.integerValue;
    NSString *stMessage = response.message;//NSString *stMessage = [self localizedStringForErrorCode:iCode];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [Func showAlertWithTitle:stTitle andMessage:stMessage andCancelButtonTitle:stOK withAlertAction:^(UIAlertAction *action) {
            [getPARENT_UIALERTCONTROLER(action) dismissViewControllerAnimated:YES completion:nil];
        } andOtherButtonTitle:nil withAlertAction:NULL];
    });
}

+(void)serverAlertWithType:(FAResponse*)response completion:(void(^)(void))completion
{
    NSString *stMessage = response.message;
    if(!stMessage || [stMessage isEqual:[NSNull null]] || stMessage.length == 0)return;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [Func showMessage:stMessage completion:^{
            if(completion)
                completion();
        }];
    });
}

+(void)generalServerError
{
    NSString *stTitle = NSLocalizedStringFromTable(@"Something went wrong", @"Localizable", nil);
    NSString *stOK = NSLocalizedStringFromTable(@"Ok", @"Localizable", nil);
    NSString *stMessage = NSLocalizedStringFromTable(@"Please try again later", @"Localizable", nil);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [Func showAlertWithTitle:stTitle andMessage:stMessage andCancelButtonTitle:stOK withAlertAction:^(UIAlertAction *action) {
            [getPARENT_UIALERTCONTROLER(action) dismissViewControllerAnimated:YES completion:nil];
        } andOtherButtonTitle:nil withAlertAction:NULL];
    });
}

@end
