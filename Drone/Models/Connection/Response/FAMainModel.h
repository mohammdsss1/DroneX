//
//  FAMainModel.h
//  AlFardan
//
//  Created by Mohammad Salah on 8/10/15.
//  Copyright (c) 2015 smarteletec. All rights reserved.
//

#import <Mantle/Mantle.h>

/*!  @brief Super class which inherit from MTLModel and adopt the 'MTLJSONSerializing' protocol, just for code organsation abd decrease the inheritence and the adoption in each response class 
 */
@interface FAMainModel : MTLModel <MTLJSONSerializing>

@end
