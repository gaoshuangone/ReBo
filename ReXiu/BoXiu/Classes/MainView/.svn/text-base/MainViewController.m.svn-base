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
#import "GetUserInfoModel.h"
#import "HideRechargeMenuModel.h"
#import "GetSystemTimeModel.h"
#import "AppManager.h"
#import "GifView.h"
#import "GetSystemTimeModel.h"

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
@property (nonatomic,strong) UILabel *activityLable;
@property (nonatomic,strong) UILabel *livelable;
@property (nonatomic,strong) UIView *updateview;
@property (nonatomic,strong) UILabel *message;
@property (nonatomic,strong) UITapGestureRecognizer *upinfor;
@property (nonatomic,strong) UIView *liveStateview;
@property (nonatomic,strong) UIView *headView;
@property (nonatomic,strong) EWPButton *headBtn;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIView *navigationRightView;
@property (nonatomic,strong) UIView *line;

@property (nonatomic,strong) UIActivityIndicatorView *indicator;
@property (nonatomic,assign) NSInteger timernumber;
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,strong) GifView* gifView;
@property (nonatomic,strong) EWPButton *buttonGif;

@property (nonatomic, assign) BOOL showhead;
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

-(void) motionEnded:(UIEventSubtype)motion withEvent:(UIEvent*)event
{
    //摇动结束
    BOOL isTestVersion = [[[NSBundle mainBundle] objectForInfoDictionaryKey:@"Test_Version"] boolValue];
    if (isTestVersion)
    {
        if(event.subtype== UIEventSubtypeMotionShake) {
            [self pushCanvas:ChangeServer_Canvas withArgument:nil];
        }
    }
    
}
-(BOOL)canBecomeFirstResponder
{// 默认值是 NO
    //添加摇晃监测
    BOOL isTestVersion = [[[NSBundle mainBundle] objectForInfoDictionaryKey:@"Test_Version"] boolValue];
    if (isTestVersion)
    {
        
        return YES;
    }
    return NO;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    //监测版本升级
    [self performSelector:@selector(checkVersion) withObject:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getUserInfo) name:@"getUserInfo" object:nil];//获取个人中心数据缓存
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setHeadImg) name:@"refashHead" object:nil];//没有获取系统参数之前，会用默认的头像地址
    //    设置状态栏的颜色
    UIView *statusBarView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
    statusBarView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:statusBarView];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    
    _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, 60, 44)];
    _headBtn = [EWPButton buttonWithType:UIButtonTypeCustom];
    [_headBtn setBackgroundImage :[UIImage imageNamed:@"leftBtn_normal"] forState:UIControlStateNormal];
    _navigationRightView= [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width-40, 20,55,44)];
    [self setHeadImg];
    
    _line = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 0.6)];
    _line.backgroundColor = [CommonFuction colorFromHexRGB:@"959596" alpha:0.2];
    [self.view addSubview:_line];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 18, self.view.frame.size.width-85, 46)];
    _titleLabel.text = @"活动";
    _titleLabel.font = [UIFont systemFontOfSize:17.0f];
    _titleLabel.textColor = [CommonFuction colorFromHexRGB:@"454a4d"];
    _titleLabel.backgroundColor = [UIColor whiteColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview: _titleLabel];
    _titleLabel.hidden = YES;
    
    //初始化:
    _indicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2, 80, 80)];
    _indicator.tag = 103;
    //设置显示样式,见UIActivityIndicatorViewStyle的定义
    _indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    //设置背景色
    _indicator.backgroundColor = [UIColor blackColor];
    //设置背景透明
    _indicator.alpha = 0.5;
    //设置背景为圆角矩形
    _indicator.layer.cornerRadius = 6;
    _indicator.layer.masksToBounds = YES;
    //设置显示位置
    [_indicator setCenter:CGPointMake(self.view.frame.size.width / 2.0, self.view.frame.size.height / 2.0)];
    
    
    // Do any additional setup after loading the view.ee
    self.bFirstViewWillAppear = YES;
    [[NSNotificationCenter defaultCenter ]addObserver:self selector:@selector(showOherTerminal) name:@"showOherTerminalLoggedDialog" object:nil];
    
    _tabMenuControl = [[EWPTabMenuControl alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, self.view.frame.size.height)];
    _tabMenuControl.dataSource = self;
    _tabMenuControl.delegate = self;
    _tabMenuControl.defaultSelectedSegmentIndex = 1;
    self.tabMenuControl.currentSelectedSegmentIndex = 1;
    [self.view addSubview:_tabMenuControl];
    
    [self activity];
    _headImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _headImageView.layer.masksToBounds = YES;
    [self.view addSubview:_headImageView];
    
