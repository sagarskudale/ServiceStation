//
//  AppDelegate.m
//  KTMBaner
//
//  Created by Sagar Kudale on 10/29/14.
//  Copyright (c) 2014 Sagar Kudale. All rights reserved.
//

#import "AppDelegate.h"
#import "ServiceRecordsViewController.h"
#import "DashBoardViewController.h"
#import "BikeViewController.h"
#import "Constants.h"
#import "CurrentViewControllerHandler.h"
#import "Utils.h"
#import "ArchiveManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)])
    {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    else
    {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         (UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)];
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    NSLog(@"My token is: %@", deviceToken);
    NSString *devToken = [[[[deviceToken description]
                            stringByReplacingOccurrencesOfString:@"<"withString:@""]
                            stringByReplacingOccurrencesOfString:@">" withString:@""]
                          stringByReplacingOccurrencesOfString: @" " withString: @""];
    
    NSLog(@"My token is: %@", devToken);
    [Utils storeDeviceToken:devToken];
    if ([self isUserLoggedIn]) {
        [self registerUserDevice];
    }
}
- (void) registerUserDevice
{
    DebugLog(@"");
    NSMutableDictionary *dataDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    [dataDic setObject:[self getUserID] forKey:@"UserId"];
    [dataDic setObject:@"2" forKey:@"OSType"];
    [dataDic setObject:[Utils getDeviceToken] forKey:@"DeviceToken"];
    
    [[ServerController sharedInstance] sendPOSTServiceRequestForService:SERVICE_REGISTER_USER_DEVICE withData:dataDic withDelegate:nil];
}
- (NSString *) getUserID
{
    DebugLog(@"");
    AllUserData *allUserData = [ArchiveManager getUserData];
    AccountInformation *userInfo = [allUserData accountInformation];
    return userInfo.strUserID;
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
    NSLog(@"Failed to get token, error: %@", error);
}

#define MSG_SERVICECREATED @"ServiceCreated"
#define MSG_SERVICEUPDATED @"ServiceUpdated"
#define MSG_VEHICLEADDED @"VehicleAdded"
#define MSG_POINTSADDED @"PointsAdded"

- (void)application:(UIApplication*)application didReceiveRemoteNotification:(NSDictionary*)userInfo
{
    NSLog(@"Received notification: %@", userInfo);
    NSDictionary *apsInfo = [userInfo objectForKey:@"aps"];
    NSString *alertMessage = @"";
    if(apsInfo!= nil && [apsInfo objectForKey:@"alert"] != NULL)
    {
        alertMessage = [apsInfo objectForKey:@"alert"];
    }
    
    if ([alertMessage containsString:MSG_SERVICECREATED]) {
        [self launchServiceScreen];
    }else if ([alertMessage containsString:MSG_SERVICEUPDATED]) {
        [self launchServiceScreen];
    }else if ([alertMessage containsString:MSG_VEHICLEADDED]) {
        [self launchVehiclesScreen];
    }else if ([alertMessage containsString:MSG_POINTSADDED]) {
        [self launchDashboard];
    }
    
}

- (void) launchDashboard
{
    DebugLog(@"");
    UIViewController * vc = [CurrentViewControllerHandler sharedInstance].currentViewController;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    DashBoardViewController *dashBoardViewController = [storyboard instantiateViewControllerWithIdentifier:@"DashBoardViewController"];
    [CurrentViewControllerHandler sharedInstance].currentViewController = dashBoardViewController;
    [vc.navigationController pushViewController:dashBoardViewController animated:YES];
}

- (void) launchServiceScreen
{
    DebugLog(@"");
    UIViewController * vc = [CurrentViewControllerHandler sharedInstance].currentViewController;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    ServiceRecordsViewController *serviceRecordVC = [storyboard instantiateViewControllerWithIdentifier:@"ServiceRecordsViewController"];
    [CurrentViewControllerHandler sharedInstance].currentViewController = serviceRecordVC;
    [vc.navigationController pushViewController:serviceRecordVC animated:YES];
}

- (void) launchVehiclesScreen
{
    DebugLog(@"");
    UIViewController * vc = [CurrentViewControllerHandler sharedInstance].currentViewController;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    BikeViewController *bikeVC = [storyboard instantiateViewControllerWithIdentifier:@"BikeViewController"];
    [CurrentViewControllerHandler sharedInstance].currentViewController = bikeVC;
    [vc.navigationController pushViewController:bikeVC animated:YES];
}

- (BOOL) isUserLoggedIn
{
    DebugLog(@"");
    if ([ArchiveManager getUserData] == nil ) {
        return NO;
    }
    
    return YES;
}
@end
