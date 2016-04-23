//
//  DRNotification.h
//  Drone
//
//  Created by Mohammad Salah on 4/22/16.
//  Copyright © 2016 Hammoda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DRNotification : NSObject

@property (nonatomic) NSString *title;
@property (nonatomic) BOOL read;

-(instancetype)init:(NSString*)title;

-(void)setAsRead;

@end
