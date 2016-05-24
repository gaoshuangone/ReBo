//
//  MainViewController.m
//  XiuBo
//
//  Created by Andy on 14-3-20.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "MainViewController.h"
#import "RecommendViewController.h"
#import "AttentViewController.h"
#import "AppDelegate.h"
#import "GetTwoLevelCategoryModel.h"
#import "StarCategoryViewController.h"
#import "MessageCenterViewController.h"
#import "CustomBadge.h"
#import "MessageCenter.h"
#import "AutoRegistModel.h"
#import "UserInfoManager.h"
#import "UMSocial.h"
#import "UMessage.h"
#import "MobClick.h"
#import "LoginViewController.h"
#import "WXApi.h"
#import "GiftItem.h"
#import "GetConfigModel.h"
#import "CustomMethod.h"
#import "PersonItemView.h"
#import "HomePageAdvertModel.h"
#import "ADvertCell.h"
#import "UserInfoManager.h"
#import "ProgramCell.h"
#import "JEProgressView.h"
#import "LiveStarCell.h"
#import "CanShowOnMobile.h"
#import "LiveProtocolViewController.h"
@implementation CategoryMenu

@end

@interface MainViewController ()<BaseTableViewDataSoure,BaseTableViewDelegate,ProgramCellDelegate,ADvertCellDelegate,LiveStarCellDelegate,EWPTabMenuControlDataSource,EWPTabMenuControlDelegate>


//标签
@property (nonatomic,strong) NSMutableArray *tabMenuTitles;
@property (nonatomic,strong) NSMutableArray *contentViewControllerMArray;
@property (nonatomic,assign) NSInteger currentTabIndex;

@property (nonatomic,assign) BOOL bTapTabItem;
@property (nonatomic,assign) int startContentOffsetX;

@property (nonatomic,strong) CustomBadge *msgBadge;

@property (nonatomic, strong) AutoRegistModel *autoRegistModel;
@property (nonatomic, strong) EWPSimpleDialog *autoRegistDialog;
@property (nonatomic, strong) EWPSimpleDialog *giftDialog;
@property (nonatomic, strong) EWPSimpleDialog *awaysLoginDialog;
@property (nonatomic,assign) BOOL isShouLeftView;

@property (nonatomic,assign) NSInteger location;
@property (nonatomic,strong) NSArray* dataLoginDialogArray;
@property (nonatomic,strong) NSDictionary* dictLoginDialogArray;

@property (nonatomic, strong) UIButton *liveBtn;
@property (nonatomic, strong) UIButton *home;
@property (nonatomic, strong) UIButton *activityBtn;
@property (nonatomic, strong) NSMutableArray *advertMary;  //存放广告数据

@property (nonatomic,strong) EWPADView *ewpAdView;
@property (nonatomic,strong) UIButton *closeBtn;

@property (nonatomic,strong) JEProgressView *consumProgressView;

@property (nonatomic,assign) int height;
@property (nonatomic,assign) NSInteger hideSwitch;          //开关
@property (nonatomic,assign) NSInteger hideSwitch2;

@property (nonatomic,strong) PersonItemView *rankItemView;
@property (nonatomic,strong) UITapGestureRecognizer *rankItem;
@property (nonatomic,strong) PersonItemView *ictivityItemView;
@property (nonatomic,strong) UIView *lineView2;
@property (nonatomic,strong) UIView *lineView3;
@property (nonatomic,strong) UITapGestureRecognizer *activityInfor;
@property (nonatomic,strong) PersonItemView *inviteFriendsView;
@property (nonatomic,strong) PersonItemView *marketView;
@property (nonatomic,strong) UITapGestureRecognizer *market;
@property (nonatomic,strong) PersonItemView *rechargeView;
@property (nonatomic,strong) UILabel *infor;
@property (nonatomic,strong) UIImageView *headImageView;

@property (nonatomic,strong) UIView *updateview;
@property (nonatomic,strong) UILabel *message;
@property (nonatomic,strong) UITapGestureRecognizer *upinfor;
@end

@implementation MainViewController

- (void)dealloc
{
//    [[MessageCenter shareMessageCenter] removeObserver:self forKeyPath:@"unReadCount" context:nil];
    
    [[AppInfo shareInstance] removeObserver:self forKeyPath:@"bLoginSuccess"];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.baseViewType = kbaseScroolViewType;
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"首页";
    // Do any additional setup after loading the view.
    self.bFirstViewWillAppear = YES;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ShowLiveBtnOnMain) name:@"ShowLiveBtnOnMain" object:nil];
    [[NSNotificationCenter defaultCenter ]addObserver:self selector:@selector(showOherTerminal) name:@"showOherTerminalLoggedDialog" object:nil];

    _tabMenuControl = [[EWPTabMenuControl alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _tabMenuControl.dataSource = self;
    _tabMenuControl.delegate = self;
    _tabMenuControl.defaultSelectedSegmentIndex = 0;
    [self.view addSubview:_tabMenuControl];
    
    [self activity];
    _headImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _headImageView.layer.masksToBounds = YES;
    [self.view addSubview:_headImageView];
    
#pragma mark 显示下面的标签栏
    UIView *liveStateview = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 114, SCREEN_WIDTH, 52)];
    liveStateview.backgroundColor = [CommonFuction colorFromHexRGB:@"ffffff"];
    [self.view addSubview:liveStateview];
    
    UIView *liveview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 127, 51)];
    liveview.backgroundColor = [UIColor clearColor];
    [liveStateview addSubview:liveview];
    UITapGestureRecognizer *setinfor = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnHome:)];
    [liveview addGestureRecognizer:setinfor];
    
    _home= [UIButton buttonWithType:UIButtonTypeCustom];
    [_home addTarget:self action:@selector(OnHome:) forControlEvents:UIControlEventTouchUpInside];
    _home.frame = CGRectMake(43, 8, 21, 21);
    [_home setImage:[UIImage imageNamed:@"tv-select"] forState:UIControlStateNormal];
    [liveview addSubview:_home];
    
    UILabel *livelable = [[UILabel alloc] initWithFrame:CGRectMake(43, 32, 51, 11)];
    livelable.text = @"直播";
    livelable.textColor = [CommonFuction colorFromHexRGB:@"9a9a9a"];
    livelable.font = [UIFont boldSystemFontOfSize:10.0f];
    [liveview addSubview:livelable];
    
    
    _liveBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    [_liveBtn addTarget:self action:@selector(OnLveing) forControlEvents:UIControlEventTouchUpInside];
    _liveBtn.frame = CGRectMake(131, -10, 55, 55);
    [_liveBtn setImage:[UIImage imageNamed:@"live_but"] forState:UIControlStateNormal];
    [liveStateview addSubview:_liveBtn];
    
    UIView *activityview = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 127, 0, 127, 51)];
    activityview.backgroundColor = [UIColor clearColor];
    [liveStateview addSubview:activityview];
    //view 点击事件
    UITapGestureRecognizer *activityInfor = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnActivity:)];
    [liveStateview addGestureRecognizer:activityInfor];
    //    button 点击事件
    _activityBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    [_activityBtn addTarget:self action:@selector(OnActivity:) forControlEvents:UIControlEventTouchUpInside];
    _activityBtn.frame = CGRectMake(55, 8, 21, 21);
    [_activityBtn setImage:[UIImage imageNamed:@"activity_normal"] forState:UIControlStateNormal];
    [activityview addSubview:_activityBtn];
    
    UILabel *activityLable = [[UILabel alloc] initWithFrame:CGRectMake(55, 32, 51, 11)];
    activityLable.text = @"活动";
    activityLable.textColor = [CommonFuction colorFromHexRGB:@"9a9a9a"];
    activityLable.font = [UIFont boldSystemFontOfSize:10.0f];
    [activityview addSubview:activityLable];

    _updateview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 126)];
    _upinfor = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(updateinfor:)];
    [_updateview addGestureRecognizer:_upinfor];

    _message = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 80)/2, (SCREEN_HEIGHT - 140)/2,80, 40)];
    _message.font = [UIFont systemFontOfSize:15.0f];
    _message.textColor = [CommonFuction colorFromHexRGB:@"959596"];
    [_updateview addSubview:_message];
    [self.view addSubview:_updateview];
    
    [[MessageCenter shareMessageCenter] addObserver:self forKeyPath:@"unReadCount" options:NSKeyValueObservingOptionNew context:nil];
    
    [[AppInfo shareInstance] addObserver:self forKeyPath:@"bLoginSuccess" options:NSKeyValueObservingOptionNew context:nil];

}
#pragma  mark  初始化活动
-(void)activity
{
    self.scrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 53 );
    self.scrollView.backgroundColor = [CommonFuction colorFromHexRGB:@"eeeeee"];
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.hidden = YES;
    
    int YOffset = _height + 10;
    
    //    排行
    _rankItemView= [[PersonItemView alloc] initWithFrame:CGRectMake(0, YOffset, SCREEN_WIDTH, 43) title:Rank_Title smallImg:[UIImage imageNamed:@"Rank"]];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(50, 42, 552/2, 1)];
    lineView.backgroundColor = [CommonFuction colorFromHexRGB:@"eeeeee"];
    [_rankItemView addSubview:lineView];
    _rankItem= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(RankItem:)];
    [_rankItemView addGestureRecognizer:_rankItem];
    
    //    活动
        YOffset += 43;
        _ictivityItemView = [[PersonItemView alloc] initWithFrame:CGRectMake(0, YOffset, SCREEN_WIDTH, 43) title:Activity_Title smallImg:[UIImage imageNamed:@"Activity"]];
        _lineView2= [[UIView alloc] initWithFrame:CGRectMake(50, 42, 552/2, 1)];
        _lineView2.backgroundColor = [CommonFuction colorFromHexRGB:@"eeeeee"];
        [_ictivityItemView addSubview:_lineView2];
        _activityInfor= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ActivityItem:)];
        [_ictivityItemView addGestureRecognizer:_activityInfor];
    
        //   邀请
        YOffset += 43;
        _inviteFriendsView = [[PersonItemView alloc] initWithFrame:CGRectMake(0, YOffset, SCREEN_WIDTH, 43) title:Invite_friends smallImg:[UIImage imageNamed:@"InviterFriends"]];
        UITapGestureRecognizer *inviteFriends = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(InviteFriends:)];
        [_inviteFriendsView addGestureRecognizer:inviteFriends];
    

        //    商城
        YOffset += 48;
        _marketView= [[PersonItemView alloc] initWithFrame:CGRectMake(0, YOffset, SCREEN_WIDTH, 43) title:Market_Title smallImg:[UIImage imageNamed:@"Market"]];
        _lineView3 = [[UIView alloc] initWithFrame:CGRectMake(50, 42, 552/2, 1)];
        _lineView3.backgroundColor = [CommonFuction colorFromHexRGB:@"eeeeee"];
        [_marketView addSubview:_lineView3];
        _market= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Market:)];
        [_marketView addGestureRecognizer:_market];
    

    
    //    充值
    YOffset += 43;
    _rechargeView = [[PersonItemView alloc] initWithFrame:CGRectMake(0, YOffset, SCREEN_WIDTH, 43) title:Recharge_Title smallImg:[UIImage imageNamed:@"Recharge"]];
    UITapGestureRecognizer *recharge = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Recharge:)];
    [_rechargeView addGestureRecognizer:recharge];
    
    YOffset += 43;
    _infor= [[UILabel alloc] initWithFrame:CGRectMake(10, YOffset, SCREEN_WIDTH, 29)];
    _infor.text = @"商务合作: QQ 2273211546";
    _infor.textColor = [CommonFuction colorFromHexRGB:@"9a9a9a"];
    _infor.font = [UIFont systemFontOfSize:14.0f];
    

}
#pragma mark 更新网络
-(void)updateinfor:(id)sender
{
    [self loadMenu];
}
- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    
    //      是否显示左侧菜单栏   live_but
    [AppDelegate shareAppDelegate].lrSliderMenuViewController.canShowLeft = NO;
    [AppDelegate shareAppDelegate].lrSliderMenuViewController.isSupportPanGesture = YES;
    
    if ([AppInfo shareInstance].bFirstEnterMainView)
    {
        // 如果要检测网络状态的变化,必须用检测管理器的单例的startMonitoring
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
        
        // 检测网络连接的单例,网络变化时的回调方法
        [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == AFNetworkReachabilityStatusReachableViaWWAN)
            {
                [self showNoticeInWindow:@"您正使用4G/3G/2G网络，建议使用Wi-Fi观看直播,土豪随意。"];
            }
            [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
            
        }];
        
        //监测版本升级
        [self performSelector:@selector(checkVersion) withObject:nil];
        [AppInfo shareInstance].bFirstEnterMainView = NO;
    }
    
    NSInteger nCount = self.navigationController.viewControllers.count;
    if (nCount > 1)
    {
        NSMutableArray *viewControllers = [[NSMutableArray alloc] initWithArray:self.navigationController.viewControllers];
        ViewController *viewController = (ViewController *)[viewControllers objectAtIndex:0];
        [viewController removeFromParentViewController];
    }
