//
//  AccountDetailsViewController.m
//  KTMBaner
//
//  Created by Sagar Kudale on 11/9/14.
//  Copyright (c) 2014 Sagar Kudale. All rights reserved.
//

#import "AccountDetailsViewController.h"
#import "Constants.h"
#import "AllUserData.h"
#import "Utils.h"
#import "LoginViewController.h"
#import "AccountInformation.h"
#import "CurrentViewControllerHandler.h"
#import "ArchiveManager.h"

@interface AccountDetailsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labelPhoneNumber;
@property (weak, nonatomic) IBOutlet UILabel *labelEmail;
@property (weak, nonatomic) IBOutlet UILabel *labelBirthday;

@end

@implementation AccountDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setStatusBarHidden];
    [self displayAccountInformation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) displayAccountInformation
{
    DebugLog(@"");
    
    AllUserData *userData = [ArchiveManager getUserData];
    AccountInformation *accountInfo = userData.accountInformation;
    
    self.labelName.text = accountInfo.strName;
    self.labelEmail.text = accountInfo.strEmailID;
    self.labelPhoneNumber.text = accountInfo.strPhoneNumber;
    self.labelBirthday.text = accountInfo.strBirtDate;
}

#pragma mark-
#pragma mark- Action Handling
#pragma mark-
- (IBAction)actionBackButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)actionLogoutButton:(id)sender {
    
    [Utils deleteUserData];
    
    NSMutableArray *allViewControllers = [NSMutableArray arrayWithArray:[self.navigationController viewControllers]];
    for (UIViewController *aViewController in allViewControllers) {
        if ([aViewController isKindOfClass:[LoginViewController class]]) {
            [self.navigationController popToViewController:aViewController animated:NO];
            return;
        }
    }
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    [CurrentViewControllerHandler sharedInstance].currentViewController = loginViewController;
    [self.navigationController pushViewController:loginViewController animated:YES];
    
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
