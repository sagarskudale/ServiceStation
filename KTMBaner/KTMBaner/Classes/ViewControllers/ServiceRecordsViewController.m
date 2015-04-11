//
//  ServiceRecordsViewController.m
//  KTMBaner
//
//  Created by Sagar Kudale on 11/29/14.
//  Copyright (c) 2014 Sagar Kudale. All rights reserved.
//

#import "ServiceRecordsViewController.h"
#import "Constants.h"
#import "ArchiveManager.h"
#import "AllUserData.h"
#import "Utils.h"
#import "AccountInformation.h"
#import "BikeDetail.h"
#import "PdfViewController.h"
#import "ServiceRecordTableViewCell.h"
#import "ServiceRecordDetails.h"
#import "LoadingPlaceHolderView.h"
#import "CurrentViewControllerHandler.h"

#define TAG_PLACEHOLDER 12

typedef enum {
    kServiceTypeNone,
    kServiceTypeGetServiceRecords,
    kServiceTypeGetUserBikeData
}ServiceType;

@interface ServiceRecordsViewController (){
    ServiceType serviceType;
    NSArray *serRecords;
}

@property (weak, nonatomic) IBOutlet UITableView *serviceRecordTableView;
@end

@implementation ServiceRecordsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setStatusBarHidden];
    self.serviceRecordTableView.bounces = NO;
    self.serviceRecordTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if ([[ServerController sharedInstance] isNetworkAvailabe]) {
        [self addPlaceHolderView];
        [self loadServiceRecords];
    }else{
        [self displayStoredRecords];
    }
    
    
}
- (void) displayStoredRecords
{
    DebugLog(@"");
     AllUserData *userData = [ArchiveManager getUserData];
    NSArray *serviceRecords = userData.serviceRecordArray;
    if (serviceRecords == nil || [serviceRecords count] == 0) {
        [self addPlaceHolderView];
    }else{
        serRecords = serviceRecords;
        [self.serviceRecordTableView reloadData];
    }
}
- (void) addPlaceHolderView
{
    DebugLog(@"");
    LoadingPlaceHolderView *placeHolderView = [[LoadingPlaceHolderView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 65) andWithScreenType:kScreenTypeServiceRecords];
    placeHolderView.tag = TAG_PLACEHOLDER;
    [self.serviceRecordTableView addSubview:placeHolderView];
}

- (void) removePlaceHolderView
{
    DebugLog(@"");
    LoadingPlaceHolderView *placeHolderView  = (LoadingPlaceHolderView *) [self.serviceRecordTableView viewWithTag:TAG_PLACEHOLDER];
    if (placeHolderView != nil) {
        [placeHolderView removeFromSuperview];
    }
}

- (void) loadServiceRecords
{
    DebugLog(@"");
    NSMutableDictionary *dataDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    [dataDic setObject:[self getUserID] forKey:@"userId"];
    
    if ([self isUserVehicleDataPresent]) {
        serviceType = kServiceTypeGetServiceRecords;
        [[ServerController sharedInstance] sendGETServiceRequestForService:SERVICE_GET_SERVICE_RECORDS withData:dataDic withDelegate:self];
    }else{
        serviceType = kServiceTypeGetUserBikeData;
        [[ServerController sharedInstance] sendGETServiceRequestForService:SERVICE_GET_USER_BIKES withData:dataDic withDelegate:self];
    }
    
}

- (NSString *) getUserID
{
    DebugLog(@"");
    AllUserData *allUserData = [ArchiveManager getUserData];
    AccountInformation *userInfo = [allUserData accountInformation];
    
    return userInfo.strUserID;
}

- (BOOL) isUserVehicleDataPresent
{
    DebugLog(@"");
    AllUserData *allUserData = [ArchiveManager getUserData];
    NSArray *userBikes = [allUserData usersBikesArray];
    if (userBikes != nil) {
        return YES;
    }
    return NO;
}

- (BikeDetail *) getUserBikeDataForBikeID:(NSString *) bikeID
{
    DebugLog(@"");
    AllUserData *allUserData = [ArchiveManager getUserData];
    NSArray *userBikes = [allUserData usersBikesArray];
    for (BikeDetail *bikeDetails in userBikes) {
        if (bikeDetails.bikeID == [bikeID integerValue]) {
            return bikeDetails;
        }
    }
    
    
    return nil;
}

