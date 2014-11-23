//
//  CostViewController.m
//  KTMBaner
//
//  Created by Sagar Kudale on 11/22/14.
//  Copyright (c) 2014 Sagar Kudale. All rights reserved.
//

#import "CostViewController.h"
#import "ArchiveManager.h"
#import "AllUserData.h"
#import "BikeDetail.h"
#import "Constants.h"
#import "DetailCostViewController.h"

@interface CostViewController (){
    NSArray * allBikeData;
}
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation CostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setStatusBarHidden];
    [self loadAllBikes];
}

- (void) loadAllBikes
{
    DebugLog(@"");
    AllUserData *userData = [ArchiveManager getUserData];
    allBikeData = [userData allBikeInformation];
    if (allBikeData != nil) {
        [self addButtonsForAllBikeData:allBikeData];
    }else{
        [[ServerController sharedInstance] sendGETServiceRequestForService:SERVICE_MERCHANT_VEHICAL withData:nil withDelegate:self];
    }
    
    
}
- (void) addButtonsForAllBikeData:(NSArray *) allBikesData
{
    DebugLog(@"");
    CGRect btnRect = CGRectMake(20, 10, self.view.frame.size.width - 40, 40);
    
    
    UIButton *bikeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [bikeButton addTarget:self
                   action:@selector(actionButtonClicked:)
         forControlEvents:UIControlEventTouchUpInside];
    [bikeButton setTitle:@"All Parts" forState:UIControlStateNormal];
    [bikeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    bikeButton.backgroundColor = [UIColor lightGrayColor];
    bikeButton.frame = btnRect;
    
    bikeButton.layer.cornerRadius = 6;
    bikeButton.layer.masksToBounds = YES;
    
    [self.scrollView addSubview:bikeButton];
    
    for (BikeDetail *bikeDetails in allBikesData) {
        UIButton *bikeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [bikeButton addTarget:self
                       action:@selector(actionButtonClicked:)
             forControlEvents:UIControlEventTouchUpInside];
        [bikeButton setTitle:[bikeDetails bikeName] forState:UIControlStateNormal];
        [bikeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        bikeButton.backgroundColor = [UIColor lightGrayColor];
        btnRect.origin.y += 55;
        bikeButton.layer.cornerRadius = 6;
        bikeButton.layer.masksToBounds = YES;
        bikeButton.frame = btnRect;
        [self.scrollView addSubview:bikeButton];
    }
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, btnRect.origin.y + 50);
}
- (void) actionButtonClicked:(id) sender
{
    DebugLog(@"");
    NSString *vehicalID = @"";
    UIButton *button = (UIButton *) sender;
    if (button != nil) {
        if ([button.titleLabel.text isEqualToString:@"All Parts"]) {
            vehicalID = @"All Parts";
        }else{
            
            for (BikeDetail *bikeDetail in allBikeData) {
                if ([bikeDetail.bikeName isEqualToString:button.titleLabel.text]) {
                    vehicalID = [NSString stringWithFormat:@"%d",(int)[bikeDetail bikeID]];
                    break;
                }
            }
            
        }
    }
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    DetailCostViewController *detailCostVC = [storyboard instantiateViewControllerWithIdentifier:@"DetailCostViewController"];
    detailCostVC.vehicleID = vehicalID;
    [self.navigationController pushViewController:detailCostVC animated:YES];
}
- (void) saveAndLoadData:(NSArray *) data
{
    DebugLog(@"");
    
    NSMutableArray *allBikesInformation = [[NSMutableArray alloc] initWithCapacity:1];
    
    for (NSDictionary *bikeInfo in data) {
        BikeDetail *bikeDetail = [[BikeDetail alloc] init];
        
        bikeDetail.bikeName = [bikeInfo objectForKey:@"Name"];
        bikeDetail.bikeID = [[bikeInfo objectForKey:@"Id"] integerValue];
        bikeDetail.licensePlateNumber = [bikeInfo objectForKey:@"LicensePlateNumber"];
        bikeDetail.modelID = [[bikeInfo objectForKey:@"ModelId"] integerValue];
        bikeDetail.makeId = [[bikeInfo objectForKey:@"MakeId"] integerValue];
        bikeDetail.userID = [[bikeInfo objectForKey:@"UserId"] integerValue];
        bikeDetail.vehicleTypeId = [[bikeInfo objectForKey:@"VehicleTypeId"] integerValue];
        
        [allBikesInformation addObject:bikeDetail];
    }
    allBikeData = allBikesInformation;
    [self addButtonsForAllBikeData:allBikesInformation];
}
#pragma mark-
#pragma mark- Server Controller delegate
#pragma mark-

- (void)onDataFetchComplete:(NSDictionary *)dicData
{
    DebugLog(@"");
    if ([[[dicData objectForKey:@"Response"] objectForKey:@"Status"] isEqualToString:@"success"]) {
        [self saveAndLoadData:[[dicData objectForKey:@"Data"] objectForKey:@"Records"]];
    }
}
#pragma mark-
#pragma mark- Memory management
#pragma mark-

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark-
#pragma mark- Action Handling
#pragma mark-

- (IBAction)actionBackButton:(id)sender {
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
