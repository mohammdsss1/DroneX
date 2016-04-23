//
//  FAAlert.h
//  AlFardan
//
//  Created by Mohammad Salah on 8/6/15.
//  Copyright (c) 2015 smarteletec. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FAResponse;

typedef NS_ENUM(NSInteger, BE_ALERT_TYPE)
{
    LOCATION_DENIED,
    NO_INTERNET_ACCESS,
    FACE_DETECTION_FAILED
};

@interface FAAlert : NSObject

+(void)alertWithType:(enum BE_ALERT_TYPE)alertType;
+(void)serverAlertWithType:(FAResponse*)response;
+(void)serverAlertWithType:(FAResponse*)response completion:(void(^)(void))completion;
+(void)generalServerError;

@end
