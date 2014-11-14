//
//  ArchiveManager.h
//  KTMBaner
//
//  Created by Sagar Kudale on 11/10/14.
//  Copyright (c) 2014 Sagar Kudale. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AllUserData.h"

@interface ArchiveManager : NSObject

+ (void) storeDataToFile:(AllUserData *) userData;
+ (AllUserData *) getUserData;
@end
