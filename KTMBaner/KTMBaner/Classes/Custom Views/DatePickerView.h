//
//  DatePickerView.h
//  KTMBaner
//
//  Created by Sagar Kudale on 11/8/14.
//  Copyright (c) 2014 Sagar Kudale. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DatePickerViewDelegate <NSObject>

- (void) onDateSelected:(NSDate *) selectedDate;

@end

@interface DatePickerView : UIView
@property (nonatomic, unsafe_unretained) id<DatePickerViewDelegate> delegate;

- (id) initDatePickerViewWithDate:(NSDate *) currentDate withDelegate:(id<DatePickerViewDelegate>) del;
@end
