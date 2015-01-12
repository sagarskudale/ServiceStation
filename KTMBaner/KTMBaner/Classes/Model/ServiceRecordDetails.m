//
//  ServiceRecordDetails.m
//  KTMBaner
//
//  Created by Sagar Kudale on 11/30/14.
//  Copyright (c) 2014 Sagar Kudale. All rights reserved.
//

#import "ServiceRecordDetails.h"
#import "Constants.h"

#define KEY_VEHICLE_ID @"VehicleId"
#define KEY_KMS @"KMS"
#define KEY_PDFURL @"PdfUrl"
#define KEY_SERVICING_DATE @"ServiceDate"
#define KEY_POINTS @"Points"

@implementation ServiceRecordDetails

- (id)initWithServiceDetailsDict: (NSDictionary *) serviceDetails
{
    DebugLog(@"");
    self = [super init];
    if(self){
        [self initializeServiceDetailsWithData:serviceDetails];
    }
    return self;
}

- (void) initializeServiceDetailsWithData: (NSDictionary *) serviceDetails
{
    DebugLog(@"");
    self.vehicleID = [[serviceDetails objectForKey:KEY_VEHICLE_ID] integerValue];
    self.kms = [[serviceDetails objectForKey:KEY_KMS] integerValue];
    self.pdfURL = [serviceDetails objectForKey:KEY_PDFURL];
    self.date = [serviceDetails objectForKey:KEY_SERVICING_DATE];
    self.points = [[serviceDetails objectForKey:KEY_POINTS] integerValue];
}

- (id)initWithCoder:(NSCoder *)decoder {
    DebugLog(@"");
    self = [super init];
    if (!self) {
        return nil;
    }

    self.vehicleID = [decoder decodeIntegerForKey:KEY_VEHICLE_ID];
    self.kms = [decoder decodeIntegerForKey:KEY_KMS];
    self.pdfURL = [decoder decodeObjectForKey:KEY_PDFURL];
    self.date = [decoder decodeObjectForKey:KEY_SERVICING_DATE];
    self.points = [decoder decodeIntegerForKey:KEY_POINTS];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    DebugLog(@"");
    [encoder encodeInteger:self.vehicleID forKey:KEY_VEHICLE_ID];
    [encoder encodeInteger:self.kms forKey:KEY_KMS];
    [encoder encodeObject:self.pdfURL forKey:KEY_PDFURL];
    [encoder encodeObject:self.date forKey:KEY_SERVICING_DATE];
    [encoder encodeInteger:self.points forKey:KEY_POINTS];
}


#pragma mark - NSCopying
- (id)copyWithZone:(NSZone *)zone {
    DebugLog(@"");
    ServiceRecordDetails *serviceDetails = [[ServiceRecordDetails allocWithZone:zone] init];
    
    serviceDetails.vehicleID = self.vehicleID;
    serviceDetails.kms = self.kms;
    serviceDetails.pdfURL = self.pdfURL;
    serviceDetails.date = self.date;
    serviceDetails.points = self.points;
    return serviceDetails;
}
@end