//[UserInfoManager shareUserInfoManager].currentUserInfo.photo
//    BOOL bLoginSuccess= [AppInfo shareInstance].bLoginSuccess;

    [self setHeadImg];

    [self setNavigationBarRightMenu];
    
    if(self.tabMenuControl && [self.tabMenuTitles count])
    {
        [self.tabMenuControl viewWillAppear];
    }
    else
    {
        [self loadMenu];
    }
    
    if ([AppDelegate shareAppDelegate].showingLeftMenu)
    {
        [[AppDelegate shareAppDelegate].lrSliderMenuViewController showLeftView];
        [AppDelegate shareAppDelegate].showingLeftMenu = NO;
    }
}

-(void)setHeadImg
{
    __weak typeof(self) safeSelf = self;
    BOOL bLoginSuccess= [AppInfo shareInstance].bLoginSuccess;
    //如果已登录则跳转到跟人信息界面，否则登录界面
    if (bLoginSuccess) {
        
        NSURL *headUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[AppInfo shareInstance].res_server,[UserInfoManager shareUserInfoManager].currentUserInfo.photo]];
        [_headImageView sd_setImageWithURL:headUrl];
        if ([UserInfoManager shareUserInfoManager].currentUserInfo.photo == NULL) {
            [self setNavigationBarLeftItem:nil itemNormalImg:[UIImage imageNamed:@"default_photo"] itemHighlightImg:nil withBlock:^(id sender) {
                Class viewControllerType = nil;
                viewControllerType = NSClassFromString(PersonInfo_Canvas);
                [safeSelf pushCanvas:PersonInfo_Canvas withArgument:nil];
            }];
        }
        [self setNavigationBarLeftItem:nil itemNormalImg:[_headImageView image] itemHighlightImg:nil withBlock:^(id sender) {
            Class viewControllerType = nil;
            viewControllerType = NSClassFromString(PersonInfo_Canvas);
            [safeSelf pushCanvas:PersonInfo_Canvas withArgument:nil];
        }];
    }
    else
    {
        [self setNavigationBarLeftItem:nil itemNormalImg:[UIImage imageNamed:@"leftBtn_normal"] itemHighlightImg:nil withBlock:^(id sender) {
            
            Class viewControllerType = nil;
            viewControllerType = NSClassFromString(Login_Canvas);
            [safeSelf pushCanvas:Login_Canvas withArgument:nil];
            
        }];
    }
    
    [AppDelegate shareAppDelegate].isNeedReturnLiveRoom = NO;


}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    [self showGiftDialog];
}


-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [AppDelegate shareAppDelegate].lrSliderMenuViewController.canShowLeft = NO;
    [AppDelegate shareAppDelegate].lrSliderMenuViewController.isSupportPanGesture = NO;
    
}

- (void)argumentForCanvas:(id)argumentData
{
    if (argumentData && [argumentData isKindOfClass:[NSDictionary class]])
    {
        NSDictionary *param = (NSDictionary *)argumentData;
        NSString *className = [param objectForKey:@"className"];
        if (className && [className isKindOfClass:[NSString class]])
        {
            if ([className isEqualToString:@"LoginViewController"]||[className isEqualToString:@"RegisterSuccessViewController"] ) {
                if ([AppInfo shareInstance].bLoginSuccess) {
                    [self showAwaysLoginDialog];
                }
            }
            
        }
    }
}

- (void)setNavigationBarRightMenu
{
    UIView *navigationRightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
    navigationRightView.backgroundColor = [UIColor clearColor];
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn addTarget:self action:@selector(OnSearch:) forControlEvents:UIControlEventTouchUpInside];
    searchBtn.frame = CGRectMake(52, 0, 40, 40);
    [searchBtn setImage:[UIImage imageNamed:@"right_search_normal"] forState:UIControlStateNormal];
    [navigationRightView addSubview:searchBtn];
    
//    去掉消息中心
    UIButton *messageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [messageBtn addTarget:self action:@selector(OnMessage:) forControlEvents:UIControlEventTouchUpInside];
    messageBtn.frame = CGRectMake(40,0, 40, 40);
    [messageBtn setImage:[UIImage imageNamed:@"message_normal"] forState:UIControlStateNormal];
    messageBtn.imageEdgeInsets = UIEdgeInsetsMake(0,15, 0.0, 0.0);
//    [navigationRightView addSubview:messageBtn];
    
    _msgBadge = [CustomBadge customBadgeWithString:@"0" withStringColor:[UIColor whiteColor] withInsetColor:[CommonFuction colorFromHexRGB:@"ff6666"] withBadgeFrame:YES withBadgeFrameColor:[CommonFuction colorFromHexRGB:@"ff6666"] withScale:0.5 withShining:NO];
    _msgBadge.userInteractionEnabled = NO;
    _msgBadge.backgroundColor = [UIColor clearColor];
    _msgBadge.frame = CGRectMake(69, 5, _msgBadge.frame.size.width, _msgBadge.frame.size.height);
    NSInteger unreadMsgCount = [[MessageCenter shareMessageCenter] unReadCount];
    if (unreadMsgCount == 0)
    {
        _msgBadge.hidden = YES;
    }
    else
    {
        _msgBadge.hidden = NO;
        _msgBadge.badgeText = [NSString stringWithFormat:@"%ld",(long)unreadMsgCount];
    }
    [navigationRightView addSubview:_msgBadge];
    
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithCustomView:navigationRightView];
    self.navigationItem.rightBarButtonItem = rightBtn;
}

