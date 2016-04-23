//
//  FASharedAPI.h
//  AlFardan
//
//  Created by Mohammad Salah on 1/30/16.
//  Copyright © 2016 Smarteletec. All rights reserved.
//

#import "FAAPI.h"

#import "DRWeatherList.h"

@interface FASharedAPI : FAAPI

+(instancetype)shared;

#pragma mark - Update Device ID
-(AnyPromise*)getWatherForCoordinate:(CLLocationCoordinate2D)coordinate;

@end
