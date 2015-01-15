//
//  SignUpViewController.m
//
//  Created by Sagar Kudale on 2/17/14.
//  Copyright (c) 2014 atomicobject. All rights reserved.
//

#import "SignUpViewController.h"
#import "ServerController.h"
#import "AccountInformation.h"
#import "AllUserData.h"
#import "ArchiveManager.h"
#import "DashBoardViewController.h"
#import "Constants.h"
#import "Utils.h"

#define MSG_USER_ALREADY_EXISTS @"User already exists."

@interface SignUpViewController ()
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) UITextField *activeField;

@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *adderessTextField;
@property (weak, nonatomic) IBOutlet UITextField *mobileNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *confimePasswordTextField;

@property (weak, nonatomic) IBOutlet UIButton *selectDateButton;
@end

@implementation SignUpViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:self.contentView
                                                                      attribute:NSLayoutAttributeLeading
                                                                      relatedBy:0
                                                                         toItem:self.view
                                                                      attribute:NSLayoutAttributeLeft
                                                                     multiplier:1.0
                                                                       constant:0];
    [self.view addConstraint:leftConstraint];
    
    NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:self.contentView
                                                                       attribute:NSLayoutAttributeTrailing
                                                                       relatedBy:0
                                                                          toItem:self.view
                                                                       attribute:NSLayoutAttributeRight
                                                                      multiplier:1.0
                                                                        constant:0];
    [self.view addConstraint:rightConstraint];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    
    [self setStatusBarHidden];
    
    [self addBordersToAllTextFields];
    [self setDelegatesToAllTextFields];
}

- (void) keyboardDidShow:(NSNotification *)notification
{
    NSDictionary* info = [notification userInfo];
    CGRect kbRect = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    kbRect = [self.view convertRect:kbRect fromView:nil];
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbRect.size.height, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbRect.size.height;
    if (!CGRectContainsPoint(aRect, self.activeField.frame.origin) ) {
        [self.scrollView scrollRectToVisible:self.activeField.frame animated:YES];
    }
}

- (void) keyboardWillBeHidden:(NSNotification *)notification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}


- (void) addDatePicker
{
    DebugLog(@"");
    DatePickerView *datePikerView = [[DatePickerView alloc] initDatePickerViewWithDate:[NSDate date] withDelegate:self];
    datePikerView.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2 + 83);
    [self.view addSubview:datePikerView];
    
}

#pragma mark-
#pragma mark- Private Methods
#pragma mark-
- (BOOL) isAllEnterdDataIsValid
{
    if ([self.firstNameTextField.text isEqualToString:@""]) {
        [Utils displayAlerViewWithTitle:@"KTM Baner" withMessage:@"Please enter first name" withDelegate:nil];
    }else if ([self.lastNameTextField.text isEqualToString:@""]) {
        [Utils displayAlerViewWithTitle:@"KTM Baner" withMessage:@"Please enter last name" withDelegate:nil];
    }else if (![Utils isNSStringValidEmail:self.emailTextField.text]){
        [Utils displayAlerViewWithTitle:@"KTM Baner" withMessage:@"Please enter valid email id" withDelegate:nil];
    }else if ([self.adderessTextField.text isEqualToString:@""]) {
        [Utils displayAlerViewWithTitle:@"KTM Baner" withMessage:@"Please enter address" withDelegate:nil];
    }else if ([self.mobileNumberTextField.text isEqualToString:@""]) {
        [Utils displayAlerViewWithTitle:@"KTM Baner" withMessage:@"Please enter mobile number" withDelegate:nil];
    }else if([self.mobileNumberTextField.text length] < 10){
        [Utils displayAlerViewWithTitle:@"KTM Baner" withMessage:@"Please enter valid mobile number" withDelegate:nil];
    }else if ([self.passwordTextField.text isEqualToString:@""]) {
        [Utils displayAlerViewWithTitle:@"KTM Baner" withMessage:@"Please enter password" withDelegate:nil];
    }else if (![self.confimePasswordTextField.text isEqualToString:self.passwordTextField.text]) {
        [Utils displayAlerViewWithTitle:@"KTM Baner" withMessage:@"Password confirmation failed" withDelegate:nil];
    }else if ([self.selectDateButton.titleLabel.text isEqualToString:@"Select Date"]) {
        [Utils displayAlerViewWithTitle:@"KTM Baner" withMessage:@"Please select Birthdate." withDelegate:nil];
    }else{
        return YES;
    }
    return NO;
}

