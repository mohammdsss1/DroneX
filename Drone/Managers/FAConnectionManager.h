//
//  FAConnectionManager.h
//  AlFardan
//
//  Created by Mohammad Salah on 8/3/15.
//  Copyright (c) 2015 smarteletec. All rights reserved.
//

//#import <AFNetworking/AFNetworking.h>
#import "AFNetworking.h"
#import "FAService.h"

@interface FAConnectionManager : AFHTTPSessionManager

/**
 * @author Mohammad Salah
 * @return Singletone class which can be used to call the websrvices methods
 */
+(instancetype)shared;

/**
 * @author Mohammad Salah
 * @param service All needed data to initiate the request
 * @return Starts a GET request, and return PMKPromise as a block completion
 */
-(AnyPromise*)getWithService:(FAService*)service;

-(BOOL)isConnected;

@property (nonatomic, assign) BOOL waitForConnection;

@end