- (void)showGiftDialog
{
    UserInfo *currentUserInfo = [UserInfoManager shareUserInfoManager].currentUserInfo;
    if (currentUserInfo == nil)
    {
        return;
    }
    
    if (currentUserInfo.rewards == nil || currentUserInfo.rewards.count == 0)
    {
        return;
    }
    
    _giftDialog = [[EWPSimpleDialog alloc] initWithFrame:CGRectMake(0, 0, 270, 273) showInView:self.view];
    _giftDialog.layer.borderColor = [UIColor whiteColor].CGColor;
    _giftDialog.backgroundColor = [UIColor whiteColor];
    _giftDialog.layer.cornerRadius = 4.0f;
    _giftDialog.layer.borderWidth = 1.0f;
    
    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(225, 5, 40, 40)];
    [closeBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeDialog) forControlEvents:UIControlEventTouchUpInside];
    [_giftDialog addSubview:closeBtn];
    
    UILabel *giftTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 200, 20)];
    giftTipLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    giftTipLabel.textColor = [CommonFuction colorFromHexRGB:@"575757"];
    giftTipLabel.text = @"恭喜您获得友情大礼包";
    [_giftDialog addSubview:giftTipLabel];
    
    UIImageView *hLineImgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 50, 240, 0.5)];
    hLineImgView.backgroundColor = [CommonFuction colorFromHexRGB:@"cbcbcb"];
    [_giftDialog addSubview:hLineImgView];
    
    NSArray *rewards = currentUserInfo.rewards;
    CGFloat nItemWidth = 240.0f/rewards.count;
    for (int nIndex = 0; nIndex < rewards.count; nIndex++)
    {
        CGFloat xPos = 15 + nItemWidth * nIndex;
        GiftItem *giftItem = [[GiftItem alloc] initWithFrame:CGRectMake(xPos, 60, nItemWidth, 90) showInView:_giftDialog];
        giftItem.reward= [rewards objectAtIndex:nIndex];
        [_giftDialog addSubview:giftItem];
    }
    
    UIButton *getGiftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    getGiftBtn.frame = CGRectMake(60, 171, 148, 31);
    [getGiftBtn setTitle:@"收礼" forState:UIControlStateNormal];
    getGiftBtn.layer.masksToBounds = YES;
    getGiftBtn.layer.cornerRadius = 15.5;
    getGiftBtn.layer.borderWidth = 1;
    getGiftBtn.layer.borderColor = [CommonFuction colorFromHexRGB:@"d14c49"].CGColor;
    [getGiftBtn setTitleColor:[CommonFuction colorFromHexRGB:@"d14c49"] forState:UIControlStateNormal];
    getGiftBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    [getGiftBtn addTarget:self action:@selector(getGift) forControlEvents:UIControlEventTouchUpInside];
    [_giftDialog addSubview:getGiftBtn];
    
    UIImageView *giftDialogBK = [[UIImageView alloc] initWithFrame:CGRectMake(0, 273 - 65.5, 270, 65.5)];
    giftDialogBK.image = [UIImage imageNamed:@"giftdialogBK"];
    [_giftDialog addSubview:giftDialogBK];
    
    [_giftDialog showInWindow];
    
}
#pragma mark 首页
- (void)OnHome:(id)sender
{
    self.title = @"首页";
    self.scrollView.hidden = YES;
    _tabMenuControl.hidden = NO;
    [_home setImage:[UIImage imageNamed:@"tv-select"] forState:UIControlStateNormal];
    [_activityBtn setImage:[UIImage imageNamed:@"activity_normal"] forState:UIControlStateNormal];
    
}
-(void)ShowLiveBtnOnMain
{
    [self setHeadImg];
}
#pragma mark 开播
-(void)OnLveing
{
    BaseHttpModel *model = [[BaseHttpModel alloc] init];
    [model requestDataWithMethod:ShowLiveBtnOnMobile_Method params:nil success:^(id object)
     {
         
         if (model.result == 0)
         {
             if (model.code == 1)
             {
                 [self OnLive];
             }
             else
             {
                 [self showNoticeInWindow:@"当前开播人数已达上限,请稍候再试!" duration:1.5];
             }
             
         }
     } fail:^(id object)
     {

     }];
    
}
#pragma mark 直播
-(void)OnLive
{
    NSString *iphone = [AppInfo getMachineName];
    if (![iphone isEqualToString :@"iPhone 4S (A1387/A1431)"] && ![iphone isEqualToString:@"iPhone 4 (A1349)"] && ![iphone isEqualToString:@"iPhone 4 (A1332)"])
    {
        self.liveBtn.userInteractionEnabled=NO;
        //code 1 表示可以直播；2表示因为全民直播开关没打开而不能直播；3表示还没同意开播协议(此时手机端需要跳转到协议页面)；4表示已经在开播了，不允许重复开播；5表示当前用户已经同意过协议，但是被平台禁止直播了。
        
        if ([self showLoginDialog])
        {
            return;
        }
        __block CanShowOnMobile *model = [[CanShowOnMobile alloc] init];
        [self requestDataWithAnalyseModel:[CanShowOnMobile class] params:nil success:^(id object) {
            model = object;
            
            if (model.code == 1)
            {
                
                Class viewControllerType = NSClassFromString(LiveRoom_CanVas);
                UIViewController *viewController = [[viewControllerType alloc] init];
                [viewController setValue:@([UserInfoManager shareUserInfoManager].currentUserInfo.userId) forKey:@"staruserid"];
                [self pushViewController:viewController];
                
            }
            else if (model.code == 3)
            {
                
                LiveProtocolViewController *vc = [[LiveProtocolViewController alloc] init];
                [self pushViewController:vc];
            }
            else if(model.code == 2)
            {
                
                [self showNoticeInWindow:@"手机直播未开启" duration:2.0];
            }  else if(model.code == 4)
            {
                
                [self showNoticeInWindow:@"你已经在开播了，不允许重复开播" duration:2.0];
            }  else if(model.code == 5)
            {
                
                [self showNoticeInWindow:@"你已被禁止手机直播" duration:2.0];
            }else{
                
                if (model.code == 403)
                {
                    [[AppInfo shareInstance] loginOut];
                    [self showOherTerminalLoggedDialog];
                    
                    return ;
                }
            }
            if (model.title && [model.title isEqualToString:@"用户没有登陆！"]){
                [self showNoticeInWindow:@"用户没有登陆！" duration:2.0];
            }
            
            self.liveBtn.userInteractionEnabled=YES;
            
        } fail:^(id object) {
            self.liveBtn.userInteractionEnabled=YES;
        }];
    }
    else
    {
        [self showNoticeInWindow:@"您的手机暂时不支持开播功能!" duration:1.5];
    }
}
- (void)pushViewController:(UIViewController *)viewController
{
    [[AppDelegate shareAppDelegate].navigationController pushViewController:viewController animated:YES];
}

#pragma mark  活动
- (void)OnActivity:(id)sender
{
    _hideSwitch = [[[AppInfo shareInstance].hideSwitch substringFromIndex:1] integerValue];
    _hideSwitch2= [[[AppInfo shareInstance].hideSwitch substringToIndex:1] integerValue];

    self.title = @"首页";
    self.scrollView.hidden = NO;
    _tabMenuControl.hidden = YES;
    [_activityBtn setImage:[UIImage imageNamed:@"activity_select"] forState:UIControlStateNormal];
    [_home setImage:[UIImage imageNamed:@"tv-normal"] forState:UIControlStateNormal];
    
    int YOffset = _height + 10;
    
    //    排行
    _rankItemView.frame = CGRectMake(0, YOffset, SCREEN_WIDTH, 43);
    [self.scrollView addSubview:_rankItemView];
    
    //    活动
    if(_hideSwitch != 1)
    {
        YOffset += 43;
        _ictivityItemView.frame = CGRectMake(0, YOffset, SCREEN_WIDTH, 43);
        [self.scrollView addSubview:_ictivityItemView];
        
    }
    if (_hideSwitch2 !=1)
    {
        //   邀请
        YOffset += 43;
        _inviteFriendsView.frame = CGRectMake(0, YOffset, SCREEN_WIDTH, 43);
        [self.scrollView addSubview:_inviteFriendsView];
        
    }
    if(_hideSwitch != 1)
    {
        //    商城
        YOffset += 48;
        _marketView.frame = CGRectMake(0, YOffset, SCREEN_WIDTH, 43);
        [self.scrollView addSubview:_marketView];
    }
    //充值
    YOffset += 43;
    _rechargeView.frame = CGRectMake(0, YOffset, SCREEN_WIDTH, 43);
    [self.scrollView addSubview:_rechargeView];
    
    YOffset += 43;
    _infor.frame = CGRectMake(0, YOffset, SCREEN_WIDTH, 43);
    [self.scrollView addSubview:_infor];
    
    [self OnActivityInfor];

    
    HomePageAdvertModel *model = [[HomePageAdvertModel alloc] init];
    [model requestDataWithParams:nil success:^(id object) {
        if (_advertMary == nil)
        {
            _advertMary = [NSMutableArray array];
        }
        [_advertMary removeAllObjects];
        if (model.result == 0)
        {
            [_advertMary addObjectsFromArray:model.adMarray];
            if ([_advertMary count] == 0) {
                _height = 0.0f;
                return ;
            }
            else
            {
                _height = 180.0f;
                [self OnActivityInfor];

            }
            
            _ewpAdView = [[EWPADView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [ADvertCell height]) placeHolderImg:[UIImage imageNamed:@""] adImgUrlArray:nil adBlock:^(int nIndex)
                {
                              [self  indexOfAdImg:nIndex];
                }];
            [self.scrollView addSubview:_ewpAdView];
            [self setAdImgUrlArray:_advertMary];
            
        }else if (model.code == 403){
            [self showOherTerminalLoggedDialog];
        }
        
    } fail:^(id object) {
        
    }];
    
}
-(void)OnActivityInfor
{
    int YOffset = _height + 10;

    _rankItemView.frame = CGRectMake(0,YOffset, SCREEN_WIDTH, 43);
    if(_hideSwitch != 1)
    {
        YOffset += 43;
        _ictivityItemView.frame = CGRectMake(0, YOffset, SCREEN_WIDTH, 43);
    }
    if (_hideSwitch2 !=1)
    {
        YOffset += 43;
        _inviteFriendsView.frame = CGRectMake(0, YOffset, SCREEN_WIDTH, 43);

    }
    if(_hideSwitch != 1)
    {
        YOffset += 48;
        _marketView.frame = CGRectMake(0, YOffset, SCREEN_WIDTH, 43);

    }
    YOffset += 43;
    _rechargeView.frame = CGRectMake(0, YOffset, SCREEN_WIDTH, 43);
    YOffset += 47;
    _infor.frame = CGRectMake(10, YOffset, SCREEN_WIDTH, 29);

    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH ,_height + 144 + 196);

}

