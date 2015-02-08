//
//  PdfDownloader.m
//  KTMBaner
//
//  Created by Sagar Kudale on 2/7/15.
//  Copyright (c) 2015 Sagar Kudale. All rights reserved.
//

#import "PdfDownloader.h"

@implementation PdfDownloader {
    NSMutableData *receivedData;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}



-(void)downloadWithNsurlconnection:(NSString *) pdfUrl
{
    NSData *myFile = [NSData dataWithContentsOfURL:[NSURL URLWithString:pdfUrl]];
    [myFile writeToFile:[NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], @"yourfilename.pdf"] atomically:YES];
}

@end
