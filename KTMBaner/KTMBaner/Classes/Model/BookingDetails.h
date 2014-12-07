//
//  BookingDetails.h
//  KTMBaner
//
//  Created by Sagar Kudale on 12/6/14.
//  Copyright (c) 2014 Sagar Kudale. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BookingDetails : NSObject<NSCoding, NSCopying>

@property (nonatomic, strong) NSString *bikeName;
@property (nonatomic, strong) NSString *bookingDate;
@property (nonatomic, strong) NSString *bookingTime;
@property (nonatomic, strong) NSString *bookingStatus;

@end
