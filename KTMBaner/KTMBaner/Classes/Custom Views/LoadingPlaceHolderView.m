//
//  LoadingPlaceHolderView.m
//  KTMBaner
//
//  Created by Sagar Kudale on 11/16/14.
//  Copyright (c) 2014 Sagar Kudale. All rights reserved.
//

#import "LoadingPlaceHolderView.h"
#import "Constants.h"

#define TAG_IMAGE_VIEW 122

@implementation LoadingPlaceHolderView{
    ScreenType _screenType;
}


- (id) initWithFrame:(CGRect)frame andWithScreenType:(ScreenType) screenType
{
    self = [super initWithFrame:frame];
    if (self) {
        _screenType = screenType;
        [self initialiseView];
    }
    return self;
}

- (void) initialiseView
{
    DebugLog(@"");
    [self addSmilyImageView];
    [self addMessageLabel];
}

- (void) addSmilyImageView
{
    DebugLog(@"");
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width * 0.7, self.frame.size.width * 0.7)];
    imageView.tag = TAG_IMAGE_VIEW;
    imageView.image = [UIImage imageNamed:@"no_records"];
    imageView.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height * 0.5 - 65);
    [self addSubview:imageView];
}

- (void) addMessageLabel
{
    DebugLog(@"");
    UIImageView *imageView = (UIImageView *) [self viewWithTag:TAG_IMAGE_VIEW];
    
    UILabel *msgLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width - 10, 100)];
    msgLabel.text = [self getMessageToDisplay];
    msgLabel.numberOfLines = 2;
    msgLabel.textAlignment = NSTextAlignmentCenter;
    msgLabel.textColor = [UIColor redColor];
    msgLabel.center = CGPointMake(self.frame.size.width / 2, imageView.center.y + imageView.frame.size.height / 2 + 100);
    [self addSubview:msgLabel];
}

- (NSString *) getMessageToDisplay
{
    DebugLog(@"");
    if(_screenType == kScreenTypeShowroom){
        return @"No records found! \nKeep checking for updates.";
    }
    return nil;
}

@end