#pragma mark 显示下面的标签栏
    _liveStateview = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 52, SCREEN_WIDTH, 52)];
    _liveStateview.backgroundColor = [CommonFuction colorFromHexRGB:@"ffffff"];
    [self.view addSubview:_liveStateview];
    
    UIView *Lineview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.6)];
    Lineview.backgroundColor = [CommonFuction colorFromHexRGB:@"959596"];
    Lineview.alpha = 0.2;
    [_liveStateview addSubview:Lineview];
    
    //直播
    UIView *liveview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 127, 51)];
    liveview.backgroundColor = [UIColor clearColor];
    [_liveStateview addSubview:liveview];
    UITapGestureRecognizer *setinfor = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnHome:)];
    [liveview addGestureRecognizer:setinfor];
    
    _home= [UIButton buttonWithType:UIButtonTypeCustom];
    [_home addTarget:self action:@selector(OnHome:) forControlEvents:UIControlEventTouchUpInside];
    _home.frame = CGRectMake(43, 8, 21, 21);
    [_home setImage:[UIImage imageNamed:@"tv-select"] forState:UIControlStateNormal];
    [liveview addSubview:_home];
    
    _livelable = [[UILabel alloc] initWithFrame:CGRectMake(43, 32, 51, 11)];
    _livelable.text = @"直播";
    _livelable.textColor = [CommonFuction colorFromHexRGB:@"d14c49"];
    _livelable.font = [UIFont boldSystemFontOfSize:10.0f];
    [liveview addSubview:_livelable];
    
    //直播按钮
    _liveBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    [_liveBtn addTarget:self action:@selector(OnLveing) forControlEvents:UIControlEventTouchUpInside];
    _liveBtn.frame = CGRectMake(131, -10, 55, 55);
    [_liveBtn setImage:[UIImage imageNamed:@"live_but"] forState:UIControlStateNormal];
    [_liveStateview addSubview:_liveBtn];
    
    //活动
    UIView *activityview = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 125, 0, 127, 51)];
    activityview.backgroundColor = [UIColor clearColor];
    [_liveStateview addSubview:activityview];
    //view 点击事件
    UITapGestureRecognizer *activityInfor = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnActivity:)];
    [activityview addGestureRecognizer:activityInfor];
    //    button 点击事件
    _activityBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    [_activityBtn addTarget:self action:@selector(OnActivity:) forControlEvents:UIControlEventTouchUpInside];
    _activityBtn.frame = CGRectMake(55, 8, 21, 21);
    [_activityBtn setImage:[UIImage imageNamed:@"activity_normal"] forState:UIControlStateNormal];
    [activityview addSubview:_activityBtn];
    
    _activityLable = [[UILabel alloc] initWithFrame:CGRectMake(55, 32, 51, 11)];
    _activityLable.text = @"活动";
    _activityLable.textColor = [CommonFuction colorFromHexRGB:@"9a9a9a"];
    _activityLable.font = [UIFont boldSystemFontOfSize:10.0f];
    [activityview addSubview:_activityLable];
    
    
    //    [[MessageCenter shareMessageCenter] addObserver:self forKeyPath:@"unReadCount" options:NSKeyValueObservingOptionNew context:nil];
    
    [[AppInfo shareInstance] addObserver:self forKeyPath:@"bLoginSuccess" options:NSKeyValueObservingOptionNew context:nil];
    
    
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showAwaysLoginDialog) name:@"ReLogin" object:nil];
    [self  getUserInfo];
    
    
    
    
    if (![AppManager  valueForKey:@"isFirst"]) {//引导层
        
        
       _gifView = [[GifView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-131)/2-4, SCREEN_HEIGHT-111-6, 131, 111) withTime:0.05 filePath: [[NSBundle mainBundle] pathForResource:@"引导home" ofType:@"gif"]];
        
        
        [self.view addSubview:_gifView];
       
        __weak  GifView* safeGif = _gifView;
        _buttonGif = [[EWPButton alloc]initWithFrame:CGRectMake(0, 0  , SCREEN_WIDTH, SCREEN_HEIGHT)];
        __weak EWPButton* button =_buttonGif;
        _buttonGif.buttonBlock = ^(UIButton* sender){
            [AppManager setUserBoolValue:YES key:@"isFirst"];
            [safeGif removeFromSuperview];
            _gifView = nil;
            [button removeFromSuperview];
       
            
        };

   
        [self.view addSubview:_buttonGif];
    }
    
    
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
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(46, 42, 552/2, 1)];
    lineView.backgroundColor = [CommonFuction colorFromHexRGB:@"eeeeee"];
    [_rankItemView addSubview:lineView];
    _rankItem= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(RankItem:)];
    [_rankItemView addGestureRecognizer:_rankItem];
    
    
    YOffset += 43;
    _ictivityItemView = [[PersonItemView alloc] initWithFrame:CGRectMake(0, YOffset, SCREEN_WIDTH, 43) title:Activity_Title smallImg:[UIImage imageNamed:@"Activity"]];
    _lineView2= [[UIView alloc] initWithFrame:CGRectMake(46, 42, 552/2, 1)];
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
    _lineView3 = [[UIView alloc] initWithFrame:CGRectMake(46, 42, 552/2, 1)];
    _lineView3.backgroundColor = [CommonFuction colorFromHexRGB:@"eeeeee"];
    [_marketView addSubview:_lineView3];
    _market= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Market:)];
    [_marketView addGestureRecognizer:_market];
    
    
    //    充值
    YOffset += 43;
    _rechargeView = [[PersonItemView alloc] initWithFrame:CGRectMake(0, YOffset, SCREEN_WIDTH, 43) title:Recharge_Title smallImg:[UIImage imageNamed:@"RechargeHD"]];
    UITapGestureRecognizer *recharge = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Recharge:)];
    [_rechargeView addGestureRecognizer:recharge];
    
    YOffset += 53;
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
    
    _headView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview: _headView];
    
    _headBtn.backgroundColor = [UIColor grayColor];
    _headBtn.frame = CGRectMake(16, 4, 32, 32);
    _headBtn.layer.cornerRadius = 32/2;
    [_headBtn setClipsToBounds:YES];
    [_headView addSubview:_headBtn];
    
    
    
    _navigationRightView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_navigationRightView];
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn addTarget:self action:@selector(OnSearch:) forControlEvents:UIControlEventTouchUpInside];
    searchBtn.frame = CGRectMake(9, 10, 20, 20);
    [searchBtn setImage:[UIImage imageNamed:@"right_search_normal"] forState:UIControlStateNormal];
    [_navigationRightView addSubview:searchBtn];
    UITapGestureRecognizer *setinfor2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnSearch:)];
    [_navigationRightView addGestureRecognizer:setinfor2];
    
    
    
    [AppDelegate shareAppDelegate].isSelfWillLive = NO;
    self.navigationController.navigationBarHidden = YES;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ShowLiveBtnOnMain) name:@"ShowLiveBtnOnMain" object:nil];
    
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
        //        连续登录
        //        [self showGiftDialog];
        
        if ([AppInfo shareInstance].bLoginSuccess) {
            [self showAwaysLoginDialog];
        }
        [AppInfo shareInstance].bFirstEnterMainView = NO;
    }
    
    NSInteger nCount = self.navigationController.viewControllers.count;
    if (nCount > 1)
    {
        NSMutableArray *viewControllers = [[NSMutableArray alloc] initWithArray:self.navigationController.viewControllers];
        ViewController *viewController = (ViewController *)[viewControllers objectAtIndex:0];
        [viewController removeFromParentViewController];
    }
    
    
    
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

