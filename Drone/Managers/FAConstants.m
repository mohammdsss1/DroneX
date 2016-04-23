//
//  FAConstants.m
//  AlFardan
//
//  Created by Mohammad Salah on 8/3/15.
//  Copyright (c) 2015 smarteletec. All rights reserved.
//

#import "FAConstants.h"

@implementation FAConstants

#pragma mark - Web Service Keys

NSString * const FA_BASE_URL = @"http://smarteletec-test.com/fardan-php/Client_Services/";
NSString * const FA_RESPONSE_CODE = @"response_code";
NSString * const FA_RESPONSE_CODE_MESSAGE = @"response_message";

NSInteger const FA_SUCCESS = 1;

NSString * const FA_TOKEN_KEY = @"token";
NSString * const FA_USER_ID_KEY = @"user_id";
NSString * const FA_USER_ROLE_KEY = @"user_role";
NSString * const FA_USER_NAME_KEY = @"userName";

#pragma mark - Login
NSString * const FA_CHECK_LOGIN_API = @"user_login";
NSString * const FA_LOGIN_ID_KEY = @"username";
NSString * const FA_PASSWORD_KEY = @"password";
NSString * const FA_DEVICE_ID_KEY = @"device_id";
NSString * const FA_SECRET_KEY = @"secret";
NSString * const FA_MOBILE_KEY = @"mobile";

#pragma mark - Social Login
NSString * const FA_SOCIAL_LOGIN_API = @"social_login";
NSString * const FA_FACEBOOK_ID_KEY = @"fb_id";
NSString * const FA_GOOGLE_ID_KEY = @"google_id";

#pragma mark - Register
NSString * const FA_REGISTER_API = @"register";
NSString * const FA_COUNTRY_KEY = @"country";

#pragma mark - Change Password
NSString * const FA_CHANGE_PASSWORD_API = @"change_password";
NSString * const FA_OLD_PASSWORD_KEY = @"old_password";
NSString * const FA_NEW_PASSWORD_KEY = @"new_password";

#pragma mark - Send Verification Code
NSString * const FA_SEND_VERIFICATION_CODE_API = @"send_verification_code";

#pragma mark - Send Feedback
NSString * const FA_SEND_FEEDBACK_API = @"send_feedback";
NSString * const FA_MESSAGE_KEY = @"message";
NSString * const FA_SUBJECT_KEY = @"subject";
NSString * const FA_DRIVER_KEY = @"driver_id";

#pragma mark - Get Cars Classes
NSString * const FA_GET_CARS_CLASSES_API = @"get_cars_classes";

#pragma mark - Get Recent Places
NSString * const FA_GET_RECENT_PLACES_API = @"get_recent_locations";
NSString * const FA_LIMIT_KEY = @"limit";
NSString * const FA_LOCATION_TYPE_KEY = @"location_type";
NSString * const FA_RECENT_LOCATION_PICKUP_KEY = @"pick_up";
NSString * const FA_RECENT_LOCATION_DROPOFF = @"drop_off";
NSString * const FA_RECENT_LOCATION_BOTH_KEY = @"both";

#pragma mark - Get Recent Places
NSString * const FA_GET_FREQUENT_LOCATIONS_API = @"get_frequent_locations";

#pragma mark - Get Offers
NSString * const FA_GET_OFFERS_API = @"get_offers";

#pragma mark - Get Fleet
NSString * const FA_GET_FLEET_API = @"get_fleet";
NSString * const FA_PAGE_KEY = @"page";

#pragma mark - Get Page
NSString * const FA_GET_PAGE_API = @"get_page";
NSString * const FA_GET_PAGE_ID_KEY = @"page_id";

#pragma mark - Get Service Points
NSString * const FA_GET_SERVICE_POINTS_API = @"get_service_points";

#pragma mark - Get User Notification
NSString * const FA_GET_USER_NOTIFICATIONS_API = @"get_user_notifications";

#pragma mark - Set Notification As Read
NSString * const FA_SET_NOTIFICATIONS_RED_API = @"set_notification_as_read";
NSString * const FA_NOTIFICATION_ID_KEY = @"notification_id";

#pragma mark - Delete Notification
NSString * const FA_DELETE_NOTIFICATIONS_API = @"delete_notification";

#pragma mark - Complete Social Registration
NSString * const FA_COMPLETE_SOCIAL_REGISTRATION_API = @"complete_social_registeration";

#pragma mark - Tracking Online Drivers
NSString * const FA_TRACKING_ONLINE_DRIVERS_API = @"tracking_online_drivers";

