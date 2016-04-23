//
//  POAPI.h
//  AlFardan
//
//  Created by Mohammad Salah on 8/3/15.
//  Copyright (c) 2015 smarteletec. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FAConnectionManager.h"

/*! 
 @class FAAPI
 @brief This class and its subclasses are responsible for interacting with connection manager which call the server directly, by receving the specific params for the service initiate the request then pass the final response to the first caller
 */
@interface FAAPI : NSObject

-(AnyPromise*)createPromiseWithService:(FAService*)service;

//#ifdef CustomerApp
-(AnyPromise*)promiseWithGetService:(FAService*)service;
//#endif


@end
