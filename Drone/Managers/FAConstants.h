//
//  BEConstants.h
//  AlFardan
//
//  Created by Mohammad Salah on 8/3/15.
//  Copyright (c) 2015 smarteletec. All rights reserved.
//

#import <Foundation/Foundation.h>

// Google Maps Service key
static NSString *const kAPIKey = @"AIzaSyCmqQ0fEFkpq2th6e2NsQ1T5PN_7EvHVn4";
static NSString *const kAWeatherPIKey = @"c72f33a3062f07806bf704906f779a6d";

@interface FAConstants : NSObject

#pragma mark - Test Only Purposes

#define USER_ID @"Salah"
#define USER_PASS @"123456"
#define DEVICE_ID @"6b97c5a173144e6a4d90921e51561295bc0dec928907af3a951f897aca26e2c4"
#define USER_TOKEN @"fbb023e0832f811915f02fd852a5e99aae6e458a589ee7946ccada2cf9a4fef0d8cac9d3ff599e2da9f045bf4ecd4c55"

#ifdef CustomerApp
#define ENABLE_DEVELOPMENT 0
#else
#define ENABLE_DEVELOPMENT 0
#endif

#define IS_OS_8_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE_4 (IS_IPHONE && ([[UIScreen mainScreen] bounds].size.height == 480.0) && (([UIScreen mainScreen].nativeScale == [UIScreen mainScreen].scale) || !IS_OS_8_OR_LATER))
#define IS_IPHONE_5 (IS_IPHONE && ([[UIScreen mainScreen] bounds].size.height == 568.0) && ((IS_OS_8_OR_LATER && [UIScreen mainScreen].nativeScale == [UIScreen mainScreen].scale) || !IS_OS_8_OR_LATER))
#define IS_STANDARD_IPHONE_6 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 667.0  && IS_OS_8_OR_LATER && [UIScreen mainScreen].nativeScale == [UIScreen mainScreen].scale)
#define IS_ZOOMED_IPHONE_6 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 568.0 && IS_OS_8_OR_LATER && [UIScreen mainScreen].nativeScale > [UIScreen mainScreen].scale)
#define IS_STANDARD_IPHONE_6_PLUS (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 736.0)
#define IS_ZOOMED_IPHONE_6_PLUS (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 667.0 && IS_OS_8_OR_LATER && [UIScreen mainScreen].nativeScale < [UIScreen mainScreen].scale)

#define USER_SECRET @"]75vgD~w=uhG'\\/M" //]75vgD~w=uhG'\/M

// Storyboard Refrences
#define STB_SIGNUP_LOGIN @"SignupLogin"
#define STB_PAYMENT      @"Payment"
#define STB_RIDE_AN_DMAP @"RideAndMap"
#define STB_PROFILE      @"Profile"
#define STB_DRAWER_MENU  @"DrawerMenu"

//Fonts
#define FONT_BOLD_EN_NAME @"ROBOTO-BOLD"
#define FONT_MEDIUM_EN_NAME @"ROBOTO-MEDIUM"
#define FONT_LIGHT_EN_NAME @"ROBOTO-LIGHT"

#define UserDefaultManager [NSUserDefaults standardUserDefaults]

#define INAVALIDE_TOKEN_ID @-6
#define MOBILE_ALREADY_REGISTERED @-7
#define EMAIL_ADDRESS_REGISTERED @-8

#define DROP_OFF_ID @"-1"

#define DOHA_LOCATION CLLocationCoordinate2DMake(25.305179, 51.526014)

#define STAR_ON [UIImage imageNamed:@"StarOn"]
#define STAR_ON_HALF [UIImage imageNamed:@"StarOnHalf"]
#define STAR_OFF [UIImage imageNamed:@"StarOff"]
#define DRIVER_PLACEHOLDER_IMAGE [UIImage imageNamed:@"DriverPlaceholder"]

#pragma mark - Web Service Keys

extern NSString * const FA_BASE_URL;
extern NSString * const FA_RESPONSE_CODE;
extern NSString * const FA_RESPONSE_CODE_MESSAGE;

extern NSInteger const FA_SUCCESS;

extern NSString * const FA_TOKEN_KEY;
extern NSString * const FA_USER_ID_KEY;
extern NSString * const FA_USER_NAME_KEY;
extern NSString * const FA_USER_ROLE_KEY;

