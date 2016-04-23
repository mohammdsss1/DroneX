//
//  FAService.m
//  AlFardan
//
//  Created by Mohammad Salah on 8/3/15.
//  Copyright (c) 2015 smarteletec. All rights reserved.
//

#import "FAService.h"

@interface FAServiceParent ()

@property (nonatomic) NSString *serviceName;
@property (nonatomic) NSDictionary *params;
@property (nonatomic) Class response;

@end

@implementation FAServiceParent

-(instancetype)initWithServiceName:(NSString*)servicename params:(NSDictionary*)params response:(Class)response
{
    if(self = [super init])
    {
        _serviceName = servicename;
        _params = params;
        _response = response;
        
        return  self;
    }
    
    return nil;
}

@end

@interface FAService()


@end

@implementation FAService

-(instancetype)initWithServiceNameAndToken:(NSString*)servicename params:(NSDictionary*)params response:(Class)response
{
    if(self = [super initWithServiceName:servicename params:params response:response])
    {
//        [self addUserID];
//        [self addToken];
        
        return self;
    }
    
    return nil;
}

-(instancetype)initWithServiceNameWithoutToken:(NSString*)servicename params:(NSDictionary*)params response:(Class)response
{
    if(self = [super initWithServiceName:servicename params:params response:response])
    {
//        [self addDeviceID];
        return  self;
    }
    
    return nil;
}

-(instancetype)initWithServiceName:(NSString*)servicename params:(NSDictionary*)params response:(Class)response
{
    if(self = [super initWithServiceName:servicename params:params response:response])
    {
        return  self;
    }
    
    return nil;
}
@end
