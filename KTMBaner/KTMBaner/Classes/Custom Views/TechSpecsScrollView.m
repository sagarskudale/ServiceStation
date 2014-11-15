//
//  TechSpecsScrollView.m
//  KTMBaner
//
//  Created by Sagar Kudale on 11/15/14.
//  Copyright (c) 2014 Sagar Kudale. All rights reserved.
//

#import "TechSpecsScrollView.h"
#import "Constants.h"

@implementation TechSpecsScrollView
{
    UITableView *techSpecsTableView;
}

- (id) initDictData: (NSDictionary *) data
{
    self = [super init];
    if (self) {
        [self initiaizeScrollViewWithData:data];
    }
    return self;
}

- (void) initiaizeScrollViewWithData: (NSDictionary *) data
{
    DebugLog(@"");
    NSArray *chasisArray = [data objectForKey:KEY_CHASIS_DATA_ARRAY];
    NSArray *engineArray = [data objectForKey:KEY_ENGINE_DATA_ARRAY];
    DebugLog(@"chasis aray: %@",chasisArray);
    DebugLog(@"engine aray: %@",engineArray);
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300, 50)];
    imgView.backgroundColor = [UIColor blackColor];
    [self addSubview:imgView];
    
    self.frame = CGRectMake(0, 0, imgView.frame.size.width, imgView.frame.size.height);
    self.center = self.center;
}

- (UITableView *) addTechSpecsTableView
{
    DebugLog(@"");
    CGRect fr = CGRectMake(101, 45, 100, 416);
    
    UITableView *tabrleView = [[UITableView alloc] initWithFrame:fr
                                                           style:UITableViewStylePlain];
    
    tabrleView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    tabrleView.delegate = self;
    tabrleView.dataSource = self;
    [tabrleView reloadData];
    
    return tabrleView;
}

@end
