//
//  SelectTimeView.m
//  KTMBaner
//
//  Created by Sagar Kudale on 11/18/14.
//  Copyright (c) 2014 Sagar Kudale. All rights reserved.
//

#import "SelectTimeView.h"
#import "Constants.h"

#define TAG_DATE_BUTTONS 200 // +

#define NO_OF_BUTTON_PER_ROW 3
#define BUTTON_HEIGHT 30
#define PADDING 10
#define DISTANCE_BETWEEN_TWO_BUTTON 10


@implementation SelectTimeView{
    NSArray *dateArray;
    UIColor *grayColor, *orangeColor;
    NSString *selectedTime;
}

- (id) initWithDatesArray:(NSArray *) DatesArray
{
    DebugLog(@"");
    
    self = [super init];
    if (self) {
        dateArray = DatesArray;
        selectedTime = nil;
        orangeColor = [UIColor colorWithRed:242 / 255 green:101 / 255 blue:35 / 255 alpha:1];
        [self initialiseView];
    }
    return self;
}

- (void) initialiseView
{
    DebugLog(@"");
    NSUInteger totalRows = [dateArray count] / NO_OF_BUTTON_PER_ROW; // 3 is number of buttons per row
    if ([dateArray count] % NO_OF_BUTTON_PER_ROW != 0) {
        totalRows +=1;
    }
    float buttonWidth = ([[UIScreen mainScreen] bounds].size.width - 20 - 10) / 3; // 10 is left and right padding (10 + 10) and other one is distane between two button
    
    self.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, totalRows * BUTTON_HEIGHT + DISTANCE_BETWEEN_TWO_BUTTON);
    
    float height = 0;
    for (int i = 0; i < [dateArray count]; i++) {
        float xPos = 10 + (buttonWidth * (i % NO_OF_BUTTON_PER_ROW) + (DISTANCE_BETWEEN_TWO_BUTTON / 2) * (i % NO_OF_BUTTON_PER_ROW));
        if (i > 0 && (i % NO_OF_BUTTON_PER_ROW) == 0) {
            height = height + BUTTON_HEIGHT + DISTANCE_BETWEEN_TWO_BUTTON;
        }else if (i == 0){
            height = height + DISTANCE_BETWEEN_TWO_BUTTON;
        }

        
        
        UIButton *dateButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [dateButton addTarget:self
                       action:@selector(onButtonPressed:)
         forControlEvents:UIControlEventTouchUpInside];
        dateButton.backgroundColor = [UIColor lightGrayColor];
        dateButton.tag = TAG_DATE_BUTTONS + i;
        [dateButton setTitle:(NSString *)[dateArray objectAtIndex:i] forState:UIControlStateNormal];
        [dateButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        dateButton.frame = CGRectMake(xPos, height, buttonWidth, BUTTON_HEIGHT);
        [self addSubview:dateButton];
    }
    
}

- (void) resetAllButtonState
{
    DebugLog(@"");
    for (int i =0 ; i< [dateArray count]; i++) {
        UIButton *button = (UIButton *) [self viewWithTag:TAG_DATE_BUTTONS + i];
        if (button != nil) {
            [button setBackgroundColor:[UIColor lightGrayColor]];
        }
    }
}
- (NSString *) getSelectedTime
{
    DebugLog(@" %@",selectedTime);
    return selectedTime;
}
- (void) onButtonPressed:(id) sender
{
    DebugLog(@"");
    [self resetAllButtonState];
    UIButton *button = (UIButton *) sender;
    if (button != nil) {
        selectedTime = button.titleLabel.text;
        [button setBackgroundColor:[UIColor orangeColor]];
    }
}

@end
