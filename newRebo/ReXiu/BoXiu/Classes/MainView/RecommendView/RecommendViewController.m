//
//  RecommendViewController.m
//  XiuBo
//
//  Created by Andy on 14-3-26.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "RecommendViewController.h"
#import "RecommendCell.h"
#import "UserInfo.h"
#import "EnterRoomModel.h"
#import "CommandManager.h"
#import "GetRecommendStarModel.h"
#import "DelAttentionModel.h"
#import "AddAttentModel.h"
#import "QueryLiveSchedulesModel.h"
#import "ProgramCell.h"
#import "TopProgramModel.h"
#import "ADvertCell.h"
#import "LiveStarCell.h"
#import "HomePageAdvertModel.h"
#import "Reachability.h"
#import "MainViewController.h"

#define RecommendCount_Per_Page (10)

typedef enum _RequestState
{
    eNotRequest = 1,
    eRequesting = 2,
}RequestState;

@interface RecommendViewController ()<BaseTableViewDataSoure,BaseTableViewDelegate,RecommendCellDelegate,ProgramCellDelegate,ADvertCellDelegate,LiveStarCellDelegate>

@property (nonatomic,strong) NSMutableArray *starUserMArray;
@property (nonatomic,strong) StarInfo *selectedStarUser;

@property (nonatomic, strong) UIImageView *headStarImgView;
@property (nonatomic, strong) UILabel *starTitleLabel;
@property (nonatomic, strong) UILabel *noStarTitleLabel;
@property (nonatomic, strong) UILabel *LastStarTitleLabel;
@property (nonatomic, strong) UILabel *starTimeLabel;
@property (nonatomic, strong) UILabel *noStarTimeLabel;
@property (nonatomic, strong) UILabel *lastStarTimeLabel;
@property (nonatomic, strong) StarInfo *starInfo;

@property (nonatomic, assign) NSInteger updateDataNum;//节目列表和推荐主播到下来刷新
@property (nonatomic, assign) BOOL IsCloseAd;  //判断广告是否关闭

@property (nonatomic,assign) RequestState requestState;
@property (nonatomic,assign) int indexPage;
@property (nonatomic,assign) NSInteger Number;

@end

@implementation RecommendViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.baseViewType = kbaseTableViewType;
        
        _IsCloseAd = NO;
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = Recommend_Title;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    
    self.tableView.frame =  CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 44 - 36 - 40);
    self.tableView.baseDataSource = self;
    self.tableView.baseDelegate = self;
    self.hideProgressHud = YES;
    
    [self addObserver:self forKeyPath:@"updateDataNum" options:NSKeyValueObservingOptionNew context:nil];
    
    self.requestState = eNotRequest;
    self.indexPage =1;
    
    __weak  typeof(self) weakSelf = self;
    self.netViewTouchEd = ^(){
        if ([AppInfo shareInstance].nowtimesMillis == 0) {
            [[AppDelegate shareAppDelegate] enter:nil];
        }
        else
        {
            [weakSelf  requestData:NO];
        }
    };
}
- (void) reachabilityChanged:(NSNotification *)note
{
    Reachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
    [self configureTextField:nil imageView:nil reachability:curReach];
}