#pragma mark 设置头像
-(void)setHeadImg
{
    __weak typeof(self) safeSelf = self;
    BOOL bLoginSuccess= [AppInfo shareInstance].bLoginSuccess;
    //如果已登录则跳转到跟人信息界面，否则登录界面
    if (bLoginSuccess) {
        
        NSURL *headUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[AppInfo shareInstance].res_server,[UserInfoManager shareUserInfoManager].currentUserInfo.photo]];
        [_headImageView sd_setImageWithURL:headUrl];
        if ([UserInfoManager shareUserInfoManager].currentUserInfo.photo == NULL) {
            [_headBtn setBackgroundImage :[UIImage imageNamed:@"default_photo"] forState:UIControlStateNormal];
            _headBtn.buttonBlock = ^(id sender)
            {
                
             
                if (safeSelf.gifView!= nil) {
                    [safeSelf.gifView removeFromSuperview];
                    safeSelf.gifView = nil;
                    [safeSelf.gifView removeFromSuperview];
                    safeSelf.buttonGif = nil;
                    
                    return ;
                }
                
                [UserInfoManager shareUserInfoManager].tempHederImage = [UIImage imageNamed:@"default_photo"];
                Class viewControllerType = nil;
                viewControllerType = NSClassFromString(PersonInfo_Canvas);
                [safeSelf pushCanvas:PersonInfo_Canvas withArgument:nil];
         
            };
            
        }else{
            
            UIImage* image = nil;
            
            if (_headImageView.image==nil) {
                NSOperationQueue *queue=[NSOperationQueue mainQueue];
                NSURLRequest *request=[NSURLRequest requestWithURL:headUrl];
                [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                    if (data) {
                        
                        [_headBtn setBackgroundImage:[UIImage imageWithData:data] forState:UIControlStateNormal];
                        [UserInfoManager shareUserInfoManager].tempHederImage = [UIImage imageWithData:data];
                    }
                    
                }];
                
                
            }else{
                image = _headImageView.image;
            }
            [_headBtn setBackgroundImage:image forState:UIControlStateNormal];
            _headBtn.buttonBlock = ^(id sender)
            {
                
                if (safeSelf.gifView!= nil) {
                    [safeSelf.gifView removeFromSuperview];
                    safeSelf.gifView = nil;
                    [safeSelf.gifView removeFromSuperview];
                    safeSelf.buttonGif = nil;
                    
                    return ;
                }
                
                
                
                if (image!=nil) {
                     [UserInfoManager shareUserInfoManager].tempHederImage= image;
                }
                
               
                Class viewControllerType = nil;
                viewControllerType = NSClassFromString(PersonInfo_Canvas);
                [safeSelf pushCanvas:PersonInfo_Canvas withArgument:nil];
                
            };
        }
    }
    else
    {
        [_headBtn setBackgroundImage:[UIImage imageNamed:@"leftBtn_normal"]  forState:UIControlStateNormal];
        _headBtn.buttonBlock = ^(id sender)
        {
            if (safeSelf.gifView!= nil) {
                [safeSelf.gifView removeFromSuperview];
                safeSelf.gifView = nil;
                [safeSelf.gifView removeFromSuperview];
                safeSelf.buttonGif = nil;
                
                return ;
            }
            
            Class viewControllerType = nil;
            viewControllerType = NSClassFromString(Login_Canvas);
            [safeSelf pushCanvas:Login_Canvas withArgument:nil];
            
        };
    }
    
    [AppDelegate shareAppDelegate].isNeedReturnLiveRoom = NO;
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    MessageData *currentShowType =  [MessageCenter shareMessageCenter].currentNotifyData;
    [MessageCenter shareMessageCenter].currentNotifyData = nil;
    if (currentShowType != nil)
    {
        if (currentShowType.messageType == 1)
        {
            if (currentShowType.actionLink == 1)
            {
                NSMutableDictionary *param = [NSMutableDictionary dictionary];
                [param setObject:currentShowType.data forKey:@"pageurlmobile"];
                [param setObject:currentShowType.title forKey:@"title"];
                
                
                [self pushCanvas:ActivityUrl_Canvas withArgument:param];
            }
            else if (currentShowType.actionLink == 2)
            {
                NSDictionary *param = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:[currentShowType.data integerValue]] forKey:@"staruserid"];
                [self pushCanvas:LiveRoom_CanVas withArgument:param];
            }
            else if (currentShowType.actionLink == 3)
            {
                NSInteger hideSwitch = [[[AppInfo shareInstance].hideSwitch substringFromIndex:1] integerValue];
                if (hideSwitch == 2)
                {//商城显示的时候才可以进入商城界面
                    
                    [self pushCanvas:Mall_Canvas withArgument:nil];
                }
            }
            else if (currentShowType.actionLink == 4)
            {
                if (![AppInfo shareInstance].bLoginSuccess)
                {
                    
                    [self pushCanvas:Login_Canvas withArgument:nil];
                }
                else
                {
                    
                    [self pushCanvas:SelectModePay_Canvas withArgument:nil];
                }
                
            }
            else if (currentShowType.actionLink == 5)
            {
                //跳转到邀请界面
                
                [self pushCanvas:Invite_Canvas withArgument:nil];
                
            }
        }
        else if (currentShowType.messageType == 2)
        {
            
            [self pushCanvas:PersonInfo_Canvas withArgument:nil];
        }
        else if (currentShowType.messageType == 3)
        {
            NSDictionary *param = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:currentShowType.staruserId] forKey:@"staruserid"];
            
            [self pushCanvas:LiveRoom_CanVas withArgument:param];
        }
        else if (currentShowType.messageType == 4)
        {
            //跳转到充值
            if (![AppInfo shareInstance].bLoginSuccess)
            {
                ViewController *viewController = (ViewController *)self.rootViewController;
                if ([viewController showLoginDialog])
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
        else if (currentShowType.messageType == 5)
        {
            //跳转到邀请界面
            self.isShouldPop = YES;
            [self pushCanvas:Invite_Canvas withArgument:nil];
            
        }
    }
    
}


-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated
{
    
    
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    [self resignFirstResponder];
    
    //    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"ShowLiveBtnOnMain" object:nil];
    //    能否显示左侧菜单栏
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
                //                if ([AppInfo shareInstance].bLoginSuccess) {
                //                    [self showAwaysLoginDialog];
                //                }
            }
            
        }
    }
}

