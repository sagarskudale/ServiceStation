//
//  SelectDatesView.h
//  KTMBaner
//
//  Created by Sagar Kudale on 11/18/14.
//  Copyright (c) 2014 Sagar Kudale. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectTimeView : UIView

- (id) initWithDatesArray:(NSArray *) DatesArray;
- (NSString *) getSelectedTime;
@end
