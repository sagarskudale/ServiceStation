//
//  KtmInstagramViewController.m
//  KTMBaner
//
//  Created by Sagar Kudale on 11/9/14.
//  Copyright (c) 2014 Sagar Kudale. All rights reserved.
//

#import "KtmInstagramViewController.h"
#import "Constants.h"

#define INSTAGRAM_LINK @"http://www.yooying.com/tag/ktmbaner"

@interface KtmInstagramViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation KtmInstagramViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setStatusBarHidden];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:INSTAGRAM_LINK]]];
}

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
