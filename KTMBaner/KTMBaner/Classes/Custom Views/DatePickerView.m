//
//  DatePickerView.m
//  KTMBaner
//
//  Created by Sagar Kudale on 11/8/14.
//  Copyright (c) 2014 Sagar Kudale. All rights reserved.
//

#import "DatePickerView.h"
#import "Constants.h"

@implementation DatePickerView{
    UIDatePicker *datePicker;
}
@synthesize delegate;

- (id) initDatePickerViewWithDate:(NSDate *) currentDate withDelegate:(id<DatePickerViewDelegate>) del
{
    DebugLog(@"");
    self = [super init];
    if (self) {
        delegate = del;
        [self initiliseViewWithCurrentDate:currentDate];
    }
    return self;
}

- (void) initiliseViewWithCurrentDate:(NSDate *) currentDate
{
    DebugLog(@"");
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    self.frame = CGRectMake(0, 0, screenWidth, 250);
    self.backgroundColor = [UIColor lightGrayColor];
    [self addBorder];
    
    [self addDoneButton];
    [self addDatePickerWithCurrentDate:currentDate];
}

- (void) addBorder
{
    DebugLog(@"");
    
    CGFloat borderWidth = 2.0f;
    self.layer.borderColor = [UIColor orangeColor].CGColor;
    self.layer.borderWidth = borderWidth;
}

- (void) addDoneButton
{
    DebugLog(@"");
    
    [self addBackgroundViewToDoneButton];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button addTarget:self
               action:@selector(onDoneButtonPressed)
     forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"Done" forState:UIControlStateNormal];
    button.frame = CGRectMake( self.frame.size.width - 100 , 0, 100, 50);
    [self addSubview:button];
}

- (void) addBackgroundViewToDoneButton
{
    DebugLog(@"");
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 50)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bgView];
}

- (void) onDoneButtonPressed
{
    DebugLog(@"");
    [delegate onDateSelected:datePicker.date];
    [self removeFromSuperview];
}

- (void) addDatePickerWithCurrentDate:(NSDate *) currentDate
{
    DebugLog(@"");
    datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 50, self.frame.size.width, 200)];
    datePicker.datePickerMode = UIDatePickerModeDate;
    datePicker.hidden = NO;
    datePicker.date = currentDate;
    [self addSubview:datePicker];
}
@end