- (void)RankItem:(id)sender
{
    [self pushCanvas:Rank_Canvas withArgument:nil];
}
-(void)ActivityItem:(id)sender
{
    [self pushCanvas:Activity_Canvas withArgument:nil];
}
-(void)InviteFriends:(id)sender
{
    [self pushCanvas:Invite_Canvas withArgument:nil];
}
-(void)Market:(id)sender
{
    [self pushCanvas:Mall_Canvas withArgument:nil];
}
-(void)Recharge:(id)sender
{
    //跳转到充值
    if (![AppInfo shareInstance].bLoginSuccess)
    {     
        if ([self showLoginDialog])
        {
            return;
        }

    }
    else
    {
        NSInteger hideSwitch = [[[AppInfo shareInstance].hideSwitch substringToIndex:1] integerValue];
        if (hideSwitch == 1)
        {
            [self pushCanvas:AppStore_Recharge_Canvas withArgument:nil];
        }
        else
        {
            [self pushCanvas:SelectModePay_Canvas withArgument:nil];
            
        }
        
    }
}

#pragma mark 海报视图
-(void)setAdImgUrlArray:(NSMutableArray *)AdImgUrlArray
{
    _AdImgUrlArray = AdImgUrlArray;
    if (AdImgUrlArray)
    {
        NSMutableArray *imgUrlAry = [NSMutableArray array];
        
        for (HomePageAdData *adData in AdImgUrlArray)
        {
            NSString *url = [NSString stringWithFormat:@"%@%@",[AppInfo shareInstance].res_server,adData.imgurl];
            [imgUrlAry addObject:url];
        }
        _ewpAdView.adImgUrlArray = imgUrlAry;
    }
}
#pragma mark 根据海报判断进入界面
- (void) indexOfAdImg:(NSInteger)index
{
    if (_advertMary && _advertMary.count)
    {
        HomePageAdData *adData=[_AdImgUrlArray objectAtIndex:index];        
        if (adData.actiontype == 1)
        {
            //打开一个内嵌webview的页面
            NSMutableDictionary *param = [NSMutableDictionary dictionary];
            if (adData.data)
            {
                [param setObject:adData.data forKey:@"pageurlmobile"];
            }
            if (adData.title)
            {
                [param setObject:adData.title forKey:@"title"];
            }
            
            [self.rootViewController pushCanvas:ActivityUrl_Canvas withArgument:param];
        }
        else if (adData.actiontype == 2)
        {
            //跳转到直播间
            NSDictionary *param = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:[adData.data integerValue]] forKey:@"staruserid"];
            //    [self.rootViewController pushCanvas:ChatRoom_Canvas withArgument:param];
            [self pushCanvas:LiveRoom_CanVas withArgument:param];
        }
        else if (adData.actiontype == 3)
        {
            NSInteger hideSwitch = [[[AppInfo shareInstance].hideSwitch substringFromIndex:1] integerValue];
            if (hideSwitch == 2)
            {//商城显示的时候才可以进入商城界面
                [self pushCanvas:Mall_Canvas withArgument:nil];
            }
        }
        else if (adData.actiontype == 4)
        {
            //跳转到充值
            if (![AppInfo shareInstance].bLoginSuccess)
            {
                if ([self showLoginDialog])
                {
                    return;
                }
            }
            else
            {
                NSInteger hideSwitch = [[[AppInfo shareInstance].hideSwitch substringToIndex:1] integerValue];
                if (hideSwitch == 1)
                {
                    [self pushCanvas:AppStore_Recharge_Canvas withArgument:nil];
                }
                else
                {
                    [self pushCanvas:SelectModePay_Canvas withArgument:nil];
                    
                }
                
            }
        }
        else if (adData.actiontype == 5)
        {
            //跳转到邀请界面
            [self pushCanvas:Invite_Canvas withArgument:nil];
            
        }
        
    }
    
}
//搜索
- (void)OnSearch:(id)sender
{
    [self pushCanvas:Search_Canvas withArgument:nil];
    //      [self pushCanvas:Task_Canvas withArgument:nil];
    
}

//点击消息
- (void)OnMessage:(id)sender
{
    [MessageCenter shareMessageCenter].unReadCount = 0;
    [self pushCanvas:MessageCenter_Canvas withArgument:nil];
}

- (void)loadMenu
{
    [self loadLocolMenu];
    [self loadNetworkMenu];
}

- (void)loadLocolMenu
{
    if (_tabMenuTitles == nil)
    {
        _tabMenuTitles = [NSMutableArray array];
    }
    [_tabMenuTitles removeAllObjects];
    
    CategoryMenu *menuData = [[CategoryMenu alloc] init];
    menuData.categoryId = 0;
    menuData.title = @"推荐";
    [self.tabMenuTitles addObject:menuData];
    
    menuData = [[CategoryMenu alloc] init];
    menuData.categoryId = 0;
    menuData.title = @"关注";
    [self.tabMenuTitles addObject:menuData];
    
}

- (void)loadNetworkMenu
{
    [self requestDataWithAnalyseModel:[GetTwoLevelCategoryModel class] params:nil success:^(id object) {
        GetTwoLevelCategoryModel *model = (GetTwoLevelCategoryModel *)object;
        if (model.result == 0)
        {
            _updateview.hidden = YES;
            NSArray *categoryArray = model.TwoLevelCategoryMArray;
            _location = categoryArray.count + 2;
            for (int nIndex = 0; nIndex < [categoryArray count]; nIndex++)
            {
                TwoLevelCategoryData *categoryData = [categoryArray objectAtIndex:nIndex];
                CategoryMenu *menuData = [[CategoryMenu alloc] init];
                menuData.categoryId = categoryData.categoryId;
                menuData.title = categoryData.name;
                
                [self.tabMenuTitles addObject:menuData];
            }
            [self addOnlineStar];
            [self LoadContentView];
            
        }
        
    } fail:^(id object) {
        [self.tabMenuTitles removeAllObjects];
        _message.text = @"暂无网络～";
        _updateview.hidden = NO;
    }];
}

- (void)addOnlineStar
{
    CategoryMenu *menuData = [[CategoryMenu alloc] init];
    menuData.categoryId = 63;
    menuData.title = @"正在直播";
    
    if ([AppInfo shareInstance].online_stars_location >= 0 && [AppInfo shareInstance].online_stars_location < _location)
    {
        [self.tabMenuTitles insertObject:menuData atIndex:[AppInfo shareInstance].online_stars_location];
    }
    else
    {
        [self.tabMenuTitles addObject:menuData];
    }
    
}

