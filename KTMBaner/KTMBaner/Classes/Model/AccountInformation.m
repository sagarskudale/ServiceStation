//
//  AccountInformation.m
//  KTMBaner
//
//  Created by Sagar Kudale on 11/10/14.
//  Copyright (c) 2014 Sagar Kudale. All rights reserved.
//

#import "AccountInformation.h"

@implementation AccountInformation

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.strName = [decoder decodeObjectForKey:@"name"];
    self.strEmailID = [decoder decodeObjectForKey:@"emailid"];
    self.strBirtDate = [decoder decodeObjectForKey:@"birthdate"];
    self.strPhoneNumber = [decoder decodeObjectForKey:@"phonenumber"];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.strName forKey:@"name"];
    [encoder encodeObject:self.strEmailID forKey:@"emailid"];
    [encoder encodeObject:self.strBirtDate forKey:@"birthdate"];
    [encoder encodeObject:self.strPhoneNumber forKey:@"phonenumber"];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"Name:%@ \n Email: %@ \n Phone: %@ \n birthDate: %@ \n ",
            self.strName,
            self.strEmailID,
            self.strPhoneNumber,
            self.strBirtDate];
}

#pragma mark - NSCopying
- (id)copyWithZone:(NSZone *)zone {
    AccountInformation *accountInfo = [[AccountInformation allocWithZone:zone] init];
    accountInfo.strName = [self.strName copy];
    accountInfo.strEmailID = [self.strEmailID copy];
    accountInfo.strBirtDate = [self.strBirtDate copy];
    accountInfo.strPhoneNumber = [self.strPhoneNumber copy];
    return accountInfo;
}
@end
