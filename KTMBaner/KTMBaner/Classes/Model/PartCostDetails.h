//
//  PartCostDetails.h
//  KTMBaner
//
//  Created by Sagar Kudale on 11/23/14.
//  Copyright (c) 2014 Sagar Kudale. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PartCostDetails : NSObject<NSCoding, NSCopying>

@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, strong) NSString *imgURL;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *code;
@property (nonatomic, assign) NSInteger price;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) NSInteger vehicleID;
@property (nonatomic, assign) NSInteger version;

- (id)initWithPartCostDetailsDict: (NSDictionary *) partInfo;

@end
