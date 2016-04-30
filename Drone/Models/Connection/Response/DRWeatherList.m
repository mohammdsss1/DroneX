//
//  DRWeather.m
//  Drone
//
//  Created by Mohammad Salah on 4/22/16.
//  Copyright © 2016 Hammoda. All rights reserved.
//

#import "DRWeatherList.h"

@interface DRWeatherList()

@property (nonatomic) NSArray <DRWeatherInfo*> *arrList;
@property (nonatomic) NSString *cod;

@end

@implementation DRWeatherList

#pragma mark - Mantle Helpers

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"arrList" : @"list",
             @"cod" : @"cod"
             };
}

+(NSValueTransformer *)arrListJSONTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:[DRWeatherInfo class]];
}

-(BOOL)isSuccess
{
    return [self.cod isEqualToString:@"200"];
}

@end

@interface DRWeatherInfo()

@property (nonatomic) DRWeather *weather;
@property (nonatomic) DRMain *main;
@property (nonatomic) DRWind *wind;
@property (nonatomic) NSNumber *rain;
@property (nonatomic) NSString *clouds;
@property (nonatomic) CLLocationCoordinate2D coord;
@property (nonatomic) NSString *name;
@property (nonatomic) NSNumber *lat;
@property (nonatomic) NSNumber *lon;
@property (nonatomic) NSArray <DRWeather*> *arrWeather;

@end

@implementation DRWeatherInfo

#pragma mark - Mantle Helpers

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"arrWeather" : @"weather",
             @"main" : @"main",
             @"wind" : @"wind",
             @"lat" : @"coord.lat",
             @"lon" : @"coord.lon",
             @"rain" : @"rain.3h",
             @"name" : @"name"
             };
}

+(NSValueTransformer *)arrWeatherJSONTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:[DRWeather class]];
}

-(CLLocationCoordinate2D)coord
{
    return CLLocationCoordinate2DMake(self.lat.doubleValue, self.lon.doubleValue);
}

-(DRWeather*)weather
{
    return self.arrWeather.firstObject;
}

@end

@interface DRWeather()

@property (nonatomic) NSNumber *ID;
@property (nonatomic) NSString *desc;
@property (nonatomic) NSString *icon;
@property (nonatomic) NSString *main;

@end

@implementation DRWeather

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"ID" : @"id",
             @"desc" : @"description",
             @"icon" : @"icon",
             @"main" : @"main"
             };
}

-(NSString*)description
{
    return self.desc;
}

@end

@interface DRMain()

@property (nonatomic) NSString *temp;
@property (nonatomic) NSNumber *humidity;
@property (nonatomic) NSNumber *pressure;
@property (nonatomic) NSNumber *temp_min;
@property (nonatomic) NSNumber *temp_max;
@property (nonatomic) NSNumber *grnd_level;
@property (nonatomic) NSNumber *sea_level;

@end

@implementation DRMain

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"temp" : @"temp",
             @"humidity" : @"humidity",
             @"pressure" : @"pressure",
             @"temp_min" : @"temp_min",
             @"temp_max" : @"temp_max",
             @"grnd_level" : @"grnd_level",
             @"sea_level" : @"sea_level"
             };
}

+(NSValueTransformer *)tempJSONTransformer
{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *temp, BOOL *success, NSError *__autoreleasing *error)
            {
                if([temp isEqual:[NSNull null]] || temp == nil)
                    return @"0°";
                
                NSInteger fNumber = temp.integerValue - 273.15;
                NSString *stDesc = [NSString stringWithFormat:@"%ld°", (long)fNumber];
                return stDesc;
            } reverseBlock:^id(NSString *number, BOOL *success, NSError *__autoreleasing *error) {
                return number;
            }];
}

+(NSValueTransformer *)grnd_levelJSONTransformer
{
    return [FAResponse formatNumbersJSONTransformer];
}

+(NSValueTransformer *)sea_levelJSONTransformer
{
    return [FAResponse formatNumbersJSONTransformer];
}

@end

@interface DRWind()

@property (nonatomic) NSNumber *speed;
@property (nonatomic) NSNumber *deg;
@property (nonatomic) NSString *degree;

@end

@implementation DRWind

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"speed" : @"speed",
             @"deg" : @"deg"
             };
}

-(NSString *)degree
{
    if(!_degree)
    {
        if([self.deg isEqual:[NSNull null]] || self.deg == nil)
            return @"";
        
        double fNumber = self.deg.doubleValue;
        NSString *stDesc = [Func directionStringFromDeg:fNumber];
        _degree = stDesc;
    }
    
    return _degree;
}

@end
