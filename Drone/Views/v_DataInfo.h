//
//  v_DataInfo.h
//  Drone
//
//  Created by Mohammad Salah on 4/22/16.
//  Copyright © 2016 Hammoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface v_DataInfo : UIView

-(void)fill:(DRWeatherInfo*)weather;
-(void)fillDroneDirection:(double)dir;

@end
