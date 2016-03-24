//
//  StarCategoryViewController.m
//  BoXiu
//
//  Created by andy on 14-7-8.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "StarCategoryViewController.h"
#import "RecommendCell.h"
#import "UserInfoManager.h"
#import "CategoryStarModel.h"
#import "GetOneLevelCategoryStarListModel.h"
#import "AddAttentModel.h"
#import "DelAttentionModel.h"
#import "QueryOnLineStarModel.h"
#import "StarCategoryCell.h"

#define Category_StarCount_Per_Page (10)

@interface StarCategoryViewController ()<BaseTableViewDataSoure,BaseTableViewDelegate,StarCategoryCellDelegate>

@property (nonatomic,strong) NSMutableArray *starUserMArray;
@property (nonatomic,strong) NSMutableArray *starIdArry;

@property (nonatomic,strong) UserInfo *selectedStarUser;
@property (nonatomic,strong) NSString *categoryName;
@property (nonatomic,assign) NSInteger number;

@property (nonatomic,strong) QueryOnLineStarModel *OnLineStamodel;
@end

@implementation StarCategoryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _starIdArry = [[NSMutableArray alloc] init];
        _starUserMArray = [[NSMutableArray alloc] initWithCapacity:0];
        self.baseViewType = kbaseTableViewType;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.frame =  CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 44 - 36 - 44);
    self.tableView.baseDataSource = self;
    self.tableView.baseDelegate = self;
    self.hideProgressHud = YES;
    
    __weak  typeof(self) weakSelf = self;
    self.netViewTouchEd = ^(){
        if ([AppInfo shareInstance].nowtimesMillis == 0) {
            [[AppDelegate shareAppDelegate] enter:nil];
        }
        else
        {
            [weakSelf refreshData];
        }
    };
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshData) name:@"refresList" object:nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    if([AppInfo IsEnableConnection])
    {
        if ([AppInfo shareInstance].nowtimesMillis == 0) {
            [[AppDelegate shareAppDelegate] enter:nil];
            return ;
        }
        
        //将选中的主播置空。
        self.selectedStarUser = nil;
        if (self.bFirstViewWillAppear)
        {
            [self refreshData];
            self.bFirstViewWillAppear = NO;
        }
        else
        {
            if (_starUserMArray && self.starUserMArray.count == 0)
            {
                [self refreshData];
            }
        }
    }
    else
    {
        
        if([_starUserMArray count] == 0)
        {
            [self showNoticeInWindow:@"网络连接失败，请重试" duration:1.5];
            self.tipLabel.hidden = YES;
            self.networkview.hidden = NO;
        }
        else
        {
            [self showNoticeInWindow:@"网络连接失败，请重试" duration:1.5];
        }
    }
    
    [self stopAnimating];
    [self.tableView reloadData];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //将选中的主播置空。
    self.selectedStarUser = nil;
}

- (void)argumentForCanvas:(id)argumentData
{
    if (argumentData)
    {
        NSDictionary *params = (NSDictionary *)argumentData;
        self.categoryid = [[params objectForKey:@"categoryid"] integerValue];
        self.categoryName = [params objectForKey:@"categoryName"];
    }
}
#pragma mark - BaseCanvasController

- (void)loadMorData
{
    if (self.isOnlineStar)
    {
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        //        [params setObject:[NSNumber numberWithInteger:self.categoryid] forKey:@"categoryid"];
        //底层是从page=0开始的
        
        [params setObject:[NSNumber numberWithInteger:++self.tableView.curentPage] forKey:@"pageIndex"];
        [params setObject:[NSNumber numberWithInteger:Count_Per_Page] forKey:@"pageSize"];
        [params setObject:[NSNumber numberWithBool:YES] forKey:@"isFromMobile"];
        [params setObject:[NSNumber numberWithInteger:5] forKey:@"starType"];
        [self requestDataWithAnalyseModel:[QueryOnLineStarModel class] params:params success:^(id object) {
            QueryOnLineStarModel *model = (QueryOnLineStarModel *)object;
            if (model.result == 0)
            {
                
                if ([_starUserMArray count] < (self.tableView.curentPage * Count_Per_Page)?1:0) {
                    self.tableView.totalPage = 0;
                    self.tableView.curentPage --;
                }else
                {
                    
                }
                
                for(int num = 0; num < [model.starIdArry2 count]; num++)
                {
                    StarInfo *infoid = [model.starIdArry2 objectAtIndex:num];
                    StarInfo *lineStar = [model.onLineStarMArray objectAtIndex:num];
                    
                    BOOL isHave = [self.starIdArry containsObject:infoid];
                    if(!isHave)
                    {
                        [self.starUserMArray addObject:lineStar];
                        [self.starIdArry addObject:infoid];
                    }
                }
                
                [self.tableView reloadData];
                
            }else if (model.code == 403){
                [self showOherTerminalLoggedDialog];
            }
        } fail:^(id object) {
            
        }];
    }
    else
    {
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:[NSNumber numberWithInteger:self.categoryid] forKey:@"categoryid"];
        //底层是从page=0开始的
        [params setObject:[NSNumber numberWithInteger:self.tableView.curentPage ] forKey:@"pageIndex"];
        [params setObject:[NSNumber numberWithInteger:Count_Per_Page] forKey:@"pageSize"];
        [params setObject:[NSNumber numberWithBool:YES] forKey:@"isFromMobile"];
        [self requestDataWithAnalyseModel:[CategoryStarModel class] params:params success:^(id object) {
            CategoryStarModel *model = (CategoryStarModel *)object;
            if (model.result == 0)
            {
                [self.starUserMArray addObjectsFromArray: model.starMArray];
                [self.tableView reloadData];
            }
        } fail:^(id object) {
            
        }];
    }
}


