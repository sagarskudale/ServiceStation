//
//  ForgotPasswordViewController.m
//  KTMBaner
//
//  Created by Sagar Kudale on 11/7/14.
//  Copyright (c) 2014 Sagar Kudale. All rights reserved.
//

#import "ForgotPasswordViewController.h"
#import "Constants.h"
#import "Utils.h"

#define MSG_FORGOT_PASSWORD_NOT_REGISTERD @"This email is not registered with us."
#define MSG_LINK_SENT @"Password reset link has been sent to your mail id."

@interface ForgotPasswordViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;

@end

@implementation ForgotPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setStatusBarHidden];
    self.emailTextField.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL) isAllEnterdDataIsValid
{
    if ([self.emailTextField.text isEqualToString:@""]) {
        [Utils displayAlerViewWithTitle:@"KTM Baner" withMessage:@"Please enter email" withDelegate:self];
    }else if (![Utils isNSStringValidEmail:self.emailTextField.text]){
        [Utils displayAlerViewWithTitle:@"KTM Baner" withMessage:@"Please enter valid email" withDelegate:self];
    }else{
        return YES;
    }
    return NO;
}
- (void) performActionSignIn{
    if ([self isAllEnterdDataIsValid]) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:1];
        [dic setObject:self.emailTextField.text forKey:@"emailid"];
        [[ServerController sharedInstance] sendPOSTServiceRequestForService:SERVICE_FORGOT_PASSWORD withData:dic withDelegate:self];
    }
}


#pragma mark-
#pragma mark- Action handling
#pragma mark-
- (IBAction)actionSubmitButtonClicked:(id)sender {
    DebugLog(@"");
    [self performActionSignIn];
}

- (IBAction)actionBackButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark-
#pragma mark- TextFied Delegate
#pragma mark-

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    DebugLog(@"");
    [textField resignFirstResponder];
    return YES;
}

#pragma mark-
#pragma mark- Alert View delegate
#pragma mark-

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    DebugLog(@"");
    if ([alertView.message isEqualToString:MSG_LINK_SENT]) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark-
#pragma mark- Server controller delegate
#pragma mark-

- (void)onDataFetchComplete:(NSDictionary *)dicData
{
    DebugLog(@"");
    NSDictionary *responseDic = [dicData objectForKey:@"Response"];
    if ([[responseDic objectForKey:@"Status"] isEqualToString:@"failure"] && [[responseDic objectForKey:@"Message"] isEqualToString:@"userdoesnotexists"]) {
        [Utils displayAlerViewWithTitle:@"KTM Baner" withMessage:MSG_FORGOT_PASSWORD_NOT_REGISTERD withDelegate:self];
    }else if ([[responseDic objectForKey:@"Status"] isEqualToString:@"success"]){
        [Utils displayAlerViewWithTitle:@"KTM Baner" withMessage:MSG_LINK_SENT withDelegate:self];
    }
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