- (void) performActionSignUp
{
    DebugLog(@"");
    if ([self isAllEnterdDataIsValid]) {
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:1];
//        [dic setObject:@"" forKey:@"UserId"];
        [dic setObject:self.firstNameTextField.text forKey:@"FirstName"];
        [dic setObject:self.lastNameTextField.text forKey:@"LastName"];
        [dic setObject:self.emailTextField.text forKey:@"Email"];
        [dic setObject:@"Male" forKey:@"Gender"];
        [dic setObject:self.mobileNumberTextField.text forKey:@"MobileNumber"];
        [dic setObject:self.adderessTextField.text forKey:@"AddressLine1"];
        [dic setObject:@"" forKey:@"AddressLine2"];
        [dic setObject:@"411030" forKey:@"PostaZipCode"];
        [dic setObject:@"Pune" forKey:@"City"];
        [dic setObject:@"MH" forKey:@"State"];
        [dic setObject:@"India" forKey:@"Country"];
        [dic setObject:self.selectDateButton.titleLabel.text forKey:@"Birthdate"];
        [dic setObject:self.passwordTextField.text forKey:@"Password"];
        
        [[ServerController sharedInstance] sendPOSTServiceRequestForService:SERVICE_NAME_REGISTER_USER withData:dic withDelegate:self];
    }
}

- (void) setDelegatesToAllTextFields
{
    DebugLog(@"");
    self.firstNameTextField.delegate = self;
    self.lastNameTextField.delegate = self;
    self.emailTextField.delegate = self;
    self.adderessTextField.delegate = self;
    self.mobileNumberTextField.delegate = self;
    self.passwordTextField.delegate = self;
    self.confimePasswordTextField.delegate = self;
}

- (void) resignFirstResponderOfAllTextFields
{
    DebugLog(@"");
    [self.firstNameTextField resignFirstResponder];
    [self.lastNameTextField  resignFirstResponder];
    [self.emailTextField resignFirstResponder];
    [self.adderessTextField resignFirstResponder];
    [self.mobileNumberTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    [self.confimePasswordTextField resignFirstResponder];
}

- (void) refreshPage
{
    DebugLog(@"");
    self.firstNameTextField.text = @"";
    self.lastNameTextField.text = @"";
    self.emailTextField.text = @"";
    self.adderessTextField.text = @"";
    self.mobileNumberTextField.text = @"";
    self.passwordTextField.text = @"";
    self.confimePasswordTextField.text = @"";
}

- (void) addBordersToAllTextFields
{
    DebugLog(@"");
    [self addBorderToTextField:self.firstNameTextField];
    [self addBorderToTextField:self.lastNameTextField];
    [self addBorderToTextField:self.emailTextField];
    [self addBorderToTextField:self.adderessTextField];
    [self addBorderToTextField:self.mobileNumberTextField];
    [self addBorderToTextField:self.passwordTextField];
    [self addBorderToTextField:self.confimePasswordTextField];
}

- (void) addBorderToTextField: (UITextField *)textField
{
    DebugLog(@"");
    CGFloat borderWidth = 2.0f;
    //    self.frame = CGRectInset(self.frame, -borderWidth, -borderWidth);
    textField.layer.borderColor = [UIColor orangeColor].CGColor;
    textField.layer.borderWidth = borderWidth;
}

- (void) changeColorOfTextField: (UITextField *)textField withColor: (UIColor *) color
{
    DebugLog(@"");
    textField.layer.borderColor = color.CGColor;
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
    
    NSString *birtDate = (NSString *) [userData objectForKey:@"Birthdate"];
    NSString *date = [[birtDate componentsSeparatedByString:@"T"] objectAtIndex:0];
    accountInformation.strBirtDate = date;
    
    AllUserData * allUserData = [[AllUserData alloc] init];
    allUserData.accountInformation = accountInformation;
    
    [ArchiveManager storeDataToFile:allUserData];
}

#pragma mark-
#pragma mark- textFied Delegate
#pragma mark-

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == self.mobileNumberTextField) {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        return (newLength > 10) ? NO : YES;
    }
    return YES;
}