#pragma mark - Login
extern NSString * const FA_CHECK_LOGIN_API;
extern NSString * const FA_LOGIN_ID_KEY;
extern NSString * const FA_PASSWORD_KEY;
extern NSString * const FA_DEVICE_ID_KEY;
extern NSString * const FA_SECRET_KEY;
extern NSString * const FA_MOBILE_KEY;

#pragma mark - Social Login
extern NSString * const FA_SOCIAL_LOGIN_API;
extern NSString * const FA_FACEBOOK_ID_KEY;
extern NSString * const FA_GOOGLE_ID_KEY;

#pragma mark - Register
extern NSString * const FA_REGISTER_API;
extern NSString * const FA_COUNTRY_KEY;

#pragma mark - Change Password
extern NSString * const FA_CHANGE_PASSWORD_API;
extern NSString * const FA_OLD_PASSWORD_KEY;
extern NSString * const FA_NEW_PASSWORD_KEY;

#pragma mark - Send Verification Code
extern NSString * const FA_SEND_VERIFICATION_CODE_API;

#pragma mark - Send Feedback
extern NSString * const FA_SEND_FEEDBACK_API;
extern NSString * const FA_MESSAGE_KEY;
extern NSString * const FA_SUBJECT_KEY;
extern NSString * const FA_DRIVER_KEY;

#pragma mark - Get Cars Classes
extern NSString * const FA_GET_CARS_CLASSES_API;

#pragma mark - Get Recent Places
extern NSString * const FA_GET_RECENT_PLACES_API;
extern NSString * const FA_LIMIT_KEY;
extern NSString * const FA_LOCATION_TYPE_KEY;
extern NSString * const FA_RECENT_LOCATION_PICKUP_KEY;
extern NSString * const FA_RECENT_LOCATION_DROPOFF;
extern NSString * const FA_RECENT_LOCATION_BOTH_KEY;

#pragma mark - Get Recent Places
extern NSString * const FA_GET_FREQUENT_LOCATIONS_API;

#pragma mark - Get Offers
extern NSString * const FA_GET_OFFERS_API;

#pragma mark - Get Fleet
extern NSString * const FA_GET_FLEET_API;
extern NSString * const FA_PAGE_KEY;

#pragma mark - Get Page
extern NSString * const FA_GET_PAGE_API;
extern NSString * const FA_GET_PAGE_ID_KEY;

#pragma mark - Get Service Points
extern NSString * const FA_GET_SERVICE_POINTS_API;

#pragma mark - Get User Notification
extern NSString * const FA_GET_USER_NOTIFICATIONS_API;

#pragma mark - Set Notification As Read
extern NSString * const FA_SET_NOTIFICATIONS_RED_API;
extern NSString * const FA_NOTIFICATION_ID_KEY;

#pragma mark - Delete Notification
extern NSString * const FA_DELETE_NOTIFICATIONS_API;

#pragma mark - Complete Social Registration
extern NSString * const FA_COMPLETE_SOCIAL_REGISTRATION_API;

#pragma mark - Tracking Online Drivers
extern NSString * const FA_TRACKING_ONLINE_DRIVERS_API;

#pragma mark - Check Available Cars
extern NSString * const FA_CHECK_AVAILABEL_CARS_API;
extern NSString * const FA_CLASS_ID_KEY;

#pragma mark - Rent Car
extern NSString * const FA_RENT_CAR_API;
extern NSString * const FA_PICKUP_DATE_KEY;
extern NSString * const FA_RETURN_DATE_KEY;
extern NSString * const FA_SERVICE_POINT_PICKUP_KEY;
extern NSString * const FA_SERVICE_POINT_RETURN_KEY;

#pragma mark - Request Car
extern NSString * const FA_REQUEST_CAR_API;
extern NSString * const FA_SOURCE_LAT_KEY;
extern NSString * const FA_SOURCE_LNG_KEY;
extern NSString * const FA_SOURCE_NAME_KEY;
extern NSString * const FA_SOURCE_DESC_KEY;
extern NSString * const FA_DESTINATION_DESC_KEY;

extern NSString * const FA_DESTINATION_LAT_KEY;
extern NSString * const FA_DESTINATION_LNG_KEY;
extern NSString * const FA_DESTINATION_NAME_KEY;
extern NSString * const FA_BOOK_DATE_KEY;
extern NSString * const FA_FARE_ESTIMATE_KEY;
extern NSString * const FA_PACKAGE_TYPE_KEY;

