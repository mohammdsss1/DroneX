//
//  FAAPI.m
//  AlFardan
//
//  Created by Mohammad Salah on 8/3/15.
//  Copyright (c) 2015 smarteletec. All rights reserved.
//

#import "FAAPI.h"

@implementation FAAPI

//#ifdef CustomerApp
-(AnyPromise*)promiseWithGetService:(FAService*)service
{
    return [[FAConnectionManager shared] getWithService:service];
}
//#endif

@end