-(void)buttonTest{
    [self pushCanvas:ChangeServer_Canvas withArgument:nil];
}
-(void)close
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
    
    [self loginDialogAlways];
}
#pragma mark 大礼包
- (void)showGiftDialog
{
    if (_giftDialog!=nil) {
        return;
    }
    UserInfo *currentUserInfo = [UserInfoManager shareUserInfoManager].currentUserInfo;
    if (currentUserInfo == nil)
    {
        return;
    }
    [self setHeadImg];
    
    if (currentUserInfo.rewards == nil || currentUserInfo.rewards.count == 0)
    {
        [self close];
        return;
    }
    
    _giftDialog = [[EWPSimpleDialog alloc] initWithFrame:CGRectMake(0, 0, 270, 273) showInView:self.view];
    _giftDialog.layer.borderColor = [UIColor whiteColor].CGColor;
    _giftDialog.backgroundColor = [UIColor whiteColor];
    _giftDialog.layer.cornerRadius = 4.0f;
    _giftDialog.layer.borderWidth = 1.0f;
    
    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(225, 5, 40, 40)];
    [closeBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    [_giftDialog addSubview:closeBtn];
    
    UILabel *giftTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(53, 15, 200, 20)];
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
    
    UIImage *normalImg = [CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"ffffff"] size:CGSizeMake(150, 32)];
    UIImage *selectImg = [CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"d14c49"] size:CGSizeMake(150, 32)];
    
    UIButton *getGiftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    getGiftBtn.frame = CGRectMake(60, 171, 148, 31);
    [getGiftBtn setTitle:@"收礼" forState:UIControlStateNormal];
    getGiftBtn.layer.masksToBounds = YES;
    getGiftBtn.layer.cornerRadius = 15.5;
    getGiftBtn.layer.borderWidth = 1;
    [getGiftBtn setBackgroundImage:normalImg forState:UIControlStateNormal];
    [getGiftBtn setBackgroundImage:selectImg forState:UIControlStateHighlighted];
    getGiftBtn.layer.borderColor = [CommonFuction colorFromHexRGB:@"d14c49"].CGColor;
    [getGiftBtn setTitleColor:[CommonFuction colorFromHexRGB:@"d14c49"] forState:UIControlStateNormal];
    [getGiftBtn setTitleColor:[CommonFuction colorFromHexRGB:@"ffffff"] forState:UIControlStateHighlighted];
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
    _livelable.textColor = [CommonFuction colorFromHexRGB:@"d14c49"];
    _activityLable.textColor = [CommonFuction colorFromHexRGB:@"9a9a9a"];
    self.scrollView.hidden = YES;
    _tabMenuControl.hidden = NO;
    [_home setImage:[UIImage imageNamed:@"tv-select"] forState:UIControlStateNormal];
    [_activityBtn setImage:[UIImage imageNamed:@"activity_normal"] forState:UIControlStateNormal];
    
}
#pragma mark 通知方法，登录后刷新头像
-(void)ShowLiveBtnOnMain
{
    [self setHeadImg];
    
}
#pragma mark 开播
-(void)OnLveing
{
    //开始显示Loading动画
    [_indicator startAnimating];
    [self.view addSubview:_indicator];
    _timer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(timerMethod:) userInfo:nil repeats:YES];
    
    if ([AppInfo shareInstance].network ==0 || ![AppInfo IsEnableConnection])
    {
        [_indicator stopAnimating];
        _timernumber = 1;
        [_timer invalidate];
        [[AppInfo shareInstance] showNoticeInWindow:@"您的网络有问题,请检查网络" duration:1.5];
        return;
    }
    
    _hideSwitch = [[[AppInfo shareInstance].hideSwitch substringFromIndex:1] integerValue];
    
    if ([self showLoginDialog])
    {
        [_indicator stopAnimating];
        _timernumber = 1;
        [_timer invalidate];
        return;
    }
    
    if(_hideSwitch == 1)
    {
        [self showNoticeInWindow:@"开播功能只对签约Star开放" duration:1.5];
        [_indicator stopAnimating];
        _timernumber = 1;
        [_timer invalidate];
        return;
    }
    
    _liveBtn.userInteractionEnabled = NO;
    [self startAnimating];
    BaseHttpModel *model = [[BaseHttpModel alloc] init];
    [model requestDataWithMethod:ShowLiveBtnOnMobile_Method params:nil success:^(id object)
     {
         [self stopAnimating];
         [_indicator stopAnimating];
         _timernumber = 1;
         [_timer invalidate];
         _liveBtn.userInteractionEnabled = YES;
         if (model.result == 0)
         {
             if (model.code == 2)
             {
//                 本地判断是否登录,如果登录了后台告诉我没有登录则是被踢下线
                 if([model.msg isEqualToString:@"没有登录"])
                 {
                     [[AppInfo shareInstance] loginOut];
                     [self showOherTerminalLoggedDialog];
                     return ;
                 }
                 else
                 {
                     [self showNoticeInWindow:@"当前开播人数已达上限,请稍候再试!" duration:1.5];
                 }
             }
             if (model.code == 1)
             {
                 [self OnLive];
                 return ;
             }
             else
             {
                 
                 [self showNoticeInWindow:@"当前开播人数已达上限,请稍候再试!" duration:1.5];
             }
             
         }else{
             [self showNoticeInWindow:@"当前开播人数已达上限,请稍候再试!"  duration:1.5];
             
         }
         
     } fail:^(id object)
     {
         [_indicator stopAnimating];
         _timernumber = 1;
         [_timer invalidate];
         _liveBtn.userInteractionEnabled = YES;
         [self stopAnimating];
     }];
    
}
-(void)timerMethod:(NSTimer *)timer
{
    if (_timernumber == 1) {
        _timernumber = 0;
        return;
    }
    else if (_timernumber ==0)
    {
        [_timer invalidate];
        [_indicator stopAnimating];
        [self showNoticeInWindow:@"未请求到开播数据,请稍候再试!" duration:1.5];
    }else
    {
        
    }
    
}
#pragma mark 直播
-(void)OnLive
{
    NSString *iphone = [AppInfo getMachineName];
    if (![iphone isEqualToString :@"iPhone 4S (A1387/A1431)"] && ![iphone isEqualToString:@"iPhone 4 (A1349)"] && ![iphone isEqualToString:@"iPhone 4 (A1332)"])
    {
        
        //code 1 表示可以直播；2表示因为全民直播开关没打开而不能直播；3表示还没同意开播协议(此时手机端需要跳转到协议页面)；4表示已经在开播了，不允许重复开播；5表示当前用户已经同意过协议，但是被平台禁止直播了。
        
        if ([self showLoginDialog])
        {
            return;
        }
        self.liveBtn.userInteractionEnabled=NO;
        __block CanShowOnMobile *model = [[CanShowOnMobile alloc] init];
        [self requestDataWithAnalyseModel:[CanShowOnMobile class] params:nil success:^(id object) {
            model = object;
            [AppDelegate shareAppDelegate].isSelfWillLive = NO;
            if (model.code == 1)
            {
                
                [AppDelegate shareAppDelegate].isSelfWillLive = YES;
                Class viewControllerType = NSClassFromString(LiveRoom_CanVas);
                UIViewController *viewController = [[viewControllerType alloc] init];
                [viewController setValue:@([UserInfoManager shareUserInfoManager].currentUserInfo.userId) forKey:@"staruserid"];
                
                [self pushViewController:viewController];
                
            }
            else if (model.code == 3)
            {
                
                __block BaseHttpModel *model = [[BaseHttpModel alloc] init];
                [model requestDataWithMethod:SubmitAgreeAllShow params:nil success:^(id object)
                 {
                     model = object;
                     
                     
                     if (model.result == 0 || model.result == 1)
                     {
                         
                         //                         model = object;
                         //                         [AppDelegate shareAppDelegate].isSelfWillLive = NO;
                         //                         [AppDelegate shareAppDelegate].isSelfWillLive = YES;
                         //
                         //                         [stongSelf startLiving];
                         //
                         //                         if (stongSelf.isFrontCamera) {//当为前置摄像头时候关闭闪光灯
                         //                             [stongSelf.openFlashLight setImage:[UIImage imageNamed:@"Star_LiveRoom_lightning_no.png"] forState:UIControlStateNormal];
                         //                             _isFlashOn  = NO;
                         //                         }
                         
                     }
                     
                 } fail:^(id object)
                 {
                     
                     [self showNotice:@"出错了，请重试" duration:2.0f];
                 }];
                
                
                
                [AppDelegate shareAppDelegate].isSelfWillLive = YES;
                Class viewControllerType = NSClassFromString(LiveRoom_CanVas);
                UIViewController *viewController = [[viewControllerType alloc] init];
                [viewController setValue:@([UserInfoManager shareUserInfoManager].currentUserInfo.userId) forKey:@"staruserid"];
                
                [self pushViewController:viewController];
                
                
                //                LiveProtocolViewController *vc = [[LiveProtocolViewController alloc] init];
                //                [self pushViewController:vc];
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
            [self showNoticeInWindow:@"网络连接失败" duration:2.0];
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
        [self showNoticeInWindow:@"网络连接失败，请重试" duration:1.5];
        
    }
    
    
    _titleLabel.hidden = NO;
    
    
    _hideSwitch = [[[AppInfo shareInstance].hideSwitch substringFromIndex:1] integerValue];
    _hideSwitch2= [[[AppInfo shareInstance].hideSwitch substringToIndex:1] integerValue];
    
    self.scrollView.hidden = NO;
    _tabMenuControl.hidden = YES;
    _updateview.hidden = YES;
    _activityLable.textColor = [CommonFuction colorFromHexRGB:@"d14c49"];
    _livelable.textColor = [CommonFuction colorFromHexRGB:@"9a9a9a"];
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
    
    //    充值
    YOffset += 43;
    _rechargeView.frame = CGRectMake(0, YOffset, SCREEN_WIDTH, 43);
    [self.scrollView addSubview:_rechargeView];
    
    YOffset += 48;
    _infor.frame = CGRectMake(0, YOffset, SCREEN_WIDTH, 43);
    [self.scrollView addSubview:_infor];
    
    [self OnActivityInfor];
    
}

-(void)networking
{
    
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
            
            _ewpAdView = [[EWPADView alloc] initWithFrame:CGRectMake(0, 65, SCREEN_WIDTH, [ADvertCell height]) placeHolderImg:[UIImage imageNamed:@""] adImgUrlArray:nil adBlock:^(int nIndex)
                          {
                              [self  indexOfAdImg:nIndex];
                          }];
            [self.scrollView addSubview:_ewpAdView];
            [self setAdImgUrlArray:_advertMary];
            
        }else if (model.code == 403){
            [[AppInfo shareInstance] loginOut];
            [self showOherTerminalLoggedDialog];
        }
        
    } fail:^(id object) {
        
    }];
    
}
-(void)OnActivityInfor
{
    _liveStateview.frame = CGRectMake(0, SCREEN_HEIGHT - 56, SCREEN_WIDTH, 52);
    
    int YOffset = _height + 76;
    
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
    YOffset += 48;
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
            if (!adData.data) {
                return;
            }
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
            
            [self pushCanvas:ActivityUrl_Canvas withArgument:param];
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
            if (_hideSwitch != 1)
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
            if (_hideSwitch2 !=1)
            {
                //跳转到邀请界面
                [self pushCanvas:Invite_Canvas withArgument:nil];
            }
        }
        
    }
    
}
//搜索
- (void)OnSearch:(id)sender
{
    if (self.gifView!= nil) {
        [self.gifView removeFromSuperview];
        self.gifView = nil;
        [self.gifView removeFromSuperview];
        self.buttonGif = nil;
        
        return ;
    }
    [self pushCanvas:Search_Canvas withArgument:nil];
    
}

