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
    
    
}
- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicator.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2);
    [self.view addSubview:activityIndicator];
    
    [activityIndicator startAnimating];
    [self.webView setScalesPageToFit:YES];
    
    self.webView.delegate = self;
    
    
    NSString *url = [NSString stringWithFormat:@"http://ktmbaner.com/FileUploads/%@",self.pdfURL];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {
        NSArray *parts = [url componentsSeparatedByString:@"/"];
        NSString *filename = [parts objectAtIndex:[parts count]-1];
        
        NSString *path = NSHomeDirectory();
        path = [NSString stringWithFormat:@"%@/%@",path,filename];
        NSData *pdfData = [NSData dataWithContentsOfFile:path];
        if (pdfData == nil) {
            NSArray *parts = [url componentsSeparatedByString:@"/"];
            NSString *filename = [parts objectAtIndex:[parts count]-1];
            
            
            NSString *path = NSHomeDirectory();
            path = [NSString stringWithFormat:@"%@/%@",path,filename];
            
            pdfData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
            [pdfData writeToFile:path atomically:YES];
        }
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            [self.webView loadData:pdfData MIMEType: @"application/pdf" textEncodingName: @"UTF-8" baseURL:nil];
        });
    });
        
}
- (void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    
    
    
    //    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.pdfURL]]]];
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


#pragma mark-
#pragma mark- Download pdf
#pragma mark-

- (NSData *) getPdfAtUrl:(NSString *) url
{
    DebugLog(@"");
    
    NSArray *parts = [url componentsSeparatedByString:@"/"];
    NSString *filename = [parts objectAtIndex:[parts count]-1];
    
    NSString *path = NSHomeDirectory();
    path = [NSString stringWithFormat:@"%@/%@",path,filename];
    NSData *pdfData = [NSData dataWithContentsOfFile:path];
    if (pdfData != nil) {
        return pdfData;
    }
    
    return [self downloadPDFAtURL:url];
}

- (NSData *) downloadPDFAtURL:(NSString *) pdfUrl {
    DebugLog(@"");
    
    
    NSArray *parts = [pdfUrl componentsSeparatedByString:@"/"];
    NSString *filename = [parts objectAtIndex:[parts count]-1];
    
    
    NSString *path = NSHomeDirectory();
    path = [NSString stringWithFormat:@"%@/%@",path,filename];
    
    NSData *myFile = [NSData dataWithContentsOfURL:[NSURL URLWithString:pdfUrl]];
    [myFile writeToFile:path atomically:YES];
    return myFile;
}

@end