- (void)configureTextField:(UITextField *)textField imageView:(UIImageView *)imageView reachability:(Reachability *)reachability
{
    NetworkStatus netStatus = [reachability currentReachabilityStatus];
    
    switch (netStatus)
    {
        case NotReachable:        {
            [AppInfo shareInstance].network = 0;
            break;
        }
            
        case ReachableViaWWAN:        {
            [AppInfo shareInstance].network = 1;
            break;
        }
        case ReachableViaWiFi:        {
            [AppInfo shareInstance].network = 2;
            break;
        }
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    if([AppInfo IsEnableConnection])
    {
        if ([AppInfo shareInstance].nowtimesMillis == 0) {
            [[AppDelegate shareAppDelegate] enter:nil];
            return ;
        }
        else
        {
            [super viewWillAppear:animated];
            self.selectedStarUser = nil;
            
            if (_starUserMArray)
            {
                if (self.requestState == eNotRequest)
                {
                    if (_starUserMArray.count == 0)
                    {
                        [self requestData:NO];
                    }
                    else
                    {
                        [self.tableView reloadData];
                    }
                    
                }
            }
            else
            {
                [self requestData:NO];
            }
        }
    }
    else
    {
        [self stopAnimating];
        [self.tableView reloadData];
        
        if (_starUserMArray.count > 0)
        {
            [self showNoticeInWindow:@"网络连接失败，请重试" duration:1.5];
            return ;
        }else if(_starUserMArray.count == 0)
        {
            self.tipLabel.hidden = YES;
            self.networkview.hidden = NO;
            [self showNoticeInWindow:@"网络连接失败，请重试" duration:1.5];
            return ;
            
        }
        
        
    }
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.selectedStarUser = nil;
}

#pragma mark - BaseCanvasController

- (void)loadMorData
{
    if ( self.starUserMArray.count==0) {
        self.isFirstRequestData = YES;
    }else{
        self.isFirstRequestData = NO;
    }
    [self startAnimating];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithBool:YES] forKey:@"isPagination"];
    [dict setObject:[NSNumber numberWithInt:RecommendCount_Per_Page] forKey:@"pageSize"];
    [dict setObject:[NSNumber numberWithBool:YES] forKey:@"isFromMobile"];
    
    //加载数据
    [dict setObject:[NSNumber numberWithInteger: ++self.indexPage] forKey:@"pageIndex"];
    
    __weak typeof(self) weakSelf = self;
    GetRecommendStarModel *model = [[GetRecommendStarModel alloc] init];
    [model requestDataWithParams:dict success:^(id object) {
        _Number = 0;
        __strong typeof(self) strongSelf = weakSelf;
        /*成功返回数据*/
        GetRecommendStarModel *model = object;
        if (model.result == 0)
        {
            if ([_starUserMArray count] < (self.indexPage * Count_Per_Page)?1:0) {
                self.tableView.totalPage = 0;
                self.indexPage --;
            }else
            {
                
            }
            if ([model.starMArray count]>0) {
                [strongSelf.starUserMArray addObjectsFromArray:model.starMArray];
                [strongSelf.tableView reloadData];
            }
            [self stopAnimating];
            
        }else if (model.code == 403){
            [self showOherTerminalLoggedDialog];
        }
        
        if (model.result == 0)
        {
            StarInfo* startInof = [model.starMArray lastObject];
            if (startInof.onlineflag) {
                self.tableView.totalPage = 100;
            }else{
                self.tableView.totalPage = 1;
            }
        }
        
        
    } fail:^(id object) {
        /*失败返回数据*/
        _Number = 1;
        [self stopAnimating];
        [self.tableView reloadData];
    }];
}
- (void)requestData:(BOOL)refresh
{
    if([AppInfo IsEnableConnection])
    {
        if([_starUserMArray count] > 0)
        {
            self.tipLabel.hidden = YES;
            self.networkview.hidden = YES;
        }
        else
        {
            self.tipLabel.hidden = NO;
            self.networkview.hidden = YES;
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
        
        return;
        
        
        
    }
    
    if (self.starUserMArray.count==0) {
        self.isFirstRequestData = YES;
    }else{
        self.isFirstRequestData = NO;
    }
    [self startAnimating];
    
    self.updateDataNum = 0;//数据都下来后一起刷新
    //查询直播排期数据
    
    //查询推荐列表
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        GetRecommendStarModel *model = [[GetRecommendStarModel alloc] init];
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:[NSNumber numberWithBool:YES] forKey:@"isPagination"];
        [dict setObject:[NSNumber numberWithInt:RecommendCount_Per_Page] forKey:@"pageSize"];
        [dict setObject:[NSNumber numberWithBool:YES] forKey:@"isFromMobile"];
        //刷新数据
        [dict setObject:[NSNumber numberWithInt:self.indexPage] forKey:@"pageIndex"];
        [model requestDataWithParams:dict success:^(id object) {
            _Number = 0;
            if (_starUserMArray == nil)
            {
                _starUserMArray = [NSMutableArray array];
            }
            [_starUserMArray removeAllObjects];
            if (model.result == 0)
            {
                [_starUserMArray addObjectsFromArray:model.starMArray];
            }else if (model.code == 403){
                [self showOherTerminalLoggedDialog];
            }
            
            if (model.result == 0)
            {
                StarInfo* startInof = [model.starMArray lastObject];
                if (startInof.onlineflag) {
                    self.tableView.totalPage = 100;
                }else{
                    self.tableView.totalPage = 1;
                }
            }
            
            self.updateDataNum++;
        } fail:^(id object) {
            _Number = 1;
            self.updateDataNum++;
        }];
        
    });
    
    
    [self stopAnimating];
    [self.tableView reloadData];
    
    
    
    [self stopAnimating];
    [self.tableView reloadData];
    
    
}

