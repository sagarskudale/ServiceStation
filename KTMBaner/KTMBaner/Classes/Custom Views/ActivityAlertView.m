//
//  ActivityAlertView.m
//  iOS_OUTDemo
//
//  Created by Sagar Kudale on 05/02/14.
//  Copyright (c) 2014 CUELogic. All rights reserved.
//

#import "ActivityAlertView.h"

@implementation ActivityAlertView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}

- (void) close
{
	[self dismissWithClickedButtonIndex:0 animated:YES];
}

-(void)statAnimation
{
    UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(125, 55, 30, 30)];
    [activityView startAnimating];
    activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    [self addSubview:activityView];
}

#pragma mark - Show Activity Indicator -
-(void)showActivityIndicator
{
    [self show];
    [self statAnimation];
}

#pragma mark - Hide Activity Indicator -
-(void)hideActivityIndicator
{
    //Remove the alert
    [self close];
}

@end
