
//  FAResponse.m
//  AlFardan
//
//  Created by Mohammad Salah on 8/3/15.
//  Copyright (c) 2015 smarteletec. All rights reserved.
//

#import "FAResponse.h"

@interface FAResponse ()

@property (nonatomic) BOOL isSuccess;
@property (nonatomic) id responseCode;
@property (nonatomic) NSString *message;
@property (nonatomic) id data;

@end

@implementation FAResponse

#pragma mark - Mantle Helpers

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"responseCode" : @"code",
             @"message" : @"message",
             @"data" : @"data"
             };
}

+(NSValueTransformer<MTLTransformerErrorHandling> *)numbersTransformer
{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        if([value isKindOfClass:NSString.class])
        {
            NSString *val = (NSString*)value;
            return @(val.integerValue);
        }
        else
        {
            NSNumber *val = (NSNumber*)value;
            return val;
        }
    } reverseBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        return value;
    }];
}

+(NSValueTransformer<MTLTransformerErrorHandling> *)decimalTransformer
{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        if([value isKindOfClass:NSString.class])
        {
            NSString *val = (NSString*)value;
            return @(val.doubleValue);
        }
        else
        {
            NSNumber *val = (NSNumber*)value;
            return val;
        }
    } reverseBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        return value;
    }];
}

+(NSValueTransformer *)formatNumbersJSONTransformer
{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSNumber *number, BOOL *success, NSError *__autoreleasing *error)
            {
                if([number isEqual:[NSNull null]] || number == nil)
                    return nil;
                
                double fNumber = number.doubleValue;
                NSString *stNum = [NSString stringWithFormat:@"%.2f", fNumber];
                return @(stNum.doubleValue);
            } reverseBlock:^id(NSString *number, BOOL *success, NSError *__autoreleasing *error) {
                return number;
            }];
}

+(NSValueTransformer *)toStringJSONTransformer
{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *text, BOOL *success, NSError *__autoreleasing *error)
            {
                return [NSString stringWithFormat:@"%f", text.floatValue];
            } reverseBlock:^id(NSString *text, BOOL *success, NSError *__autoreleasing *error) {
                return text;
            }];
}

#pragma mark - Getters

-(BOOL)isSuccess
{
    return self.responseCode.integerValue >= 1;
}

@end
