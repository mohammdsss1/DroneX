//
//  FASharedAPI.m
//  AlFardan
//
//  Created by Mohammad Salah on 1/30/16.
//  Copyright © 2016 Smarteletec. All rights reserved.
//

#import "FASharedAPI.h"

@implementation FASharedAPI

+(instancetype)shared
{
    static FASharedAPI *instance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        instance = [[[self class] alloc] init];
    });
    
    return instance;
}

#pragma mark - Update Device ID
-(AnyPromise*)getWatherForCoordinate:(CLLocationCoordinate2D)coordinate
{
//    NSString *url = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/find?lat=%@&lon=%@&cnt=10&appid=%@", @(coordinate.latitude), @(coordinate.longitude), kAWeatherPIKey];
    NSString *url = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/forecast/city?id=250441&appid=%@", kAWeatherPIKey];
    
    FAService *service = [[FAService alloc] initWithServiceNameAndToken:url params:nil response:[DRWeatherList class]];
    service.hideHUD = YES;
    
    return [self promiseWithGetService:service];
}
@end
