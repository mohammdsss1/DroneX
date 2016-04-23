//
//  v_Notifications.m
//  Drone
//
//  Created by Mohammad Salah on 4/22/16.
//  Copyright © 2016 Hammoda. All rights reserved.
//

#import "v_Notifications.h"

@interface v_Notifications () 

@property (nonatomic, weak) IBOutlet UILabel *lblCount;

@end

@implementation v_Notifications

-(void)awakeFromNib
{
    self.tableView.tableFooterView = [UIView new];
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.estimatedRowHeight = 60.0;
}

-(void)setICount:(NSInteger)iCount
{
    _iCount = iCount;
    
    self.lblCount.text = [NSString stringWithFormat:@"%ld", (long)iCount];
}

@end