#pragma mark - Check Available Cars
NSString * const FA_CHECK_AVAILABEL_CARS_API = @"check_available_cars";
NSString * const FA_CLASS_ID_KEY = @"class_id";

#pragma mark - Rent Car
NSString * const FA_RENT_CAR_API = @"rent_car";
NSString * const FA_PICKUP_DATE_KEY = @"pickup_date";
NSString * const FA_RETURN_DATE_KEY = @"return_date";
NSString * const FA_SERVICE_POINT_PICKUP_KEY = @"service_point_id";
NSString * const FA_SERVICE_POINT_RETURN_KEY = @"return_service_point_id";

#pragma mark - Request Car
NSString * const FA_REQUEST_CAR_API = @"request_car";
NSString * const FA_SOURCE_LAT_KEY = @"source_latitude";
NSString * const FA_SOURCE_LNG_KEY = @"source_longitude";
NSString * const FA_SOURCE_NAME_KEY = @"source_name";
NSString * const FA_SOURCE_DESC_KEY = @"source_description";
NSString * const FA_DESTINATION_LAT_KEY = @"destination_latitude";
NSString * const FA_DESTINATION_LNG_KEY = @"destination_longitude";
NSString * const FA_DESTINATION_NAME_KEY = @"destination_name";
NSString * const FA_DESTINATION_DESC_KEY = @"destination_description";
NSString * const FA_BOOK_DATE_KEY = @"book_date";
NSString * const FA_FARE_ESTIMATE_KEY = @"fare_estimate";
NSString * const FA_PACKAGE_TYPE_KEY = @"package_type";

#pragma mark - Add Favorite Location
NSString * const FA_ADD_FAV_LOCATION_API = @"add_favorite_location";
NSString * const FA_NAME_KEY = @"name";
NSString * const FA_DESC_KEY = @"description";
NSString * const FA_LATITUDE_KEY = @"latitude";
NSString * const FA_LONGITUDE_KEY = @"longitude";

#pragma mark - Delete Favourite Location
NSString * const FA_DELETE_FAV_LOCATION_API = @"delete_favorite_location";
NSString * const FA_LOCATION_ID_KEY = @"location_id";

#pragma mark - Get Favourite Location
NSString * const FA_GET_FAV_LOCATION_API = @"get_favorite_locations";

#pragma mark - Edit Favorite Location
NSString * const FA_EDIT_FAV_LOCATION_API = @"edit_favorite_location";

#pragma mark - Update Device ID
NSString * const FA_DEVICE_ID_CHANGE_API = @"change_device_id";

#pragma mark - Add Voucher
NSString * const FA_ADD_VOUCHER_API = @"add_voucher";
NSString * const FA_VOUCHER_KEY = @"voucher";

#pragma mark - Add Fuel
NSString * const FA_ADD_FUEL_API = @"add_fuel";
NSString * const FA_AMOUNT_KEY   = @"amount";
NSString * const FA_FILE_KEY     = @"file";

#pragma mark - Update Mileage
NSString * const FA_UPDATE_MILE_AGE_API = @"update_mileage";
NSString * const FA_MILE_AGE_KEY = @"mileage";

#pragma mark - Update Online Status
NSString * const FA_UPDATE_ONLINE_STATUS_API = @"update_online_status";
NSString * const FA_ONLINE_STATUS_KEY = @"online_status";

#pragma mark - Update Driver Location
NSString * const FA_UPDATE_DRIVER_LOCATION_API = @"update_driver_location";

#pragma mark - Accept Reject Request
NSString * const FA_ACCEPT_REJECT_REQUEST_API = @"accept_reject_request";
NSString * const FA_IS_ACCEPT_KEY = @"is_accepted";

#pragma mark - Get Rides History
NSString * const FA_GET_RIDES_HISTORY_API = @"get_trips_history";

#pragma mark - Rate Trip
NSString * const FA_RATE_TRIP_API = @"rate_trip";
NSString * const FA_REQUEST_ID_KEY = @"request_id";
NSString * const FA_RATE_KEY = @"rate";
NSString * const FA_RATE_MESSAGE_KEY = @"rate_message";

#pragma mark - Start Trip
NSString * const FA_START_TRIP_API = @"trip_start";

#pragma mark - End Trip
NSString * const FA_END_TRIP_API = @"trip_end";

#pragma mark - Enable/Disable Notifications
NSString * const FA_ENABLE_DISBALE_NOTIFICATIONS_API = @"enable_disable_notifications";
NSString * const FA_ENABLE_KEY = @"enable";

