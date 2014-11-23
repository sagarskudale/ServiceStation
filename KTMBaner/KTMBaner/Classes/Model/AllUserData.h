//
//  AllUserData.h
//  KTMBaner
//
//  Created by Sagar Kudale on 11/10/14.
//  Copyright (c) 2014 Sagar Kudale. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AccountInformation.h"

@interface AllUserData : NSObject<NSCoding, NSCopying>

@property (nonatomic, strong) AccountInformation * accountInformation;
@property (nonatomic, strong) NSArray *allBikeInformation;
@property (nonatomic, strong) NSDictionary *allPartsInfo;
@end