#pragma mark - Add Favorite Location
extern NSString * const FA_ADD_FAV_LOCATION_API;
extern NSString * const FA_NAME_KEY;
extern NSString * const FA_DESC_KEY;
extern NSString * const FA_LATITUDE_KEY;
extern NSString * const FA_LONGITUDE_KEY;

#pragma mark - Delete Favourite Location
extern NSString * const FA_DELETE_FAV_LOCATION_API;
extern NSString * const FA_LOCATION_ID_KEY;

#pragma mark - Get Favourite Location
extern NSString * const FA_GET_FAV_LOCATION_API;

#pragma mark - Edit Favorite Location
extern NSString * const FA_EDIT_FAV_LOCATION_API;

#pragma mark - Update Device ID
extern NSString * const FA_DEVICE_ID_CHANGE_API;

#pragma mark - Add Voucher
extern NSString * const FA_ADD_VOUCHER_API;
extern NSString * const FA_VOUCHER_KEY;

#pragma mark - Add Fuel
extern NSString * const FA_ADD_FUEL_API;
extern NSString * const FA_AMOUNT_KEY;
extern NSString * const FA_FILE_KEY;

#pragma mark - Update Mileage
extern NSString * const FA_UPDATE_MILE_AGE_API;
extern NSString * const FA_MILE_AGE_KEY;

#pragma mark - Update Online Status
extern NSString * const FA_UPDATE_ONLINE_STATUS_API;
extern NSString * const FA_ONLINE_STATUS_KEY;

#pragma mark - Update Driver Location
extern NSString * const FA_UPDATE_DRIVER_LOCATION_API;

#pragma mark - Accept Reject Request
extern NSString * const FA_ACCEPT_REJECT_REQUEST_API;
extern NSString * const FA_IS_ACCEPT_KEY;

#pragma mark - Get Rides History
extern NSString * const FA_GET_RIDES_HISTORY_API;

#pragma mark - Rate Trip
extern NSString * const FA_RATE_TRIP_API;
extern NSString * const FA_REQUEST_ID_KEY;
extern NSString * const FA_RATE_KEY;
extern NSString * const FA_RATE_MESSAGE_KEY;

#pragma mark - Start Trip
extern NSString * const FA_START_TRIP_API;

#pragma mark - End Trip
extern NSString * const FA_END_TRIP_API;

#pragma mark - Enable/Disable Notifications
extern NSString * const FA_ENABLE_DISBALE_NOTIFICATIONS_API;
extern NSString * const FA_ENABLE_KEY;

#pragma mark - Send Trip Details
extern NSString * const FA_SEND_TRIP_DETAILS_API;
extern NSString * const FA_TOTA_KEY;
extern NSString * const FA_TOTAL_DISTANCE_KEY;

#pragma mark - Get Last Trip Milage
extern NSString * const FA_GET_LAST_TRIP_MILEAGE_API;

#pragma mark - Get Trips History
extern NSString * const FA_GET_TRIP_HISTORY_API;

#pragma mark - Cancel Request
extern NSString * const FA_CANCEL_REQUEST_API;
extern NSString * const FA_REASON_KEY;

#pragma mark - Track Driver
extern NSString * const FA_TRACK_DRIVER_API;

#pragma mark - Get Booked Later Trips
extern NSString * const FA_GET_BOOKED_LAETR_TRIPS_API;

#pragma mark - Walk In Request
extern NSString * const FA_WALK_IN_API;

#pragma mark - Check Voucher
extern NSString * const FA_CHECK_VOUCHER_API;
extern NSString * const FA_TRIP_COST_KEY;

#pragma mark - Update Profile
extern NSString * const FA_UPDATE_PROFILE_API;
extern NSString * const FA_GENDER_KEY;
extern NSString * const FA_DOF_KEY;

#pragma mark - Get Last Trip Summary
extern NSString * const FA_GET_LAST_TRIP_SUMMARY_API;

#pragma mark - Forget Password
extern NSString * const FA_FORGOT_PASSWORD_API;

#pragma mark - Get Unread Notifications Count
extern NSString * const FA_GET_UN_READ_MESSAGES_API;

#pragma mark - Get App Constants
extern NSString * const FA_GET_APP_CONSTANTS_API;

#pragma mark - Get Request Info
extern NSString * const FA_GET_REQUEST_INFO_API;

#pragma mark - Get Corporate Account Status
extern NSString * const FA_GET_GET_CORP_ACCOUNT_STATUS_API;

#pragma mark - Walk In Payment
extern NSString * const FA_WALK_IN_PAYMENT_API;
extern NSString * const FA_PAYMENT_KEY;

