//
//  RoomFansViewController.m
//  BoXiu
//
//  Created by andy on 15/5/22.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import "RoomFansViewController.h"
#import "FansRankModel.h"
#import "FansCell.h"

@interface RoomFansViewController ()<BaseTableViewDataSoure,BaseTableViewDelegate>

@property (nonatomic,strong) NSMutableArray *dataMArray;

@property (nonatomic,assign) BOOL refreshing;//正在刷新数据

@end

@implementation RoomFansViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.baseViewType = kbaseTableViewType;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.frame =  CGRectZero;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.baseDataSource = self;
    self.tableView.baseDelegate = self;
    self.loadMore = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}

- (void)getRoomRankData;
{
    if (!self.refreshing && _dataMArray)
    {
        [self.tableView reloadData];
        return;
    }
    self.tipLabel.hidden = YES;
    NSString *method = getFansRank_Method;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInteger:[UserInfoManager shareUserInfoManager].currentStarInfo.roomid] forKey:@"roomid"];
    [params setObject:[NSNumber numberWithInteger:[UserInfoManager shareUserInfoManager].currentStarInfo.userId] forKey:@"staruserid"];
    if (self.dataMArray.count==0) {
        self.isFirstRequestData = YES;
    }else{
        self.isFirstRequestData = NO;
    }
    [self startAnimating];
    FansRankModel *fansModel = [[FansRankModel alloc] init];
    [fansModel requestDataWithMethod:method params:params success:^(id object) {
        if (fansModel.result == 0)
        {
            if (_dataMArray == nil)
            {
                _dataMArray = [NSMutableArray array];
            }
            if (fansModel.fansUserMArray)
            {
                if (self.refreshing)
                {
                    [_dataMArray removeAllObjects];
                    self.refreshing = NO;
                }

                [_dataMArray addObjectsFromArray:fansModel.fansUserMArray];
                [self.tableView reloadData];
                if (_dataMArray.count == 0)
                {
                    self.tipLabel.hidden = NO;
                }
                else
                {
                    self.tipLabel.hidden = YES;
                }
            }
            else
            {
                self.tipLabel.hidden = NO;
            }
        }
        [self stopAnimating];
    } fail:^(id object) {
        [self.tableView reloadData];
        [self stopAnimating];
    }];
}

- (void)refreshData
{
    self.refreshing = YES;
    [self getRoomRankData];
}

#pragma mark - UITalbeViewDataSurce

- (NSInteger)numberOfSectionsInBaseTableView:(BaseTableView *)baseTableView
{
    return 1;
}

- (NSInteger)baseTableView:(BaseTableView *)baseTableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger nCount = 0;
    if (_dataMArray)
    {
        nCount = _dataMArray.count + 1;
    }
    
    return nCount;
}

- (UITableViewCell *)baseTableView:(BaseTableView *)baseTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier =  @"cellIdentifier";
    static NSString *blankCellIdentifier = @"blankCellIdentifier";
    
    UITableViewCell *cell = nil;
    if (_dataMArray)
    {
        if (_dataMArray.count == indexPath.row)
        {
            //最后一个空白cell
            UITableViewCell *blankCell = [baseTableView dequeueReusableCellWithIdentifier:blankCellIdentifier];
            if (blankCell == nil)
            {
                blankCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:blankCellIdentifier];
                blankCell.backgroundColor = [UIColor clearColor];
                blankCell.accessoryType = UITableViewCellAccessoryNone;
                blankCell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell = blankCell;
        }
        else
        {
            FansCell *fansCell = [baseTableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (fansCell == nil)
            {
                fansCell = [[FansCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                fansCell.backgroundColor = [UIColor clearColor];
                fansCell.accessoryType = UITableViewCellAccessoryNone;
                fansCell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            UserInfo *userInfo = [_dataMArray objectAtIndex:indexPath.row];
            fansCell.isThis = YES;
            fansCell.userInfo = userInfo;
            fansCell.rankIndex = indexPath.row;
            cell = fansCell;
        }
    }
    else
    {
        UITableViewCell *blankCell = [baseTableView dequeueReusableCellWithIdentifier:blankCellIdentifier];
        if (blankCell == nil)
        {
            blankCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:blankCellIdentifier];
            blankCell.backgroundColor = [UIColor clearColor];
            blankCell.accessoryType = UITableViewCellAccessoryNone;
            blankCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell = blankCell;
    }
    return cell;
}


#pragma mark - UITableViewDelegate

- (CGFloat)baseTableView:(BaseTableView *)baseTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = [FansCell height];
    if (_dataMArray)
    {
        if (indexPath.row == _dataMArray.count)
        {
            height = 40;
        }
    }
    else
    {
        height = 40;
    }
    
    return height;
}

- (void)baseTableView:(BaseTableView *)baseTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
