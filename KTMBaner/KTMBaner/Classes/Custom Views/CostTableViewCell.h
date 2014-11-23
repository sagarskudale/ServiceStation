//
//  CostTableViewCell.h
//  KTMBaner
//
//  Created by Sagar Kudale on 11/23/14.
//  Copyright (c) 2014 Sagar Kudale. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CostTableViewCell : UITableViewCell
@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UILabel *discriptionLabel;
@property (nonatomic, strong) IBOutlet UILabel *priceLabel;
@end
