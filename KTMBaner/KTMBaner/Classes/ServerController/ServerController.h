//
//  ServerController.h
//  iOS_OUTDemo
//
//  Created by Sagar Kudale on 04/02/14.
//  Copyright (c) 2014 CUELogic. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SERVICE_NAME_AUTHONTICATE @"Account/Authenticate"
#define SERVICE_FORGOT_PASSWORD @"User/ForgotPassword?"
#define SERVICE_NAME_REGISTER_USER @"Account/Register"
#define SERVICE_NAME_GET_SHEDULE @"Booking/GetSchedule?"
#define SERVICE_MERCHANT_VEHICAL @"Vehicle/GetMerchantVehicels"
#define SERVICE_BOOKING_SHEDULE_MERCHANT_VEHICLE @"Booking/GetScheduleByMerchantVehicle?"
#define SERVER_MAKE_BOOKING @"Booking/MakeBooking?"
#define SERVER_GET_ALL_PARTS @"PartType/GetAllPartType"
#define SERVER_GET_PARTS_VEHICLE @"PartType/GetPartTypeByVehicle?"
#define SERVICE_GET_SERVICE_RECORDS @"ServiceRecord/GetServiceRecordsByUserId?"
#define SERVICE_GET_USER_BIKES @"Vehicle/GetVehiclesByUserId?"
/*
 * This class handles all server requests and responses.
 */

@protocol ServiceControlerDelegate
@optional
- (void)onDataFetchComplete:(NSDictionary *)dicData;
@end
@interface ServerController : NSObject


@property (nonatomic,unsafe_unretained) id<ServiceControlerDelegate> delegate;

+ (id)sharedInstance;

-(void)sendPOSTServiceRequestForService:(NSString *)serviceName withData:(NSDictionary *)dicData withDelegate:(id<ServiceControlerDelegate>) serviceDelegate;

-(void)sendGETServiceRequestForService:(NSString *)serviceName withData:(NSDictionary *)dicData withDelegate:(id<ServiceControlerDelegate>) serviceDelegate;

- (BOOL) isNetworkAvailabe;

@end
