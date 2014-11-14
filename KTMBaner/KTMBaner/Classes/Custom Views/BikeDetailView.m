//
//  BikeDetailView.m
//  KTMBaner
//
//  Created by Sagar Kudale on 11/13/14.
//  Copyright (c) 2014 Sagar Kudale. All rights reserved.
//

#import "BikeDetailView.h"
#import "Constants.h"
#import "Utils.h"

@implementation BikeDetailView
{
    BikeDetail *bikeDetail;
}

- (id) initWithFrame:(CGRect)frame withBikeDetails:(BikeDetail *) bikeDetails
{
    self = [super initWithFrame:frame];
    if (self) {
        bikeDetail = bikeDetails;
        self.backgroundColor = [UIColor whiteColor];
        [self addTestRideButton];
        [self addBikeImage];
        [self addBikeName];
    }
    return self;
}

- (void) addTestRideButton
{
    DebugLog(@"");
    UIButton *testRideButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [testRideButton addTarget:self
               action:@selector(acionTestRideButtonClicked)
     forControlEvents:UIControlEventTouchUpInside];
    [testRideButton setBackgroundColor:[UIColor orangeColor]];
    [testRideButton setTitle:@"Test Ride" forState:UIControlStateNormal];
    [testRideButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    testRideButton.frame = CGRectMake(5, self.frame.size.height - self.frame.size.height * 0.2 - 10, self.frame.size.width - 10, self.frame.size.height * 0.2);
    [self addSubview:testRideButton];
}

- (void) acionTestRideButtonClicked
{
    DebugLog(@"");
    [self.delegate onTestRideButtonClicked:bikeDetail];
}

- (void) addBikeName
{
    DebugLog(@"");
    UILabel *bikeName = [[UILabel alloc] initWithFrame:CGRectMake(5,  self.frame.size.height - self.frame.size.height * 0.2 - 50, self.frame.size.width - 10, 40)];
    bikeName.text = bikeDetail.bikeName;
    [bikeName setFont:[UIFont systemFontOfSize:15]];
    bikeName.textAlignment = NSTextAlignmentCenter;
    [self addSubview:bikeName];
}

- (void) addBikeImage
{
    DebugLog(@"");
    UIImageView *bikeImage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, self.frame.size.width - 10, self.frame.size.height - self.frame.size.height * 0.2 - 60)];
    
    [Utils downloadImageWithURL:[NSURL URLWithString:bikeDetail.bikeImageUrl] completionBlock:^(BOOL succeeded, UIImage *image) {
        if (succeeded) {
            bikeImage.image = image;
            
        }
    }];
    
    [self addSubview:bikeImage];
}

@end