- (void)LoadContentView
{
    if (_contentViewControllerMArray == nil)
    {
        _contentViewControllerMArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    [self.contentViewControllerMArray removeAllObjects];
    
    for (int nIndex = 0; nIndex < [_tabMenuTitles count]; nIndex++)
    {
        ViewController *viewController = nil;
        Class contentViewControllerType = nil;
        
        if (nIndex == 0)
        {
            
            if ([AppInfo shareInstance].online_stars_location==0) {//第一个是正在直播
                [self addCategoryViewControllerWithIndex:nIndex];
            }else{
                contentViewControllerType = NSClassFromString(Recomment_Canvas);
                viewController = (ViewController *)[[contentViewControllerType alloc] init];
                viewController.rootViewController = self;
                [self.contentViewControllerMArray addObject:viewController];
            }
        }
        else if (nIndex == 1)
        {
            if ([AppInfo shareInstance].online_stars_location==0) {
                contentViewControllerType = NSClassFromString(Recomment_Canvas);
                viewController = (ViewController *)[[contentViewControllerType alloc] init];
                viewController.rootViewController = self;
                [self.contentViewControllerMArray addObject:viewController];
            }else if([AppInfo shareInstance].online_stars_location==1){//第二个是正在直播
                [self addCategoryViewControllerWithIndex:nIndex];
            }else{
                contentViewControllerType = NSClassFromString(Attent_Canvas);
                viewController = [[contentViewControllerType alloc] init];
                viewController.rootViewController = self;
                [self.contentViewControllerMArray addObject:viewController];
            }
        }
        else
        {
            if (([AppInfo shareInstance].online_stars_location==1 || [AppInfo shareInstance].online_stars_location==0) && nIndex==2) {//如果正在直播是第一个或者第二个，则第三个是关注
                contentViewControllerType = NSClassFromString(Attent_Canvas);
                viewController = [[contentViewControllerType alloc] init];
                viewController.rootViewController = self;
                [self.contentViewControllerMArray addObject:viewController];
            }
            else{
                [self addCategoryViewControllerWithIndex:nIndex];
            }
            
        }
    }
    //    [_tabMenuControl viewWillAppear];
    [_tabMenuControl reloadData];
    
}

//正在直播，不用传参数
-(void)addCategoryViewControllerWithIndex:(int)nIndex{
    CategoryMenu *menuData = [self.tabMenuTitles objectAtIndex:nIndex];
    StarCategoryViewController *categoryViewController = [[StarCategoryViewController alloc] init];
    categoryViewController.navigationItem.title = menuData.title;
    //    后台配置位置
    if (nIndex == [AppInfo shareInstance].online_stars_location)
    {
        categoryViewController.isOnlineStar = YES;
    }
    //其他正在直播的情况
    else if (nIndex == _location)
    {
        //        数组越界 ［0～7］ 后台配置大于7
        if ([AppInfo shareInstance].online_stars_location >_location) {
            categoryViewController.isOnlineStar = YES;
        }
        //            为负数的情况
        else if( [AppInfo shareInstance].online_stars_location < 0 )
        {
            categoryViewController.isOnlineStar = YES;
        }
        else
        {
            categoryViewController.categoryid = menuData.categoryId;
            categoryViewController.isOnlineStar = NO;
        }
    }
    else
    {
        categoryViewController.categoryid = menuData.categoryId;
        categoryViewController.isOnlineStar = NO;
    }
    categoryViewController.rootViewController = self;
    
    
    [self.contentViewControllerMArray addObject:categoryViewController];
}
#pragma mark - EWPTabMenuDataSource

- (EWPSegmentedControl *)ewpSegmentedControl
{
    NSMutableArray *menuTitles = [NSMutableArray array];
    for (int nIndex = 0; nIndex < [self.tabMenuTitles count]; nIndex++)
    {
        CategoryMenu *menuData = [self.tabMenuTitles objectAtIndex:nIndex];
        [menuTitles addObject:menuData.title];
    }
    EWPSegmentedControl *segmentedControl = [[EWPSegmentedControl alloc] initWithSectionTitles:menuTitles];
    segmentedControl.frame = CGRectMake(0, 0, self.view.frame.size.width, 36);
    segmentedControl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    segmentedControl.backgroundColor = [UIColor whiteColor];
    segmentedControl.textColor = [CommonFuction colorFromHexRGB:@"575757"];
    segmentedControl.selectionStyle = EWPSegmentedControlSelectionStyleFullWidthStripe;
    segmentedControl.selectionIndicatorLocation = EWPSegmentedControlSelectionIndicatorLocationDown;
    segmentedControl.selectionIndicatorColor = [CommonFuction colorFromHexRGB:@"d14c49"];
    segmentedControl.selectedTextColor = [CommonFuction colorFromHexRGB:@"d14c49"];
    segmentedControl.selectionIndicatorHeight = 1.5f;
    segmentedControl.font = [UIFont systemFontOfSize:14.0f];
    segmentedControl.indicatorBKColor = [UIColor whiteColor];
    return segmentedControl;
}

- (UIViewController *)ewpTabMenuControl:(EWPTabMenuControl *)ewpTabMenuControl tabViewOfindex:(NSInteger)index
{
    ViewController *itemViewController = nil;
    if (self.contentViewControllerMArray && [self.contentViewControllerMArray count] > index)
    {
        itemViewController = [self.contentViewControllerMArray objectAtIndex:index];
    }
    return itemViewController;
}

#pragma mark - EWPTabMenuDelegate

- (void)progressEdgePanGestureRecognizer:(UIPanGestureRecognizer *)panGestureRecognizer tabMenuOfIndex:(NSInteger)index
{
    if (index == 0)
    {
        [[AppDelegate shareAppDelegate].lrSliderMenuViewController moveViewWithGesture:panGestureRecognizer];
    }
    
}

#pragma mark - Observer
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"unReadCount"])
    {
        NSInteger unReadCount = [[change objectForKey:NSKeyValueChangeNewKey] integerValue];
        if (unReadCount == 0)
        {
            _msgBadge.hidden = YES;
        }
        else
        {
            _msgBadge.hidden = NO;
            if (_msgBadge)
            {
                _msgBadge.badgeText = [NSString stringWithFormat:@"%ld",(long)unReadCount];
                [_msgBadge setNeedsDisplay];
            }
        }
    }
    else if([keyPath isEqualToString:@"bLoginSuccess"])
    {
        BOOL bLoginSuccess = [[change objectForKey:NSKeyValueChangeNewKey] boolValue];
        if (bLoginSuccess)
        {
            if (_autoRegistDialog)
            {
                [self hideAutoRegistDialog];
                _autoRegistDialog = nil;
            }
        }
    }
    
}

#pragma mark 连续登录
-(void)showAwaysLoginDialog{
    
    
    BaseHttpModel *model = [[BaseHttpModel alloc] init];
    [model requestDataWithMethod:Loginreward params:nil success:^(id object)
     {
         if (model.result == 0)
         {
             
             
             NSDictionary *dic = (NSDictionary*)model.data;
             
             if (dic && [dic isKindOfClass:[NSDictionary class]] && [dic count])
             {
                 self.dictLoginDialogArray = dic;
                 
                 if ([[self.dictLoginDialogArray objectForKey:@"isFirstRequest"] boolValue] ) {
                  
                     if (self.dataLoginDialogArray) {
                         self.dataLoginDialogArray = nil;
                     }
                     self.dataLoginDialogArray = [NSArray arrayWithArray:[dic objectForKey:@"rewards"] ];
                     
                     [self addLogAwaysView];
                     
                 }
             }
             
         }
     } fail:^(id object)
     {
     }];
    
    
    
}
-(void)addLogAwaysView{
    CGFloat distanceLeft = 20;
    _awaysLoginDialog = [[EWPSimpleDialog alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH , SCREEN_HEIGHT)];
    
    
    UIImageView* imageViewBG = [[UIImageView alloc] initWithFrame:CGRectMake(distanceLeft, 170, SCREEN_WIDTH-distanceLeft*2, (SCREEN_WIDTH-distanceLeft*2)*614/606)];
    imageViewBG.userInteractionEnabled = YES;
    imageViewBG.image = [UIImage imageNamed:@"bglogin.png"];
    [_awaysLoginDialog addSubview:imageViewBG];
    
    UIImageView* imageViewswatsLogo =[[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-186/2, 170-50, 186, 88)];
    imageViewswatsLogo.image = [UIImage imageNamed:@"toplogin.png"];
    [_awaysLoginDialog addSubview:imageViewswatsLogo];
    
    UILabel* labelTitle = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-200/2, CGRectGetMaxY(imageViewswatsLogo.frame), 200, 20)];
    labelTitle.font = [UIFont boldSystemFontOfSize:14];
    labelTitle.textColor = [UIColor whiteColor];
    
    NSMutableAttributedString* attrStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"当前连续登录: %@ 天",[[self.dictLoginDialogArray objectForKey:@"days"] toString]]];
    NSRange redRange = NSMakeRange([attrStr.string rangeOfString:@":"].location+2,1 );
    [attrStr setAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:20],NSForegroundColorAttributeName:[CommonFuction colorFromHexRGB:@"ffea77"]}  range:redRange];
    labelTitle.attributedText = attrStr;
    
    
    labelTitle.textAlignment = NSTextAlignmentCenter;
    [_awaysLoginDialog addSubview:labelTitle];

    
    for (int i =0; i<=6; i++) {
        CGFloat distanceLeftBg1 = 22;
        CGFloat distanceLeftBg2 = 54;
        CGFloat orX = 0;
        CGFloat orY =0;
        
        if (i<=3) {
            orX =   distanceLeftBg1+(imageViewBG.frameWidth-distanceLeftBg1*2-45*4)/3*i+45*i;
            orY = 50;
        }else{
            orX =   distanceLeftBg2+(imageViewBG.frameWidth-distanceLeftBg2*2-45*3)/2*(i-4)+45*(i-4);
            orY = 150;
        }
        
        
        UIImageView* imageViewDayIcon = [[UIImageView alloc]initWithFrame:CGRectMake(orX, orY, 45, 45)];
        NSString *url = [NSString stringWithFormat:@"%@%@",[AppInfo shareInstance].res_server,[[self.dataLoginDialogArray objectAtIndex:i ] valueForKey:@"img"]];
        [imageViewDayIcon sd_setImageWithURL:[[NSURL alloc] initWithString:url] placeholderImage:nil];
        [imageViewBG addSubview:imageViewDayIcon];
        
        UILabel* labelPrice = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 150, 25)];
        labelPrice.textAlignment = NSTextAlignmentCenter;
        //        labelPrice.font = [UIFont boldSystemFontOfSize:11];
        labelPrice.font = [UIFont boldSystemFontOfSize:11];
        labelPrice.textColor = [UIColor whiteColor ];
        
        
        NSMutableAttributedString* attrStr = [[NSMutableAttributedString alloc]initWithString:[[self.dataLoginDialogArray objectAtIndex:i ] valueForKey:@"name"]];
        //        NSRange redRange = NSMakeRange([attrStr.string rangeOfString:@" "].location+1,1 );
        //        [attrStr setAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],NSForegroundColorAttributeName:[CommonFuction colorFromHexRGB:@"ffea77"]}  range:redRange];
        labelPrice.attributedText = attrStr;
        labelPrice.center = CGPointMake(imageViewDayIcon.center.x, imageViewDayIcon.center.y+imageViewDayIcon.frameHeight/2+10);
        [imageViewBG addSubview:labelPrice];
        
        UIButton *rechargeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rechargeBtn.frame = CGRectMake(0, 0, 57, 22);
        rechargeBtn.userInteractionEnabled = NO;
        [rechargeBtn setTitleColor:[CommonFuction colorFromHexRGB:@"ffea77"] forState:UIControlStateNormal];
        
        
        NSString* title = nil;
        if ([[[[self.dictLoginDialogArray objectForKey:@"rewards"] objectAtIndex:i] valueForKey:@"days"] integerValue] < [[self.dictLoginDialogArray objectForKey:@"days"] integerValue]) {
            title = @"已领取";
            
        }else if([[[[self.dictLoginDialogArray objectForKey:@"rewards"] objectAtIndex:i] valueForKey:@"days"] integerValue] == [[self.dictLoginDialogArray objectForKey:@"days"] integerValue]){
            title = @"领取";
            rechargeBtn.layer.cornerRadius = 11;
            rechargeBtn.layer.masksToBounds = YES;
            rechargeBtn.layer.borderColor = [CommonFuction colorFromHexRGB:@"ffea77"].CGColor;
            [rechargeBtn setBackgroundImage:[CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"ffea77"] size:CGSizeMake(57, 22)] forState:UIControlStateNormal];
            rechargeBtn.layer.borderWidth = 1;
            rechargeBtn.userInteractionEnabled = YES;
            
             [rechargeBtn setTitleColor:[CommonFuction colorFromHexRGB:@"d14c49"] forState:UIControlStateNormal];
            
        }else{
            title = [NSString stringWithFormat:@"连登%d天",i+1];
        }
        
        [rechargeBtn setTitle:title forState:UIControlStateNormal];
        rechargeBtn.titleLabel.font = [UIFont boldSystemFontOfSize:13.0f];
        rechargeBtn.center = CGPointMake(labelPrice.center.x, labelPrice.center.y+25);
        rechargeBtn.tag = 100+i;
        [rechargeBtn addTarget:self action:@selector(buttonAwaysLogin:) forControlEvents:UIControlEventTouchUpInside];
        [imageViewBG addSubview:rechargeBtn];
        
    }
    
    UIImageView* yunImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, imageViewBG.frameWidth-imageViewBG.frameWidth*120/606+5, imageViewBG.frameWidth, imageViewBG.frameWidth*120/606)];
    yunImageView.image = [UIImage imageNamed:@"cloudlogin.png"];
    [imageViewBG addSubview:yunImageView];
    
    [_awaysLoginDialog showInView:[UIApplication sharedApplication].keyWindow withColor:[UIColor blackColor] withAlpha:0.7];
}
#pragma mark 点击连续登陆按钮
-(void)buttonAwaysLogin:(UIButton*)sender{
    [self showAlertView:@"温馨提示" message:[NSString stringWithFormat:@"恭喜您获得%@",[[self.dataLoginDialogArray objectAtIndex:sender.tag-100 ] valueForKey:@"name"]] confirm:^(id sender) {
        
    } cancel:nil];
    [self.awaysLoginDialog hide];
}

