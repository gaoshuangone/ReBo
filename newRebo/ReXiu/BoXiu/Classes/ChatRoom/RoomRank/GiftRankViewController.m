//
//  GiftRankViewController.m
//  BoXiu
//
//  Created by andy on 14-5-12.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "GiftRankViewController.h"
#import "GiftRankCell.h"
#import "GiftRankModel.h"
#import "UserInfoManager.h"
#import "EWPTabBar.h"
#import "SpecialRankModel.h"
#import "GrabStarRankCell.h"

@interface GiftRankViewController ()<BaseTableViewDataSoure,BaseTableViewDelegate,EWPTabBarDelegate,EWPTabBarDataSource>
@property (nonatomic,strong) GiftRankModel *giftRankModel;
@property (nonatomic,strong) EWPTabBar *tabMenuBar;
@property (nonatomic,strong) NSArray *tabMenuTitles;
@property (nonatomic,strong) NSMutableArray *robStarMArray;
@property (nonatomic,strong) NSMutableArray *thisWeekMArray;

@end

@implementation GiftRankViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.baseViewType = kbaseTableViewType;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = GiftRank_TItle;
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"rankBg_5"]];
    
    _tabMenuTitles = @[@"Star抢星",@"本周排行"];
    _tabMenuBar = [[EWPTabBar alloc] initWithFrame:CGRectMake(10, 20, self.view.bounds.size.width - 20, 30)];
    _tabMenuBar.tabSelectedBKColor = [UIColor colorWithWhite:1 alpha:0.3];
    _tabMenuBar.tabNormalBKColor = [UIColor clearColor];
    _tabMenuBar.normalTextColor = [CommonFuction colorFromHexRGB:@"ffffff"];
    _tabMenuBar.layer.cornerRadius = 2.0f;
    _tabMenuBar.layer.borderColor = [CommonFuction colorFromHexRGB:@"ffffff"].CGColor;
    _tabMenuBar.layer.borderWidth = 1.0f;
    _tabMenuBar.delegate = self;
    _tabMenuBar.dataSource = self;
    [self.view addSubview:_tabMenuBar];
    [_tabMenuBar reloadData];
    
    self.tableView.frame = CGRectMake(0, 70, self.view.frame.size.width, self.view.frame.size.height - 70 - 45);
    self.tableView.baseDelegate = self;
    self.tableView.baseDataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.loadMore = NO;
    self.refresh = NO;
}

#pragma mark - EWPTabBarDataSource

- (NSInteger)numberOfItems
{
    return 2;
}

- (CGFloat)widthOfItem:(NSInteger)index
{
    return 150;
}

- (CGFloat)heightOfItem
{
    return 30.0f;
}

- (NSString *)titleOfItem:(NSInteger)index
{
    if (_tabMenuTitles && _tabMenuTitles.count)
    {
        return [_tabMenuTitles objectAtIndex:index];
    }
    return nil;
}

- (NSInteger)tagOfItem:(NSInteger)index
{
    return index;
}

#pragma mark - EWPTabBarDelegate

- (void)tabBar:(EWPTabBar *)tabBar didSelectItemWithTag:(NSInteger)itemTag
{
    if (tabBar.selectedIndex == 0)
    {
        if (_robStarMArray && _robStarMArray.count)
        {
            self.tipLabel.hidden = YES;
            [self.tableView reloadData];
        }
        else
        {
            [self refreshData];
        }
    }
    else
    {
        if (_thisWeekMArray && _thisWeekMArray.count)
        {
            self.tipLabel.hidden = YES;
            [self.tableView reloadData];
        }
        else
        {
            [self refreshData];
        }
    }
}


- (void)valueChanged:(id)sender
{
    if (_tabMenuBar.selectedIndex == 0)
    {
        if (_robStarMArray && _robStarMArray.count)
        {
            self.tipLabel.hidden = YES;
            [self.tableView reloadData];
        }
        else
        {
            [self refreshData];
        }
    }
    else
    {
        if (_thisWeekMArray && _thisWeekMArray.count)
        {
            self.tipLabel.hidden = YES;
            [self.tableView reloadData];
        }
        else
        {
            [self refreshData];
        }
    }
}

