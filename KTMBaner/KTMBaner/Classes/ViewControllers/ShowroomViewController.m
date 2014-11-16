//
//  ShowroomViewController.m
//  KTMBaner
//
//  Created by Sagar Kudale on 11/13/14.
//  Copyright (c) 2014 Sagar Kudale. All rights reserved.
//

#import "ShowroomViewController.h"
#import "BikeDetailView.h"
#import "Constants.h"
#import "ArchiveManager.h"
#import "AllUserData.h"
#import "BikeDetailsViewController.h"

@interface ShowroomViewController (){
    NSArray *bikeInfoArray;
}
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation ShowroomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setStatusBarHidden];
    [[ServerController sharedInstance] sendGETServiceRequestForService:SERVICE_MERCHANT_VEHICAL withData:nil withDelegate:self];
    CGSize scrollableSize = CGSizeMake(self.view.frame.size.width, self.scrollView.frame.size.height);
    [self.scrollView setContentSize:scrollableSize];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) addBikeDetails
{
    DebugLog(@"");
    float width = (self.scrollView.frame.size.width - 60) / 2;
    CGSize detailViewSize = CGSizeMake(width, width * 1.4);
    float height = 15;
    for (int i = 0; i< [bikeInfoArray count]; i++) {
        
        CGPoint position = CGPointMake(((i % 2) * (30 + width)) + 15,height );
        
        BikeDetailView *detailView = [[BikeDetailView alloc] initWithFrame:CGRectMake(position.x, position.y, detailViewSize.width, detailViewSize.height) withBikeDetails:[bikeInfoArray objectAtIndex:i]];
        detailView.delegate = self;
        [self.scrollView addSubview:detailView];
        
        if (i > 0 && (i % 2) == 0) {
            height = height + width * 1.4 + 15;
        }
        
    }
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, height);
}

- (void) saveDataToArchiver:(NSArray *) bikeData
{
    DebugLog(@"");
    AllUserData *userData = [ArchiveManager getUserData];
    userData.allBikeInformation = bikeData;
    
    [ArchiveManager storeDataToFile:userData];
}

- (void) saveAndLoadData:(NSArray *) data
{
    DebugLog(@"");
    
    NSMutableArray *allBikesInformation = [[NSMutableArray alloc] initWithCapacity:1];
    
    for (NSDictionary *bikeInfo in data) {
        BikeDetail *bikeDetail = [[BikeDetail alloc] initWithBikeDetailsDict:bikeInfo];
        [allBikesInformation addObject:bikeDetail];
    }
    
    bikeInfoArray = [NSArray arrayWithArray:allBikesInformation];
    [self saveDataToArchiver:bikeInfoArray];
    [self addBikeDetails];
}

- (IBAction)actionBackButton:(id)sender
{
    DebugLog(@"");
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark-
#pragma mark- server controller delegates
#pragma mark-

- (void)onDataFetchComplete:(NSDictionary *)dicData
{
    DebugLog(@"");
    DebugLog(@"dic data : %@", [dicData debugDescription]);
    if ([[[dicData objectForKey:@"Response"] objectForKey:@"Status"] isEqualToString:@"success"]) {
        [self saveAndLoadData:[[dicData objectForKey:@"Data"] objectForKey:@"Records"]];
    }
}

#pragma mark-
#pragma mark- BikeDetailView delegate
#pragma mark-

- (void) onTestRideButtonClicked:(BikeDetail *) bikeDetail
{
    DebugLog(@"");
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    BikeDetailsViewController *bikeDetailVC = [storyboard instantiateViewControllerWithIdentifier:@"BikeDetailsViewController"];
    bikeDetailVC.bikeDetails = bikeDetail;
    [self.navigationController pushViewController:bikeDetailVC animated:YES];
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