- (void)refreshData
{
    
    if([AppInfo IsEnableConnection])
    {
        if ([AppInfo shareInstance].nowtimesMillis == 0) {
            [[AppDelegate shareAppDelegate] enter:nil];
            return ;
        }
        else
        {
            [self networking];
        }
    }
    else
    {
        
        if([_starUserMArray count] == 0)
        {
            [self showNoticeInWindow:@"网络连接失败，请重试" duration:1.5];
            self.tipLabel.hidden = YES;
            self.networkview.hidden = NO;
        }
        else
        {
            [self showNoticeInWindow:@"网络连接失败，请重试" duration:1.5];
        }
    }
    [self stopAnimating];
    [self.tableView reloadData];
    
}

-(void)networking
{
    //    请求动画
    if (self.starUserMArray.count==0) {
        self.isFirstRequestData = YES;
    }else{
        self.isFirstRequestData = NO;
    }
    [self startAnimating];
    
    if (self.isOnlineStar)
    {
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        //        [params setObject:[NSNumber numberWithInteger:self.categoryid] forKey:@"categoryid"];
        [params setObject:[NSNumber numberWithInteger:1] forKey:@"pageIndex"];
        [params setObject:[NSNumber numberWithInteger:Count_Per_Page] forKey:@"pageSize"];
        [params setObject:[NSNumber numberWithBool:YES] forKey:@"isFromMobile"];
        [params setObject:[NSNumber numberWithInteger:5] forKey:@"starType"];
        [self requestDataWithAnalyseModel:[QueryOnLineStarModel class] params:params success:^(id object) {
            _OnLineStamodel = (QueryOnLineStarModel *)object;
            if (_OnLineStamodel.result == 0)
            {
                
                [self.starUserMArray removeAllObjects];
                [self.starIdArry removeAllObjects];
                
                [self.starUserMArray addObjectsFromArray:_OnLineStamodel.onLineStarMArray];
                _starIdArry = _OnLineStamodel.starIdArry;
                
                self.tableView.totalPage = 1000;
                if ([_starUserMArray count] < (self.tableView.curentPage * Count_Per_Page)?1:0) {
                    self.tableView.curentPage --;
                }
                
                [self.tableView reloadData];
                NSInteger nCount = [self.starUserMArray count];
                if (nCount == 0)
                {
                    self.tipLabel.hidden = NO;
                }
                else
                {
                    self.tipLabel.hidden = YES;
                    self.networkview.hidden = YES;
                    //                    [self endRefreshing];
                }
            }
            [self stopAnimating];
        } fail:^(id object) {
            [self stopAnimating];
            [self.tableView reloadData];
            self.tipLabel.hidden = YES;
            self.networkview.hidden = NO;
            
            //             [_header endRefreshing];
            
        }];
    }
    else
    {
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:[NSNumber numberWithInteger:self.categoryid] forKey:@"categoryid"];
        [params setObject:[NSNumber numberWithInteger:1] forKey:@"pageIndex"];
        [params setObject:[NSNumber numberWithInteger:Count_Per_Page] forKey:@"pageSize"];
        [params setObject:[NSNumber numberWithBool:YES] forKey:@"isFromMobile"];
        [self requestDataWithAnalyseModel:[CategoryStarModel class] params:params success:^(id object) {
            CategoryStarModel *model = (CategoryStarModel *)object;
            if (model.result == 0)
            {
                [self.starUserMArray removeAllObjects];
                [self.starIdArry removeAllObjects];
                
                [self.starUserMArray addObjectsFromArray:model.starMArray];
                _starIdArry = _OnLineStamodel.starIdArry;
                
                if ([self.starUserMArray count] < Category_StarCount_Per_Page)
                {
                    self.tableView.totalPage = [self.starUserMArray count]/Category_StarCount_Per_Page + ([self.starUserMArray count] %Category_StarCount_Per_Page? 1:0);
                }
                else
                {
                    self.tableView.totalPage = 1000;
                }
                
                [self.tableView reloadData];
                NSInteger nCount = [self.starUserMArray count];
                if (nCount == 0)
                {
                    self.tipLabel.hidden = NO;
                }
                else
                {
                    self.tipLabel.hidden = YES;
                    self.networkview.hidden = YES;
                }
            }
        } fail:^(id object) {
            self.tipLabel.hidden = YES;
            self.networkview.hidden = NO;
            [self.tableView reloadData];
            [[AppInfo shareInstance] showNoticeInWindow:@"网络连接失败" duration:1.5];
            
        }];
    }
    
}

