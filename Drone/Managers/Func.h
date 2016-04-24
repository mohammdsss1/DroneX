//
//  Func.h
//  AlFardan
//
//  Created by Mahran Bayed on 6/9/15.
//  Copyright (c) 2015 Smarteletec. All rights reserved.
//

#import <Foundation/Foundation.h>

@import GoogleMaps;

#import "NSString+FontAwesome.h"
#import <objc/runtime.h>
#import "AppDelegate.h"
#import "M13BadgeView.h"
#import "MRProgressOverlayView+AFNetworking.h"
#import "FASharedAPI.h"
#import "DRData.h"

//#define getPARENT_UIALERTCONTROLER(action) (UIAlertController*) objc_getAssociatedObject(action, PARENT_UIALERTCONTROLER)
#define LOCALIZED_STRING(v) NSLocalizedStringFromTable(v, @"Localizable", nil)
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define PARENT_UIALERTCONTROLER @"PARENT_UIALERTCONTROLER"

@interface Func : NSObject

#define getPARENT_UIALERTCONTROLER(action) (UIAlertController*) objc_getAssociatedObject(action, PARENT_UIALERTCONTROLER)

NS_ASSUME_NONNULL_BEGIN

+(void)showAlertWithTitle:(NSString* _Nonnull)title andMessage:(NSString*)message andCancelButtonTitle:(NSString*)cancelTitle withAlertAction:(void (^)(UIAlertAction *action))cancelAction andOtherButtonTitle:(nullable NSString*)otherTitle withAlertAction:(nullable void (^)(UIAlertAction *action))otherAction;
+(void)showMessage:(NSString*)message completion:(void(^)(void))completion;

+(void)shake:(NSInteger)times direction:(NSInteger)direction currentTimes:(NSInteger)current withDelta:(CGFloat)delta speed:(NSTimeInterval)interval textField:(UIView*)textField;
+(id)instantiateControllerFromClass:(Class)myClass;
+(NSString*)directionStringFromDeg:(double)fNumber;
+ (CLLocationCoordinate2D)centerCoordinateForCoordinates:(NSArray <CLLocation*>*)coordinateArray;

+(void)initToolBarOnTextField:(UITextField*)tfield andActiveClass:(id)activeTarget withPrevSelector:(nullable SEL)preSelector andNextSelect:(nullable SEL)nexSelector andDoneSelect:(SEL)doneSeletor andHasNext:(bool)haveNext andHasPrev:(bool)havaPrev;

NS_ASSUME_NONNULL_END

@end
