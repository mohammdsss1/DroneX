//
//  CoordsList.h
//  Drone
//
//  Created by Mohammad Salah on 4/22/16.
//  Copyright © 2016 Hammoda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoordsList : NSObject

@property(nonatomic, readonly, copy) GMSPath *path;
@property(nonatomic, readonly) NSUInteger target;

- (id)initWithPath:(GMSPath *)path;

- (CLLocationCoordinate2D)next;

@end
