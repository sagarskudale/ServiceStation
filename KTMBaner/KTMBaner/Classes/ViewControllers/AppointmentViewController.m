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

@interface AppointmentViewController ()
{
    NSArray *bookingDetailsArray;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation AppointmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setStatusBarHidden];
    
    AllUserData *userData = [ArchiveManager getUserData];
    bookingDetailsArray = userData.bookingDetailsArray;
    
//    NSMutableDictionary *dataDic = [[NSMutableDictionary alloc] initWithCapacity:1];
//    [dataDic setObject:@"2" forKey:@"type"];
//    [dataDic setObject:@"12-07-2014" forKey:@"bookingDate"];
//    [dataDic setObject:@"13:00:00" forKey:@"bookingTime"];
//    [dataDic setObject:@"12" forKey:@"userId"];
//    
//    [[ServerController sharedInstance] sendPOSTServiceRequestForService:SERVICE_BOOKING_STATUS withData:dataDic withDelegate:self];
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
    
    return cell;
}

#pragma mark-
#pragma mark- Delegate Handling
#pragma mark-

- (void)onDataFetchComplete:(NSDictionary *)dicData
{
    DebugLog(@"");
    
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
