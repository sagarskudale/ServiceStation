//
//  AllUserData.m
//  KTMBaner
//
//  Created by Sagar Kudale on 11/10/14.
//  Copyright (c) 2014 Sagar Kudale. All rights reserved.
//

#import "AllUserData.h"

@implementation AllUserData


#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.accountInformation = [decoder decodeObjectForKey:@"accountInformation"];
    self.allBikeInformation = [decoder decodeObjectForKey:@"AllBikeInformation"];
    self.allPartsInfo = [decoder decodeObjectForKey:@"allPartInfo"];
    self.usersBikesArray = [decoder decodeObjectForKey:@"UsersBikesArray"];
    self.serviceRecordArray = [decoder decodeObjectForKey:@"serviceRecordArray"];
    self.bookingDetailsArray = [decoder decodeObjectForKey:@"BookingDetailsArray"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.accountInformation forKey:@"accountInformation"];
    [encoder encodeObject:self.allBikeInformation forKey:@"AllBikeInformation"];
    [encoder encodeObject:self.allPartsInfo forKey:@"allPartInfo"];
    [encoder encodeObject:self.usersBikesArray forKey:@"UsersBikesArray"];
    [encoder encodeObject:self.serviceRecordArray forKey:@"serviceRecordArray"];
    [encoder encodeObject:self.bookingDetailsArray forKey:@"BookingDetailsArray"];
}

- (id)copyWithZone:(NSZone *)zone {
    AllUserData *allUserData = [[AllUserData allocWithZone:zone] init];
    allUserData.accountInformation = [self.accountInformation copy];
    allUserData.allBikeInformation = [self.allBikeInformation copy];
    allUserData.allPartsInfo = [self.allPartsInfo copy];
    allUserData.usersBikesArray = [self.usersBikesArray copy];
    allUserData.serviceRecordArray = [self.serviceRecordArray copy];
    allUserData.bookingDetailsArray = [self.bookingDetailsArray copy];
    return allUserData;
}

@end
