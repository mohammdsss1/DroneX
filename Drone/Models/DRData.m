//
//  DRData.m
//  Drone
//
//  Created by Mohammad Salah on 4/22/16.
//  Copyright © 2016 Hammoda. All rights reserved.
//

#import "DRData.h"

@implementation DRData

#pragma mark - Init

+(instancetype)shared
{
    static DRData *instance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        instance = [[[self class] alloc] init];
    });
    
    return instance;
}


@end
