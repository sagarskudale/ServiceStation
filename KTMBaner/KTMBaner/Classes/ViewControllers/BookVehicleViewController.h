//
//  BookVehicleViewController.h
//  KTMBaner
//
//  Created by Sagar Kudale on 11/18/14.
//  Copyright (c) 2014 Sagar Kudale. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServerController.h"
#import "AdderessSelectionView.h"
#import "Constants.h"

@interface BookVehicleViewController : UIViewController<ServiceControlerDelegate, AddressSelectionViewDelegate,UIAlertViewDelegate>

@property (nonatomic, strong) NSString * vehicleID;
@property (nonatomic, strong) NSString * userID;
@property (nonatomic, strong) NSString * bikeName;
@property (nonatomic, strong) NSString * userAddress;
@property (nonatomic, assign) ScreenType screenType;

@end
