//
//  AppointmentViewController.m
//  KTMBaner
//
//  Created by Sagar Kudale on 11/11/14.
//  Copyright (c) 2014 Sagar Kudale. All rights reserved.
//

#import "AppointmentViewController.h"
#import "AppointmentTableViewCell.h"
#import "Constants.h"
#import "ArchiveManager.h"
#import "AllUserData.h"
#import "BookingDetails.h"
#import "AccountInformation.h"
#import "LoadingPlaceHolderView.h"

#define TAG_PLACEHOLDER 12

@interface AppointmentViewController ()
{
    NSMutableArray *bookingDetailsArray;
    NSUInteger currentIndex;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation AppointmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setStatusBarHidden];
    
    AllUserData *userData = [ArchiveManager getUserData];
    bookingDetailsArray = [userData.bookingDetailsArray mutableCopy];
    
    currentIndex = 0;
    if ([bookingDetailsArray count] > 0) {
        [self checkStatusForBookingDetailsAtIndex:currentIndex];
    }else{
        self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        [self addPlaceHolderView];
    }
    
}
- (void) removePlaceHolderView
{
    DebugLog(@"");
    LoadingPlaceHolderView *placeHolderView  = (LoadingPlaceHolderView *) [self.tableView viewWithTag:TAG_PLACEHOLDER];
    if (placeHolderView != nil) {
        [placeHolderView removeFromSuperview];
    }
}
- (void) addPlaceHolderView
{
    DebugLog(@"");
    LoadingPlaceHolderView *placeHolderView = [[LoadingPlaceHolderView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 65) andWithScreenType:kScreenTypeBookServicingAppointment];
    placeHolderView.tag = TAG_PLACEHOLDER;
    [self.tableView addSubview:placeHolderView];
}

- (void) checkStatusForBookingDetailsAtIndex:(NSUInteger) index
{
    DebugLog(@"");
    AllUserData *userData = [ArchiveManager getUserData];
    AccountInformation *userInfo = userData.accountInformation;
    
    BookingDetails *currBookingDetails = [bookingDetailsArray objectAtIndex:index];
    
//    http://ktmbaner.com/api/Booking/CheckStatus?type=1&bookingDate=14-06-2014&bookingTime=13:00:00&userId=12
    NSMutableDictionary *dataDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    [dataDic setObject:@"1" forKey:@"type"];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [formatter dateFromString:currBookingDetails.bookingDate];
    [formatter setDateFormat:@"yyyy/MM/dd"];
    NSString *output = [formatter stringFromDate:date];
    
    [dataDic setObject:output forKey:@"bookingDate"];
    [dataDic setObject:currBookingDetails.bookingTime forKey:@"bookingTime"];
    [dataDic setObject:userInfo.strUserID forKey:@"userId"];
    
    
    [[ServerController sharedInstance] sendPOSTServiceRequestForService:SERVICE_BOOKING_STATUS withData:dataDic withDelegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark-
#pragma mark- Action Handling
#pragma mark-

- (IBAction)onBackButton:(id)sender {
    DebugLog(@"");
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark-
#pragma mark- Table View Delegate
#pragma mark-

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    DebugLog(@"");
    return [bookingDetailsArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DebugLog(@"");
    AppointmentTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"AppointmentCell" forIndexPath:indexPath];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"AppointmentCell"];
    }
    
    BookingDetails *bookingDetails = [bookingDetailsArray objectAtIndex:indexPath.row];
    cell.bikeLabel.text = bookingDetails.bikeName;
    cell.dateLabel.text = bookingDetails.bookingDate;
    cell.timeLabel.text = bookingDetails.bookingTime;
    cell.statusLabel.text = bookingDetails.bookingStatus;
    if ([bookingDetails.bookingStatus isEqualToString:@"Approved"]) {
        cell.statusLabel.textColor = [UIColor greenColor];
    }
    
    return cell;
}

#pragma mark-
#pragma mark- Delegate Handling
#pragma mark-

- (void)onDataFetchComplete:(NSDictionary *)dicData
{
    DebugLog(@"");
    NSDictionary *response = [dicData objectForKey:@"Response"];
    if (response && [[response objectForKey:@"Status"] isEqualToString:@"failure"]) {
        
    }else if(response && [[response objectForKey:@"Status"] isEqualToString:@"success"]){
        BookingDetails *currBookingDetails = [bookingDetailsArray objectAtIndex:currentIndex];
        currBookingDetails.bookingStatus = @"Approved";
        [bookingDetailsArray replaceObjectAtIndex:currentIndex withObject:currBookingDetails];
    }
    
    currentIndex ++;
    if ([bookingDetailsArray count] > currentIndex) {
        [self checkStatusForBookingDetailsAtIndex:currentIndex];
    }else{
        AllUserData *userData = [ArchiveManager getUserData];
        userData.bookingDetailsArray = bookingDetailsArray;
        [ArchiveManager storeDataToFile:userData];
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
