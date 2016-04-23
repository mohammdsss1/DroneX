//
//  DRData.h
//  Drone
//
//  Created by Mohammad Salah on 4/22/16.
//  Copyright © 2016 Hammoda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DRData : NSObject

+(instancetype)shared;

@property (nonatomic) DRWeatherList *weatherList;

@end
