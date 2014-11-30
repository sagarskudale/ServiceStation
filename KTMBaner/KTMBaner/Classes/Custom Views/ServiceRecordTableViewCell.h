//
//  ServiceRecordTableViewCell.h
//  KTMBaner
//
//  Created by Sagar Kudale on 11/30/14.
//  Copyright (c) 2014 Sagar Kudale. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ServiceRecordTableViewCell : UITableViewCell
@property (nonatomic, strong) IBOutlet UILabel *bikeNumber;
@property (nonatomic, strong) IBOutlet UILabel *kms;
@property (nonatomic, strong) IBOutlet UILabel *date;
@end
