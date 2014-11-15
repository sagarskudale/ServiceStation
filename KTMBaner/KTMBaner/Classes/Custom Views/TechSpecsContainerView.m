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


@implementation TechSpecsContainerView
{
    
}

- (id)initWithDictData: (NSDictionary *) dictData
{
    DebugLog(@"");
    self = [super init];
    if (self) {
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
    
    CollapsableTableView *collapseTableView = [[CollapsableTableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width - 30, self.frame.size.height)];
    [self addSubview:collapseTableView];
    collapseTableView.center = self.center;
    collapseTableView.delegate = self;
    collapseTableView.dataSource = self;
    collapseTableView.collapsableTableViewDelegate = self;
    
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 10;
}


- (NSString*) titleForHeaderForSection:(int) section
{
    switch (section)
    {
        case 0 : return @"First Section";
        case 1 : return @"Second Section";
        case 2 : return @"Third Section";
        case 3 : return @"Fourth Section";
        case 4 : return @"Fifth Section";
        default : return [NSString stringWithFormat:@"Section no. %i",section + 1];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self titleForHeaderForSection:(int)section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

// Uncomment the following two methods to use custom header views.
//- (UILabel *) createHeaderLabel: (UITableView *) tableView :(NSString *)headerTitle {
//    UILabel *titleLabel = [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
//    titleLabel.frame =CGRectMake(0, 0, tableView.frame.size.width - 20, 60);
//    titleLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
//    titleLabel.backgroundColor = [UIColor clearColor];
//    titleLabel.textColor = [UIColor whiteColor];
//    titleLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:20];
//    titleLabel.text = headerTitle;
//    titleLabel.textAlignment = UITextAlignmentRight;
//    return titleLabel;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    // create the parent view that will hold header Label
//    UIView * customView = [[[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, tableView.frame.size.width , 60)]autorelease];
//    UILabel *titleLabel;
//    titleLabel = [self createHeaderLabel: tableView :[CollapsableTableViewViewController titleForHeaderForSection:section]];
//
//    [customView addSubview:titleLabel];
//
//    UILabel* collapsedLabel = [[[UILabel alloc] initWithFrame:CGRectMake(10,0,50,60)] autorelease];
//    collapsedLabel.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
//    collapsedLabel.backgroundColor = [UIColor clearColor];
//    collapsedLabel.textColor = [UIColor whiteColor];
//    collapsedLabel.text = @"-";
//    collapsedLabel.tag = COLLAPSED_INDICATOR_LABEL_TAG;
//    [customView addSubview:collapsedLabel];
//
//    customView.tag = section;
//    customView.backgroundColor = [UIColor blackColor];
//    return customView;
//}

//- (NSString*) tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
//{
//    return [NSString stringWithFormat:@"Footer %i",section + 1];
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section)
    {
        case 2 : return 0;
        case 3 : return 30;
        default : return 8;
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
    
    switch (indexPath.row)
    {
        case 0 : cell.textLabel.text = @"First Cell"; break;
        case 1 : cell.textLabel.text = @"Second Cell"; break;
        case 2 : cell.textLabel.text = @"Third Cell"; break;
        case 3 : cell.textLabel.text = @"Fourth Cell"; break;
        case 4 : cell.textLabel.text = @"Fifth Cell"; break;
        case 5 : cell.textLabel.text = @"Sixth Cell"; break;
        case 6 : cell.textLabel.text = @"Seventh Cell"; break;
        case 7 : cell.textLabel.text = @"Eighth Cell"; break;
        default : cell.textLabel.text = [NSString stringWithFormat:@"Cell %i",indexPath.row + 1];
    }
    
    //cell.detailTextLabel.text = ...;
    
    return cell;
}


#pragma mark -
#pragma mark CollapsableTableViewDelegate

- (void) collapsableTableView:(CollapsableTableView*) tableView willCollapseSection:(NSInteger) section title:(NSString*) sectionTitle headerView:(UIView*) headerView
{
}

- (void) collapsableTableView:(CollapsableTableView*) tableView didCollapseSection:(NSInteger) section title:(NSString*) sectionTitle headerView:(UIView*) headerView
{
}

- (void) collapsableTableView:(CollapsableTableView*) tableView willExpandSection:(NSInteger) section title:(NSString*) sectionTitle headerView:(UIView*) headerView
{
}

- (void) collapsableTableView:(CollapsableTableView*) tableView didExpandSection:(NSInteger) section title:(NSString*) sectionTitle headerView:(UIView*) headerView
{
}

@end
