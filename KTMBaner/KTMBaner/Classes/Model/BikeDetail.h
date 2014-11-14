//
//  BikeDetail.h
//  KTMBaner
//
//  Created by Sagar Kudale on 11/13/14.
//  Copyright (c) 2014 Sagar Kudale. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BikeDetail : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *bikeName;
@property (nonatomic, assign) NSInteger bikeID;
@property (nonatomic, strong) NSString *licensePlateNumber;
@property (nonatomic, assign) NSInteger makeId;
@property (nonatomic, assign) NSInteger modelID;
@property (nonatomic, strong) NSString *notes;
@property (nonatomic, strong) NSString *pdfURL;
@property (nonatomic, assign) NSInteger userID;
@property (nonatomic, assign) NSInteger vehicleTypeId;
@property (nonatomic, assign) NSInteger year;
@property (nonatomic, strong) NSString *bikeImageUrl;
@property (nonatomic, strong) NSString *contact;
@property (nonatomic, strong) NSArray *chasisArray;
@property (nonatomic, strong) NSArray *engineArray;

- (id)initWithBikeDetailsDict: (NSDictionary *) bikeInfo;

@end
