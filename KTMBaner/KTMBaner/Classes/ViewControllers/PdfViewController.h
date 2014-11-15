//
//  PdfViewController.h
//  KTMBaner
//
//  Created by Sagar Kudale on 11/15/14.
//  Copyright (c) 2014 Sagar Kudale. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PdfViewController : UIViewController<UIWebViewDelegate>
@property (nonatomic, strong) NSString * pdfURL;
@end
