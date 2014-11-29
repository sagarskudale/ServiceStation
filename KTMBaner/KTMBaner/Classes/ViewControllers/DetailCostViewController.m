//
//  DetailCostViewController.m
//  KTMBaner
//
//  Created by Sagar Kudale on 11/23/14.
//  Copyright (c) 2014 Sagar Kudale. All rights reserved.
//

#import "DetailCostViewController.h"
#import "Constants.h"
#import "CostTableViewCell.h"
#import "ArchiveManager.h"
#import "PartCostDetails.h"
#import "AllUserData.h"

@interface DetailCostViewController () {
    NSArray *partsInfo;
}
@property (weak, nonatomic) IBOutlet UITableView *costTabelView;

@end

@implementation DetailCostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setStatusBarHidden];
    AllUserData *userData = [ArchiveManager getUserData];
    NSMutableDictionary *partsInfoDic = [[userData allPartsInfo] mutableCopy];
    if (partsInfoDic != nil) {
        partsInfo = [partsInfoDic objectForKey:self.vehicleID];
        if (partsInfo != nil) {
            [self.costTabelView reloadData];
        }
        
    }
    
    
    if ([self.vehicleID isEqualToString:@"All Parts"]) {
        [[ServerController sharedInstance] sendGETServiceRequestForService:SERVER_GET_ALL_PARTS withData:nil withDelegate:self];
    }else{
        NSMutableDictionary *dataDic = [[NSMutableDictionary alloc] initWithCapacity:1];
        [dataDic setObject:self.vehicleID forKey:@"vehicleId"];
         [[ServerController sharedInstance] sendGETServiceRequestForService:SERVER_GET_PARTS_VEHICLE withData:dataDic withDelegate:self];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) saveAndLoadData:(NSArray *) data
{
    DebugLog(@"");
    
    NSMutableArray *allPartsInfo = [[NSMutableArray alloc] initWithCapacity:1];
    
    for (NSDictionary *partInfo in data) {
        PartCostDetails *partDetail = [[PartCostDetails alloc] initWithPartCostDetailsDict:partInfo];
        
        [allPartsInfo addObject:partDetail];
    }
    partsInfo = allPartsInfo;
    
    [self.costTabelView reloadData];
    
    AllUserData *userData = [ArchiveManager getUserData];
    NSMutableDictionary *partsInfoDic = [[userData allPartsInfo] mutableCopy];
    if (partsInfoDic == nil) {
        partsInfoDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    }
    
    [partsInfoDic setObject:partsInfo forKey:self.vehicleID];
    userData.allPartsInfo = partsInfoDic;
    
    [ArchiveManager storeDataToFile:userData];
}
#pragma mark-
#pragma mark- Server controller delegate
#pragma mark-
- (void)onDataFetchComplete:(NSDictionary *)dicData
{
    DebugLog(@"");
    if ([[[dicData objectForKey:@"Response"] objectForKey:@"Status"] isEqualToString:@"success"]) {
        [self saveAndLoadData:[[dicData objectForKey:@"Data"] objectForKey:@"Records"]];
    }
}

#pragma mark-
#pragma mark- Data Source
#pragma mark-
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    DebugLog(@"");
    return [partsInfo count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DebugLog(@"");
    
    CostTableViewCell *cell = [self.costTabelView dequeueReusableCellWithIdentifier:@"CostTableViewCell"];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CostTableViewCell"];
    }
    
    PartCostDetails *details = [partsInfo objectAtIndex:indexPath.row];
    
    cell.titleLabel.text = details.name;
    cell.discriptionLabel.text = [NSString stringWithFormat:@"Part Code: %@",details.code];
    cell.priceLabel.text = [NSString stringWithFormat:@"Price: %dRs",(int)details.price];
    
    return cell;
}
- (IBAction)actionBackButton:(id)sender {
    DebugLog(@"");
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark-
#pragma mark- Status Bar
#pragma mark-

- (void) setStatusBarHidden
{
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        // iOS 7
        [self prefersStatusBarHidden];
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    } else {
        // iOS 6
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    }
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}
@end