#pragma mark __自动注册

- (void)autoRegister
{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![defaults objectForKey:@"auto_user"])
    {
        AutoRegistModel *model = [[AutoRegistModel alloc] init];
        [model requestDataWithParams:nil success:^(id object)
         {
             if (model.result == 0)
             {
                 self.autoRegistModel = model;
                 [self performSelector:@selector(showAutoRegistDialog) withObject:nil afterDelay:0.3];
             }
         }
                                fail:^(id object)
         {
             
         }];
    }
}

-(void)showAutoRegistDialog
{
    
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *loginType = [defaults objectForKey:@"loginType"];
    if (loginType)
    {
        return;
    }
    
    _autoRegistDialog = [[EWPSimpleDialog alloc] initWithFrame:CGRectMake(0, 0, 270, 275)];
    _autoRegistDialog.layer.borderColor = [UIColor whiteColor].CGColor;
    _autoRegistDialog.backgroundColor = [UIColor whiteColor];
    _autoRegistDialog.layer.cornerRadius = 4.0f;
    _autoRegistDialog.layer.borderWidth = 1.0f;
    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(225, 5, 40, 40)];
    [closeBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeDialog) forControlEvents:UIControlEventTouchUpInside];
    [_autoRegistDialog addSubview:closeBtn];
    
    CGSize nickSize = [CommonFuction sizeOfString:_autoRegistModel.nick maxWidth:135 maxHeight:20 withFontSize:17.0f];
    UILabel *nickLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 200, 20)];
    NSString *nick = [NSString stringWithFormat:@"%@%@",_autoRegistModel.nick,@" 您好！"];
    nickLabel.font = [UIFont systemFontOfSize:16.0f];
    NSMutableAttributedString *rankPosStr = [[NSMutableAttributedString alloc] initWithString:nick];
    NSLog(@"%lu",(unsigned long)[_autoRegistModel.nick length]);
    [rankPosStr addAttribute:NSForegroundColorAttributeName value:[CommonFuction colorFromHexRGB:@"d14c49"] range:NSMakeRange(0,[_autoRegistModel.nick length])];
    nickLabel.attributedText = rankPosStr;
    [_autoRegistDialog addSubview:nickLabel];

    nickLabel.frame = CGRectMake((275-(nickLabel.frame.origin.x + nickSize.width + 20 ))/2, 27, 200, 20);
    
    UIImageView *lineImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, 50, 240, 0.5)];
    lineImg.backgroundColor = [CommonFuction colorFromHexRGB:@"cbcbcb"];
    [_autoRegistDialog addSubview:lineImg];
    
    UILabel *registTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 59, 150, 20)];
    registTipLabel.font = [UIFont systemFontOfSize:14.0f];
    registTipLabel.textColor = [CommonFuction colorFromHexRGB:@"d14c49"];
    registTipLabel.text = @"恭喜你获得新人奖励";
