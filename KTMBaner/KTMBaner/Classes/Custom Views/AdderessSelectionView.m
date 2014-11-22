//
//  AdderessSelectionView.m
//  KTMBaner
//
//  Created by Sagar Kudale on 11/21/14.
//  Copyright (c) 2014 Sagar Kudale. All rights reserved.
//

#import "AdderessSelectionView.h"
#import "Constants.h"
#import "RadioButton.h"

#define TAG_CONTAINER_VIEW 51

@implementation AdderessSelectionView
{
    NSString * strUserAdderess;
    NSString *selectedAdd;
    UITextView *addTextField;
}

- (id) initWithFrame:(CGRect)frame withUserAddress:(NSString *) userAdderess
{
    DebugLog(@"");
    self = [super initWithFrame:frame];
    if (self) {
        strUserAdderess = userAdderess;
        [self addBackgroundView];
        [self initialiseView];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardDidShow:)
                                                     name:UIKeyboardDidShowNotification
                                                   object:nil];
        
    }
    return self;
}

- (void) addBackgroundView
{
    DebugLog(@"");
    UIView *backgroundView = [[UIView alloc] initWithFrame:self.frame];
    backgroundView.backgroundColor = [UIColor blackColor];
    backgroundView.alpha = 0.4;
    backgroundView.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    [self addSubview:backgroundView];
}

- (void) initialiseView
{
    DebugLog(@"");
    
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 300)];
    containerView.backgroundColor = [UIColor whiteColor];
    containerView.tag = TAG_CONTAINER_VIEW;
    containerView.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    [self addSubview:containerView];
    
    [self addRadioButtonsOnContainerView:containerView];
    [self addAddressesOnContainerView:containerView];
    [self addSelectButtonOnContainerView:containerView];
    [self addTextfieldForNewAddressOnContainerView:containerView];
}
- (void) addTextfieldForNewAddressOnContainerView:(UIView *) containerView
{
    DebugLog(@"");
    addTextField = [[UITextView alloc] initWithFrame:CGRectMake(5, 175, 190, 70)];
    addTextField.text = @"Custom address";
    addTextField.editable = YES;
    addTextField.delegate = self;
    [containerView addSubview:addTextField];
    
}
- (void) addSelectButtonOnContainerView:(UIView *) containerView
{
    DebugLog(@"");
    UIButton *selectButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [selectButton addTarget:self
               action:@selector(onSelectButtonPresse)
     forControlEvents:UIControlEventTouchUpInside];
    [selectButton setTitle:@"Select" forState:UIControlStateNormal];
    [selectButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    selectButton.frame = CGRectMake(5, 260, 190, 35);
    selectButton.backgroundColor = [UIColor blackColor];
    [containerView addSubview:selectButton];
}

- (void) onSelectButtonPresse
{
    DebugLog(@"");
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    if ([selectedAdd isEqualToString:@"Custom address"]) {
        selectedAdd = addTextField.text;
    }
    [self.delegate onAddressSelected:selectedAdd];
    [self removeFromSuperview];
}

- (void) addAddressesOnContainerView:(UIView *) containerView
{
    DebugLog(@"");
    
    UILabel *serviceStationAdd = [[UILabel alloc] initWithFrame:CGRectMake(20, 40, 200, 30)];
    serviceStationAdd.text = @"Service Station";
    [containerView addSubview:serviceStationAdd];
    
    UILabel *myAddress = [[UILabel alloc] initWithFrame:CGRectMake(20, 110, 200, 30)];
    myAddress.text = strUserAdderess;
    [containerView addSubview:myAddress];
}
- (void) addRadioButtonsOnContainerView:(UIView *) containerView
{
    DebugLog(@"");
    NSMutableArray* buttons = [NSMutableArray arrayWithCapacity:3];
    CGRect btnRect = CGRectMake(5, 5, 200, 30);
    for (NSString* optionTitle in @[@"Service Station", @"My address", @"Add new address"]) {
        RadioButton* btn = [[RadioButton alloc] initWithFrame:btnRect];
        [btn addTarget:self action:@selector(onRadioButtonValueChanged:) forControlEvents:UIControlEventValueChanged];
        btnRect.origin.y += 70;
        [btn setTitle:optionTitle forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        btn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        [btn setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 6, 0, 0);
        [containerView addSubview:btn];
        [buttons addObject:btn];
    }
    
    [buttons[0] setGroupButtons:buttons]; // Setting buttons into the group
    
    [buttons[0] setSelected:YES]; // Making the first button initially selected
    selectedAdd = @"Service Station";
}

-(void) onRadioButtonValueChanged:(RadioButton*)sender
{
    // Lets handle ValueChanged event only for selected button, and ignore for deselected
    if(sender.selected) {
        NSLog(@"Selected color: %@", sender.titleLabel.text);
        if ([sender.titleLabel.text isEqualToString:@"Service Station"]) {
            selectedAdd = @"Service Station";
        }else if ([sender.titleLabel.text isEqualToString:@"My address"]) {
            selectedAdd = strUserAdderess;
        }else if ([sender.titleLabel.text isEqualToString:@"Add new address"]) {
            selectedAdd = addTextField.text;
        }
    }
}


- (void) keyboardDidShow:(NSNotification *)notification
{
    NSDictionary* info = [notification userInfo];
    CGRect kbRect = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    kbRect = [self convertRect:kbRect fromView:nil];
    
    UIView *containerView = (UIView *) [self viewWithTag:TAG_CONTAINER_VIEW];
    if (containerView != nil) {
        containerView.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height - kbRect.size.height - containerView.frame.size.height / 2);
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    DebugLog(@"");
    
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        UIView *containerView = (UIView *) [self viewWithTag:TAG_CONTAINER_VIEW];
        if (containerView != nil) {
            containerView.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
        }
        return NO;
    }
    
    return YES;
}

@end