#pragma mark - Send Trip Details
NSString * const FA_SEND_TRIP_DETAILS_API = @"send_trip_details";
NSString * const FA_TOTA_KEY = @"total_fare";
NSString * const FA_TOTAL_DISTANCE_KEY = @"total_distance";

#pragma mark - Get Last Trip Milage
NSString * const FA_GET_LAST_TRIP_MILEAGE_API = @"get_last_milage";

#pragma mark - Get Trips History
NSString * const FA_GET_TRIP_HISTORY_API = @"get_trips_history";

#pragma mark - Cancel Request
NSString * const FA_CANCEL_REQUEST_API = @"cancel_request";
NSString * const FA_REASON_KEY = @"reason";

#pragma mark - Track Driver
NSString * const FA_TRACK_DRIVER_API = @"track_driver";

#pragma mark - Get Booked Later Trips
NSString * const FA_GET_BOOKED_LAETR_TRIPS_API = @"get_booked_later_trips";

#pragma mark - Walk In Request
NSString * const FA_WALK_IN_API = @"walk_in_request";

#pragma mark - Check Voucher
NSString * const FA_CHECK_VOUCHER_API = @"validate_voucher";
NSString * const FA_TRIP_COST_KEY = @"trip_cost";

#pragma mark - Update Profile
NSString * const FA_UPDATE_PROFILE_API = @"update_profile";
NSString * const FA_GENDER_KEY = @"gender";
NSString * const FA_DOF_KEY = @"dob";

#pragma mark - Get Last Trip Summary
NSString * const FA_GET_LAST_TRIP_SUMMARY_API = @"get_last_trip_summary";

#pragma mark - Forget Password
NSString * const FA_FORGOT_PASSWORD_API = @"forget_password";

#pragma mark - Get Unread Notifications Count
NSString * const FA_GET_UN_READ_MESSAGES_API = @"get_unread_notifications_count";

#pragma mark - Get App Constants
NSString * const FA_GET_APP_CONSTANTS_API = @"get_app_constants";

#pragma mark - Get Request Info
NSString * const FA_GET_REQUEST_INFO_API = @"get_request_info";

#pragma mark - Get Corporate Account Status
NSString * const FA_GET_GET_CORP_ACCOUNT_STATUS_API = @"get_corporate_account_status";

#pragma mark - Walk In Payment
NSString * const FA_WALK_IN_PAYMENT_API = @"walk_in_payment";
NSString * const FA_PAYMENT_KEY = @"payment";

#pragma mark - Get Latest Driver Rate
NSString * const FA_GER_DRIVER_RATING_API = @"get_latest_driver_rate";

#pragma mark - Validate Corporate Account
NSString * const FA_VALIDATE_CORP_ACCOUNT_API = @"validate_corporate_account";
NSString * const FA_AUTH_CODE_KEY = @"auth_code";

#pragma mark - Verify Mobile Number
NSString * const FA_VERIFY_MOBILE_NUMBER_API = @"verify_mobile_number";
NSString * const FA_CODE_KEY = @"code";

#pragma mark - Social Profile Keys
NSString * const FA_EMAIL_KEY = @"email";
NSString * const FA_FIRST_NAME_KEY = @"first_name";
NSString * const FA_LAST_NAME_KEY = @"last_name";

#pragma mark - User Defaults Keys

NSString * const FA_APP_FIRST_TIME_LAUNCH_KEY = @"FirstRun";
NSString * const FA_IP_ADDRESS_KEY = @"myAddress";
NSString * const FA_SECRET_PASSWORD = @"lakjl23rjo08jd0vsdv09304g8j0j";
NSString * const FA_AUTH_SECRET_KEY = @"SDER4334KKKJUYUDND7C6D";
NSString * const FA_LOGGED_IN_KEY = @"L07O88G13G12E32D67I10N";
NSString * const FA_VERIFIED_KEY = @"V04E45R6I4F3I22D443";
NSString * const FA_IS_DRIVER_KEY = @"I23S45D67R86I55V445E67R8";
NSString * const FA_MESSAGES_ON_KEY = @"M23E4S53S23A46G77E44O2N89";
NSString * const FA_USER_LAST_LOCATION_KEY = @"9U1S3E5R6L7A22S3T5L66OCA3T4I89O7N88";
NSString * const FA_CORP_ACCOUNT_KEY = @"C2O31R2P2AC3CO6U5N423T";
NSString * const FA_BADGE_COUNT_KEY = @"2B5ADG212E2C46OU2N23T";

#pragma mark - Notifications Keys


#pragma mark - Others

@end