- (void)refreshData
{
    self.tipLabel.hidden = YES;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    __weak typeof(self) weakSelf = self;
    if (_tabMenuBar.selectedIndex == 0)
    {
        [dict setObject:[NSNumber numberWithInt:[UserInfoManager shareUserInfoManager].currentStarInfo.userId] forKey:@"staruserid"];
        [self requestDataWithAnalyseModel:[GiftRankModel class] params:dict success:^(id object)
         {
             __strong typeof(self) strongSelf = weakSelf;
             GiftRankModel *model  = (GiftRankModel *)object;
             if (model.result == 0)
             {
                 if (_robStarMArray == nil)
                 {
                     _robStarMArray = [NSMutableArray array];
                 }
                 [_robStarMArray removeAllObjects];
                 [_robStarMArray addObjectsFromArray:model.starUserMArray];
                 [strongSelf.tableView reloadData];
                 
                 if (_robStarMArray.count)
                 {
                     strongSelf.tipLabel.hidden = YES;
                 }
                 else
                 {
                     strongSelf.tipLabel.hidden = NO;
                 }
                 
             }
         }
        fail:^(id object)
         {
             __strong typeof(self) strongSelf = weakSelf;
             /*失败返回数据*/
             [strongSelf.tableView reloadData];
         }];
    }
    else
    {
        [dict setObject:[NSNumber numberWithInt:1] forKey:@"type"];
        [self requestDataWithAnalyseModel:[SpecialRankModel class] params:dict success:^(id object)
         {
             __strong typeof(self) strongSelf = weakSelf;
             /*成功返回数据*/
             SpecialRankModel *model = (SpecialRankModel *)object;
             if (model.result == 0)
             {
                 if (_thisWeekMArray == nil)
                 {
                     _thisWeekMArray = [NSMutableArray array];
                 }
                 [_thisWeekMArray removeAllObjects];
                 [_thisWeekMArray addObjectsFromArray:model.starUserMArray];
                 [self.tableView reloadData];
                 if (_thisWeekMArray.count)
                 {
                     strongSelf.tipLabel.hidden = YES;
                 }
                 else
                 {
                     strongSelf.tipLabel.hidden = NO;
                 }
             }
         }
        fail:^(id object)
         {
             /*失败返回数据*/
              __strong typeof(self) strongSelf = weakSelf;
             [strongSelf.tableView reloadData];
         }];
    }
 }

#pragma mark - UITalbeViewDataSurce


- (NSInteger)numberOfSectionsInBaseTableView:(BaseTableView *)baseTableView
{
    return 1;
}

- (NSInteger)baseTableView:(BaseTableView *)baseTableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger nCount = 0;
    if (self.tabMenuBar.selectedIndex == 0)
    {
        nCount = [self.robStarMArray count];
    }
    else
    {
        nCount = [self.thisWeekMArray count];
    }
    return nCount;
}

- (UITableViewCell *)baseTableView:(BaseTableView *)baseTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (self.tabMenuBar.selectedIndex == 0)
    {
        static NSString *giftRankCellIdentifier =  @"giftRankCellIdentifier";
        GiftRankCell *giftRankCell = [baseTableView dequeueReusableCellWithIdentifier:giftRankCellIdentifier];
        if (giftRankCell == nil)
        {
            giftRankCell = [[GiftRankCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:giftRankCellIdentifier];
            giftRankCell.backgroundColor = [UIColor clearColor];
            giftRankCell.accessoryType = UITableViewCellAccessoryNone;
            giftRankCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        StarGift * starGift = [self.robStarMArray objectAtIndex:indexPath.row];
        giftRankCell.starGift = starGift;
        cell = giftRankCell;
    }
    else
    {
        static NSString *grabStarRankCellIdentifier =  @"GrabStarRankCell";
        GrabStarRankCell *grabStarRankCell = [baseTableView dequeueReusableCellWithIdentifier:grabStarRankCellIdentifier];
        if (grabStarRankCell == nil)
        {
            grabStarRankCell = [[GrabStarRankCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:grabStarRankCellIdentifier];
            grabStarRankCell.backgroundColor = [UIColor clearColor];
            grabStarRankCell.accessoryType = UITableViewCellAccessoryNone;
            grabStarRankCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        StarGift *starGift=nil;
        if(self.tabMenuBar.selectedIndex == 0)
        {
            starGift = [self.thisWeekMArray objectAtIndex:indexPath.row];
        }
        else
        {
            starGift = [self.thisWeekMArray objectAtIndex:indexPath.row];
        }
        
        grabStarRankCell.starGift = starGift;
        grabStarRankCell.rankIndex = indexPath.row;
        cell = grabStarRankCell;
    }
    return cell;

}


#pragma mark - UITableViewDelegate

- (CGFloat)baseTableView:(BaseTableView *)baseTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0;
    if (self.tabMenuBar.selectedIndex == 0)
    {
        height = [GiftRankCell height];
    }
    else
    {
        height = [GrabStarRankCell height];
    }
    return height;
    
}

@end
