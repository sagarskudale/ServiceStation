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

- (void)viewWillAppear:(BOOL)animated {
    
}

#pragma mark-
#pragma mark- Initialisation methods
#pragma mark-

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
    
}

- (void) addTapGesturesOnPointsView
{
    
}

- (void) addTapGesturesOnCostView
{
    
}

- (void) addTapGesturesOnUserView
{
    [self addTapGestureOnView:viewUser withAction:@selector(onUserViewTapped)];
}

- (void) addTapGesturesOnServiceView
{
    
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

- (void) onShowRoomViewTapped
{
    DebugLog(@"");
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"SignUp" bundle: nil];
    ShowroomViewController *showroomVC = [storyboard instantiateViewControllerWithIdentifier:@"ShowroomViewController"];
    [self.navigationController pushViewController:showroomVC animated:YES];
}

- (void) onAppointmentViewTapped
{
    DebugLog(@"");
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
//    AppointmentViewController *appointmentVC = [storyboard instantiateViewControllerWithIdentifier:@"AppointmentViewController"];
//    [self.navigationController pushViewController:appointmentVC animated:YES];
}

- (void) onAboutUsViewTapped
{
    DebugLog(@"");
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    AboutUsViewController *aboutUsVC = [storyboard instantiateViewControllerWithIdentifier:@"AboutUsViewController"];
    [self.navigationController pushViewController:aboutUsVC animated:YES];

}

- (void) onUserViewTapped
{
    DebugLog(@"");
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    AccountDetailsViewController *accountInfoView = [storyboard instantiateViewControllerWithIdentifier:@"AccountDetailsViewController"];
    [self.navigationController pushViewController:accountInfoView animated:YES];
}

- (void) onInstagramViewTapped
{
    DebugLog(@"");
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    KtmInstagramViewController *instagramVC = [storyboard instantiateViewControllerWithIdentifier:@"KtmInstagramViewController"];
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
