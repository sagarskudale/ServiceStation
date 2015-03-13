//
//  LoginViewController.m
//  KTMBaner
//
//  Created by Sagar Kudale on 11/3/14.
//  Copyright (c) 2014 Sagar Kudale. All rights reserved.
//

#import "LoginViewController.h"
#import "DashBoardViewController.h"
#import "ForgotPasswordViewController.h"
#import "SignUpViewController.h"
#import "Constants.h"
#import "AllUserData.h"
#import "AccountInformation.h"
#import "ArchiveManager.h"
#import "Utils.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@end

@implementation LoginViewController

#pragma mark-
#pragma mark- View Life Cycle
#pragma mark-
- (void)viewDidLoad
{
    DebugLog(@"");
    [super viewDidLoad];
    [self setStatusBarHidden];
    
    self.emailTextField.delegate = self;
    self.passwordTextField.delegate = self;
}

- (void) viewWillAppear:(BOOL)animated
{
    DebugLog(@"");
    self.emailTextField.text = @"";
    self.passwordTextField.text = @"";
}

#pragma mark-
#pragma mark- Private Methods
#pragma mark-
- (BOOL) isAllEnterdDataIsValid
{
    DebugLog(@"");
    if ([self.emailTextField.text isEqualToString:@""]) {
        [Utils displayAlerViewWithTitle:@"KTM Baner" withMessage:@"Please enter email" withDelegate:nil];
    }else if (![Utils isNSStringValidEmail:self.emailTextField.text]){
        [Utils displayAlerViewWithTitle:@"KTM Baner" withMessage:@"Please enter valid email" withDelegate:nil];
    }else if ([self.passwordTextField.text isEqualToString:@""]) {
        [Utils displayAlerViewWithTitle:@"KTM Baner" withMessage:@"Please enter Password" withDelegate:nil];
    }else{
        return YES;
    }
    return NO;
}

- (void) performActionSignIn
{
    DebugLog(@"");
    if ([self isAllEnterdDataIsValid]) {
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:1];
        [dic setObject:self.emailTextField.text forKey:@"Email"];
        [dic setObject:self.passwordTextField.text forKey:@"Password"];
        
        [[ServerController sharedInstance] sendPOSTServiceRequestForService:SERVICE_NAME_AUTHONTICATE withData:dic withDelegate:self];
    }
}

- (void) resignFirstResponderOfAllTextFields
{
    DebugLog(@"");
    [self.emailTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}

- (void) launchDashboardScreen
{
    DebugLog(@"");
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    DashBoardViewController *dashBoardViewController = [storyboard instantiateViewControllerWithIdentifier:@"DashBoardViewController"];
    [self.navigationController pushViewController:dashBoardViewController animated:YES];
}

- (void) saveUserData: (NSDictionary *) userDetails
{
    DebugLog(@"");
    NSDictionary *userData = [[userDetails objectForKey:@"Data"] objectForKey:@"Record"];
    
    AccountInformation * accountInformation = [[AccountInformation alloc] init];
    accountInformation.strName = [NSString stringWithFormat:@"%@ %@",[userData objectForKey:@"FirstName"], [userData objectForKey:@"LastName"]];
    accountInformation.strEmailID = (NSString *) [userData objectForKey:@"Email"];
    accountInformation.strPhoneNumber = (NSString *) [userData objectForKey:@"MobileNumber"];
    accountInformation.strAdderess = (NSString *) [userData objectForKey:@"AddressLine1"];
    accountInformation.strUserID = (NSString *) [userData objectForKey:@"UserId"];
    
    
    id birtDate =  [userData objectForKey:@"Birthdate"];
    if(birtDate == [NSNull null]){
        accountInformation.strBirtDate = @"null";
    }else {
        NSString *date = [[((NSString *)birtDate) componentsSeparatedByString:@"T"] objectAtIndex:0];
        accountInformation.strBirtDate = date;
    }
    
    
    AllUserData * allUserData = [[AllUserData alloc] init];
    allUserData.accountInformation = accountInformation;
    
    [ArchiveManager storeDataToFile:allUserData];
}

#pragma mark-
#pragma mark- Action Handling
#pragma mark-

- (IBAction) signInButtonClicked:(id)sender
{
    DebugLog(@"");
    [self resignFirstResponderOfAllTextFields];
    [self performActionSignIn];

}

- (IBAction) signUpButtonClicked:(id)sender
{
    DebugLog(@"");
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"SignUp" bundle:nil];
    SignUpViewController *signUpViewController = [storyboard instantiateViewControllerWithIdentifier:@"SignUpViewController"];
    [self.navigationController pushViewController:signUpViewController animated:YES];
    
}
- (IBAction)actionForgotPassword:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    ForgotPasswordViewController *forgotPasswordVC = [storyboard instantiateViewControllerWithIdentifier:@"ForgotPasswordViewController"];
    [self.navigationController pushViewController:forgotPasswordVC animated:YES];
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
#pragma mark-
#pragma mark- Delegate Methods
#pragma mark-

- (void)onDataFetchComplete:(NSDictionary *)dicData
{
    DebugLog(@"");
    NSAssert(dicData!=nil, @"Responce dictionary should not be nil");
    NSDictionary *responseDictionary = [dicData objectForKey:@"Response"];
    if ([[responseDictionary objectForKey:@"Status"] isEqualToString:@"success"]) {
        NSDictionary *userDitails = [dicData objectForKey:@"Data"];
        [self saveUserData:dicData];
        [self registerUserDevice];
        [self launchDashboardScreen];
    }else{
        [Utils displayAlerViewWithTitle:@"KTM Baner" withMessage:@"Incorrect Usename or Password." withDelegate:nil];
    }
    
}

#pragma mark-
#pragma mark- Text field delegates
#pragma mark-

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    DebugLog(@"");
    if (textField == self.emailTextField) {
        [self.passwordTextField becomeFirstResponder];
    }else{
        [textField resignFirstResponder];
    }
    return YES;
}
#pragma mark-
#pragma mark- memory Management
#pragma mark-

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
