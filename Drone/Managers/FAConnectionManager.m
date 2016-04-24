//
//  FAConnectionManager.m
//  AlFardan
//
//  Created by Mohammad Salah on 8/3/15.
//  Copyright (c) 2015 smarteletec. All rights reserved.
//

#import "FAConnectionManager.h"

@interface FAConnectionManager ()

/* Stop the alerts about failure for 5 seconds since the 'cancelAllOperations' doesn't cancel all the operations */
//@property (nonatomic) NSTimer *timerToHoldAlerts;
//@property (nonatomic, assign) BOOL showFailureAlerts;

@end

@implementation FAConnectionManager

#pragma mark - Init

+(instancetype)shared
{
    static FAConnectionManager *instance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        instance = [[[self class] alloc] init];
    });
    
    return instance;
}

-(instancetype)init
{
    if(self = [super initWithBaseURL:[NSURL URLWithString:@""]])
    {
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        self.requestSerializer = [AFHTTPRequestSerializer serializer];
//        self.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", nil];

        _waitForConnection = YES;
        
        return self;
    }
    
    return nil;
}

#pragma mark - Setters

-(void)setWaitForConnection:(BOOL)waitForConnection
{
    _waitForConnection = waitForConnection;
    
    if(!waitForConnection)
    {
        // If the connection becomes availbale but its not connected to the internet the cancel all the operations, else continue on the queued operations
        if(!self.isConnected)
            [self.operationQueue cancelAllOperations];
        
        [self.operationQueue setSuspended:NO];
    }
}

#pragma mark - POST Requests

-(AnyPromise*)getWithService:(FAService*)service
{
    if(self.waitForConnection)
        [self.operationQueue setSuspended:YES];
    
    __block FAService *service_ = service;
    return [AnyPromise promiseWithResolverBlock:^(PMKResolver resolve)
            {
                if(!self.waitForConnection && ![self isConnected])
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [FAAlert alertWithType:NO_INTERNET_ACCESS];
                    });
                    resolve([self disconnectionError]);
                }
                else
                {
                    NSURLSessionDataTask *task = [FAConnectionManager.shared GET:service_.serviceName parameters:nil success:^(NSURLSessionDataTask *task, id responseObject)
                    {
                        dispatch_promise(^
                         {
//                             POLog(@"%@ \n %@ \n %@", service_.serviceName, service_.params, responseObject);
                             
                             NSError *error = nil;
                             
                             id response = [MTLJSONAdapter modelOfClass:service_.response fromJSONDictionary:responseObject error:&error];
                             
                             if(!error)
                             {
                                 resolve(response);
                             }
                             else
                             {
                                 [FAAlert generalServerError];
                                 resolve(error);
                             }
                         });
                        
                    } failure:^(NSURLSessionDataTask *task, NSError *error) {
                        //                            #if !ENABLE_DEVELOPMENT
//                        if(!(([error.domain isEqualToString:NSURLErrorDomain] && (error.code == NSURLErrorNotConnectedToInternet))))
//                            [FAAlert generalServerError];
                        //                            #endif
                        resolve(error);
                    }];
                    
//                    if(!service_.hideHUD)
//                        [self showprogressForTask:task];
                }
            }];
}

#pragma mark - Network Reachability

-(BOOL)isConnected
{
    return [AFNetworkReachabilityManager sharedManager].isReachable;
}

-(NSError*)disconnectionError
{
    NSError *error = [[NSError alloc] initWithDomain:@"com.drone" code:NSURLErrorNotConnectedToInternet userInfo:nil];
    return error;
}

@end