//点击消息
- (void)OnMessage:(id)sender
{
    [self pushCanvas:MessageCenter_Canvas withArgument:nil];
}

- (void)loadMenu
{
    [self loadLocolMenu];
    [self loadNetworkMenu];
}
+ (void)initConfigInfo
{
    if ([AppInfo shareInstance].first) {
        return;
    }
    //初始化消息中心，登录成功装在消息
    [AppInfo shareInstance].messageCenter =  [MessageCenter shareMessageCenter];
    
    if([AppInfo shareInstance].initCoinfigState == 2)
    {
        return;
    }
    
    [AppInfo shareInstance].initCoinfigState = 1;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        GetConfigModel *getConfigModel = [[GetConfigModel alloc] init];
        [getConfigModel requestDataWithParams:nil success:^(id sender){
            if (getConfigModel.result ==  0)
            {
                [AppInfo shareInstance].first = YES;
                [AppInfo shareInstance].initCoinfigState = 2;//初始化完成
                
                [AppInfo shareInstance].res_server = getConfigModel.res_server;
                long time = getConfigModel.heart_time/1000;
                [AppInfo shareInstance].online_stars_location = getConfigModel.online_stars_location;
                if (time != 0)
                {
                    [AppInfo shareInstance].heart_time = time;
                }
                [[NSNotificationCenter defaultCenter] postNotificationName:@"refashHead" object:nil];
                
            }
            else
            {
                [AppInfo shareInstance].initCoinfigState = 0;
            }
        }
                                         fail:^(id sender)
         {
             [AppInfo shareInstance].initCoinfigState = 0;
         }];
        
        
        
    });
    
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        HideRechargeMenuModel *model = [[HideRechargeMenuModel alloc] init];
        [model requestDataWithParams:nil success:^(id object) {
            if (model.result == 0)
            {
                long hide = [model.hideSwitch length];
                if (hide >1) {
                    [AppInfo shareInstance].hideSwitch = model.hideSwitch;
                }
            }
            
        } fail:^(id object) {
            [[AppInfo shareInstance] showNoticeInWindow:@"网络连接失败，请重试" duration:1.5];
            
        }];
        
    });