#pragma mark -BaseTableCanvasDataSoure

- (NSInteger)numberOfSectionsInBaseTableView:(BaseTableView *)baseTableView
{
    return 1;
}

- (NSInteger)baseTableView:(BaseTableView *)baseTableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger nCount = [self.starUserMArray count];
    return nCount;
}

- (UITableViewCell *)baseTableView:(BaseTableView *)baseTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ((indexPath.row+1)%10 == 0) {
        if ((10 + [self.starUserMArray count])%10 ==0 ) {
            if(self.tableView.totalPage != 0)
            {
                [self loadMorData];
            }
        }
    }
    
    static NSString *cellIdentifier =  @"cellIdentifier";
    StarCategoryCell *cell = [baseTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[StarCategoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.starInfo = [self.starUserMArray objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark - BaseTableCanvasDelegate

- (void)baseTableView:(BaseTableView *)baseTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedStarUser = [self.starUserMArray objectAtIndex:indexPath.row];
    NSDictionary *param = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:self.selectedStarUser.userId] forKey:@"staruserid"];
    [self.rootViewController pushCanvas:LiveRoom_CanVas withArgument:param];
    //[self.rootViewController pushCanvas:LiveRoom_CanVas withArgument:param];
}

- (CGFloat)baseTableView:(BaseTableView *)baseTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [StarCategoryCell height];
}

//- (void)recommendCell:(RecommendCell *)recommendCell attendStar:(StarInfo *)starInfo

#pragma mark - RecommendCellDelegate
- (void)StarCategoryCell:(StarCategoryCell *)StarCategoryCell attendStar:(StarInfo *)starInfo
{
    if (![AppInfo shareInstance].bLoginSuccess)
    {
        [self showNoticeInWindow:@"需要先登录哦"];
        return;
    }
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInteger:starInfo.userId]forKey:@"staruserid"];
    
    __weak typeof(self) weakSelf = self;
    if (starInfo.attentionflag)
    {
        //取消关注
        DelAttentionModel *delAttentionModel = [[DelAttentionModel alloc] init];
        [delAttentionModel requestDataWithParams:dict success:^(id object) {
            __strong typeof(self) strongSelf = weakSelf;
            /*成功返回数据*/
            if (delAttentionModel.result == 0)
            {
                starInfo.attentionflag = NO;
                StarCategoryCell.starInfo = starInfo;
                [strongSelf showNoticeInWindow:@"已取消对TA的关注"];
            }
            else
            {
                [[AppInfo shareInstance] loginOut];
                [self.tableView reloadData];
                [self showOherTerminalLoggedDialog];
            }
        } fail:^(id object) {
            
        }];
    }
    else
    {
        //添加关注
        AddAttentModel *addAttentionModel = [[AddAttentModel alloc] init];
        [addAttentionModel requestDataWithMethod:AddAttention_Method params:dict success:^(id object) {
            __strong typeof(self) strongSelf = weakSelf;
            /*成功返回数据*/
            if (addAttentionModel.result == 0)
            {
                starInfo.attentionflag = YES;
                StarCategoryCell.starInfo = starInfo;
                [strongSelf showNoticeInWindow:@"已成功关注TA"];
            }
            else
            {
                [[AppInfo shareInstance] loginOut];
                [self.tableView reloadData];
                [self showOherTerminalLoggedDialog];
            }
        } fail:^(id object) {
            
        }];
    }
    
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
