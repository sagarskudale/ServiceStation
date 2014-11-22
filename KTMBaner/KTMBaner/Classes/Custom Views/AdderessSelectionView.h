//
//  AdderessSelectionView.h
//  KTMBaner
//
//  Created by Sagar Kudale on 11/21/14.
//  Copyright (c) 2014 Sagar Kudale. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddressSelectionViewDelegate <NSObject>

- (void) onAddressSelected:(NSString *) selectedAdd;

@end

@interface AdderessSelectionView : UIView<UITextViewDelegate>

@property (nonatomic, unsafe_unretained) id <AddressSelectionViewDelegate> delegate;

- (id) initWithFrame:(CGRect)frame withUserAddress:(NSString *) userAdderess;
@end
