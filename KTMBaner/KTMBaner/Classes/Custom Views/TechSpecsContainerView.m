//
//  TechSpecsContainerView.m
//  KTMBaner
//
//  Created by Sagar Kudale on 11/15/14.
//  Copyright (c) 2014 Sagar Kudale. All rights reserved.
//

#import "TechSpecsContainerView.h"
#import "Constants.h"


@implementation TechSpecsContainerView
{
    UITableView *techSpecsTableView;
    BOOL shouldShowChasisData;
}

- (id)initWithFrame:(CGRect)frame withDictData: (NSDictionary *) dictData
{
    DebugLog(@"");
    self = [super initWithFrame:frame];
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
    self.backgroundColor = [UIColor redColor];
    shouldShowChasisData = NO;
    
//    scrollView = [[TechSpecsScrollView alloc] initDictData:dictData];
//    scrollView.backgroundColor = [UIColor greenColor];
//    scrollView.center = self.center;
//    [self addSubview:scrollView];

//    [self addTechSpecsTableView];
}

- (void) addTechSpecsTableView
{
    DebugLog(@"");
    CGRect fr = CGRectMake(101, 45, 300, 416);
    
    techSpecsTableView = [[UITableView alloc] initWithFrame:fr
                                                           style:UITableViewStylePlain];
    
    techSpecsTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    techSpecsTableView.delegate = self;
    techSpecsTableView.dataSource = self;
    techSpecsTableView.center = self.center;
    [techSpecsTableView reloadData];
    
    [self addSubview:techSpecsTableView];
}

#pragma mark-
#pragma mark- Touch Handlers
#pragma mark-

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    DebugLog(@"");
    [self removeFromSuperview];
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    DebugLog(@"");
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    DebugLog(@"");
}

- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    DebugLog(@"");
    [self touchesEnded:touches withEvent:event];
}

#pragma mark-
#pragma mark- Tabel View Delegates
#pragma mark-

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    DebugLog(@"");
//    if(shouldShowChasisData){
//        return 10;
//    }
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DebugLog(@"");
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    [[[cell contentView] subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];

    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height / 2)];
    headerLabel.text = [NSString stringWithFormat:@"Cell Header: %d",(int)indexPath.row];
    [cell.contentView addSubview:headerLabel];
    
//    [cell.contentView addSubview:[self getSubViewForRowAtIndex:indexPath.row withFrame:cell.frame]];
    
    return cell;
}

- (UIView *) getSubViewForRowAtIndex: (NSInteger) rowIndex withFrame: (CGRect) frame
{
    DebugLog(@"");
    UIView *subViewForRow = [[UIView alloc] initWithFrame:frame];
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, subViewForRow.frame.size.width, subViewForRow.frame.size.height / 2)];
    headerLabel.text = [NSString stringWithFormat:@"Cell Header: %d",(int)rowIndex];
    [subViewForRow addSubview:headerLabel];
    
    if(rowIndex == 0){
        subViewForRow.backgroundColor = [UIColor blackColor];
        headerLabel.text = @"Chasis";

        headerLabel.textColor = [UIColor whiteColor];
    }
    if(shouldShowChasisData){
        if(rowIndex == 10){
            subViewForRow.backgroundColor = [UIColor blackColor];
            headerLabel.text = @"Engine";
            headerLabel.textColor = [UIColor whiteColor];
        }
    }else{
        if(rowIndex == 1){
            subViewForRow.backgroundColor = [UIColor blackColor];
            headerLabel.text = @"Engine";
            headerLabel.textColor = [UIColor whiteColor];
        }
    }
    
    return subViewForRow;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DebugLog(@"");
//    if(indexPath.row == 0 && shouldShowChasisData){
//        shouldShowChasisData = NO;
//    }else if(indexPath.row == 0 && !shouldShowChasisData){
//        shouldShowChasisData = YES;
//    }
//    [techSpecsTableView reloadData];
}




@end
