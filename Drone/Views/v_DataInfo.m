//
//  v_DataInfo.m
//  Drone
//
//  Created by Mohammad Salah on 4/22/16.
//  Copyright © 2016 Hammoda. All rights reserved.
//

#import "v_DataInfo.h"

@interface v_DataInfo ()

@property (nonatomic, weak) IBOutlet UILabel *lblTemp;
@property (nonatomic, weak) IBOutlet UILabel *lblWeather;
@property (nonatomic, weak) IBOutlet UILabel *lblHum;
@property (nonatomic, weak) IBOutlet UILabel *lblWind;
@property (nonatomic, weak) IBOutlet UILabel *lblWindDir;
@property (nonatomic, weak) IBOutlet UILabel *lblClar;
@property (nonatomic, weak) IBOutlet UILabel *lblSea;
@property (nonatomic, weak) IBOutlet UILabel *lblGround;
@property (nonatomic, weak) IBOutlet UILabel *lblPressure;
@property (nonatomic, weak) IBOutlet UILabel *lblDroneDir;

@end

@implementation v_DataInfo

-(void)fill:(DRWeatherInfo*)weather
{
    self.lblTemp.text = weather.main.temp;
    self.lblWeather.text = weather.weather.main;
    self.lblHum.text = weather.main.humidity.stringValue;
    self.lblWind.text = weather.wind.speed.stringValue;
    self.lblWindDir.text = weather.wind.degree;
    self.lblClar.text = @"12";
    self.lblSea.text = weather.main.sea_level.stringValue;
    self.lblGround.text = weather.main.grnd_level.stringValue;
    self.lblPressure.text = weather.main.pressure.stringValue;
}

-(void)fillDroneDirection:(double)dir
{
    self.lblDroneDir.text = [Func directionStringFromDeg:dir];
}

@end