#pragma  mark 获取服务器时间
    GetSystemTimeModel *timermodel= [[GetSystemTimeModel alloc] init];
    [timermodel requestDataWithParams:nil success:^(id object) {
        [AppInfo shareInstance].nowtimesMillis = timermodel.systemTime;
        NSDate *TimeDate = [NSDate dateWithTimeIntervalSince1970:(timermodel.systemTime/1000)];
        [AppInfo shareInstance].nowtimes = TimeDate;
        
        NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]];
        long long nowtime = [timeSp longLongValue];
        [AppInfo shareInstance].timerMillis = (timermodel.systemTime/1000 - nowtime);
        
    } fail:^(id object) {
        
    }];
  
}

#pragma  mark 添加标题头的 名称
- (void)loadLocolMenu
{
    if (_tabMenuTitles == nil)
    {
        _tabMenuTitles = [NSMutableArray array];
    }
    [_tabMenuTitles removeAllObjects];
    
    CategoryMenu *menuData = [[CategoryMenu alloc] init];
    menuData.categoryId = 0;
    menuData.title = @"关注";
    [self.tabMenuTitles addObject:menuData];
    
    menuData = [[CategoryMenu alloc] init];
    menuData.categoryId = 0;
    menuData.title = @"推荐";
    [self.tabMenuTitles addObject:menuData];
    
    menuData = [[CategoryMenu alloc] init];
    menuData.categoryId = 63;
    menuData.title = @"最新";
    [self.tabMenuTitles addObject:menuData];
    
    menuData = [[CategoryMenu alloc] init];
    menuData.categoryId = 63;
    menuData.title = @"预告";
    [self.tabMenuTitles addObject:menuData];
    
}

- (void)loadNetworkMenu
{
    [self LoadContentView];
    
    
    //    [self requestDataWithAnalyseModel:[GetTwoLevelCategoryModel class] params:nil success:^(id object) {
    //        GetTwoLevelCategoryModel *model = (GetTwoLevelCategoryModel *)object;
    //        if (model.result == 0)
    //        {
    //            _updateview.hidden = YES;
    //            NSArray *categoryArray = model.TwoLevelCategoryMArray;
    //            _location = categoryArray.count + 2;
    //            for (int nIndex = 0; nIndex < [categoryArray count]; nIndex++)
    //            {
    //                TwoLevelCategoryData *categoryData = [categoryArray objectAtIndex:nIndex];
    //                CategoryMenu *menuData = [[CategoryMenu alloc] init];
    //                menuData.categoryId = categoryData.categoryId;
    //                menuData.title = categoryData.name;
    //
    //                //                [self.tabMenuTitles addObject:menuData];
    //            }
    //
    //        }
    //
    //    } fail:^(id object) {
    //        //        [self.tabMenuTitles removeAllObjects];
    //    }];
}
#pragma mark 列表内容
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
            contentViewControllerType = NSClassFromString(Attent_Canvas);
            viewController = (ViewController *)[[contentViewControllerType alloc] init];
            viewController.rootViewController = self;
            [self.contentViewControllerMArray addObject:viewController];
            
        }
        else if (nIndex == 1)
        {
            contentViewControllerType = NSClassFromString(Recomment_Canvas);
            viewController = [[contentViewControllerType alloc] init];
            viewController.rootViewController = self;
            [self.contentViewControllerMArray addObject:viewController];
        }
        else if(nIndex == 2)
        {
            [self addCategoryViewControllerWithIndex:2];
            
        }
        else
        {
            contentViewControllerType = NSClassFromString(ShowPreView_Canvas);
            viewController = [[contentViewControllerType alloc] init];
            viewController.rootViewController = self;
            [self.contentViewControllerMArray addObject:viewController];
            
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
    
    categoryViewController.isOnlineStar = YES;
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
    segmentedControl.frame = CGRectMake(60, -3, self.view.frame.size.width-100, 47);
    segmentedControl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    segmentedControl.backgroundColor = [UIColor whiteColor];
    segmentedControl.textColor = [CommonFuction colorFromHexRGB:@"575757"];
    segmentedControl.selectionStyle = EWPSegmentedControlSelectionStyleFullWidthStripe;
    segmentedControl.selectionIndicatorLocation = EWPSegmentedControlSelectionIndicatorLocationDown;
    segmentedControl.selectionIndicatorColor = [CommonFuction colorFromHexRGB:@"d14c49"];
    segmentedControl.selectedTextColor = [CommonFuction colorFromHexRGB:@"d14c49"];
    segmentedControl.selectionIndicatorHeight = 1.5f;
    segmentedControl.font = [UIFont systemFontOfSize:17.0f];
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
    if([keyPath isEqualToString:@"bLoginSuccess"])
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
    
    
    [self showGiftDialog];
    
}
-(void)loginDialogAlways
{
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
#pragma mark 连续登录界面
-(void)addLogAwaysView{
    
    if (_awaysLoginDialog!=nil) {
        return;
        
    }
    
    _awaysLoginDialog = [[EWPSimpleDialog alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH , SCREEN_HEIGHT)];
    
    CGFloat distanceLeft = 20;
    
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
        UIImage* image = nil;
        
        if (imageViewDayIcon.image==nil) {
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSData* data = [[NSData alloc]initWithContentsOfURL:[[NSURL alloc] initWithString:url]];
                
                imageViewDayIcon.image = [UIImage imageWithData:data];
            });
            
        }
        
        [imageViewBG addSubview:imageViewDayIcon];
        
        UILabel* labelPrice = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 150, 25)];
        labelPrice.textAlignment = NSTextAlignmentCenter;
        labelPrice.font = [UIFont boldSystemFontOfSize:11];
        labelPrice.textColor = [UIColor whiteColor ];
        
        
        NSMutableAttributedString* attrStr = [[NSMutableAttributedString alloc]initWithString:[[self.dataLoginDialogArray objectAtIndex:i ] valueForKey:@"name"]];
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
            [rechargeBtn setBackgroundImage:[CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"ffea77"] size:CGSizeMake(57, 22)] forState:UIControlStateHighlighted];
            rechargeBtn.layer.borderWidth = 1;
            rechargeBtn.userInteractionEnabled = YES;
            
            [rechargeBtn setTitleColor:[CommonFuction colorFromHexRGB:@"ff9c34"] forState:UIControlStateNormal];
            
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
    [self showAlertView:@"温馨提示" message:[NSString stringWithFormat:@"恭喜您获得%@",[[self.dataLoginDialogArray objectAtIndex:sender.tag-100 ] valueForKey:@"name"]] confirm:^(id sender){
        
    } cancel:nil];
    [_awaysLoginDialog hide];
    _awaysLoginDialog = nil;
    [self getUserInfo];
}

