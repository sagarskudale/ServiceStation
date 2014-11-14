//
//  BikeDetailView.h
//  KTMBaner
//
//  Created by Sagar Kudale on 11/13/14.
//  Copyright (c) 2014 Sagar Kudale. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BikeDetail.h"

@protocol BikeDetailViewDelegate <NSObject>

- (void) onTestRideButtonClicked:(BikeDetail *) bikeDetail;

@end

@interface BikeDetailView : UIView

@property (nonatomic, unsafe_unretained) id<BikeDetailViewDelegate> delegate;

- (id) initWithFrame:(CGRect)frame withBikeDetails:(BikeDetail *) bikeDetails;
@end
