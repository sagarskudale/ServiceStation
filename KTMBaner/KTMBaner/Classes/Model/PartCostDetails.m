//
//  PartCostDetails.m
//  KTMBaner
//
//  Created by Sagar Kudale on 11/23/14.
//  Copyright (c) 2014 Sagar Kudale. All rights reserved.
//

#import "PartCostDetails.h"
#import "Constants.h"

#define KEY_PART_ID @"Id"
#define KEY_IMAGE_URL @"ImageUrl"
#define KEY_PART_NAME @"Name"
#define KEY_PAERT_CODE @"PartCode"
#define KEY_PRICE @"Price"
#define KEY_TYPE @"Type"
#define KEY_VEHICLE_ID @"VehicleId"
#define KEY_VERSION @"Version"

@implementation PartCostDetails

@synthesize ID;
@synthesize imgURL;
@synthesize name;
@synthesize code;
@synthesize price;
@synthesize type;
@synthesize vehicleID;
@synthesize version;

- (id)initWithPartCostDetailsDict: (NSDictionary *) partInfo
{
    DebugLog(@"");
    self = [super init];
    if(self){
        [self initializePartCostDetailsWithData:partInfo];
    }
    return self;
}

- (void) initializePartCostDetailsWithData: (NSDictionary *) partInfo
{
    DebugLog(@"");
    self.ID = [[partInfo objectForKey:KEY_PART_ID] integerValue];
    self.imgURL = @"";//[partInfo objectForKey:KEY_IMAGE_URL];
    
    id partName = [partInfo objectForKey:KEY_PART_NAME];
    if (partName != nil && ![partName isKindOfClass:[NSNull class]]) {
        self.name = [partInfo objectForKey:KEY_PART_NAME];
    }else{
        self.name = @"";
    }
    
    
    self.code = [partInfo objectForKey:KEY_PAERT_CODE];
    id partPrice = [partInfo objectForKey:KEY_PRICE];
    if (partPrice != nil && ![partPrice isKindOfClass:[NSNull class]]) {
        self.price = [[partInfo objectForKey:KEY_PRICE] integerValue];
    }else{
        self.price = 0;
    }
    
    self.type = [[partInfo objectForKey:KEY_TYPE] integerValue];
    self.vehicleID = [[partInfo objectForKey:KEY_VEHICLE_ID] integerValue];
    self.version = [[partInfo objectForKey:KEY_VERSION] integerValue];
}

- (id)initWithCoder:(NSCoder *)decoder {
    DebugLog(@"");
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.ID = [[decoder decodeObjectForKey:KEY_PART_ID] integerValue];
    self.imgURL = [decoder decodeObjectForKey:KEY_IMAGE_URL];
    self.name = [decoder decodeObjectForKey:KEY_PART_NAME];
    self.code = [decoder decodeObjectForKey:KEY_PAERT_CODE];
    self.price = [[decoder decodeObjectForKey:KEY_PRICE] integerValue];
    self.type = [[decoder decodeObjectForKey:KEY_TYPE] integerValue];
    self.vehicleID = [[decoder decodeObjectForKey:KEY_VEHICLE_ID] integerValue];
    self.version = [[decoder decodeObjectForKey:KEY_VERSION] integerValue];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    DebugLog(@"");
    [encoder encodeObject:[NSNumber numberWithInteger:self.ID] forKey:KEY_PART_ID];
    [encoder encodeObject:self.imgURL forKey:KEY_IMAGE_URL];
    [encoder encodeObject:self.name forKey:KEY_PART_NAME];
    [encoder encodeObject:self.code forKey:KEY_PAERT_CODE];
    [encoder encodeObject:[NSNumber numberWithInteger:self.price] forKey:KEY_PRICE];
    [encoder encodeObject:[NSNumber numberWithInteger:self.type] forKey:KEY_TYPE];
    [encoder encodeObject:[NSNumber numberWithInteger:self.vehicleID] forKey:KEY_VEHICLE_ID];
    [encoder encodeObject:[NSNumber numberWithInteger:self.version] forKey:KEY_VERSION];
}

- (NSString *)description {
    DebugLog(@"");
    return [NSString stringWithFormat:@"Name:%@ \n id: %d \n imgURL: %@",
            self.name,
            (int)self.ID,
            self.imgURL];
}

#pragma mark - NSCopying
- (id)copyWithZone:(NSZone *)zone {
    DebugLog(@"");
    PartCostDetails *partCostInfo = [[PartCostDetails allocWithZone:zone] init];
    
    partCostInfo.ID = self.ID;
    partCostInfo.imgURL = [self.imgURL copy];
    partCostInfo.name = [self.name copy];
    partCostInfo.code = [self.code copy];
    partCostInfo.price = self.price;
    partCostInfo.type = self.type;
    partCostInfo.vehicleID = self.vehicleID;
    partCostInfo.version = self.version;
    
    return partCostInfo;
}

@end
