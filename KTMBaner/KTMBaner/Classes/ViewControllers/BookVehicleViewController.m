//
//  BookVehicleViewController.m
//  KTMBaner
//
//  Created by Sagar Kudale on 11/18/14.
//  Copyright (c) 2014 Sagar Kudale. All rights reserved.
//

#import "BookVehicleViewController.h"
#import "SelectTimeView.h"
#import "Utils.h"

#define TAG_SELECT_DATE 300

typedef enum {
    kCurrentServiceTypeNone,
    kCurrentServiceGetSchedule,
    kCurrentServiceBookTestRide,
    kCurrentServiceBookServicing
}CurrentServiceType;

@interface BookVehicleViewController (){
    NSArray * scheduleArray;
    NSString *currentDate;
    NSUInteger currentIndex;
    NSString *selectedAddress;
    CurrentServiceType currServiceType;
}
@property (weak, nonatomic) IBOutlet UIButton *buttonToday;
@property (weak, nonatomic) IBOutlet UIButton *buttonTommorrow;
@property (weak, nonatomic) IBOutlet UILabel *labelDate;
@property (weak, nonatomic) IBOutlet UIView *datesView;

@end

@implementation BookVehicleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setStatusBarHidden];
    currentIndex = 0;
    
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithCapacity:1];
    
    
    NSDate *currDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [dateFormatter stringFromDate:currDate];
    
    [dictionary setObject:dateString forKey:@"date"];
    [dictionary setObject:self.vehicleID forKey:@"vehicleid"];
    selectedAddress = @"Service Station";
    self.labelDate.text = dateString;
    currentDate = nil;
    self.buttonToday.hidden = YES;
    currServiceType = kCurrentServiceGetSchedule;
    if (self.screenType == kScreenTypeBookTestRideAppointment) {
        [dictionary setObject:@"1" forKey:@"type"];
        [[ServerController sharedInstance] sendGETServiceRequestForService:SERVICE_BOOKING_SHEDULE_MERCHANT_VEHICLE withData:dictionary withDelegate:self];
    }else if(self.screenType == kScreenTypeBookServicingAppointment){
        [dictionary setObject:@"2" forKey:@"type"];
        [[ServerController sharedInstance] sendGETServiceRequestForService:SERVICE_NAME_GET_SHEDULE withData:dictionary withDelegate:self];
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) displayDateAndLoadTimes
{
    DebugLog(@"");
    
    NSDictionary * currentDic = [scheduleArray objectAtIndex:currentIndex];
    currentDate = [currentDic objectForKey:@"Date"];
    self.labelDate.text = currentDate;
    [self displayTimes:[currentDic objectForKey:@"AvailableSlots"]];
}

- (void) displayTimes:(NSArray *) arrayDates
{
    DebugLog(@"");
    [self removeSelectTimeView];
    SelectTimeView *selectTimeView = [[SelectTimeView alloc] initWithDatesArray:arrayDates];
    
    selectTimeView.center = CGPointMake(self.view.center.x, 70 + selectTimeView.frame.size.height / 2);
    
    selectTimeView.tag = TAG_SELECT_DATE;
    [self.datesView addSubview:selectTimeView];
}

- (void) removeSelectTimeView
{
    DebugLog(@"");
    SelectTimeView *selectTimeView = (SelectTimeView *) [self.datesView viewWithTag:TAG_SELECT_DATE];
    if (selectTimeView != nil) {
        [selectTimeView removeFromSuperview];
    }
}

#pragma mark-
#pragma mark- Server Controller Delegate
#pragma mark-
- (void)onDataFetchComplete:(NSDictionary *)dicData
{
    DebugLog(@"");
    if ([[[dicData objectForKey:@"Response"] objectForKey:@"Status"] isEqualToString:@"success"]) {
        if (currServiceType == kCurrentServiceGetSchedule) {
            scheduleArray = [[dicData objectForKey:@"Data"] objectForKey:@"Records"];
            [self displayDateAndLoadTimes];
        }else if (currServiceType == kCurrentServiceBookTestRide || currServiceType == kCurrentServiceBookServicing) {
            [Utils displayAlerViewWithTitle:@"KTM Baner" withMessage:@"Booking Successful!!" withDelegate:self];
        }
    }
}

#pragma mark-
#pragma mark- Action Handling..
#pragma mark-
- (IBAction)actionBackButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)actionChooseAddress:(id)sender {
    DebugLog(@"");
    AdderessSelectionView *addressSelection = [[AdderessSelectionView alloc] initWithFrame:self.view.frame withUserAddress:self.userAddress];
    addressSelection.delegate = self;
    [self.view addSubview:addressSelection];
}

- (IBAction)actionBook:(id)sender {
    
   DebugLog(@"");
    NSString *selectedTime;
    SelectTimeView *selectTimeView = (SelectTimeView *) [self.datesView viewWithTag:TAG_SELECT_DATE];
    if (selectTimeView != nil) {
        selectedTime = [selectTimeView getSelectedTime];
        
    }
    
    if (selectedTime == nil || [selectedTime isEqualToString:@""]) {
        [Utils displayAlerViewWithTitle:@"KTM Baner" withMessage:@"Please select time" withDelegate:nil];
        return;
    }
    
    NSMutableDictionary *dataDictionary = [[NSMutableDictionary alloc] initWithCapacity:1];
    [dataDictionary setObject:currentDate forKey:@"bookingDate"];
    [dataDictionary setObject:selectedTime forKey:@"bookingTime"];
    [dataDictionary setObject:self.userID forKey:@"userId"];
    [dataDictionary setObject:self.vehicleID forKey:@"vehicleId"];
    [dataDictionary setObject:selectedAddress forKey:@"address"];
    
    if(self.screenType == kScreenTypeBookTestRideAppointment){
        currServiceType = kCurrentServiceBookTestRide;
        [dataDictionary setObject:@"1" forKey:@"type"];
    }else if(self.screenType == kScreenTypeBookServicingAppointment){
        currServiceType = kCurrentServiceBookServicing;
        [dataDictionary setObject:@"2" forKey:@"type"];
    }
    
    [[ServerController sharedInstance] sendPOSTServiceRequestForService:SERVER_MAKE_BOOKING withData:dataDictionary withDelegate:self];
    
}

- (IBAction)actionTodayButton:(id)sender {
    DebugLog(@"");
    self.buttonTommorrow.hidden = NO;
    self.buttonToday.hidden = YES;
    currentIndex --;
    NSDictionary * currentDic = [scheduleArray objectAtIndex:currentIndex];
    currentDate = [currentDic objectForKey:@"Date"];
    self.labelDate.text = currentDate;
    [self displayTimes:[currentDic objectForKey:@"AvailableSlots"]];
}
- (IBAction)actionTommorowButton:(id)sender {
    DebugLog(@"");
    self.buttonTommorrow.hidden = YES;
    self.buttonToday.hidden = NO;
    currentIndex ++;
    NSDictionary * currentDic = [scheduleArray objectAtIndex:currentIndex];
    currentDate = [currentDic objectForKey:@"Date"];
    self.labelDate.text = currentDate;
    [self displayTimes:[currentDic objectForKey:@"AvailableSlots"]];
}

#pragma mark-
#pragma mark- Delegate Methods
#pragma mark-

- (void) onAddressSelected:(NSString *) selectedAdd
{
    DebugLog(@"");
    selectedAddress = selectedAdd;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    DebugLog(@"");
    [self.navigationController popViewControllerAnimated:YES];
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
