//
//  BikeDetail.m
//  KTMBaner
//
//  Created by Sagar Kudale on 11/13/14.
//  Copyright (c) 2014 Sagar Kudale. All rights reserved.
//

#import "BikeDetail.h"
#import "Constants.h"

#define KEY_BIKE_NAME @"BikeName"
#define KEY_BIKE_ID @"BikeID"
#define KEY_LICENSE_PLATE_NUMBER @"LicensePlateNumber"
#define KEY_MAKE_ID @"MakeId"
#define KEY_MODEL_ID @"ModelId"
#define KEY_NOTES @"Notes"
#define KEY_PDF_URL @"PdfUrl"
#define KEY_USER_ID @"UserId"
#define KEY_VEHICLE_TYPE_ID @"VehicleTypeId"
#define KEY_YEAR @"Year"
#define KEY_BIKE_IMAGE_URL @"BikeImageUrl"
#define KEY_CONTACT @"Contact"
#define KEY_CHASIS_ARRAY @"ChasisArray"
#define KEY_ENGINE_ARRAY @"EngineArray"

@implementation BikeDetail

#pragma mark - NSCoding

- (id)initWithBikeDetailsDict: (NSDictionary *) bikeInfo
{
    self = [super init];
    if (self) {
        [self initializeBikeDetailObjectWithDict:bikeInfo];
    }
    return self;
}


- (void) initializeBikeDetailObjectWithDict: (NSDictionary *) bikeInfo
{
    DebugLog(@"");
    self.bikeName = [bikeInfo objectForKey:@"Name"];
    self.bikeID = [[bikeInfo objectForKey:@"Id"] integerValue];
    self.licensePlateNumber = [bikeInfo objectForKey:@"LicensePlateNumber"];
    self.modelID = [[bikeInfo objectForKey:@"ModelId"] integerValue];
    self.makeId = [[bikeInfo objectForKey:@"MakeId"] integerValue];
    self.pdfURL = [bikeInfo objectForKey:@"PdfUrl"];
    self.userID = [[bikeInfo objectForKey:@"UserId"] integerValue];
    self.vehicleTypeId = [[bikeInfo objectForKey:@"VehicleTypeId"] integerValue];
    self.year = [[bikeInfo objectForKey:@"Year"] integerValue];
    
    id noteStringValue = [bikeInfo objectForKey:@"Notes"];
    if(noteStringValue == [NSNull null]){
        return;
    }
    
    NSString *notesString =[bikeInfo objectForKey:@"Notes"];
    [self parseNotesString:notesString];
}

