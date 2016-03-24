//
//  FansViewController.m
//  BoXiu
//
//  Created by andy on 14-5-12.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "FansViewController.h"
#import "EWPTabBar.h"
#import "FansRankModel.h"
#import "UserInfoManager.h"
#import "FansCell.h"

@interface FansViewController ()<BaseTableViewDataSoure,BaseTableViewDelegate,EWPTabBarDelegate,EWPTabBarDataSource>

@property (nonatomic,assign) NSInteger segmentedBtnIndex;
@property (nonatomic,strong) FansRankModel *fansRankModel;

@property (nonatomic,strong) NSArray *tabTitles;
@property (nonatomic,strong) NSMutableArray *thisFans;
@property (nonatomic,strong) NSMutableArray *superFans;

@property (nonatomic,strong) UIButton *roomFansBtn;
@property (nonatomic,strong) UIButton *starFansBtn;

@end

@implementation FansViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.baseViewType = kbaseTableViewType;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = FansRank_Title;
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"rankBg_5"]];
    
    CGFloat nYOffset = 12;
    _tabTitles = [NSArray arrayWithObjects:RoomFans_Title,StarFans_Tiltle, nil];
    EWPTabBar *tabBar = [[EWPTabBar alloc] initWithFrame:CGRectMake(10, nYOffset, SCREEN_WIDTH - 20, 24)];
    tabBar.tabSelectedBKColor = [UIColor colorWithWhite:1 alpha:0.3];
    tabBar.tabNormalBKColor = [UIColor clearColor];
    tabBar.normalTextColor = [CommonFuction colorFromHexRGB:@"ffffff"];
    tabBar.layer.cornerRadius = 4.0f;
    tabBar.layer.borderColor = [CommonFuction colorFromHexRGB:@"ffffff"].CGColor;
    tabBar.layer.borderWidth = 0.5f;
    tabBar.delegate = self;
    tabBar.dataSource = self;
    [self.view addSubview:tabBar];
    [tabBar reloadData];

    
    self.tableView.frame =  CGRectMake(0, nYOffset + 32, self.view.frame.size.width, self.view.frame.size.height - 24);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.baseDataSource = self;
    self.tableView.baseDelegate = self;
    self.loadMore = NO;
    self.refresh = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)valueChanged:(id)sender
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInteger:[UserInfoManager shareUserInfoManager].currentStarInfo.roomid] forKey:@"roomid"];
    if (self.segmentedBtnIndex == 0)
    {
        if (_thisFans && [_thisFans count])
        {
            [self.tableView reloadData];
            NSInteger nCount = self.thisFans.count;
            if (nCount  > 0)
            {
                self.tipLabel.hidden = YES;
            }
            else
            {
                self.tipLabel.hidden = NO;
            }
            return;
        }
        
        [dict setObject:[NSNumber numberWithInteger:[UserInfoManager shareUserInfoManager].currentStarInfo.userId] forKey:@"staruserid"];
        __weak typeof(self) weakSelf = self;
        [self requestDataWithAnalyseModel:[FansRankModel class] params:dict success:^(id object) {
            FansRankModel *model = (FansRankModel *)object;
            if (model.result == 0)
            {
                __strong typeof(self) strongSelf = weakSelf;
                if (_thisFans == nil)
                {
                    _thisFans = [NSMutableArray array];
                }
                [_thisFans removeAllObjects];
                
                FansRankModel *model = (FansRankModel *)object;
                [_thisFans addObjectsFromArray:model.fansUserMArray];
                [strongSelf.tableView reloadData];
                
                NSInteger nCount = self.thisFans.count;
                if (nCount  > 0)
                {
                    self.tipLabel.hidden = YES;
                }
                else
                {
                    self.tipLabel.hidden = NO;
                }
            }

        } fail:^(id object) {
            
        }];
    }
    else
    {
        _roomFansBtn.backgroundColor = [UIColor clearColor];
        _starFansBtn.backgroundColor = [UIColor colorWithWhite:1 alpha:0.3];
        if (_superFans && [_superFans count])
        {
            [self.tableView reloadData];
            NSInteger nCount = self.superFans.count;
            if (nCount >0)
            {
                self.tipLabel.hidden = YES;
            }
            else
            {
                self.tipLabel.hidden = NO;
            }
            return;
        }
        __weak typeof(self) weakSelf = self;
        [self requestDataWithAnalyseModel:[FansRankMonthModel class] params:dict success:^(id object) {
             FansRankMonthModel *model = (FansRankMonthModel *)object;
            if (model.result == 0)
            {
                __strong typeof(self) strongSelf = weakSelf;
                if (_superFans == nil)
                {
                    _superFans = [NSMutableArray array];
                }
                [_superFans removeAllObjects];
                
                [_superFans addObjectsFromArray:model.fansUserMArray];
                [strongSelf.tableView reloadData];
                NSInteger nCount = self.superFans.count;
                if (nCount > 0)
                {
                    self.tipLabel.hidden = YES;
                }
                else
                {
                    self.tipLabel.hidden = NO;
                }
            }
           
        } fail:^(id object) {
            
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
    if (self.segmentedBtnIndex == 0)
    {
        nCount = self.thisFans.count;
    }
    else
    {
        nCount = self.superFans.count;
    }
    return nCount;
}

- (UITableViewCell *)baseTableView:(BaseTableView *)baseTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *generaCellIdentifier =  @"FansCellIdentifier";
    FansCell *cell = [baseTableView dequeueReusableCellWithIdentifier:generaCellIdentifier];
    if (cell == nil)
    {
        cell = [[FansCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:generaCellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    UserInfo *userInfo = nil;
    if (self.segmentedBtnIndex == 0)
    {
        userInfo = [self.thisFans objectAtIndex:indexPath.row];
    }
    else
    {
        userInfo = [self.superFans objectAtIndex:indexPath.row];
    }
    cell.isThis = self.segmentedBtnIndex == 0? YES : NO;
    cell.userInfo = userInfo;
    cell.rankIndex = indexPath.row;
    return cell;
    
}

#pragma mark - UITableViewDelegate

- (CGFloat)baseTableView:(BaseTableView *)baseTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [FansCell height];
    
}

- (void)baseTableView:(BaseTableView *)baseTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}


#pragma mark - EWPTabBarDataSource

- (NSInteger)numberOfItems
{
    return [_tabTitles count];
}

- (CGFloat)widthOfItem:(NSInteger)index
{
    return 150;
}

- (CGFloat)heightOfItem
{
    return 24.0f;
}

- (NSString *)titleOfItem:(NSInteger)index
{
    return [self.tabTitles objectAtIndex:index];
}

- (NSInteger)tagOfItem:(NSInteger)index
{
    return index;
}

#pragma mark - EWPTabBarDelegate

- (void)tabBar:(EWPTabBar *)tabBar didSelectItemWithTag:(NSInteger)itemTag
{
    self.segmentedBtnIndex = itemTag;
    
    [self valueChanged:tabBar];
}

@end
