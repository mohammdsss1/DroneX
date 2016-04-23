//
//  Func.h
//  AlFardan
//
//  Created by Mahran Bayed on 6/9/15.
//  Copyright (c) 2015 Smarteletec. All rights reserved.
//

#import <Foundation/Foundation.h>

@import GoogleMaps;

#import "NSString+FontAwesome.h"
#import <objc/runtime.h>
#import "AppDelegate.h"
#import "M13BadgeView.h"
#import "MRProgressOverlayView+AFNetworking.h"
#import "FASharedAPI.h"
#import "DRData.h"

@class FABarButtonItem, v_IntroView;

typedef void (^block)(void);

@interface Func : NSObject

#pragma mark - Define For macros Method
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define APP_ISARABIC [L102Language isArabic]//[[[[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"] firstObject] hasPrefix:@"ar"]
#define APP_ISENGLISH ![L102Language isArabic]//[[[[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"] firstObject] hasPrefix:@"en"]

#define LOCALIZED_STRING(v) NSLocalizedStringFromTable(v, @"Localizable", nil)

#define PARENT_UIALERTCONTROLER @"PARENT_UIALERTCONTROLER"

#define getPARENT_UIALERTCONTROLER(action) (UIAlertController*) objc_getAssociatedObject(action, PARENT_UIALERTCONTROLER)

#define IMAGE_SELECTED [UIImage imageNamed:@"SelectedLanguage"]
#define IMAGE_NOT_SELECTED [UIImage imageNamed:@"SelectedLanguageNone"]

#pragma mark - shared func method

NS_ASSUME_NONNULL_BEGIN

/**
 * return the date to string formated in the current timezone
 * @author Mahran Bayed
 *
 * @param date to be converted
 * @return A newly string contain the data in the time zone
 */
+( NSString* _Nonnull )stringFromDate:( NSDate* _Nonnull )date;

/**
 * return the string encoded from image to base 64
 * @author Mahran Bayed
 *
 * @param image to be converted
 * @return A newly string contain the data in the base 64
 */
+(NSString *)encodeToBase64String:(UIImage *)image;

/**
 * return the base 64 string decoded from image
 * @author Mahran Bayed
 *
 * @param str 64 base to be converted
 * @return A newly image decoded from the data in the base 64
 */
+(UIImage *)decodeBase64ToImage:(NSString *)strEncodeData;

/**
 * return the string encoded from audio to base 64
 * @author Mohammad Salah
 *
 * @param image to be converted
 * @return A newly string contain the data in the base 64
 */
+(NSString *)encodeAudioToBase64String:(NSString *)fileURL;

/**
 * return YES if the email is a valid email
 * @author Mahran Bayed
 *
 * @param email string to be checked
 * @return YES if email is valid email otherwise NO
 */
+(BOOL) isValideEmail: (NSString *) email;

/**
 * return YES if the text is a numeric only
 * @author Mahran Bayed
 *
 * @param text string to be checked
 * @return YES if text is valid numeric otherwise NO
 */
+(BOOL) isValideNumeric: (NSString *) text;


/**
 * return YES if the mobile number is valid
 * @author Mohammad Salah
 *
 * @param mobile number string to be checked
 * @return YES if mobile number is valid otherwise NO
 */
+(BOOL)isValideMobileNumber:(NSString *)mobile;

/**
 * Start activity indicator in the top view controler
 * @author Mahran Bayed
 *
 */
+(void)startActivityIndicatorOnTopMainViewCotroler;

/**
 * Stop activity indicator that start in the top view controler.
 * If not started early then nothing happened
 * @author Mahran Bayed
 *
 */
+(void)stopActivityIndicator;

/**
 * return the top most view controler in the current active window
 * @author Mahran Bayed
 *
 * @return the current top most view controler in the cureent window
 */
+ (UIViewController*) topMostController;

/**
 * show alertView in the current top most active view Cotroler
 * @author Mahran Bayed
 *
 * @param title the title of the alert view
 * @param message the body of the alert view msg
 * @param cancelTitle the title of the cancel button in the alert view
 * @param cancelAction the actino of the cancel button in the alert view
 * @param otherTitle the title of the other button in the alert view
 * @param otherAction the action of the other button in the alert view
 */
+(void)showAlertWithTitle:(NSString* _Nonnull)title andMessage:(NSString*)message andCancelButtonTitle:(NSString*)cancelTitle withAlertAction:(void (^)(UIAlertAction *action))cancelAction andOtherButtonTitle:(nullable NSString*)otherTitle withAlertAction:(nullable void (^)(UIAlertAction *action))otherAction;

+(UIAlertController*)showActionSheetFrom:(UIViewController*)controller title:(NSString*)title action1:(NSString*)action1 action1Handler:(void(^)(UIAlertAction * _Nonnull action))action1Handler action2:(nullable NSString*)action2 action2Handler:(nullable void(^)(UIAlertAction * _Nonnull action))action2Handler destructiveTitle:(nullable NSString*)destructiveTitle destructiveHandler:(nullable void(^)(UIAlertAction * _Nonnull action))destructiveHandler;