- (void) saveAndLoadData:(NSArray *) serviceData
{
    DebugLog(@"");
    AllUserData *userData = [ArchiveManager getUserData];
    NSMutableArray *serviceDataArray = [[NSMutableArray alloc] initWithCapacity:1];
    for (NSDictionary *serviceRecord in serviceData) {
        ServiceRecordDetails *serviceDetails = [[ServiceRecordDetails alloc] initWithServiceDetailsDict:serviceRecord];
        [serviceDataArray addObject:serviceDetails];
    }
    userData.serviceRecordArray = serviceDataArray;
    serRecords = serviceDataArray;
    
    [ArchiveManager storeDataToFile:userData];
    [self removePlaceHolderView];
    [self.serviceRecordTableView reloadData];
}

- (void) saveUserVehicleDetails:(NSArray *)data
{
    DebugLog(@"");
    NSMutableArray *allBikes = [[NSMutableArray alloc] initWithCapacity:1];
    
    for (NSDictionary *bikeInfo in data) {
        BikeDetail *bikeDetail = [[BikeDetail alloc] initWithBikeDetailsDict:bikeInfo];
        
        [allBikes addObject:bikeDetail];
    }
    AllUserData *userData = [ArchiveManager getUserData];
    userData.usersBikesArray = allBikes;
    [ArchiveManager storeDataToFile:userData];
    
    NSMutableDictionary *dataDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    [dataDic setObject:[self getUserID] forKey:@"userId"];
    serviceType = kServiceTypeGetServiceRecords;
    [[ServerController sharedInstance] sendGETServiceRequestForService:SERVICE_GET_SERVICE_RECORDS withData:dataDic withDelegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionBackButton:(id)sender {
    DebugLog(@"");
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark-
#pragma mark- Data Source
#pragma mark-
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [serRecords count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ServiceRecordTableViewCell *cell = [self.serviceRecordTableView dequeueReusableCellWithIdentifier:@"ServiceRecordTableViewCell"];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ServiceRecordTableViewCell"];
    }
    
    ServiceRecordDetails *serviceDetails = [serRecords objectAtIndex:indexPath.row];
    cell.bikeNumber.text = [self getUserBikeDataForBikeID:[NSString stringWithFormat:@"%d",(int)serviceDetails.vehicleID]].licensePlateNumber;
    cell.kms.text = [NSString stringWithFormat:@"%dKms", serviceDetails.kms];
    
    NSString *serviceDate = (NSString *) serviceDetails.date;
    NSString *date = [[serviceDate componentsSeparatedByString:@"T"] objectAtIndex:0];
    
    cell.date.text = date;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DebugLog(@"");
    
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        PdfViewController *pdfVC = [storyboard instantiateViewControllerWithIdentifier:@"PdfViewController"];
        
        ServiceRecordDetails *serviceDetails = [serRecords objectAtIndex:indexPath.row];
        pdfVC.pdfURL = serviceDetails.pdfURL;
        [CurrentViewControllerHandler sharedInstance].currentViewController = pdfVC;

        [self.navigationController pushViewController:pdfVC animated:YES];

    
}

#pragma mark-
#pragma mark- Server Controller Delegates
#pragma mark-

- (void)onDataFetchComplete:(NSDictionary *)dicData
{
    DebugLog(@"");
    if (serviceType == kServiceTypeGetServiceRecords) {
        if ([[[dicData objectForKey:@"Response"] objectForKey:@"Status"] isEqualToString:@"success"]) {
            NSArray *dataArray = [[dicData objectForKey:@"Data"] objectForKey:@"Records"];
            [self saveAndLoadData:dataArray];
        }
    }else if (serviceType == kServiceTypeGetUserBikeData)
    {
        if ([[[dicData objectForKey:@"Response"] objectForKey:@"Status"] isEqualToString:@"success"]) {
            NSArray *dataArray = [[dicData objectForKey:@"Data"] objectForKey:@"Records"];
            [self saveUserVehicleDetails:dataArray];
        }
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