- (void) textFieldDidBeginEditing:(UITextField *)textField
{
    DebugLog(@"");
    self.activeField = textField;
    [self changeColorOfTextField:textField withColor:[UIColor greenColor]];
}

- (void) textFieldDidEndEditing:(UITextField *)textField
{
    DebugLog(@"");
    [self changeColorOfTextField:textField withColor:[UIColor orangeColor]];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    DebugLog(@"");
    if (textField == self.firstNameTextField) {
        [self.lastNameTextField becomeFirstResponder];
    }else if (textField == self.lastNameTextField) {
        [self.emailTextField becomeFirstResponder];
    }else if (textField == self.emailTextField) {
        [self.adderessTextField becomeFirstResponder];
    }else if (textField == self.adderessTextField) {
        [self.mobileNumberTextField becomeFirstResponder];
    }else if (textField == self.mobileNumberTextField) {
        [self.passwordTextField becomeFirstResponder];
    }else if (textField == self.passwordTextField) {
        [self.confimePasswordTextField becomeFirstResponder];
    }else if (textField == self.confimePasswordTextField) {
        [textField resignFirstResponder];
    }
    return YES;
}

- (void) launchDashboardScreen
{
    DebugLog(@"");
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    DashBoardViewController *dashBoardViewController = [storyboard instantiateViewControllerWithIdentifier:@"DashBoardViewController"];
    [self.navigationController pushViewController:dashBoardViewController animated:YES];
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
- (void) onDataFetchComplete:(NSDictionary *)dicData
{
    DebugLog(@"sign up response data: %@",[dicData debugDescription]);
    NSDictionary *responseDic = [dicData objectForKey:@"Response"];
    NSString *status = [responseDic objectForKey:@"Status"];
    NSString *message = [responseDic objectForKey:@"Message"];
    if ([status isEqualToString:@"success"]) {
        [self saveUserData:dicData];
        [self registerUserDevice];
        [self launchDashboardScreen];
    }else if([status isEqualToString:@"failure"] && [message isEqualToString:@"useremailalreadyexists"]){
        [Utils displayAlerViewWithTitle:@"KTM Baner" withMessage:MSG_USER_ALREADY_EXISTS withDelegate:self];
    }
}

- (void) onDateSelected:(NSDate *)selectedDate
{
    DebugLog(@"");
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    NSString *stringFromDate = [formatter stringFromDate:selectedDate];
    self.selectDateButton.titleLabel.text = stringFromDate;
    [self.selectDateButton setTitle:stringFromDate forState:UIControlStateNormal];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    DebugLog(@"");
    if ([alertView.message isEqualToString:MSG_USER_ALREADY_EXISTS]) {
        [self refreshPage];
    }
}

#pragma mark-
#pragma mark- Custom Action Handling
#pragma mark-
- (IBAction)actionBackButton:(id)sender {
    DebugLog(@"");
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)actionSelectDateButton:(id)sender {
    DebugLog(@"");
    [self resignFirstResponderOfAllTextFields];
    [self addDatePicker];
}

- (IBAction)actionSubmitButton:(id)sender {
    DebugLog(@"");
    [self resignFirstResponderOfAllTextFields];
    [self performActionSignUp];
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
