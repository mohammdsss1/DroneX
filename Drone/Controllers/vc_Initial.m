//
//  vc_Initial.m
//  Drone
//
//  Created by Mohammad Salah on 4/22/16.
//  Copyright © 2016 Hammoda. All rights reserved.
//

#import "vc_Initial.h"

#import "vc_LandingPage.h"
#import "vc_MainMap.h"

@implementation vc_Initial

-(void)viewDidLoad
{
    vc_LandingPage *landingPage = [Func instantiateControllerFromClass:vc_LandingPage.class];
    [self hopToViewController:landingPage then:^{}];
    
    [FASharedAPI.shared getWatherForCoordinate:CLLocationCoordinate2DMake(31.88542, 35.854301)].then(^(DRWeatherList *response)
    {
        if(response.isSuccess)
        {
            [DRData.shared setWeatherList:response];
        }
    });
}

-(void)openMainMap
{
    vc_MainMap *mainMap = [Func instantiateControllerFromClass:vc_MainMap.class];
    [self hopToViewController:mainMap then:^{}];
}

@end