//    [_autoRegistDialog addSubview:registTipLabel];
    
    UIImageView *effectiveTimeImg = [[UIImageView alloc] initWithFrame:CGRectMake(32, 89, 18, 37)];
    effectiveTimeImg.image = [UIImage imageNamed:@"EffectiveDay"];
    [_autoRegistDialog addSubview:effectiveTimeImg];
    
    UIImageView *carBgImg = [[UIImageView alloc] initWithFrame:CGRectMake(40, 133, 100, 20.5)];
    carBgImg.image = [UIImage imageNamed:@"carBK"];
    [_autoRegistDialog addSubview:carBgImg];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",[AppInfo shareInstance].res_server,_autoRegistModel.img];
    UIImageView *carImg = [[UIImageView alloc] initWithFrame:CGRectMake(56, 109, 55, 37.5)];
    [carImg sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:nil];
    [_autoRegistDialog addSubview:carImg];
    
    UIImageView *rebiImgView = [[UIImageView alloc] initWithFrame:CGRectMake(156, 109, 61, 57.5)];
    rebiImgView.image = [UIImage imageNamed:@"BoxRebi"];
    [_autoRegistDialog addSubview:rebiImgView];
    
    UILabel *carNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 160, 135, 20)];
    carNameLabel.text = _autoRegistModel.name;
    carNameLabel.textColor = [CommonFuction colorFromHexRGB:@"959596"];
    carNameLabel.font = [UIFont boldSystemFontOfSize:11.0f];
    [_autoRegistDialog addSubview:carNameLabel];
    
    UILabel *rebiLabel = [[UILabel alloc] initWithFrame:CGRectMake(166, 161, 135, 20)];
    rebiLabel.text = [NSString stringWithFormat:@"热币 × %ld",(long)_autoRegistModel.coin];
    rebiLabel.textColor = [CommonFuction colorFromHexRGB:@"959596"];
    rebiLabel.font = [UIFont boldSystemFontOfSize:11.0f];
    [_autoRegistDialog addSubview:rebiLabel];

    
    UIImage *normalImg = [CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"ffffff"] size:CGSizeMake(100, 32)];
    UIImage *selectImg = [CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"d14c49"] size:CGSizeMake(100, 32)];

    UIButton *openBtn = [[UIButton alloc] initWithFrame:CGRectMake(32, 190, 100, 32)];
    [openBtn setTitle:@"立即登录" forState:UIControlStateNormal];
    openBtn.layer.masksToBounds = YES;
    openBtn.layer.cornerRadius = 16;
    openBtn.layer.borderWidth = 1;
    openBtn.layer.borderColor = [CommonFuction colorFromHexRGB:@"d14c49"].CGColor;
    [openBtn setBackgroundImage:normalImg forState:UIControlStateNormal];
    [openBtn setBackgroundImage:selectImg forState:UIControlStateHighlighted];
    [openBtn setTitleColor:[CommonFuction colorFromHexRGB:@"d14c49"] forState:UIControlStateNormal];
    [openBtn setTitleColor:[CommonFuction colorFromHexRGB:@"ffffff"] forState:UIControlStateHighlighted];
    openBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    [openBtn addTarget:self action:@selector(experience) forControlEvents:UIControlEventTouchUpInside];
    [_autoRegistDialog addSubview:openBtn];
    
    UIImage *selectImg2 = [CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"c34845"] size:CGSizeMake(100, 32)];

    UIButton *accountBtn = [[UIButton alloc] initWithFrame:CGRectMake(138, 190, 100, 32)];
    [accountBtn setTitle:@"其它账号登录" forState:UIControlStateNormal];
    accountBtn.layer.masksToBounds = YES;
    accountBtn.layer.cornerRadius = 16;
    accountBtn.layer.borderWidth = 1;
    accountBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    accountBtn.layer.borderColor = [CommonFuction colorFromHexRGB:@"d14c49"].CGColor;
    [accountBtn setBackgroundImage:selectImg forState:UIControlStateNormal];
    [accountBtn setBackgroundImage:selectImg2 forState:UIControlStateHighlighted];
    [accountBtn setTitleColor:[CommonFuction colorFromHexRGB:@"ffffff"] forState:UIControlStateNormal];
    [accountBtn addTarget:self action:@selector(loginClick) forControlEvents:UIControlEventTouchUpInside];
    [_autoRegistDialog addSubview:accountBtn];
    
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 240, 100, 20)];
    tipLabel.text = @"第三方登录 :";
    tipLabel.font = [UIFont systemFontOfSize:13.0f];
    tipLabel.textColor = [CommonFuction colorFromHexRGB:@"575757"];
    [_autoRegistDialog addSubview:tipLabel];
    
    UIButton *QQBtn = [[UIButton alloc] initWithFrame:CGRectMake(170, 240, 21, 21)];
    [QQBtn setImage:[UIImage imageNamed:@"qqIcon"] forState:UIControlStateNormal];
    [QQBtn addTarget:self action:@selector(loginWithQQ) forControlEvents:UIControlEventTouchUpInside];
    
    NSInteger hideSwitch = [[[AppInfo shareInstance].hideSwitch substringToIndex:1] integerValue];
    if (hideSwitch != 1)
    {
        [_autoRegistDialog addSubview:QQBtn];
    }
    
    UIButton *WXBtn = [[UIButton alloc] initWithFrame:CGRectMake(200, 240, 21, 21)];
    [WXBtn setImage:[UIImage imageNamed:@"wxIcon"] forState:UIControlStateNormal];
    [WXBtn addTarget:self action:@selector(loginWithWx) forControlEvents:UIControlEventTouchUpInside];
    if (hideSwitch != 1)
    {
        [_autoRegistDialog addSubview:WXBtn];
    }
    
    
    UIButton *sinaWeiboBtn = [[UIButton alloc] initWithFrame:CGRectMake(230, 240, 21, 21)];
    [sinaWeiboBtn setImage:[UIImage imageNamed:@"sinaIcon"] forState:UIControlStateNormal];
    [sinaWeiboBtn addTarget:self action:@selector(loginWithSina) forControlEvents:UIControlEventTouchUpInside];
    if (hideSwitch != 1)
    {
        [_autoRegistDialog addSubview:sinaWeiboBtn];
    }
    
    [_autoRegistDialog showInWindow];
}

-(void)closeDialog
{
    if (_autoRegistDialog)
    {
        [self experience];
    }
    
    [self setHeadImg];

    if (_giftDialog)
    {
        UserInfo *currentUserInfo = [UserInfoManager shareUserInfoManager].currentUserInfo;
        if (currentUserInfo)
        {
            currentUserInfo.rewards = nil;
        }
        
        [_giftDialog hide];
        _giftDialog = nil;
    }
    [self.tableView reloadData];

//     [self setNavigationBarLeftItem:nil itemNormalImg:[UIImage imageNamed:@"default_photo"] itemHighlightImg:nil withBlock:^(id sender)
//    {
//    
//     }];
    

}

- (void)getGift
{
    if (_giftDialog)
    {
        UserInfo *currentUserInfo = [UserInfoManager shareUserInfoManager].currentUserInfo;
        if (currentUserInfo)
        {
            currentUserInfo.rewards = nil;
        }
        
        [_giftDialog hide];
        _giftDialog = nil;
    }
    
}

-(void)experience
{
    if ([AppInfo shareInstance].bLoginSuccess) {
        [self showAwaysLoginDialog];
    }
    
    UserInfo *currentUserInfo = [[UserInfo alloc] init];
    currentUserInfo.userId = _autoRegistModel.userid;
    currentUserInfo.loginname = _autoRegistModel.loginname;
    currentUserInfo.nick = _autoRegistModel.nick;
    currentUserInfo.password = _autoRegistModel.password;
    currentUserInfo.passwordnotset = _autoRegistModel.passwordnotset;
    currentUserInfo.idxcode = _autoRegistModel.idxcode;
    currentUserInfo.isstar = _autoRegistModel.isstar;
    currentUserInfo.issupermanager = _autoRegistModel.issupermanager;
    currentUserInfo.sex = _autoRegistModel.sex;
    currentUserInfo.photo = _autoRegistModel.photo;
    currentUserInfo.coin = _autoRegistModel.coin;
    currentUserInfo.isPurpleVip = _autoRegistModel.isPurpleVip;
    currentUserInfo.isYellowVip = _autoRegistModel.isYellowVip;
    currentUserInfo.consumerlevelweight = [UserInfo switchConsumerlevelweight:_autoRegistModel.consumerlevelweight];//_autoRegistModel.consumerlevelweight;
    currentUserInfo.token = _autoRegistModel.token;
    //根据umeng 后台需要绑定设备别名
    NSString *strUserId = [NSString stringWithFormat:@"%ld",(long)_autoRegistModel.userid];
    [UMessage addAlias:strUserId type:@"userid" response:^(id responseObject, NSError *error) {
    }];
    
    [UserInfoManager shareUserInfoManager].currentUserInfo = currentUserInfo;
    [[AppInfo shareInstance] saveLogin:_autoRegistModel.loginname password:_autoRegistModel.password loginType:3 autoRegistUser:YES];
    
    
    [self hideAutoRegistDialog];
}

-(void)loginClick
{
    [AppDelegate shareAppDelegate].isNeedReturnLiveRoom = YES;
    if ([[AppDelegate shareAppDelegate].lrSliderMenuViewController isShowingLeftMenu])
    {
        [AppDelegate shareAppDelegate].showingLeftMenu = YES;
    }
    
    [self hideAutoRegistDialog];
    [[AppDelegate shareAppDelegate].lrSliderMenuViewController closeSliderMenu];
    NSString *className = NSStringFromClass([self class]);
    NSDictionary *param = [NSDictionary dictionaryWithObject:className forKey:@"className"];
    [self pushCanvas:Login_Canvas withArgument:param];
}

- (void)hideAutoRegistDialog
{
    [_autoRegistDialog hide];
    
    
}

- (void)loginWithQQ
{
    [self hideAutoRegistDialog];
    
    BOOL isOauth = [UMSocialAccountManager isOauthWithPlatform:UMShareToQzone];
    if (isOauth)
    {
        [[UMSocialDataService defaultDataService] requestSocialAccountWithCompletion:^(UMSocialResponseEntity *response){
            if (response.responseCode == UMSResponseCodeSuccess)
            {
                NSDictionary *snsAccountDic = [UMSocialAccountManager socialAccountDictionary];
                UMSocialAccountEntity *qqAccount = [snsAccountDic valueForKey:UMShareToQzone];
                
                if (qqAccount)
                {
                    [self startAnimating];
                    [[AppInfo shareInstance] loginWithAccount:qqAccount.usid nick:qqAccount.userName token:qqAccount.accessToken type:1 success:^{
                        [self stopAnimating];
                        [self popCanvasWithArgment:[NSDictionary dictionaryWithObject:Login_Canvas forKey:@"CanvasName"]];
                        if ([AppInfo shareInstance].bLoginSuccess) {
                            [self showAwaysLoginDialog];
                        }
                    } fail:^(NSString *erroMessage) {
                        [self stopAnimating];
                        [self showNoticeInWindow:@"登录失败"];
                    }];
                }
                
                
            }
        }];
    }
    else
    {
        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQzone];
        if (snsPlatform == nil)
        {
            return;
        }
        snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response)
                                      {
                                          [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToQQ completion:^(UMSocialResponseEntity *respose){
                                              if (response.responseCode == UMSResponseCodeSuccess)
                                              {
                                                  NSDictionary *snsAccountDic = [UMSocialAccountManager socialAccountDictionary];
                                                  UMSocialAccountEntity *qqAccount = [snsAccountDic valueForKey:UMShareToQzone];
                                                  
                                                  if (qqAccount)
                                                  {
                                                      [self startAnimating];
                                                      [[AppInfo shareInstance] loginWithAccount:qqAccount.usid nick:qqAccount.userName token:qqAccount.accessToken type:1 success:^{
                                                          [self stopAnimating];
                                                          [self popCanvasWithArgment:[NSDictionary dictionaryWithObject:Login_Canvas forKey:@"CanvasName"]];
                                                          
                                                          
                                                          if ([AppInfo shareInstance].bLoginSuccess) {
                                                              [self showAwaysLoginDialog];
                                                          }
                                                      } fail:^(NSString *erroMessage) {
                                                          [self stopAnimating];
                                                          [self showNoticeInWindow:@"登录失败"];
                                                      }];
                                                  }
                                                  
                                              }
                                          }];
                                          
                                      });
    }
    
}

