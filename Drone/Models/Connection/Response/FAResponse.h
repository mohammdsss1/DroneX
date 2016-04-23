//
//  FAResponse.h
//  AlFardan
//
//  Created by Mohammad Salah on 8/3/15.
//  Copyright (c) 2015 smarteletec. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FAMainModel.h"

/*!
 @class FAResponse
 @author Mohammad Salah
 @brief Base response structure represented by this class, other response classes will extend from this one
 */
@interface FAResponse : FAMainModel

@property (nonatomic, readonly) BOOL isSuccess;
@property (nonatomic, readonly) NSNumber *responseCode;
@property (nonatomic, readonly) NSString *message;
@property (nonatomic, readonly) id data;

+(NSDictionary *)JSONKeyPathsByPropertyKey;
+(NSValueTransformer<MTLTransformerErrorHandling> *)numbersTransformer;
+(NSValueTransformer<MTLTransformerErrorHandling> *)decimalTransformer;
+(NSValueTransformer *)formatNumbersJSONTransformer;
+(NSValueTransformer *)toStringJSONTransformer;

@end
