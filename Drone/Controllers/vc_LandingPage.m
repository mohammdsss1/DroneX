//
//  vc_LandingPage.m
//  Drone
//
//  Created by Mohammad Salah on 4/22/16.
//  Copyright © 2016 Hammoda. All rights reserved.
//

#import "vc_LandingPage.h"

#import "WHPickerViewManager.h"

@interface vc_LandingPage () <WHPickerViewManagerDelegate, UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UITextField *tfIP;
@property (nonatomic, weak) IBOutlet UITextField *tfDroneName;

@property (nonatomic) WHPickerViewManager *pickerManager;

@end

@implementation vc_LandingPage

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.pickerManager = [WHPickerViewManager createWithController:self];
    self.pickerManager.arrObjects = @[@"DJI Phantom 4", @"DJI Phantom 3", @"Yuneec Q500 4K", @"3DR Solo"];
}

-(void)setupAndShowPicker
{
    if(self.pickerManager.superview)return;
    
    [self.pickerManager.pickerView selectRow:0 inComponent:0 animated:NO];
    //    [self.view insertSubview:self.pickerManager atIndex:10];
    UIView *view = self.view;//[WHGeneralUtil getMainWindow];
    [view insertSubview:self.pickerManager atIndex:10];
    
    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:self.pickerManager attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:self.pickerManager attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.pickerManager attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:self.pickerManager attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    
    [view addConstraints:@[left, right, top, bottom]];
    
    self.pickerManager.alpha = 0;
    [self.pickerManager applyAnimation:YES];
}

-(IBAction)tapOnMainMap:(id)sender
{
    if(self.tfIP.text.length == 0 || self.tfDroneName.text.length == 0)return;
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    MRProgressOverlayView *overlayView =[MRProgressOverlayView showOverlayAddedTo:keyWindow animated:YES];
    overlayView.titleLabelText = @"Connecting...";
    overlayView.tintColor = UIColorFromRGB(0xe91e63);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        overlayView.titleLabelText = @"Connected!";
        overlayView.mode = MRProgressOverlayViewModeCheckmark;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^
        {
            [overlayView dismiss:YES completion:^{
                [[AppDelegate appDelegate].initial openMainMap];
            }];
        });
    });
}

#pragma mark - WHPickerViewManagerDelegate

-(void)pickerViewManager:(WHPickerViewManager *)pickerViewManager didSelectItem:(id)object
{
    self.tfDroneName.text = object;
}

#pragma mark - Text Field

-(void)textFieldDone
{
    [self.tfIP resignFirstResponder];
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if([textField isEqual:self.tfDroneName] && self.tfIP.isFirstResponder)
        return NO;
    
    if([textField isEqual:self.tfIP])
    {
        [Func initToolBarOnTextField:textField andActiveClass:self withPrevSelector:nil andNextSelect:nil andDoneSelect:@selector(textFieldDone) andHasNext:NO andHasPrev:NO];
        
        return YES;
    }
    
    [self setupAndShowPicker];
    
    return NO;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

@end
