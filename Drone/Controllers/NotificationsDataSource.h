//
//  NotificationsDataSource.h
//  Drone
//
//  Created by Mohammad Salah on 4/22/16.
//  Copyright © 2016 Hammoda. All rights reserved.
//

#import <Foundation/Foundation.h>

@class vc_MainMap;

#import "v_Notifications.h"
#import "DRNotification.h"

@interface NotificationsDataSource : NSObject <UITableViewDelegate, UITableViewDataSource>

-(instancetype)initWithController:(vc_MainMap*)controller tableView:(UITableView*)tableView notificationView:(v_Notifications*)notificationView;
-(void)addEelemnt:(DRNotification*)element;
-(void)allRead;

@end
