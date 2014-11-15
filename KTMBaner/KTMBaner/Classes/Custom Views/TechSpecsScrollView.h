//
//  TechSpecsScrollView.h
//  KTMBaner
//
//  Created by Sagar Kudale on 11/15/14.
//  Copyright (c) 2014 Sagar Kudale. All rights reserved.
//

#import <UIKit/UIKit.h>


#define KEY_CHASIS_DATA_ARRAY @"ChasisDataArray"
#define KEY_ENGINE_DATA_ARRAY @"EngineDataArray"

@interface TechSpecsScrollView : UIScrollView

- (id) initDictData: (NSDictionary *) data;

@end
