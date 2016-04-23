//
//  NotificationsDataSource.m
//  Drone
//
//  Created by Mohammad Salah on 4/22/16.
//  Copyright © 2016 Hammoda. All rights reserved.
//

#import "NotificationsDataSource.h"

#import "cell_Notification.h"
#import "vc_MainMap.h"

@interface NotificationsDataSource ()

@property (nonatomic) NSMutableArray <DRNotification*> *arrNotifs;

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) v_Notifications *notificationView;
@property (nonatomic, weak) vc_MainMap *mainMap;

@end

@implementation NotificationsDataSource

-(instancetype)initWithController:(vc_MainMap*)controller tableView:(UITableView*)tableView notificationView:(v_Notifications*)notificationView
{
    if(self = [super init])
    {
        _tableView = tableView;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _arrNotifs = [NSMutableArray new];
        _notificationView = notificationView;
        _mainMap = controller;
        
        return self;
    }
    
    return nil;
}

-(void)addEelemnt:(DRNotification*)element
{
    if([self.arrNotifs containsObject:element])return;
    
    [self.arrNotifs addObject:element];
    self.notificationView.iCount = self.arrNotifs.count;
    
    [self.mainMap.btnNotif setBackgroundImage:[UIImage imageNamed:@"Notifications_On"] forState:UIControlStateNormal];
    [Func shake:10 direction:1 currentTimes:1 withDelta:5 speed:0.03 textField:self.mainMap.btnNotif];
 
    NSIndexPath *path = [NSIndexPath indexPathForRow:self.arrNotifs.count-1 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationTop];
}

-(void)allRead
{
    [self.arrNotifs makeObjectsPerformSelector:@selector(setAsRead)];
    [self.mainMap.btnNotif setBackgroundImage:[UIImage imageNamed:@"Notifications_Off"] forState:UIControlStateNormal];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrNotifs.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cell";
    
    cell_Notification *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.notification = self.arrNotifs[indexPath.row];
    
    return cell;
}

@end
