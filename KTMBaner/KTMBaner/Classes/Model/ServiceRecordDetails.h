//
//  ServiceRecordDetails.h
//  KTMBaner
//
//  Created by Sagar Kudale on 11/30/14.
//  Copyright (c) 2014 Sagar Kudale. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServiceRecordDetails : NSObject<NSCoding, NSCopying>
@property (nonatomic, assign) NSUInteger vehicleID;
@property (nonatomic, assign) NSUInteger kms;
@property (nonatomic, strong) NSString *pdfURL;
@property (nonatomic, strong) NSString *date;

- (id)initWithServiceDetailsDict: (NSDictionary *) serviceDetails;

@end
