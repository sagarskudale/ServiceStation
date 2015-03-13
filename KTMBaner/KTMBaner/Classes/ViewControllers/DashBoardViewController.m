//
//  ViewController.m
//  KTMBaner
//
//  Created by Sagar Kudale on 10/29/14.
//  Copyright (c) 2014 Sagar Kudale. All rights reserved.
//

#import "DashBoardViewController.h"
#import "AboutUsViewController.h"
#import "KtmInstagramViewController.h"
#import "Constants.h"
#import "AccountDetailsViewController.h"
#import "AppointmentViewController.h"
#import "ShowroomViewController.h"
#import "CurrentViewControllerHandler.h"
#import "ServiceRecordsViewController.h"
#import "CostViewController.h"
#import "BikeViewController.h"
#import "AllUserData.h"
#import "ServiceRecordDetails.h"
#import "ArchiveManager.h"

@interface DashBoardViewController ()
@property (weak, nonatomic) IBOutlet UILabel *labelPoints;

@end

@implementation DashBoardViewController{
    IBOutlet UIView *viewAppointment;
    IBOutlet UIView *viewBike;
    IBOutlet UIView *viewPoints;
    IBOutlet UIView *viewCost;
    IBOutlet UIView *viewUser;
    IBOutlet UIView *viewService;
    IBOutlet UIView *viewKtmInstagram;
    IBOutlet UIView *viewShowroom;
    IBOutlet UIView *viewAboutUs;
}

#pragma mark-
#pragma mark- View Life cycle
#pragma mark-

- (void)viewDidLoad {
    DebugLog(@"");
    [super viewDidLoad];
    [self setStatusBarHidden];
    [self addTapGesturesOnAllViews];
    
}

- (void) viewWillAppear:(BOOL)animated {
    DebugLog(@"");
    [self updatePoints];
}


#pragma mark-
#pragma mark- Initialisation methods
#pragma mark-
- (void) updatePoints
{
    DebugLog(@"");
    AllUserData *userData = [ArchiveManager getUserData];
    NSArray *serviceRecord = [userData serviceRecordArray];
    
    NSUInteger points = 0;
    for (ServiceRecordDetails * serviceDetail in  serviceRecord) {
        points = points + serviceDetail.points;
    }
    
    self.labelPoints.text = [NSString stringWithFormat:@"%d",(int) points];
}
- (void) addTapGesturesOnAllViews
{
    [self addTapGesturesOnAboutUsView];
    [self addTapGesturesOnAppointmentView];
    [self addTapGesturesOnBikeView];
    [self addTapGesturesOnCostView];
    [self addTapGesturesOnInstaramView];
    [self addTapGesturesOnPointsView];
    [self addTapGesturesOnServiceView];
    [self addTapGesturesOnShowroomView];
    [self addTapGesturesOnUserView];
}

#pragma mark-
#pragma mark- Add Tap Gestures
#pragma mark-

- (void) addTapGestureOnView:(UIView *) view withAction:(SEL) sel
{
    UITapGestureRecognizer *tapGestureRecogniser = [[UITapGestureRecognizer alloc] initWithTarget:self action:sel];
    tapGestureRecogniser.numberOfTapsRequired = 1;
    [view addGestureRecognizer:tapGestureRecogniser];
}

- (void) addTapGesturesOnAppointmentView
{
    [self addTapGestureOnView:viewAppointment withAction:@selector(onAppointmentViewTapped)];
}

- (void) addTapGesturesOnBikeView
{
    [self addTapGestureOnView:viewBike withAction:@selector(onBikeViewTapped)];
}

- (void) addTapGesturesOnPointsView
{
    
}

- (void) addTapGesturesOnCostView
{
    [self addTapGestureOnView:viewCost withAction:@selector(onCostViewTapped)];
}

- (void) addTapGesturesOnUserView
{
    [self addTapGestureOnView:viewUser withAction:@selector(onUserViewTapped)];
}

