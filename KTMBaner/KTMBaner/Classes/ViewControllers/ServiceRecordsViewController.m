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
#import "AccountInformation.h"

@interface ServiceRecordsViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;

@end

@implementation ServiceRecordsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setStatusBarHidden];
    [self loadServiceRecords];
}

- (void) loadServiceRecords
{
    DebugLog(@"");
    NSMutableDictionary *dataDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    [dataDic setObject:[self getUserID] forKey:@"userId"];
    
    [[ServerController sharedInstance] sendGETServiceRequestForService:SERVICE_GET_SERVICE_RECORDS withData:dataDic withDelegate:self];
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

- (IBAction)actionBackButton:(id)sender {
}

#pragma mark-
#pragma mark- Server Controller Delegates
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
