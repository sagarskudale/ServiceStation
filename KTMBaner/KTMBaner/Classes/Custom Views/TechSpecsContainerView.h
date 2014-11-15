//
//  TechSpecsContainerView.h
//  KTMBaner
//
//  Created by Sagar Kudale on 11/15/14.
//  Copyright (c) 2014 Sagar Kudale. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollapsableTableViewDelegate.h"

#define KEY_CHASIS_DATA_ARRAY @"ChasisDataArray"
#define KEY_ENGINE_DATA_ARRAY @"EngineDataArray"

@interface TechSpecsContainerView : UIView<UITableViewDataSource,UITableViewDelegate,CollapsableTableViewDelegate>
{
    UITableView * tableView;
}

- (id)initWithDictData: (NSDictionary *) dictData;

@end
