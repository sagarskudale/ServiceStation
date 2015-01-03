//
//  Constants.h
//  KTMBaner
//
//  Created by Sagar Kudale on 11/3/14.
//  Copyright (c) 2014 Sagar Kudale. All rights reserved.
//

#ifndef KTMBaner_Constants_h
#define KTMBaner_Constants_h

#endif

//#define DEBUG_MODE 1

#ifdef DEBUG_MODE
#define DebugLog( s, ... ) NSLog( @"<%s (%d)> %@", __FUNCTION__, __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define DebugLog( s, ... )
#endif

#define SERVICE_URL @"http://ktmbaner.com/api/"
#define SERVICE_URL_PART @""

typedef enum{
    kScreenTypeNone,
    kScreenTypeShowroom,
    kScreenTypeServiceRecords,
    kScreenTypeUserVehicle,
    kScreenTypeBookTestRideAppointment,
    kScreenTypeBookServicingAppointment
}ScreenType;

