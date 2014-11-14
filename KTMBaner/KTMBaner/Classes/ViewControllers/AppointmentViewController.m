//
//  AppointmentViewController.m
//  KTMBaner
//
//  Created by Sagar Kudale on 11/11/14.
//  Copyright (c) 2014 Sagar Kudale. All rights reserved.
//

#import "AppointmentViewController.h"
#import "Constants.h"

@interface AppointmentViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation AppointmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setStatusBarHidden];
    
    NSMutableDictionary *dataDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    [dataDic setObject:@"2" forKey:@"type"];
    [dataDic setObject:@"" forKey:@"date"];
    
    [[ServerController sharedInstance] sendGETServiceRequestForService:SERVICE_NAME_GET_SHEDULE withData:dataDic withDelegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark-
#pragma mark- Action Handling
#pragma mark-

- (IBAction)onBackButton:(id)sender {
}

#pragma mark-
#pragma mark- Table View Delegate
#pragma mark-

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    DebugLog(@"");
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DebugLog(@"");
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"AppointmentCell" forIndexPath:indexPath];
    
    
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