- (void)loginWithWx
{
    if (![WXApi isWXAppInstalled])
    {
        EWPAlertView *alertView = [[EWPAlertView alloc] initWithTitle:@"提示" message:@"未检测到微信客户端,是否现在安装" leftBtnTitle:@"暂不安装" rightBtnTitle:@"马上安装" clickBtnBlock:^(NSInteger nIndex) {
            if (nIndex == 0)
            {
                
            }
            else if(nIndex == 1)
            {
                [self hideAutoRegistDialog];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[WXApi getWXAppInstallUrl]]];
            }
        }];
        [alertView show];
        return;
    }
    
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession];
    if (snsPlatform == nil)
    {
        return;
    }
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response)
                                  {
                                      NSLog(@"login response is %@",response);
                                      //          获取微博用户名、uid、token等
                                      if (response.responseCode == UMSResponseCodeSuccess) {
                                          UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToWechatSession];
                                          NSLog(@"username is %@, uid is %@, token is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken);
                                          
                                          if (snsAccount)
                                          {
                                              [self startAnimating];
                                              [[AppInfo shareInstance] loginWithAccount:snsAccount.usid nick:snsAccount.userName token:snsAccount.accessToken type:3 success:^{
                                                  [self stopAnimating];
                                                  
                                                  [self popCanvasWithArgment:[NSDictionary dictionaryWithObject:Login_Canvas forKey:@"CanvasName"]];
                                                  if ([AppInfo shareInstance].bLoginSuccess) {
                                                      [self showAwaysLoginDialog];
                                                  }
                                              } fail:^(NSString *erroMessage)
                                               {
                                                   [self stopAnimating];
                                                   [self showNoticeInWindow:@"登录失败"];
                                               }];
                                          }
                                          
                                      }
                                      //这里可以获取到腾讯微博openid,Qzone的token等
                                      /*
                                       if ([platformName isEqualToString:UMShareToTencent]) {
                                       [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToTencent completion:^(UMSocialResponseEntity *respose){
                                       NSLog(@"get openid  response is %@",respose);
                                       }];
                                       }
                                       */
                                  });
}


- (void)loginWithSina
{
    [self hideAutoRegistDialog];
    
    BOOL isOauth = [UMSocialAccountManager isOauthWithPlatform:UMShareToSina];
    if (isOauth)
    {
        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
        if (snsPlatform == nil)
        {
            return;
        }
        snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
            if (response.responseCode == UMSResponseCodeSuccess)
            {
                NSDictionary *snsAccountDic = [UMSocialAccountManager socialAccountDictionary];
                UMSocialAccountEntity *sinaAccount = [snsAccountDic valueForKey:UMShareToSina];
                
                if (sinaAccount)
                {
                    [self startAnimating];
                    [[AppInfo shareInstance] loginWithAccount:sinaAccount.usid nick:sinaAccount.userName token:sinaAccount.accessToken type:2 success:^{
                        [self stopAnimating];
                        [self popCanvasWithArgment:[NSDictionary dictionaryWithObject:Login_Canvas forKey:@"CanvasName"]];
                        if ([AppInfo shareInstance].bLoginSuccess) {
                            [self showAwaysLoginDialog];
                        }
                    } fail:^(NSString *erroMessage) {
                        [self stopAnimating];
                        [self showNoticeInWindow:@"登录失败"];
                    }];
                }
                
            }
        });
    }
    else
    {
        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
        if (snsPlatform == nil)
        {
            return;
        }
        snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response)
                                      {
                                          [[UMSocialDataService defaultDataService] requestSocialAccountWithCompletion:^(UMSocialResponseEntity *accountResponse){
                                              if (accountResponse.responseCode == UMSResponseCodeSuccess)
                                              {
                                                  NSDictionary *snsAccountDic = [UMSocialAccountManager socialAccountDictionary];
                                                  UMSocialAccountEntity *sinaAccount = [snsAccountDic valueForKey:UMShareToSina];
                                                  
                                                  if (sinaAccount)
                                                  {
                                                      [self startAnimating];
                                                      [[AppInfo shareInstance] loginWithAccount:sinaAccount.usid nick:sinaAccount.userName token:sinaAccount.accessToken type:2 success:^{
                                                          [self stopAnimating];
                                                          [self popCanvasWithArgment:[NSDictionary dictionaryWithObject:Login_Canvas forKey:@"CanvasName"]];
                                                          if ([AppInfo shareInstance].bLoginSuccess) {
                                                              [self showAwaysLoginDialog];
                                                          }
                                                      } fail:^(NSString *erroMessage) {
                                                          [self stopAnimating];
                                                          [self showNoticeInWindow:@"登录失败"];
                                                      }];
                                                  }
                                                  
                                              }
                                          }];
                                          
                                      });
    }
    
}

#pragma mark - 监测版本升级

- (void)checkVersion
{
    [MobClick updateOnlineConfig];
    if ([self respondsToSelector:@selector(onlineflagComplete)])
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onlineflagComplete) name:UMOnlineConfigDidFinishedNotification object:nil];
    }
}

- (void)onlineflagComplete
{
    NSString *appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    [MobClick setAppVersion:appVersion];
    [MobClick checkUpdateWithDelegate:self selector:@selector(checkUpdateWithDictionary:)];
}

- (void)checkUpdateWithDictionary:(NSDictionary *)dictionary
{
    if ([AppInfo shareInstance].bLoginSuccess) {
        [self showAwaysLoginDialog];
    }
    
    
    BOOL update = [[dictionary objectForKey:@"update"] boolValue];
    if (update)
    {
        NSString *version = [dictionary objectForKey:@"version"];
        NSString *current_version = [dictionary objectForKey:@"current_version"];
        if (version && current_version)
        {
            if (![version isEqualToString:current_version])
            {
                NSString *upgrade = [MobClick getConfigParams:@"upgrade"];
                NSArray *upgradeParams = [upgrade objectFromJSONString];
                for (NSDictionary *upgradeParam in upgradeParams)
                {
                    if ([upgradeParam isKindOfClass:[upgradeParam class]])
                    {
                        NSString *filterVersion = [upgradeParam objectForKey:@"version"];
                        
                        if ([version isEqualToString:filterVersion])
                        {
                            NSString *update_log = [dictionary objectForKey:@"update_log"];
                            NSString *path = [dictionary objectForKey:@"path"];
                            NSString *mode = [upgradeParam objectForKey:@"mode"];
                            [self showUpgradeDialogWithVersion:version upgradeLog:update_log mode:mode path:path];
                            break;
                        }
                    }
                }
            }
        }
    }
    else
    {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *loginType = [defaults objectForKey:@"loginType"];
        if (!loginType)
        {
            [self autoRegister];
        }else{
            //                if ([AppInfo shareInstance].bLoginSuccess) {
            //                      [self showAwaysLoginDialog];
            //                }
        }
    }
}

//mode为F代表强制更新；mode为S代表非强制更新
- (void)showUpgradeDialogWithVersion:(NSString *)version upgradeLog:(NSString *)upgradeLog mode:(NSString *)mode path:(NSString *)path
{
    if (version && mode && path)
    {
        [AppInfo shareInstance].upgradeVersion = version;
        [AppInfo shareInstance].upgradePath = path;
        [AppInfo shareInstance].upgradeLog = upgradeLog;
        
        NSString *title = @"[升级提醒]";
        if ([mode isEqualToString:@"F"])
        {
            //强制更新
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:upgradeLog delegate:self cancelButtonTitle:nil otherButtonTitles:@"马上升级", nil];
            alertView.delegate = self;
            alertView.tag = 1;
            [alertView show];
        }
        else if ([mode isEqualToString:@"S"])
        {
            //非强制更新
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:upgradeLog delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"马上升级", nil];
            alertView.delegate = self;
            alertView.tag = 2;
            [alertView show];
        }
    }
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1)
    {
        //强制更新
        if (buttonIndex == 0)
        {
            
            //马上升级
            NSURL *url = [NSURL URLWithString:[AppInfo shareInstance].upgradePath];
            [[UIApplication sharedApplication] performSelectorOnMainThread:@selector(openURL:) withObject:url waitUntilDone:NO];
        }
        
    }
    else if (alertView.tag == 2)
    {
        //非强制更新
        if (buttonIndex == 0)
        {
            //取消
            [self autoRegister];
        }
        else
        {
            //马上升级
            NSURL *url = [NSURL URLWithString:[AppInfo shareInstance].upgradePath];
            [[UIApplication sharedApplication] performSelectorOnMainThread:@selector(openURL:) withObject:url waitUntilDone:NO];
        }
    }
}
-(void)showOherTerminal{
    [self showOherTerminalLoggedDialog];
}

@end
