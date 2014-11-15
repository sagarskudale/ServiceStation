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
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.accountInformation forKey:@"accountInformation"];
    [encoder encodeObject:self.allBikeInformation forKey:@"AllBikeInformation"];
}

- (id)copyWithZone:(NSZone *)zone {
    AllUserData *allUserData = [[AllUserData allocWithZone:zone] init];
    allUserData.accountInformation = [self.accountInformation copy];
    allUserData.allBikeInformation = [self.allBikeInformation copy];
    return allUserData;
}

@end
