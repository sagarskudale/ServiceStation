//
//  Utils.m
//  KTMBaner
//
//  Created by Sagar Kudale on 11/5/14.
//  Copyright (c) 2014 Sagar Kudale. All rights reserved.
//

#import "Utils.h"
#import "Constants.h"

#define KEY_USER_DETAILS @"userDetails"

@implementation Utils

+ (NSString *) getUserID
{
    DebugLog(@"");
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:KEY_USERID];
}
+ (void) setUserID:(NSString *) userID
{
    DebugLog(@"");
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:userID forKey:KEY_USERID];
    [userDefaults synchronize];
}
+ (BOOL) isNSStringValidEmail:(NSString *) string
{
    DebugLog(@"");
    BOOL stricterFilter = YES; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:string];
}

+ (void) displayAlerViewWithTitle:(NSString *) title withMessage:(NSString *) message withDelegate:(id<UIAlertViewDelegate>) delegate
{
    DebugLog(@"");
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:delegate
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

+ (NSString *)getUserDataFilePath {
    NSArray *urls = [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory
                                                           inDomains:NSUserDomainMask];
    NSString *documentDirPath = [[urls objectAtIndex:0] path];
    return [documentDirPath stringByAppendingPathComponent:@"usrData"];
}
+ (void) deleteUserData {
    
    NSError *error;
    BOOL success = [[NSFileManager defaultManager] removeItemAtPath:[Utils getUserDataFilePath] error:&error];
    if (!success) {
        NSLog(@"Error removing document path: %@", error.localizedDescription);
    }
    
}

#pragma mark -
#pragma mark ==============================
#pragma mark  Image Download
#pragma mark ==============================



+ (void)downloadImageWithURL:(NSURL *)url completionBlock:(void (^)(BOOL succeeded, UIImage *image))completionBlock
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if ( !error )
                               {
                                   UIImage *image = [[UIImage alloc] initWithData:data];
                                   completionBlock(YES,image);
                               } else{
                                   completionBlock(NO,nil);
                               }
                           }];
}

@end
