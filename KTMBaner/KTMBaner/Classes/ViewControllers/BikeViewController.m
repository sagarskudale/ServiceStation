//
//  BikeViewController.m
//  KTMBaner
//
//  Created by Sagar Kudale on 11/29/14.
//  Copyright (c) 2014 Sagar Kudale. All rights reserved.
//

#import "BikeViewController.h"
#import "BikeTableViewCell.h"
#import "AllUserData.h"
#import "ArchiveManager.h"
#import "Constants.h"
#import "BikeDetail.h"
#import "Utils.h"

@interface BikeViewController ()
@property (weak, nonatomic) IBOutlet UITableView *bikeTable;

@end

@implementation BikeViewController
{
    NSArray *bikesArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setStatusBarHidden];
    
    
    self.bikeTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.bikeTable.bounces = NO;
    
    AllUserData *userData = [ArchiveManager getUserData];
    bikesArray = [[userData usersBikesArray] mutableCopy];
    if (bikesArray != nil) {
        [self.bikeTable reloadData];
    }
 
    NSMutableDictionary *dataDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    [dataDic setObject:[self getUserID] forKey:@"userId"];
    [[ServerController sharedInstance] sendGETServiceRequestForService:SERVICE_GET_USER_BIKES withData:dataDic withDelegate:self];
}

- (NSString *) getUserID
{
    DebugLog(@"");
    AllUserData *allUserData = [ArchiveManager getUserData];
    AccountInformation *userInfo = [allUserData accountInformation];
    
    return userInfo.strUserID;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) saveAndLoadData:(NSArray *) data
{
    DebugLog(@"");
    NSMutableArray *allBikes = [[NSMutableArray alloc] initWithCapacity:1];
    
    for (NSDictionary *bikeInfo in data) {
        BikeDetail *bikeDetail = [[BikeDetail alloc] initWithBikeDetailsDict:bikeInfo];
        
        [allBikes addObject:bikeDetail];
    }
    bikesArray = allBikes;

    
    [self.bikeTable reloadData];
    
    AllUserData *userData = [ArchiveManager getUserData];
    userData.usersBikesArray = bikesArray;
    [ArchiveManager storeDataToFile:userData];
}

#pragma mark-
#pragma mark- Data Source
#pragma mark-
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [bikesArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    BikeTableViewCell *cell = [self.bikeTable dequeueReusableCellWithIdentifier:@"BikeTableViewCell"];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"BikeTableViewCell"];
    }
    
    
    BikeDetail *bikeDetail = [bikesArray objectAtIndex:indexPath.row];
    
    cell.bikeNumber.text = bikeDetail.licensePlateNumber;
    cell.bikeName.text = bikeDetail.bikeName;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DebugLog(@"");
    BikeDetail * bikeDetail = [bikesArray objectAtIndex:indexPath.row];
    [Utils displayAlerViewWithTitle:@"Servicing" withMessage:@"Do you want to take an appointment for servicing of this vehicle." withDelegate:nil];
    
}
#pragma mark-
#pragma mark- Server Controller Delegates
#pragma mark-

- (void)onDataFetchComplete:(NSDictionary *)dicData
{
    DebugLog(@"");
    if ([[[dicData objectForKey:@"Response"] objectForKey:@"Status"] isEqualToString:@"success"]) {
        NSArray *dataArray = [[dicData objectForKey:@"Data"] objectForKey:@"Records"];
        [self saveAndLoadData:dataArray];
    }
}

#pragma mark-
#pragma mark- Custom Actions
#pragma mark-

- (IBAction)actionBackButton:(id)sender {
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
