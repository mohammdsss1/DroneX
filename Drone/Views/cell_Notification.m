//
//  cell_Notification.m
//  Drone
//
//  Created by Mohammad Salah on 4/22/16.
//  Copyright © 2016 Hammoda. All rights reserved.
//

#import "cell_Notification.h"

#import "DRNotification.h"

@interface cell_Notification ()

@property (nonatomic, weak) IBOutlet UILabel *lblTitle;
@property (nonatomic, weak) IBOutlet UIView *viewBorder;

@end

@implementation cell_Notification

-(void)awakeFromNib
{
    [self changeBorder:NO];
}

-(void)changeBorder:(BOOL)read
{
    self.viewBorder.layer.cornerRadius = 5;
    self.viewBorder.backgroundColor = read ? [UIColor clearColor] : [UIColor colorWithRed:238.0/255.0 green:238.0/255.0 blue:238.0/255.0 alpha:1];
}

-(void)setNotification:(DRNotification *)notification
{
    _notification = notification;
    
    self.lblTitle.text = self.notification.title;
    [self changeBorder:self.notification.read];
}

@end
