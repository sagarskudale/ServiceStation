//
//  Utils.h
//  KTMBaner
//
//  Created by Sagar Kudale on 11/5/14.
//  Copyright (c) 2014 Sagar Kudale. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


#define KEY_USERID @"UserId"

@interface Utils : NSObject

+ (NSString *) getUserID;
+ (void) setUserID:(NSString *) userID;
+ (BOOL) isNSStringValidEmail:(NSString *) string;
+ (void) displayAlerViewWithTitle:(NSString *) title withMessage:(NSString *) message withDelegate:(id<UIAlertViewDelegate>) delegate;
+ (void) displayAlerViewWithCancelButtonWithTitle:(NSString *) title withMessage:(NSString *) message withDelegate:(id<UIAlertViewDelegate>) delegate;
+ (NSString *)getUserDataFilePath;
+ (void) deleteUserData;

+ (void)downloadImageWithURL:(NSURL *)url completionBlock:(void (^)(BOOL succeeded, UIImage *image))completionBlock;

@end