+(UIAlertController*)showActionSheetFrom:(UIViewController*)controller title:(NSString*)title destructiveTitle:(NSString*)destructiveTitle destructiveHandler:(void(^)(UIAlertAction * _Nonnull action))destructiveHandler actions:(id)actions, ... NS_REQUIRES_NIL_TERMINATION;

+(void)smsTo:(NSString*)number fromController:(UIViewController*)controller subject:(NSString*)subject;

/**
 * return random string with nedded length
 * @author Mahran Bayed
 *
 * @param len the length of the string to be generated
 * @return the generated random string with the required len
 */
+(NSString *) randomStringWithLength: (int) len;

/**
 * return UIAlertController with activity contrloer in it to be use in the loading or requsting services
 * @author Mahran Bayed
 *
 * @return alert with activity in it
 */
+(UIAlertController*)alertWithActivity;

/**
 * register for keyboard Show notification to observe the animation of it
 * @author Mahran Bayed
 * @param object the target class to be regestire in it
 * @param sel the target selector in the target object to be called on the keyboard notification
 *
 */
+(void)registerForKeyboardShowNotificationsIn:(id)object withSelector:(SEL)sel;


/**
 * register for keyboard Hide notification to observe the animation of it
 * @author Mahran Bayed
 * @param object the target class to be regestire in it
 * @param sel the target selector in the target object to be called on the keyboard notification
 *
 */
+(void)registerForKeyboardHideNotificationsIn:(id)object withSelector:(SEL)sel;

/**
 * deRegister the target for keyboard notification 
 * @author Mahran Bayed
 * @param object the target class to deregestire in it
 *
 */
+(void)deRegisterForKeyboardNotificationsIn:(id)object;

/**
 * init toolbar on the textfield withen the active target with selector for prev, next and done button action
 * @author Mahran Bayed
 * @param tfield the text field to attache the toolbat on it
 * @param activeTarget the target class to be called in any action
 * @param preSelector the prev target selector in the target object to be called when pressed on the prev button
 * @param nexSelector the next target selector in the target object to be called when pressed on the next button
 * @param doneSeletor the done target selector in the target object to be called when pressed on the done button
 * @param haveNext the enabled state of the next button
 * @param havaPrev the enabled state of the Prev button
 *
 */
+(void)initToolBarOnTextField:(UITextField*)tfield andActiveClass:(id)activeTarget withPrevSelector:(nullable SEL)preSelector andNextSelect:(nullable SEL)nexSelector andDoneSelect:(SEL)doneSeletor andHasNext:(bool)haveNext andHasPrev:(bool)havaPrev;

/**
 * Show lable on center of the required view
 * @author Mahran Bayed
 * @param title the title of the label to be presented in the view
 * @param image the image to be presented above the label in the view
 * @param parentView the view we want to present label on it's center
 *
 */
+(void)showLabelOnScreenCenterWithTitle:(NSString*)title andImage:(nullable UIImage*)image onView:(UIView*)parentView;

/**
 * hide the prev showed lable and image on center of the view
 * @author Mahran Bayed
 * @param parentView the view we want to remove label from it's center
 *
 */
+(void)hideLabelOnScreenCenterWithTitleAndImageOnView:(UIView*)parentView;

/**
 * Show page control on top of the required viewController
 * @author Mahran Bayed
 * @param pagesCount the count of the pages
 * @param pageNo the current index of the page
 * @param isCleardColor the color of background if clear or not
 * @param parentController the viewController we want to present label on it's center
 *
 */
+(void)showPageControlOnScreenWithNumberOfPages:(int)pagesCount andCurrentPageNo:(int)pageNo withClearColor:(BOOL)isCleardColor onViewController:(UIViewController*)parentController;

/**
 * hide the prev showed page control on top of the view
 * @author Mahran Bayed
 * @param parentView the viewController we want to remove page control from it's center
 *
 */
+(void)hidePageControlOnScreenFromViewController:(UIViewController*)parentController;

/**
 *  Resize UIImage by keeping Aspect ratio and width
 * @author Mahran Bayed
 * @param sourceImage the image we want to resize
 * @param i_width the width to be the image in
 *
 * @return the resized image with width
 */
+(UIImage*)imageWithImage: (UIImage*) sourceImage scaledToWidth: (float) i_width;

/**
 *  Register the device for remote push notification in ios 7,8
 * @author Mahran Bayed
 *
 */
+(void)registerForNotification;

/**
 *  Change placeholder color for the text field
 * @author Mahran Bayed
 * @param tfield the text field we want to change it's placeholder color
 * @param color the color that placeholder to be in
 *
 */
+(void)setTextField:(UITextField*)tfield placeHolderColor:(UIColor*)color;


/**
 *  Change active button color for the drawer menue
 * @author Mahran Bayed
 * @param activeTag the tag for the button we want to change
 *
 */
