//
//  LoadingPlaceHolderView.h
//  KTMBaner
//
//  Created by Sagar Kudale on 11/16/14.
//  Copyright (c) 2014 Sagar Kudale. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    kScreenTypeNone,
    kScreenTypeShowroom,
    kScreenTypeServiceRecords
}ScreenType;

@interface LoadingPlaceHolderView : UIView

- (id) initWithFrame:(CGRect)frame andWithScreenType:(ScreenType) screenType;

@end