#pragma mark - Get Latest Driver Rate
extern NSString * const FA_GER_DRIVER_RATING_API;

#pragma mark - Validate Corporate Account
extern NSString * const FA_VALIDATE_CORP_ACCOUNT_API;
extern NSString * const FA_AUTH_CODE_KEY;

#pragma mark - Verify Mobile Number
extern NSString * const FA_VERIFY_MOBILE_NUMBER_API;
extern NSString * const FA_CODE_KEY;

#pragma mark - Social Profile Keys
extern NSString * const FA_EMAIL_KEY;
extern NSString * const FA_FIRST_NAME_KEY;
extern NSString * const FA_LAST_NAME_KEY;

#pragma mark - User Defaults Keys

extern NSString * const FA_APP_FIRST_TIME_LAUNCH_KEY;
extern NSString * const FA_IP_ADDRESS_KEY;
extern NSString * const FA_SECRET_PASSWORD;
extern NSString * const FA_AUTH_SECRET_KEY;
extern NSString * const FA_LOGGED_IN_KEY;
extern NSString * const FA_VERIFIED_KEY;
extern NSString * const FA_IS_DRIVER_KEY;
extern NSString * const FA_MESSAGES_ON_KEY;
extern NSString * const FA_USER_LAST_LOCATION_KEY;
extern NSString * const FA_CORP_ACCOUNT_KEY;
extern NSString * const FA_BADGE_COUNT_KEY;

#pragma mark - Notifications Keys


#pragma mark - Enum

typedef NS_ENUM(NSInteger, FA_LOG_TYPE)
{
    LOG_TYPE_DEBUG = 1,
    LOG_TYPE_INFO,
    LOG_TYPE_WARNING,
    LOG_TYPE_ERROR
};

typedef NS_ENUM(NSInteger, GENERAL_INTEGERS_CODES)
{
    MAX_LOCATIONS_LIMITS = 10,
    NO_CONNECTION_ERROR_CODE = 1001,
    KEYBOARD_TOOL_BAR_HEIGHT = 44
};

typedef NS_ENUM(NSInteger, SOCIAL)
{
    SOCIAL_NONE,
    SOCIAL_FACEBOOK,
    SOCIAL_GOOGLE
};

typedef NS_ENUM(NSInteger, LOCATION_TYPE)
{
    LOCATION_TYPE_NEARBY = 1,
    LOCATION_TYPE_RECENT,
    LOCATION_TYPE_FAVOURITES
};

typedef NS_ENUM(NSInteger, RECENT_LOCATION_TYPE)
{
    RECENT_LOCATION_TYPE_PICKUP,
    RECENT_LOCATION_TYPE_DROPOFF,
    RECENT_LOCATION_TYPE_BOTH
};

typedef NS_ENUM(NSInteger, PAYMENT_TYPE)
{
    PAYMENT_TYPE_NOW = 1,
    PAYMENT_TYPE_LATER,
    PAYMENT_TYPE_RENT
};

typedef NS_ENUM(NSInteger, PAGE_TYPE)
{
    PAGE_TYPE_NONE = 1, // From drawer menu
    PAGE_TYPE_MAIN_HOME,
    PAGE_TYPE_SPCIAL_OFFER,
    PAGE_TYPE_OUR_FLEET,
    PAGE_TYPE_RENT
};

typedef NS_ENUM(NSInteger, BOOKING_STATUS)
{
    BOOKING_STATUS_NEW = 1,
    BOOKING_STATUS_PAID,
    BOOKING_STATUS_Cancelled
};

typedef NS_ENUM(NSInteger, TRIP_TYPE)
{
    TRIP_TYPE_NONE = 0,
    TRIP_TYPE_NOW,
    TRIP_TYPE_LATER,
    TRIP_TYPE_PACKAGE_4,
    TRIP_TYPE_PACKAGE_8,
    TRIP_TYPE_MANUAL
};

#ifdef CustomerApp
typedef NS_ENUM(NSInteger, TRIP_STATE)
{
    TRIP_STATE_PICKUP = 0,
    TRIP_STATE_DROPOFF,
    TRIP_STATE_CONFIRMATION,
    TRIP_STATE_CONFIRMATION_PICKUP,
    TRIP_STATE_CONFIRMATION_DROPOFF,
    TRIP_STATE_REQUESTING,
    TRIP_STATE_TRACK_DRIVER,
    TRIP_STATE_ON_TRIP,
    TRIP_STATE_FINISHED,
    TRIP_STATE_NONE,
};

