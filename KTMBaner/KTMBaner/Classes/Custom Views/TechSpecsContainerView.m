//
//  TechSpecsContainerView.m
//  KTMBaner
//
//  Created by Sagar Kudale on 11/15/14.
//  Copyright (c) 2014 Sagar Kudale. All rights reserved.
//

#import "TechSpecsContainerView.h"
#import "Constants.h"
#import "CollapsableTableView.h"

#define HIEGHT_FOR_HEADER 40

@implementation TechSpecsContainerView
{
    CollapsableTableView *collapseTableView;
    NSArray *chasisDataArray;
    NSArray *engineDataArray;
    int noOfRowsInChasis;
    int noOfRowsEngine;
    BOOL isChasisCollapsed;
    BOOL isEngingeCollapsed;
}

- (id)initWithDictData: (NSDictionary *) dictData
{
    DebugLog(@"");
    self = [super init];
    if (self) {
        chasisDataArray = (NSArray *)[dictData objectForKey:KEY_CHASIS_DATA_ARRAY];
        noOfRowsInChasis = chasisDataArray.count;
        engineDataArray = (NSArray *)[dictData objectForKey:KEY_ENGINE_DATA_ARRAY];
        noOfRowsEngine = engineDataArray.count;
        [self initializeViewWithData:dictData];
    }
    return self;
}

#pragma mark-
#pragma mark- Private Methods
#pragma mark-

- (void) initializeViewWithData: (NSDictionary *) dictData
{
    DebugLog(@"");
    [self setFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width,
                                  [[UIScreen mainScreen]bounds].size.height)];
    
    UIView *bkgView = [[UIView alloc] initWithFrame:self.frame];
    bkgView.backgroundColor = [UIColor whiteColor];
    bkgView.alpha = 0.75;
    [self addSubview:bkgView];
    
    collapseTableView = [[CollapsableTableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width - 30, HIEGHT_FOR_HEADER * 2)];
    [self addSubview:collapseTableView];
    collapseTableView.center = self.center;
    collapseTableView.delegate = self;
    collapseTableView.dataSource = self;
//    collapseTableView.sectionsInitiallyCollapsed = YES;
    [collapseTableView setIsCollapsed:YES forHeaderWithTitle:@"Chasis"];
    [collapseTableView setIsCollapsed:YES forHeaderWithTitle:@"Engine"];
    collapseTableView.collapsableTableViewDelegate = self;
    isChasisCollapsed = YES;
    isEngingeCollapsed = YES;
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}


- (NSString*) titleForHeaderForSection:(int) section
{
    switch (section)
    {
        case 0 : return @"Chasis";
        case 1 : return @"Engine";
        default : return [NSString stringWithFormat:@"Section no. %i",section + 1];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    UITableViewHeaderFooterView *v = (UITableViewHeaderFooterView *)view;
    v.backgroundColor = [UIColor blackColor];
    
//    UILabel *tempLabel=[[UILabel alloc]initWithFrame:CGRectMake(15,0,300,44)];
//    tempLabel.backgroundColor=[UIColor clearColor];
//    tempLabel.textColor = [UIColor whiteColor]; //here you can change the text color of header.
//    tempLabel.text=@"Header Text";
//    
//    [v addSubview:tempLabel];
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self titleForHeaderForSection:(int)section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return HIEGHT_FOR_HEADER;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section)
    {
        case 0 : return noOfRowsInChasis;
        case 1 : return noOfRowsEngine;
        default : return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell.
    NSArray *dataArray;
    if(indexPath.section == 0){
        dataArray = chasisDataArray;
    }else if(indexPath.section == 1){
        dataArray = engineDataArray;
    }
    NSString *cellHeader = [[dataArray objectAtIndex:indexPath.row] objectForKey:@"Name"];
    NSString *cellDetails = [[dataArray objectAtIndex:indexPath.row] objectForKey:@"Value"];
    cell.textLabel.text = cellHeader;
    cell.detailTextLabel.text = cellDetails;
    return cell;
}


#pragma mark -
#pragma mark CollapsableTableViewDelegate

- (void) collapsableTableView:(CollapsableTableView*) tableView willCollapseSection:(NSInteger) section title:(NSString*) sectionTitle headerView:(UIView*) headerView
{
    if([sectionTitle isEqualToString:@"Chasis"]){
        if(isEngingeCollapsed){
            collapseTableView.frame = CGRectMake(0, 0, collapseTableView.frame.size.width, HIEGHT_FOR_HEADER * 2);
        }
        isChasisCollapsed = YES;
        collapseTableView.center = self.center;
    }else if([sectionTitle isEqualToString:@"Engine"]){
        if(isChasisCollapsed){
            collapseTableView.frame = CGRectMake(0, 0, collapseTableView.frame.size.width, HIEGHT_FOR_HEADER * 2);
        }
        isEngingeCollapsed = YES;
        collapseTableView.center = self.center;
    }
}

- (void) collapsableTableView:(CollapsableTableView*) tableView didCollapseSection:(NSInteger) section title:(NSString*) sectionTitle headerView:(UIView*) headerView
{
}

- (void) collapsableTableView:(CollapsableTableView*) tableView willExpandSection:(NSInteger) section title:(NSString*) sectionTitle headerView:(UIView*) headerView
{
    if([sectionTitle isEqualToString:@"Chasis"]){
        isChasisCollapsed = NO;
        collapseTableView.frame = CGRectMake(0, 0, collapseTableView.frame.size.width, self.frame.size.height);
        collapseTableView.center = self.center;
    }else if([sectionTitle isEqualToString:@"Engine"]){
        isEngingeCollapsed = NO;
        collapseTableView.frame = CGRectMake(0, 0, collapseTableView.frame.size.width, self.frame.size.height);
        collapseTableView.center = self.center;
    }
}

- (void) collapsableTableView:(CollapsableTableView*) tableView didExpandSection:(NSInteger) section title:(NSString*) sectionTitle headerView:(UIView*) headerView
{
}

@end