- (void)refreshData
{
    [self requestData:YES];
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
    static NSString *recommendCellIdentifier =  @"recommendCellIdentifier";
    UITableViewCell *cell = nil;
    
    RecommendCell *recommendCell = [baseTableView dequeueReusableCellWithIdentifier:recommendCellIdentifier];
    if (recommendCell == nil)
    {
        recommendCell = [[RecommendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:recommendCellIdentifier];
        recommendCell.delegate = self;
        recommendCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSInteger nIndex = 0;
    
    _starInfo = [self.starUserMArray objectAtIndex:indexPath.row - nIndex];
    recommendCell.starInfo = _starInfo;
    cell = recommendCell;
    
    UIButton  *starinforButton = [UIButton buttonWithType:UIButtonTypeCustom];
    starinforButton.frame = CGRectMake(6, 198, 65, 65);
    starinforButton.backgroundColor = [UIColor clearColor];
    [starinforButton addTarget:self action:@selector(starinforButton:) forControlEvents:UIControlEventTouchUpInside];
    starinforButton.tag = indexPath.row;
    [cell.contentView addSubview:starinforButton];
    
    
    return cell;
}

- (void)starinforButton:(UIButton *)sender{
    
    RecommendCell* cell = (RecommendCell*)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:sender.tag inSection:0]  ];
    
    [UserInfoManager shareUserInfoManager].tempHederImage = cell.adPhoto.image;
    
    StarInfo *starInfo =[self.starUserMArray objectAtIndex:sender.tag];
    [UserInfoManager shareUserInfoManager].tempStarInfo = starInfo;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:[NSNumber numberWithInteger:starInfo.userId] forKey:@"userid"];
    [self.rootViewController pushCanvas:PersonInfo_Canvas withArgument:param];
}

#pragma mark -BaseTableViewDelegate
- (void)baseTableView:(BaseTableView *)baseTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger nIndex = 0;
    
    if (self.starUserMArray.count > 0)
    {
        self.selectedStarUser = [self.starUserMArray objectAtIndex:indexPath.row - nIndex];
        NSDictionary *param = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:self.selectedStarUser.userId] forKey:@"staruserid"];
        [AppDelegate shareAppDelegate].isSelfWillLive = NO;
        [self.rootViewController pushCanvas:LiveRoom_CanVas withArgument:param];
        
  
    }
}

- (CGFloat)baseTableView:(BaseTableView *)baseTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [RecommendCell height];
}

#pragma mark - RecommendCellDelegate
- (void)recommendCell:(RecommendCell *)recommendCell attendStar:(StarInfo *)starInfo
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
                recommendCell.starInfo = starInfo;
                [strongSelf showNoticeInWindow:@"已取消对TA的关注"];
            }else if (delAttentionModel.code == 403){
                [[AppInfo shareInstance] loginOut];
                [self showOherTerminalLoggedDialog];
            }
            else
            {
                
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
                recommendCell.starInfo = starInfo;
                [strongSelf showNoticeInWindow:@"已成功关注TA"];
            }else if (addAttentionModel.code == 403){
                [[AppInfo shareInstance] loginOut];
                [self showOherTerminalLoggedDialog];
            }
            else
            {
                [strongSelf showNoticeInWindow:@"需要先登录哦"];
                
            }
            
        } fail:^(id object) {
            
        }];
    }
    
}

#pragma mark observer
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"updateDataNum"])
    {
        NSInteger updateDataNum = [[change objectForKey:NSKeyValueChangeNewKey] integerValue];
        if (updateDataNum == 1)
        {
            NSInteger nCount = [self.starUserMArray count];
            
            if (_Number) {
                if ([_starUserMArray count] == 0)
                {
                    self.tipLabel.hidden = YES;
                    self.networkview.hidden = NO;
                }
                else
                {
                    [self showNoticeInWindow:@"网络连接失败,请重试"];
                }
                [self.tableView reloadData];
            }
            else
            {
                self.networkview.hidden = YES;
                
                
                if (nCount == 0)
                {
                    self.tipLabel.hidden = NO;
                }
                else
                {
                    self.tipLabel.hidden = YES;
                }
            }
            
            self.requestState = eNotRequest;
            [self stopAnimating];
        }
        else if (updateDataNum == 0)
        {
            // 如果要检测网络状态的变化,必须用检测管理器的单例的startMonitoring
            [[AFNetworkReachabilityManager sharedManager] startMonitoring];
            
            // 检测网络连接的单例,网络变化时的回调方法
            [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
                if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable)
                {
                    if ([_starUserMArray count] == 0)
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
                [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
                
            }];
            
        }
        
        [self.tableView reloadData];
        
    }
    
}

@end
