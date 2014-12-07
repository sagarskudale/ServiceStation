//
//  BookingDetails.m
//  KTMBaner
//
//  Created by Sagar Kudale on 12/6/14.
//  Copyright (c) 2014 Sagar Kudale. All rights reserved.
//

#import "BookingDetails.h"
#import "Constants.h"

#define KEY_BIKE_NAME @"BikeName"
#define KEY_BOOKING_DATE @"BookingDate"
#define KEY_BOOKING_TIME @"BookingTime"
#define KEY_BOOKING_STATUS @"BookingStatus"

@implementation BookingDetails


- (id)initWithCoder:(NSCoder *)decoder {
    DebugLog(@"");
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.bikeName = [decoder decodeObjectForKey:KEY_BIKE_NAME];
    self.bookingDate = [decoder decodeObjectForKey:KEY_BOOKING_DATE];
    self.bookingStatus = [decoder decodeObjectForKey:KEY_BOOKING_STATUS];
    self.bookingTime = [decoder decodeObjectForKey:KEY_BOOKING_TIME];
    
    return self;
}
- (void)encodeWithCoder:(NSCoder *)encoder {
    DebugLog(@"");
    [encoder encodeObject:self.bikeName forKey:KEY_BIKE_NAME];
    [encoder encodeObject:self.bookingDate forKey:KEY_BOOKING_DATE];
    [encoder encodeObject:self.bookingStatus forKey:KEY_BOOKING_STATUS];
    [encoder encodeObject:self.bookingTime forKey:KEY_BOOKING_TIME];
}


#pragma mark - NSCopying
- (id)copyWithZone:(NSZone *)zone {
    DebugLog(@"");
    BookingDetails *bookingDetails = [[BookingDetails allocWithZone:zone] init];
    
    bookingDetails.bikeName = self.bikeName;
    bookingDetails.bookingDate = self.bookingDate;
    bookingDetails.bookingStatus = self.bookingStatus;
    bookingDetails.bookingTime = self.bookingTime;
    
    return bookingDetails;
}

@end