#pragma mark __自动注册

- (void)autoRegister
{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![defaults objectForKey:@"auto_user"])
    {
        //        [[AppInfo shareInstance]loginOut];
        AutoRegistModel *model = [[AutoRegistModel alloc] init];
        [model requestDataWithParams:nil success:^(id object)
         {
             if (model.result == 0)
             {
                 self.autoRegistModel = model;
                 [self performSelector:@selector(showAutoRegistDialog) withObject:nil afterDelay:0.5];
             }
             //根据umeng 后台需要绑定设备别名
             NSString *strUserId = [NSString stringWithFormat:@"%ld",(long)model.userid];
             [UMessage addAlias:strUserId type:@"userid" response:^(id responseObject, NSError *error) {
             }];
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
    _autoRegistDialog.layer.cornerRadius = 12.0f;
    _autoRegistDialog.layer.borderWidth = 1.0f;
    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(225, -2, 40, 40)];
    [closeBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeDialog) forControlEvents:UIControlEventTouchUpInside];
    [_autoRegistDialog addSubview:closeBtn];
    
    CGSize nickSize = [CommonFuction sizeOfString:_autoRegistModel.nick maxWidth:135 maxHeight:20 withFontSize:17.0f];
    UILabel *nickLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 200, 20)];
    NSString *nick = [NSString stringWithFormat:@"%@%@",_autoRegistModel.nick,@" 您好！"];
    nickLabel.font = [UIFont systemFontOfSize:16.0f];
    NSMutableAttributedString *rankPosStr = [[NSMutableAttributedString alloc] initWithString:nick];
    [rankPosStr addAttribute:NSForegroundColorAttributeName value:[CommonFuction colorFromHexRGB:@"d14c49"] range:NSMakeRange(0,[_autoRegistModel.nick length])];
    nickLabel.attributedText = rankPosStr;
    [_autoRegistDialog addSubview:nickLabel];
    
    nickLabel.frame = CGRectMake((275-(nickLabel.frame.origin.x + nickSize.width + 20 ))/2, 15, 200, 20);
    
    UIImageView *lineImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, 50, 240, 0.5)];
    lineImg.backgroundColor = [CommonFuction colorFromHexRGB:@"cbcbcb"];
    [_autoRegistDialog addSubview:lineImg];
    
    UILabel *registTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 59, 150, 20)];
    registTipLabel.font = [UIFont systemFontOfSize:14.0f];
    registTipLabel.textColor = [CommonFuction colorFromHexRGB:@"d14c49"];
    registTipLabel.text = @"恭喜你获得新人奖励";
    //    [_autoRegistDialog addSubview:registTipLabel];
    
    //    七天
    UIImageView *effectiveTimeImg = [[UIImageView alloc] initWithFrame:CGRectMake(32, 65, 18, 37)];
    effectiveTimeImg.image = [UIImage imageNamed:@"EffectiveDay"];
    [_autoRegistDialog addSubview:effectiveTimeImg];
    // 座驾背景
    UIImageView *carBgImg = [[UIImageView alloc] initWithFrame:CGRectMake(40, 123, 100, 20.5)];
    carBgImg.image = [UIImage imageNamed:@"carBK"];
    [_autoRegistDialog addSubview:carBgImg];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",[AppInfo shareInstance].res_server,_autoRegistModel.img];
    UIImageView *carImg = [[UIImageView alloc] initWithFrame:CGRectMake(56, 89, 66, 48.5)];
    [carImg sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:nil];
    [_autoRegistDialog addSubview:carImg];
    
    //
    UIImageView *rebiImgView = [[UIImageView alloc] initWithFrame:CGRectMake(156, 89, 66, 57.5)];
    rebiImgView.image = [UIImage imageNamed:@"BoxRebi"];
    [_autoRegistDialog addSubview:rebiImgView];
    
    UILabel *carNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 150, 135, 20)];
    carNameLabel.text = _autoRegistModel.name;
    carNameLabel.textColor = [CommonFuction colorFromHexRGB:@"959596"];
    carNameLabel.font = [UIFont boldSystemFontOfSize:11.0f];
    [_autoRegistDialog addSubview:carNameLabel];
    
    UILabel *rebiLabel = [[UILabel alloc] initWithFrame:CGRectMake(166, 150, 135, 20)];
    rebiLabel.text = [NSString stringWithFormat:@"热币 × %ld",(long)_autoRegistModel.coin];
    rebiLabel.textColor = [CommonFuction colorFromHexRGB:@"959596"];
    rebiLabel.font = [UIFont boldSystemFontOfSize:11.0f];
    [_autoRegistDialog addSubview:rebiLabel];
    
    
    UIImage *normalImg = [CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"ffffff"] size:CGSizeMake(100, 32)];
    UIImage *selectImg = [CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"d14c49"] size:CGSizeMake(100, 32)];
    
    UIButton *openBtn = [[UIButton alloc] initWithFrame:CGRectMake(32, 185, 100, 32)];
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
    
    UIButton *accountBtn = [[UIButton alloc] initWithFrame:CGRectMake(138, 185, 100, 32)];
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
    
    NSInteger hideSwitch = [[[AppInfo shareInstance].hideSwitch substringToIndex:1] integerValue];
    
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 240, 100, 20)];
    tipLabel.text = @"第三方登录 :";
    tipLabel.font = [UIFont systemFontOfSize:13.0f];
    tipLabel.textColor = [CommonFuction colorFromHexRGB:@"575757"];
    
    UIButton *QQBtn = [[UIButton alloc] initWithFrame:CGRectMake(170, 240, 21, 21)];
    [QQBtn setImage:[UIImage imageNamed:@"qqIcon"] forState:UIControlStateNormal];
    [QQBtn addTarget:self action:@selector(loginWithQQ) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *WXBtn = [[UIButton alloc] initWithFrame:CGRectMake(200, 240, 21, 21)];
    [WXBtn setImage:[UIImage imageNamed:@"wxIcon"] forState:UIControlStateNormal];
    [WXBtn addTarget:self action:@selector(loginWithWx) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *sinaWeiboBtn = [[UIButton alloc] initWithFrame:CGRectMake(230, 240, 21, 21)];
    [sinaWeiboBtn setImage:[UIImage imageNamed:@"sinaIcon"] forState:UIControlStateNormal];
    [sinaWeiboBtn addTarget:self action:@selector(loginWithSina) forControlEvents:UIControlEventTouchUpInside];
    if (hideSwitch != 1)
    {
        [_autoRegistDialog addSubview:tipLabel];
        
        [_autoRegistDialog addSubview:QQBtn];
        
        [_autoRegistDialog addSubview:WXBtn];
        
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
    
    [self loginDialogAlways];
}

-(void)experience
{
    
    
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
    
    if ([AppInfo shareInstance].bLoginSuccess) {
        [self showAwaysLoginDialog];
    }
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
                    [[AppInfo shareInstance] loginWithAccount:qqAccount.usid nick:qqAccount.userName withHeadUrl:qqAccount.iconURL  token:qqAccount.accessToken type:1 success:^{
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
                                                      [[AppInfo shareInstance] loginWithAccount:qqAccount.usid nick:qqAccount.userName withHeadUrl:qqAccount.iconURL  token:qqAccount.accessToken type:1 success:^{
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
    [self hideAutoRegistDialog];
    if (![WXApi isWXAppInstalled])
    {
        EWPAlertView *alertView = [[EWPAlertView alloc] initWithTitle:@"提示" message:@"未检测到微信客户端,是否现在安装" leftBtnTitle:@"暂不安装" rightBtnTitle:@"马上安装" clickBtnBlock:^(NSInteger nIndex) {
            if (nIndex == 0)
            {
                
            }
            else if(nIndex == 1)
            {
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
                                              [[AppInfo shareInstance] loginWithAccount:snsAccount.usid nick:snsAccount.userName withHeadUrl:snsAccount.iconURL  token:snsAccount.accessToken type:4 success:^{
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
    [[AppInfo shareInstance] loginOut];
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
                    [[AppInfo shareInstance] loginWithAccount:sinaAccount.usid nick:sinaAccount.userName withHeadUrl:sinaAccount.iconURL  token:sinaAccount.accessToken type:2 success:^{
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
                                                      [[AppInfo shareInstance] loginWithAccount:sinaAccount.usid nick:sinaAccount.userName withHeadUrl:sinaAccount.iconURL  token:sinaAccount.accessToken type:2 success:^{
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
        [self onlineflagComplete];
        //        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onlineflagComplete) name:UMOnlineConfigDidFinishedNotification object:nil];
    }
}

- (void)onlineflagComplete
{
    NSString *appVersion =[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    
    [MobClick setAppVersion:appVersion];
    [MobClick checkUpdateWithDelegate:self selector:@selector(checkUpdateWithDictionary:)];
}

- (void)checkUpdateWithDictionary:(NSDictionary *)dictionary
{
    BOOL update = [[dictionary objectForKey:@"update"] boolValue];
    if (update)
    {
        //        umeng版本号
        NSString *version = [dictionary objectForKey:@"version"];
        //        本地版本号
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
                        
                        
                        NSString *update_log = [dictionary objectForKey:@"update_log"];
                        NSString *path = [dictionary objectForKey:@"path"];
                        NSString *mode = [upgradeParam objectForKey:@"mode"];
                        NSString *upversion = [upgradeParam objectForKey:@"version"];
                        
                        
                        NSString *version2 = [version stringByReplacingOccurrencesOfString:@"." withString:@""];
                        NSString *current_version2 = [current_version stringByReplacingOccurrencesOfString:@"." withString:@""];
                        NSString *upversion2 = [upversion stringByReplacingOccurrencesOfString:@"." withString:@""];
                        
                        int version1 = [version2 intValue];
                        int current_version1 = [current_version2 intValue];
                        int upversion1 = [upversion2 intValue];
                        
                        if(current_version1 < version1)
                        {
                            if (current_version1 < upversion1) {
                                [self showUpgradeDialogWithVersion:version upgradeLog:update_log mode:mode path:path];
                            }
                            else
                            {
                                [self showUpgradeDialogWithVersion:version upgradeLog:update_log mode:@"S" path:path];
                            }
                            
                        }
                        break;
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
            NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.2 target:self selector:@selector(timeAction:) userInfo:nil repeats:NO];
            [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
            
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
            if ([AppInfo shareInstance].bLoginSuccess) {
                [self showAwaysLoginDialog];
            }
            
        }
        else
        {
            //马上升级
            NSURL *url = [NSURL URLWithString:[AppInfo shareInstance].upgradePath];
            [[UIApplication sharedApplication] performSelectorOnMainThread:@selector(openURL:) withObject:url waitUntilDone:NO];
            
        }
    }
}
-(void)timeAction:(id)sender
{
    exit(0);
}
-(void)showOherTerminal{
    [self showOherTerminalLoggedDialog];
}
#pragma mark 获取个人中心数据缓存
- (void)getUserInfo
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)[UserInfoManager shareUserInfoManager].currentUserInfo.userId ] forKey:@"userid"];
    [dict setObject:[NSNumber numberWithBool:YES] forKey:@"calcOtherInfo"];
    
    //    __weak typeof(self) weakSelf = self;
    [self requestDataWithAnalyseModel:[GetUserInfoModel class] params:dict success:^(id object)
     {
         /*成功返回数据*/
         GetUserInfoModel *userInfoModel = object;
         if (userInfoModel.result == 0)
         {
             
             [UserInfoManager shareUserInfoManager].getUserInfoModel = userInfoModel;
             
             if (userInfoModel.userInfo.userId == [UserInfoManager shareUserInfoManager].currentUserInfo.userId)
             {
                 [UserInfoManager shareUserInfoManager].currentUserInfo = userInfoModel.userInfo;
                 
                 [UserInfoManager shareUserInfoManager].tempSelfStarInfo = userInfoModel.userInfo;
             }
         }
     }
                                 fail:^(id object)
     {
         /*失败返回数据*/
     }];
    
    if (![AppInfo shareInstance].bLoginSuccess) {
        return ;
    }
    [[NSNotificationCenter defaultCenter]postNotificationName:@"upDataMessage" object:nil];//更新消息
    
    [[AppInfo shareInstance] loadAppStoreRechargeInfo];
    
}
@end
