//
//  CoordsList.m
//  Drone
//
//  Created by Mohammad Salah on 4/22/16.
//  Copyright © 2016 Hammoda. All rights reserved.
//

#import "CoordsList.h"

@implementation CoordsList

- (id)initWithPath:(GMSPath *)path {
    if ((self = [super init])) {
        _path = [path copy];
        _target = 0;
    }
    return self;
}

- (CLLocationCoordinate2D)next {
    ++_target;
    if (_target == [_path count]) {
        _target = 0;
    }
    return [_path coordinateAtIndex:_target];
}

@end
