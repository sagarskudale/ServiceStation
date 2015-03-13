//
//  CurrentViewControllerHandler.m
//  KTMBaner
//
//  Created by Sagar Kudale on 3/13/15.
//  Copyright (c) 2015 Sagar Kudale. All rights reserved.
//

#import "CurrentViewControllerHandler.h"

@implementation CurrentViewControllerHandler
@synthesize currentViewController;

static CurrentViewControllerHandler *sharedInstance = nil;
+(CurrentViewControllerHandler *)sharedInstance {
    if (sharedInstance == nil) {
        sharedInstance = [[CurrentViewControllerHandler alloc]init];
        
    }
    return sharedInstance;
}

@end
