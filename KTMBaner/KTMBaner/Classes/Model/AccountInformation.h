//
//  UserData.h
//  KTMBaner
//
//  Created by Sagar Kudale on 11/10/14.
//  Copyright (c) 2014 Sagar Kudale. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountInformation : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString * strName;
@property (nonatomic, strong) NSString * strEmailID;
@property (nonatomic, strong) NSString * strBirtDate;
@property (nonatomic, strong) NSString * strPhoneNumber;

- (NSString *)description;

@end
