//
//  SplashScreenViewController.m
//  KTMBaner
//
//  Created by Sagar Kudale on 11/3/14.
//  Copyright (c) 2014 Sagar Kudale. All rights reserved.
//

#import "SplashScreenViewController.h"
#import "DashBoardViewController.h"
#import "ArchiveManager.h"
#import "LoginViewController.h"
#import "Constants.h"
#import "Utils.h"

@interface SplashScreenViewController ()

@end

@implementation SplashScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setStatusBarHidden];
    [self performSelector:@selector(loadNextView) withObject:nil afterDelay:2.0f];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) loadNextView
{
    DebugLog(@"");
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    if ([self isUserLoggedIn]) {
        DashBoardViewController *dashBoardViewController = [storyboard instantiateViewControllerWithIdentifier:@"DashBoardViewController"];
        [self.navigationController pushViewController:dashBoardViewController animated:YES];
    }else{
        LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        [self.navigationController pushViewController:loginViewController animated:YES];
    }
}

- (BOOL) isUserLoggedIn
{
    DebugLog(@"");
    if ([ArchiveManager getUserData] == nil ) {
        return NO;
    }

    return YES;
}


#pragma mark-
#pragma mark- Status Bar
#pragma mark-

- (void) setStatusBarHidden
{
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        // iOS 7
        [self prefersStatusBarHidden];
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    } else {
        // iOS 6
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    }
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}


@end
