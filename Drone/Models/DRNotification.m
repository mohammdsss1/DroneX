//
//  DRNotification.m
//  Drone
//
//  Created by Mohammad Salah on 4/22/16.
//  Copyright © 2016 Hammoda. All rights reserved.
//

#import "DRNotification.h"

@implementation DRNotification

-(instancetype)init:(NSString*)title
{
    if(self = [super init])
    {
        _title = title;
        _read = NO;
        
        return self;
    }
    
    return nil;
}

-(void)setAsRead
{
    self.read = YES;
}

-(BOOL)isEqual:(DRNotification*)object
{
    if(object == nil || [object isEqual:[NSNull null]])
        return NO;
    
    return [object.title isEqualToString:self.title];
}

-(NSUInteger)hash
{
    return self.title.hash;
}

@end
