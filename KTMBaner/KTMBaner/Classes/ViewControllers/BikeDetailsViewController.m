//
//  BikeDetailsViewController.m
//  KTMBaner
//
//  Created by Sagar Kudale on 11/15/14.
//  Copyright (c) 2014 Sagar Kudale. All rights reserved.
//

#import "BikeDetailsViewController.h"
#import "PdfViewController.h"
#import "Constants.h"
#import "Utils.h"
#import "TechSpecsContainerView.h"

@interface BikeDetailsViewController (){
    
}
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIImageView *bikeImageView;
@property (weak, nonatomic) IBOutlet UITextView *notesTextView;

@end

@implementation BikeDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setStatusBarHidden];
    [self loadAllData];
    
}

- (void) loadAllData
{
    DebugLog(@"");
//    self.backButton.titleLabel.text = self.bikeDetails.bikeName;
    [self.backButton setTitle:self.bikeDetails.bikeName forState:UIControlStateNormal];
    self.notesTextView.text = self.bikeDetails.notes;
    
    [Utils downloadImageWithURL:[NSURL URLWithString:self.bikeDetails.bikeImageUrl] completionBlock:^(BOOL succeeded, UIImage *image) {
        if (succeeded) {
            self.bikeImageView.contentMode = UIViewContentModeScaleAspectFit;
            self.bikeImageView.image = image;
        }
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark-
#pragma mark- Action Handling
#pragma mark-
- (IBAction)actionBackButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)testRideButton:(id)sender {
    
}

- (IBAction)actionGetQuotationButton:(id)sender {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    PdfViewController *pdfVC = [storyboard instantiateViewControllerWithIdentifier:@"PdfViewController"];
    pdfVC.pdfURL = self.bikeDetails.pdfURL;
    [self.navigationController pushViewController:pdfVC animated:YES];
    
}
- (IBAction)actionTechnicalSpecsButton:(id)sender {
//    NSMutableDictionary *dictData = [[NSMutableDictionary alloc] init];
//    [dictData setObject:self.bikeDetails.chasisArray forKey:KEY_CHASIS_DATA_ARRAY];
//    [dictData setObject:self.bikeDetails.engineArray forKey:KEY_ENGINE_DATA_ARRAY];
    
//    TechSpecsContainerView *techSpecsContainerView = [[TechSpecsContainerView alloc] initWithFrame:self.view.frame withDictData:dictData];
//    [self.view addSubview:techSpecsContainerView];
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
