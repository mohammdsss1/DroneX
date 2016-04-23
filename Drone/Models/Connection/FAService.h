//
//  FASService.h
//  AlFardan
//
//  Created by Mohammad Salah on 8/3/15.
//  Copyright (c) 2015 smarteletec. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FAResponse.h"

@interface FAServiceParent : NSObject

/*! Name of the service */
@property (nonatomic, readonly) NSString *serviceName;

/*! Service params */
@property (nonatomic, readonly) NSDictionary *params;

/*! The rsponse type that will hold webservice response */
@property (nonatomic, readonly) Class response;

/*! Show/Hide the progress HUD loading */
@property (nonatomic) BOOL hideHUD;

/**
 * @brief Use this method to wrap the service needed data before initiate the request
 * @author Mohammad Salah
 * @param servicename Name of the service
 * @param Service params
 * @param response the rsponse type that will hold webservice response
 * @return Instance of BEService
 */
-(instancetype)initWithServiceName:(NSString*)servicename params:(NSDictionary*)params response:(Class)response;

@end

/*!
 @class FAService
 @author Mohammad Salah
 @brief Wrap any needed info for the service to be ready
 */
@interface FAService : FAServiceParent

/**
 * @brief Use this method to wrap the service needed data before initiate the request
 * @author Mohammad Salah
 * @param servicename Name of the service
 * @param Service params
 * @param response the rsponse type that will hold webservice response
 * @return Instance of BEService
 * @note this will include the User id + token automatically
 */
//-(instancetype)initWithServiceName:(NSString*)servicename params:(NSDictionary*)params response:(Class)response;

/**
 * @brief Use this method to wrap the service needed data before initiate the request
 * @author Mohammad Salah
 * @param servicename Name of the service
 * @param Service params
 * @param response the rsponse type that will hold webservice response
 * @return Instance of BEService
 * @note this will include the device id & token automatically
 */
-(instancetype)initWithServiceNameAndToken:(NSString*)servicename params:(NSDictionary*)params response:(Class)response;

/**
 * @brief Use this method to wrap the service needed data before initiate the request
 * @author Mohammad Salah
 * @param servicename Name of the service
 * @param Service params
 * @param response the rsponse type that will hold webservice response
 * @return Instance of BEService
 * @note this will include the token automatically
 */
-(instancetype)initWithServiceNameWithoutToken:(NSString*)servicename params:(NSDictionary*)params response:(Class)response;

-(instancetype)initWithServiceName:(NSString*)servicename params:(NSDictionary*)params response:(Class)response;

@end
