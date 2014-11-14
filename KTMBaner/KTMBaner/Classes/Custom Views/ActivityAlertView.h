//
//  ActivityAlertView.h
//  iOS_OUTDemo
//
//  Created by Sagar Kudale on 05/02/14.
//  Copyright (c) 2014 CUELogic. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 * This is custome view for showing alert view with loading activity
 */

@interface ActivityAlertView : UIAlertView

-(void)close;

/*
 * starts activaty indicator animation
 */
-(void)statAnimation;
-(void)showActivityIndicator;

/*
 * Remove the alert
 */
-(void)hideActivityIndicator;


@end