- (void) parseNotesString: (NSString *) notesString
{
    DebugLog(@"");
    if([notesString isEqualToString:@"Test"]){
        [self setDataForTestBike];
        return;
    }
    
    NSData *jdata = [notesString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary* responseDict = [NSJSONSerialization
                                  JSONObjectWithData:jdata
                                  options:kNilOptions
                                  error:nil];
    
    self.notes = [responseDict objectForKey:@"Notes"];
    NSString *textFileUrl = [responseDict objectForKey:@"File"];
    [self downLoadTextFileWithUrl:textFileUrl];
}

- (void) setDataForTestBike
{
    DebugLog(@"");
    self.notes = @"Test";
    self.bikeImageUrl = @"http://ktmbaner.com/FileUploads/rsz_ktm200duketechbits01_560x420.jpg";
    self.chasisArray = nil;
    self.engineArray = nil;
}

- (void) downLoadTextFileWithUrl: (NSString *) textFileUrl
{
    DebugLog(@"");
    NSURL *url = [NSURL URLWithString:textFileUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if (data != nil) {
        [self readTextFileFromData:data];
    }
}

- (void) readTextFileFromData: (NSData *)data
{
    DebugLog(@"");
    NSError* error;
    NSDictionary* textFileDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                       options:kNilOptions
                                                                         error:&error];
    
    
    self.bikeImageUrl = [[textFileDictionary objectForKey:@"ImageUrls"] objectAtIndex:0];
    self.contact = [textFileDictionary objectForKey:@"Contact"];
    
    NSArray *techSpecArray = [textFileDictionary objectForKey:@"Info"];
    for (NSDictionary * specDic in techSpecArray) {
        if ([[specDic objectForKey:@"Title"] isEqualToString:@"Chasis"]) {
            self.chasisArray = [specDic objectForKey:@"Data"];
        }else if ([[specDic objectForKey:@"Title"] isEqualToString:@"Engine"]) {
            self.engineArray = [specDic objectForKey:@"Data"];
        }
    }

}

- (id)initWithCoder:(NSCoder *)decoder {
    DebugLog(@"");
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.bikeName = [decoder decodeObjectForKey:KEY_BIKE_NAME];
    self.bikeID = [[decoder decodeObjectForKey:KEY_BIKE_ID] integerValue];
    self.licensePlateNumber = [decoder decodeObjectForKey:KEY_LICENSE_PLATE_NUMBER];
    self.makeId = [[decoder decodeObjectForKey:KEY_MAKE_ID] integerValue];
    self.modelID = [[decoder decodeObjectForKey:KEY_MODEL_ID] integerValue];
    self.notes = [decoder decodeObjectForKey:KEY_NOTES];
    self.pdfURL = [decoder decodeObjectForKey:KEY_PDF_URL];
    self.userID = [[decoder decodeObjectForKey:KEY_USER_ID] integerValue];
    self.vehicleTypeId = [[decoder decodeObjectForKey:KEY_VEHICLE_TYPE_ID] integerValue];
    self.year = [[decoder decodeObjectForKey:KEY_YEAR] integerValue];
    self.bikeImageUrl = [decoder decodeObjectForKey:KEY_BIKE_IMAGE_URL];
    self.contact = [decoder decodeObjectForKey:KEY_CONTACT];
    self.chasisArray = [decoder decodeObjectForKey:KEY_CHASIS_ARRAY];
    self.engineArray = [decoder decodeObjectForKey:KEY_ENGINE_ARRAY];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    DebugLog(@"");
    [encoder encodeObject:[NSNumber numberWithInteger:self.bikeID] forKey:KEY_BIKE_ID];
    [encoder encodeObject:self.bikeName forKey:KEY_BIKE_NAME];
    [encoder encodeObject:self.licensePlateNumber forKey:KEY_LICENSE_PLATE_NUMBER];
    [encoder encodeObject:[NSNumber numberWithInteger:self.makeId] forKey:KEY_MAKE_ID];
    [encoder encodeObject:[NSNumber numberWithInteger:self.modelID] forKey:KEY_MODEL_ID];
    [encoder encodeObject:self.notes forKey:KEY_NOTES];
    [encoder encodeObject:self.pdfURL forKey:KEY_PDF_URL];
    [encoder encodeObject:[NSNumber numberWithInteger:self.userID] forKey:KEY_USER_ID];
    [encoder encodeObject:[NSNumber numberWithInteger:self.vehicleTypeId] forKey:KEY_VEHICLE_TYPE_ID];
    [encoder encodeObject:[NSNumber numberWithInteger:self.year] forKey:KEY_YEAR];
    [encoder encodeObject:self.bikeImageUrl forKey:KEY_BIKE_IMAGE_URL];
    [encoder encodeObject:self.contact forKey:KEY_CONTACT];
    [encoder encodeObject:self.chasisArray forKey:KEY_CHASIS_ARRAY];
    [encoder encodeObject:self.engineArray forKey:KEY_ENGINE_ARRAY];
}

- (NSString *)description {
    DebugLog(@"");
    return [NSString stringWithFormat:@"Name:%@ \n id: %d \n pdfurl: %@",
            self.bikeName,
            (int)self.bikeID,
            self.pdfURL];
}

#pragma mark - NSCopying
- (id)copyWithZone:(NSZone *)zone {
    DebugLog(@"");
    BikeDetail *bikeInfo = [[BikeDetail allocWithZone:zone] init];
    
    bikeInfo.bikeID = self.bikeID;
    bikeInfo.bikeName = [self.bikeName copy];
    bikeInfo.licensePlateNumber = [self.licensePlateNumber copy];
    bikeInfo.makeId = self.makeId;
    bikeInfo.modelID = self.modelID;
    bikeInfo.notes = [self.notes copy];
    bikeInfo.pdfURL = [self.pdfURL copy];
    bikeInfo.userID = self.userID;
    bikeInfo.vehicleTypeId = self.vehicleTypeId;
    bikeInfo.year = self.year;
    bikeInfo.bikeImageUrl = [self.bikeImageUrl copy];
    bikeInfo.contact = [self.contact copy];
    bikeInfo.chasisArray = [self.chasisArray copy];
    bikeInfo.engineArray = [self.engineArray copy];
    
    return bikeInfo;
}
@end
