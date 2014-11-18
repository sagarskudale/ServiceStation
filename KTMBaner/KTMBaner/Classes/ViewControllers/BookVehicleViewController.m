//
//  BookVehicleViewController.m
//  KTMBaner
//
//  Created by Sagar Kudale on 11/18/14.
//  Copyright (c) 2014 Sagar Kudale. All rights reserved.
//

#import "BookVehicleViewController.h"

@interface BookVehicleViewController ()
@property (weak, nonatomic) IBOutlet UIButton *buttonToday;
@property (weak, nonatomic) IBOutlet UIButton *buttonTommorrow;
@property (weak, nonatomic) IBOutlet UILabel *labelDate;

@end

@implementation BookVehicleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark-
#pragma mark- Action Handling..
#pragma mark-
- (IBAction)actionBackButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)actionChooseAddress:(id)sender {
}

- (IBAction)actionBook:(id)sender {
}

@end
