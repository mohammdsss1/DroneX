//
//  BEPickerViewManager.h
//  WorkingHours
//
//  Created by Mohammad Salah on 9/1/15.
//  Copyright (c) 2015 Hammoda. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WHPickerViewManager;

@protocol WHPickerViewManagerDelegate <NSObject>

-(void)pickerViewManager:(WHPickerViewManager*)pickerViewManager didSelectItem:(id)object;

@end

@interface WHPickerViewManager : UIView <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic) IBOutlet UIPickerView *pickerView;

@property (nonatomic) NSArray *arrObjects;
@property (nonatomic) CGFloat *fHeight;

+(instancetype)createWithController:(id)controller;

-(void)applyAnimation:(BOOL)show;

@end
