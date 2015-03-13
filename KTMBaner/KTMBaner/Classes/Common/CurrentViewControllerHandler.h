//
//  CurrentViewControllerHandler.h
//  KTMBaner
//
//  Created by Sagar Kudale on 3/13/15.
//  Copyright (c) 2015 Sagar Kudale. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface CurrentViewControllerHandler : NSObject

@property (nonatomic, strong) UIViewController * currentViewController;

+(CurrentViewControllerHandler *)sharedInstance;

@end