typedef NS_ENUM(NSInteger, MAP_PAGE)
{
    MAP_PAGE_HOME,
    MAP_PAGE_FIND_US
};

typedef NS_ENUM(NSInteger, DRIVER_STATE)
{
    DRIVER_STATE_AVAILABLE = 0,
    DRIVER_STATE_ERROR,
    DRIVER_STATE_TOO_FAR
};
#else
typedef NS_ENUM(NSInteger, MAP_PAGE)
{
    MAP_PAGE_HOME,
    MAP_PAGE_WALK_IN
};
typedef NS_ENUM(NSInteger, TRIP_STATE)
{
    TRIP_STATE_NORMAL,
    TRIP_STATE_REQUEST,
    TRIP_STATE_NAVIGATE_TO_CUSTOMER,
    TRIP_STATE_GUEST_ON_BOARD,
    TRIP_STATE_END_TRIP,
    TRIP_STATE_WALK_IN,
    TRIP_STATE_WALK_IN_TRIP_ON,
    TRIP_STATE_WALK_IN_PICKUP = 0,
    TRIP_STATE_WALK_IN_DROPOFF
};
#endif

typedef NS_ENUM(NSInteger, PUSH_ACTION)
{
    PUSH_ACTION_NONE,
    PUSH_ACTION_CUSTOMER_REQUEST, //customer_request
    PUSH_ACTION_TRIP_ENDED,       //trip_ended
    PUSH_ACTION_REQUEST_ACCEPTED, //request_accepted
    PUSH_ACTION_REQUEST_CANCELLED, //request_canceled
    PUSH_ACTION_REQUEST_CANCELLED_BY_DRIVER, //request_canceled_by_driver
    PUSH_ACTION_TRIP_STARTED, //trip_started
    PUSH_ACTION_NOTIFICATION_MESSAGE, //notification_message
    PUSH_ACTION_NO_CARS_AVAILABLE// no_cars_available
};

typedef NS_ENUM(NSInteger, PAYMENT_METHOD)
{
    PAYMENT_METHOD_CASH,
    PAYMENT_METHOD_VOUCHER,
    PAYMENT_METHOD_CORP_ACC,
    PAYMENT_METHOD_OUTSTANDING
};

#pragma mark - Others

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#pragma mark - Colors Constants

#define color_main [UIColor colorWithRed:0.016 green:0.157 blue:0.298 alpha:1.000]
#define color_pager 0x735b8e
#define color_main_navigation_bg [UIColor colorWithRed:0.114 green:0.243 blue:0.357 alpha:1.000]
#define color_main_navigation_btn_bg 0xEFEFEF
#define color_main_navigation_btn_bg_Selected 0x00AB52
#define color_White_40_Alpha [UIColor colorWithWhite:1 alpha:0.4]
#define color_Blue_40_Alpha [UIColorFromRGB(0x00adef) colorWithAlphaComponent:0.4]
#define color_Blue UIColorFromRGB(0x0064a1)
#define color_Gold [UIColor colorWithRed:0.741 green:0.537 blue:0.173 alpha:1.000]
#define color_6B6B6B [UIColor colorWithWhite:0.420 alpha:1.000]
#define color_red [UIColor colorWithRed:0.784 green:0.110 blue:0.141 alpha:1.000]
#define color_green [UIColor colorWithRed:0.000 green:0.408 blue:0.216 alpha:1.000]

#pragma mark - Side Menu Tags

#ifdef CustomerApp
#define window_Home_tag               0
#define window_Ride_History_tag       1
#define window_Payment_tag            2
#define window_Rides_tag              3
#define window_Call_Us_tag            4
#define window_Rent_Car_tag           5
#define window_Our_Fleet_tag          6
#define window_Special_Offer_tag      7
#define window_Find_Us_tag            8
#define window_Feedback_tag           9
#define window_Invite_Freinds_tag     10
#define window_My_Profile_tag         11
#define window_Message_tag            12
#define window_Settings_tag           13
#define window_About_tag              14
#define window_Logout_tag             15

#define window_Rates_tag              20
#define window_Emergency_tag          60
#define window_Lookup_Reservation_tag 40
#else
#define window_Profile_tag    0
#define window_Home_tag       1
#define window_Walk_In        2
#define window_Trip_History   3
#define window_Mile_Age       4
#define window_Fuel           5
#define window_Settings_tag   6
#define window_My_Profile_tag 7
#define window_Logout_tag     8
#endif
@end
