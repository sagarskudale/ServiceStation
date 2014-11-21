//
//  AdderessSelectionView.m
//  KTMBaner
//
//  Created by Sagar Kudale on 11/21/14.
//  Copyright (c) 2014 Sagar Kudale. All rights reserved.
//

#import "AdderessSelectionView.h"
#import "Constants.h"

@implementation AdderessSelectionView
{
    NSString * strUserAdderess;
}

- (id) initWithFrame:(CGRect)frame withUserAddress:(NSString *) userAdderess
{
    DebugLog(@"");
    self = [super initWithFrame:frame];
    if (self) {
        strUserAdderess = userAdderess;
    }
    return self;
}



@end