+(void)setActiveWindowOnDrawerMenue:(NSInteger)activeTag;

/**
 *  draw UIImage from fontawesam with required size and color
 * @author Mahran Bayed
 * @param icon the Font awesam icon we want to draw
 * @param iconSize the size to be the icon in
 * @param color the color of icon to be used
 *
 * @return the drawed image with size and color
 */
+(UIImage *)imageFromIcon:(FAIcon)icon withSize:(int)iconSize andColor:(UIColor*)color;

/**
 *  attach M13BadgeView to any view and return reference to it
 * if the view have one return it , else make new one
 * @author Mahran Bayed
 * @param view the view you want to attach
 *
 * @return the M13BadgeView iattached to the view
 */
+(M13BadgeView*)attachedBadgeViewTo:(UIView*)view;
/**
 * Resize the image to the soecified size
 * @author Mohammad Salah
 * @param image the image to be resized
 * @param size the desired size
 *
 * @return A new image with the new size
 */
+(UIImage*)resizeImage:(UIImage*)image newSize:(CGSize)size;

/**
 *  call number and also show error if not avalible sim
 *
 * @author Mahran Bayed
 * @param mobNum the number you want to call
 *
 */
+(void)callNumber:(NSString *)mobNum;

/**
 *  check if apssword between 6-12 char with at least one Char and one Leter and optinal an special Chars-witohut space- and if contain substring of 3 identical char and more than 3 identical char in the password and password don't contain the username
 * @author Mahran Bayed
 * @param mustShow enfore info to load even if it's alrady presented
 *
 */
+(BOOL)checkIsComplexPassword:(NSString*)Pass;

/**
 * Format the double value into two decimal places and add $ sign
 * @author Mohammad Salah
 * @param value the double value which will be formatted
 *
 */
+(NSString*)formatDoubleValue:(double)value;

/**
 * Compute the text size based on the font and width provided
 * @author Mohammad Salah
 *
 */
+(CGSize)sizeFprText:(NSString*)text width:(CGFloat)width font:(UIFont*)font;

#pragma mark - Font Selections

+(UIFont*)boldFont:(CGFloat)size;
+(UIFont*)mediumFont:(CGFloat)size;
+(UIFont*)lightFont:(CGFloat)size;

+(void)setupRightButton:(UIViewController*)controller selector:(SEL)selector;
+(void)addBarButtonForController:(UIViewController*)controller;
+(UIBarButtonItem*)setupIWillGuideDriverButton:(UIViewController*)controller selector:(nonnull SEL)selector;
+(void)removeLeftButton:(UIViewController*)controller;

/**
 * Open UIActivityViewController for contents sharing
 * @param message text message
 * @param url link
 * @author Mohammad Salah
 *
 */
+(void)openShareForController:(UIViewController*)controller message:(NSString*)message url:(NSURL*)url;

/**
 * Show Alert View with a message
 * @param message text message
 * @author Mohammad Salah
 *
 */
+(void)showMessage:(NSString*)message;
+(void)showMessage:(NSString*)message completion:(void(^)(void))completion;

//+(SFSafariViewController *)openSafariFromController:(id)controller url:(NSString*)url presentExternally:(BOOL)presentExternally;

/**
 * @author Mohammmad Salah
 *
 * @param tryAgain completion block once "Try Again" button tapped
 * @param controler to be presened or pushed from it
 * @brief show the no connection view with try again button in the
 */
//+(void)loadConnectionErrorPageFromController:(UIViewController*)controller tryAgaian:(TryAgain)tryAgain animated:(BOOL)animated;

/**
 *  show intro on a specific view controller
 * @author Mohammad Salah
 * @param fromController from where the page will be presented
 *
 */

+(void)drawLayerBorder:(UIView* _Nonnull)view;

+(void)fillRatingView:(float)fRating images:(NSArray*)arrStars;

#ifdef CustomerApp
+(void)loadNotificationDeatilsViewFrom:(UIViewController *)controler message:(FAMessage*)message;
+(void)loadBookingReminder:(UIViewController *)controler requestID:(NSString*)requestID;

#endif

+(void)shake:(NSInteger)times direction:(NSInteger)direction currentTimes:(NSInteger)current withDelta:(CGFloat)delta speed:(NSTimeInterval)interval textField:(UIView*)textField;
+(id)instantiateControllerFromClass:(Class)myClass;
+(NSString*)directionStringFromDeg:(double)fNumber;

//+(MZFormSheetController*)createFromSheetController:(UIViewController*)controller size:(CGSize)size;
#pragma mark - Dispatcher Helpers

void perormOnMainQueueAfter(int seconds, block block);

+ (CLLocationCoordinate2D)centerCoordinateForCoordinates:(NSArray <CLLocation*>*)coordinateArray;

NS_ASSUME_NONNULL_END

+(void)showMessage:(nonnull NSString*)title message:(nonnull NSString*)message completion:(nullable void(^)(void))completion;

@end
