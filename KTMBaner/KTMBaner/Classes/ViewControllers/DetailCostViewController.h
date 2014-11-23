//
//  DetailCostViewController.h
//  KTMBaner
//
//  Created by Sagar Kudale on 11/23/14.
//  Copyright (c) 2014 Sagar Kudale. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServerController.h"

@interface DetailCostViewController : UIViewController<UITableViewDataSource, UITableViewDelegate,ServiceControlerDelegate>
@property (nonatomic, strong) NSString *vehicleID;
@end
