//
//  ArchiveManager.m
//  KTMBaner
//
//  Created by Sagar Kudale on 11/10/14.
//  Copyright (c) 2014 Sagar Kudale. All rights reserved.
//

#import "ArchiveManager.h"
#import "Constants.h"
#import "Utils.h"

@implementation ArchiveManager

+ (void) storeDataToFile:(AllUserData *) userData
{
    DebugLog(@"");
    NSArray *array = [NSArray arrayWithObjects:userData, nil];
    [NSKeyedArchiver archiveRootObject:array toFile:[Utils getUserDataFilePath]];
}
+ (AllUserData *) getUserData
{
    DebugLog(@"");
    NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:[Utils getUserDataFilePath]];
    
    return [array objectAtIndex:0];
}

@end
