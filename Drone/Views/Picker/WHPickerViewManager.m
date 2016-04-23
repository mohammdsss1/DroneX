//
//  BEPickerViewManager.m
//  WorkingHours
//
//  Created by Mohammad Salah on 9/1/15.
//  Copyright (c) 2015 Hammoda. All rights reserved.
//

#import "WHPickerViewManager.h"

@interface WHPickerViewManager ()

@property (nonatomic, weak) id controller;
@property (nonatomic, weak) IBOutlet UIButton *btnDone;
@property (nonatomic, weak) id<WHPickerViewManagerDelegate> delegate;

@property (nonatomic) NSString *selectedDrone;

@end

@implementation WHPickerViewManager
{
}

@synthesize arrObjects = _arrObjects;

#pragma mark - Init

+(instancetype)createWithController:(id)controller
{
    WHPickerViewManager *instance = nil;
    NSArray *arNibs = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil];
    for(id object in arNibs)
    {
        if([object isKindOfClass:[self class]])
        {
            instance = object;
            break;
        }
    }
    
    instance.controller = controller;
    instance.delegate = controller;
    instance.translatesAutoresizingMaskIntoConstraints = NO;
    [instance.btnDone setTitle:LOCALIZED_STRING(@"Done") forState:UIControlStateNormal];
    
    return instance;
}

#pragma mark - UI Actions

-(IBAction)tapOnDone:(id)sender
{
    [self applyAnimation:NO];
    
    if(!self.selectedDrone || self.selectedDrone.length == 0)
        self.selectedDrone = self.arrObjects.firstObject;
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(pickerViewManager:didSelectItem:)])
        [self.delegate pickerViewManager:self didSelectItem:self.selectedDrone];
    
    self.selectedDrone = nil;
}

#pragma mark - Methods

-(void)applyAnimation:(BOOL)show
{
    if(show)
        [self.pickerView reloadAllComponents];
//    CGRect frame = self.frame;
//    CGFloat yAxis = show ? 0 : CGRectGetHeight(self.superview.frame) - frame.size.height;
    
//    self.constBottom.constant = yAxis;
    [UIView animateWithDuration:0.3 animations:^
     {
         self.alpha = show;
//         [self layoutIfNeeded];
     } completion:^(BOOL finish)
     {
         if(!show)
             [self removeFromSuperview];
     }];
}

#pragma mark - Setters

-(void)setArrObjects:(NSArray *)arrObjects
{
    _arrObjects = nil;
    _arrObjects = arrObjects;
    [self.pickerView reloadAllComponents];
}

#pragma mark - UIPickerViewDataSource - UIPickerViewDelegate

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.arrObjects.count;
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    id object = self.arrObjects[row];
    
    return object;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
//    if(self.delegate && [self.delegate respondsToSelector:@selector(pickerViewManager:didSelectItem:)])
//        [self.delegate pickerViewManager:self didSelectItem:self.arrObjects[row]];
    self.selectedDrone = self.arrObjects[row];
}


@end
