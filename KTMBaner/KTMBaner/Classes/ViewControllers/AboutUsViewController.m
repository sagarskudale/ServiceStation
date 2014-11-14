//
//  AboutUsViewController.m
//  KTMBaner
//
//  Created by Sagar Kudale on 11/8/14.
//  Copyright (c) 2014 Sagar Kudale. All rights reserved.
//

#import "AboutUsViewController.h"
#import "Constants.h"
#import "Utils.h"

#define SALES_NUMBER @"+912065269999"
#define SERVICES_NUMBER @"+912065266255"
#define KTM_LINK @"http://www.ktmbaner.com"

@interface AboutUsViewController ()

@end

@implementation AboutUsViewController

#pragma mark-
#pragma mark- View Life Cycle
#pragma mark-
- (void)viewDidLoad {
    DebugLog(@"");
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setStatusBarHidden];

}

#pragma mark-
#pragma mark- Custom Action Handling
#pragma mark-
- (IBAction)actionBackButtonPressed:(id)sender
{
    DebugLog(@"");
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)actionSalesNumber:(id)sender {
    DebugLog(@"");
    NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",SALES_NUMBER]];
    
    if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
        [[UIApplication sharedApplication] openURL:phoneUrl];
    } else
    {
        [Utils displayAlerViewWithTitle:@"KTM Baner" withMessage:@"Call facility is not available!!!" withDelegate:nil];
    }
}

- (IBAction)actionServicesNumber:(id)sender {
    DebugLog(@"");
    NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",SERVICES_NUMBER]];
    
    if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
        [[UIApplication sharedApplication] openURL:phoneUrl];
    } else
    {
        [Utils displayAlerViewWithTitle:@"KTM Baner" withMessage:@"Call facility is not available!!!" withDelegate:nil];
    }
}
- (IBAction)actionKtmLink:(id)sender {
    DebugLog(@"");
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:KTM_LINK]];
}

#pragma mark-
#pragma mark- Memory Management
#pragma mark-
- (void)didReceiveMemoryWarning {
    DebugLog(@"");
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
