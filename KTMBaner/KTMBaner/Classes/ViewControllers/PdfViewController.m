//
//  PdfViewController.m
//  KTMBaner
//
//  Created by Sagar Kudale on 11/15/14.
//  Copyright (c) 2014 Sagar Kudale. All rights reserved.
//

#import "PdfViewController.h"
#import "Constants.h"

@interface PdfViewController (){
    UIActivityIndicatorView * activityIndicator;
}

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end

@implementation PdfViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicator.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2);
    [self.view addSubview:activityIndicator];
    
    [activityIndicator startAnimating];
    [self.webView setScalesPageToFit:YES];
    
    self.webView.delegate = self;
    
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://ktmbaner.com/FileUploads/%@",self.pdfURL]]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark-
#pragma mark- webView Delegate
#pragma mark-

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    DebugLog(@"");
    [activityIndicator removeFromSuperview];
}

#pragma mark-
#pragma mark- Action handling
#pragma mark-

- (IBAction)actionBackButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
