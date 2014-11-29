//
//  BikeTableViewCell.h
//  KTMBaner
//
//  Created by Sagar Kudale on 11/29/14.
//  Copyright (c) 2014 Sagar Kudale. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BikeTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *bikeNumber;
@property (weak, nonatomic) IBOutlet UILabel *bikeName;
@property (weak, nonatomic) IBOutlet UIView *bikeImageView;
@end
