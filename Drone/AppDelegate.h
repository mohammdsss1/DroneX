//
//  AppDelegate.h
//  Drone
//
//  Created by Mohammad Salah on 4/19/16.
//  Copyright © 2016 Hammoda. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "vc_Initial.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, readonly) vc_Initial *initial;

+(AppDelegate*)appDelegate;

@end