- (void) addTapGesturesOnServiceView
{
    [self addTapGestureOnView:viewService withAction:@selector(onServiceRecordViewTapped)];
}

- (void) addTapGesturesOnInstaramView
{
    [self addTapGestureOnView:viewKtmInstagram withAction:@selector(onInstagramViewTapped)];
}

- (void) addTapGesturesOnShowroomView
{
    [self addTapGestureOnView:viewShowroom withAction:@selector(onShowRoomViewTapped)];
}

- (void) addTapGesturesOnAboutUsView
{
    DebugLog(@"");
    [self addTapGestureOnView:viewAboutUs withAction:@selector(onAboutUsViewTapped)];
}

#pragma mark-
#pragma mark- Action Handling
#pragma mark-
- (void) onBikeViewTapped
{
    DebugLog(@"");
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    BikeViewController *bikeVC = [storyboard instantiateViewControllerWithIdentifier:@"BikeViewController"];
    [CurrentViewControllerHandler sharedInstance].currentViewController = bikeVC;

    [self.navigationController pushViewController:bikeVC animated:YES];
}

- (void) onServiceRecordViewTapped
{
    DebugLog(@"");
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    ServiceRecordsViewController *serviceRecordVC = [storyboard instantiateViewControllerWithIdentifier:@"ServiceRecordsViewController"];
    [CurrentViewControllerHandler sharedInstance].currentViewController = serviceRecordVC;

    [self.navigationController pushViewController:serviceRecordVC animated:YES];
}

- (void) onCostViewTapped
{
    DebugLog(@"");
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    CostViewController *costVC = [storyboard instantiateViewControllerWithIdentifier:@"CostViewController"];
    [CurrentViewControllerHandler sharedInstance].currentViewController = costVC;

    [self.navigationController pushViewController:costVC animated:YES];
}

- (void) onShowRoomViewTapped
{
    DebugLog(@"");
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"SignUp" bundle: nil];
    ShowroomViewController *showroomVC = [storyboard instantiateViewControllerWithIdentifier:@"ShowroomViewController"];
    [CurrentViewControllerHandler sharedInstance].currentViewController = showroomVC;

    [self.navigationController pushViewController:showroomVC animated:YES];
}

- (void) onAppointmentViewTapped
{
    DebugLog(@"");
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    AppointmentViewController *appointmentVC = [storyboard instantiateViewControllerWithIdentifier:@"AppointmentViewController"];
    [CurrentViewControllerHandler sharedInstance].currentViewController = appointmentVC;

    [self.navigationController pushViewController:appointmentVC animated:YES];
}

- (void) onAboutUsViewTapped
{
    DebugLog(@"");
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    AboutUsViewController *aboutUsVC = [storyboard instantiateViewControllerWithIdentifier:@"AboutUsViewController"];
    [CurrentViewControllerHandler sharedInstance].currentViewController = aboutUsVC;

    [self.navigationController pushViewController:aboutUsVC animated:YES];

}

- (void) onUserViewTapped
{
    DebugLog(@"");
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    AccountDetailsViewController *accountInfoView = [storyboard instantiateViewControllerWithIdentifier:@"AccountDetailsViewController"];
    [CurrentViewControllerHandler sharedInstance].currentViewController = accountInfoView;

    [self.navigationController pushViewController:accountInfoView animated:YES];
}

- (void) onInstagramViewTapped
{
    DebugLog(@"");
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    KtmInstagramViewController *instagramVC = [storyboard instantiateViewControllerWithIdentifier:@"KtmInstagramViewController"];
    [CurrentViewControllerHandler sharedInstance].currentViewController = instagramVC;

    [self.navigationController pushViewController:instagramVC animated:YES];
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

#pragma mark-
#pragma mark- Memory Warning Handling
#pragma mark-

- (void)didReceiveMemoryWarning {
    DebugLog(@"");
    [super didReceiveMemoryWarning];
}
@end
