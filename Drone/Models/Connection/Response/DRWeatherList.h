//
//  DRWeather.h
//  Drone
//
//  Created by Mohammad Salah on 4/22/16.
//  Copyright © 2016 Hammoda. All rights reserved.
//

#import "FAResponse.h"

@class DRWeather, DRMain, DRWind, DRWeatherInfo;

@interface DRWeatherList : FAResponse

@property (nonatomic, readonly) NSArray <DRWeatherInfo*> *arrList;

@end

@interface DRWeatherInfo : FAResponse

@property (nonatomic, readonly) DRWeather *weather;
@property (nonatomic, readonly) DRMain *main;
@property (nonatomic, readonly) DRWind *wind;
@property (nonatomic, readonly) NSNumber *rain;
@property (nonatomic, readonly) NSString *clouds;
@property (nonatomic, readonly) CLLocationCoordinate2D coord;
@property (nonatomic, readonly) NSString *name;

@end


@interface DRWeather : FAResponse

@property (nonatomic, readonly) NSNumber *ID;
//@property (nonatomic, readonly) NSString *description;
@property (nonatomic, readonly) NSString *icon;
@property (nonatomic, readonly) NSString *main;

@end

@interface DRMain : FAResponse

@property (nonatomic, readonly) NSString *temp;
@property (nonatomic, readonly) NSNumber *humidity;
@property (nonatomic, readonly) NSNumber *pressure;
@property (nonatomic, readonly) NSNumber *temp_min;
@property (nonatomic, readonly) NSNumber *temp_max;
@property (nonatomic, readonly) NSNumber *grnd_level;
@property (nonatomic, readonly) NSNumber *sea_level;

@end

@interface DRWind : FAResponse

@property (nonatomic, readonly) NSNumber *speed;
@property (nonatomic, readonly) NSNumber *deg;
@property (nonatomic, readonly) NSString *degree;

@end
