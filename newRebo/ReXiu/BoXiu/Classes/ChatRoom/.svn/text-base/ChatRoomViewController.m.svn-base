//
//  ChatRoomViewController.m
//  XiuBo
//
//  Created by Andy on 14-3-21.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "ChatRoomViewController.h"
#import "AppDelegate.h"
#import "EntireView.h"
#import "ChatMessageModel.h"
#import "CommandManager.h"
#import "UserInfoManager.h"
//#import "seeku.h"
#import "AppInfo.h"
#import "EWPScrollNotice.h"
#import "EnterRoomModel.h"
#import "GlobalMessageModel.h"
#import "GiveGiftModel.h"
#import "RobSofaModel.h"
#import "EWPDialog.h"
#import "BroadcastModel.h"
#import "TakeoutModel.h"
#import "TakeUnSpeak.h"
#import "NotifyMessageModel.h"
#import "PopupMenuDelegate.h"
#import "GetUserInfoModel.h"
#import "TcpServerInterface.h"
#import "GetApproveModel.h"
#import "SendApproveModel.h"
#import "RoomManagerModel.h"
#import "GetRoomImageModel.h"
#import "UserEnterRoomModel.h"
#import "CrownModel.h"
#import "GetPraisenumModel.h"
#import "EWPADView.h"
#import "GetStarPraiseNumModel.h"
#import "RXAlertView.h"
#import "LevelUpgradeModel.h"
#import "UMSocial.h"
#import "HotStarsView.h"
#import "QueryHotStarsModel.h"
#import "GlobaMessageLuckyModel.h"
#import "PraiseView.h"
#import "AuthModel.h"
#import "HeartModel.h"
#import "ReportModel.h"
#import "EmotionManager.h"
#import "EWPTextView.h"
#import "EWPBarrageView.h"
#import "BarrageMessageModel.h"
#import "SingleGiftContainerView.h"
#import "MoreGiftContainerView.h"
#import "ChoseMusicModel.h"
#import "GlobalMessageMusicModel.h"
#import "EWPTabMenuControl.h"
#import "PublicViewController.h"
#import "PrivateViewController.h"
#import "AudienceViewController.h"
#import "VoteMusicViewController.h"
#import "GiftDataManager.h"
#import "StarGiftRankModel.h"
#import "CustomMethod.h"
#import "UIPopoverListView.h"
#import "RightMenuCell.h"
#import "AttentionNotifyModel.h"
#import "GetSystemTimeModel.h"
#import "PublicTalkSettingModel.h"
#import "ShowTimeViewController.h"
#import "SendShowTimeApproveModel.h"
#import "RecordApproveManager.h"
#import "NavBackBar.h"
#import "WXApi.h"
#import "RoomRankViewController.h"
#import "RoomWorkViewController.h"

#define ViewTag_Offset 1000
#define EnterRoom_TimeOut (15)

typedef enum {
    rsStopType_None, //runing. maybe from startbutton or from background to restart.
    rsStoptype_StopButton,
    rsStoptype_HomeButton,
    rsStopType_PowerButton
    
} rsStopType;

@interface ChatRoomViewController ()<PopupMenuDelegate,UIPopoverListViewDelegate,UIPopoverListViewDataSource
                                    ,AudienceViewControllerDelegate,UMSocialUIDelegate
                                    ,HotStarsViewDelegate,PraiseViewDelegate,UIActionSheetDelegate
                                    ,EWPBarrageViewDataSource,ChatToolBarDelegate
                                    ,EWPTabMenuControlDataSource,EWPTabMenuControlDelegate,ShowTImeViewControllerDelegate
                                    ,GiftAnimationViewDataSource,RobSofaViewDelegate>

//{
//    seeku *seeku_all;
//    seeku *seeku_audio;
//}
@property (nonatomic,strong) UIImageView *loadVideoAnimationView;

@property (nonatomic,strong) UIImageView *videoImage;
@property (nonatomic,strong) EWPADView *roomImgeView;

@property (nonatomic,strong) ChatToolBar *chatToolBar;
@property (nonatomic,strong) EntireView *entireview;
@property (nonatomic,strong) EWPScrollNotice *scrollNotice;
@property (nonatomic,strong) NSMutableDictionary *chatMemberMDic;
@property (nonatomic,strong) PersonData *persondata;//个人档案数据

@property (nonatomic,strong) MBProgressHUD *mbProgressHud;
@property (nonatomic,strong) NSTimer *mbProgressHudTimer;
@property (nonatomic,strong) NSTimer *loginNoticeTimer;
@property (nonatomic,assign) BOOL showChatToolBar;

@property (nonatomic,weak) UITextField *sofaCoin;
@property (nonatomic,weak) SofaData *robSofaData;


@property (nonatomic,assign) BOOL changeCavasFromLogin;

@property (nonatomic,strong) HotStarsView *recommendStarView;

@property (readwrite) rsStopType stopType;


@property (nonatomic,strong) NSTimer *getApproveTimer;

@property (nonatomic,strong) UIView *praiseBackView;
@property (nonatomic, strong) UIButton *praiseBtn;
@property (nonatomic,strong) PraiseView *praiseView;
@property (nonatomic, strong) UILabel *praiseCount;
@property (nonatomic,strong) UILabel *starApprove;

@property (nonatomic,strong) EWPActivityIndicatorView *httpIndicatorView;

@property (nonatomic,assign) CGFloat prossTimes; //获取赞60秒后自动加1

@property (nonatomic,assign) BOOL tcpDisconnectWithErro;//tcp异常断开

@property (nonatomic,strong) NSTimer *heartTimer;

@property (nonatomic,assign) BOOL reconnect;

@property (nonatomic,strong) EWPDialog *loginNoticeDialog;

@property (nonatomic,strong) EWPSimpleDialog *reportUserDialog;
@property (nonatomic,strong) EWPTextView *reportContent;
@property (nonatomic,strong) UITextField *reportContact;
@property (nonatomic,assign) NSInteger reportedUserId;

@property (nonatomic,strong) SingleGiftContainerView *singleGiftContainerView;//单礼物送动画
@property (nonatomic,strong) MoreGiftContainerView *moreGiftContainerView;//多礼物送动画

@property (nonatomic,strong) EWPBarrageView *barrageView;//弹幕


@property (nonatomic,strong) EWPTabMenuControl *tabMenu;
@property (nonatomic,strong) NSMutableArray *tabMenuTitles;
@property (nonatomic,strong) NSMutableDictionary *tabMenuContentViewControllers;

@property (nonatomic,strong) NSMutableArray *popMenuTitles;
@property (nonatomic,strong) UserInfo *userInfoOfPopupMenu;

@property (nonatomic,assign) NSInteger enterRoomResultCode;//进入房间返回码

//明星直播间聊天时间限制
@property (nonatomic,strong) UILabel *startTitleLabel; //明星直播间未开播时提示
@property (nonatomic,strong) UILabel *startTimeLable;//明星直播间为开播时显示的开播时间。
@property (nonatomic,strong) NSTimer *starTimeTimer;//开播倒计时
@property (nonatomic,assign) long long timeInterval;//离开播剩余秒。

@property (nonatomic,strong) NSTimer *chatTimer;
@property (nonatomic,assign) NSInteger chatTime;

@property (nonatomic,strong) NSMutableArray *starGiftRankMArray;//明星直播间礼物排行榜

@property (nonatomic,strong) NSTimer *roomPersonFullTimer;    //房间人满倒计时

@property (nonatomic,assign) NSInteger showTimeSendFreeApproveNum;//明星直播间点击免费赞积累

@property (nonatomic,strong) NSTimer *showTimeApproveTimer;//免费赞定时发送，普通房间不受次限制


@property (nonatomic,assign) BOOL shieldGift;     //屏蔽显示礼物动画
@property (nonatomic,assign) BOOL shieldBarrage;  //屏蔽弹幕消息
@property (nonatomic,assign) BOOL isPlayVideo;//当前是音频或视频

@property (nonatomic,strong) EWPSimpleDialog *sofaDialog;


//弹幕
@property (nonatomic,strong) NSMutableArray *barrageMessageMArray;
@property (nonatomic,strong) NSLock *barrageMessageLock;
@property (nonatomic,strong) dispatch_queue_t barrageMessageQueue;

//动画
@property (nonatomic,strong) NSMutableArray *giftAnimationMArray;
@property (nonatomic,strong) NSLock *giftAnimationLock;
@property (nonatomic,strong) dispatch_queue_t giftAnimationQueue;

@property (nonatomic,assign) BOOL showingErroDialog;//控制同一时间只显示一个

//为开播转开播，暂时保存起来，信息不一致，后台问题
@property (nonatomic,assign) NSInteger showid;//主播id
@property (nonatomic,strong) NSString *livestream;//主播id
@property (nonatomic,strong) NSString *serverip;

//showtime开始时，点击免费赞，对showTimeSendFreeApproveNum锁定
@property (nonatomic,strong) NSLock *showTimeFreeApproveNumLock;
@property (nonatomic,strong) NSLock *showTImeTotalApproveNumLock;


@property (nonatomic,strong) EWPButton *audioOrVideoBtn;

@property (nonatomic,assign) BOOL playing;//记录是否正在直播。
void hook_func_call(void *args);

@end

@implementation ChatRoomViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//	// Do any additional setup after loading the view.
//    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
//    
//    _isPlayVideo = YES;
//    
//    //弹幕
//    _barrageMessageMArray = [NSMutableArray array];
//    _barrageMessageLock = [[NSLock alloc] init];
//    _barrageMessageQueue = dispatch_queue_create("barrageMessageQueue", DISPATCH_QUEUE_SERIAL);
//    
//    //礼物动画
//    _giftAnimationMArray = [NSMutableArray array];
//    _giftAnimationLock = [[NSLock alloc] init];
//    _giftAnimationQueue = dispatch_queue_create("giftAnimationQueue", DISPATCH_QUEUE_SERIAL);
//    
//    self.showChatToolBar =  YES;
//    self.changeCavasFromLogin = NO;
//
//    //视频播放背景
//    int nYOffset = 0;
//    //视频播放
//    _videoImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, nYOffset, SCREEN_WIDTH, 240)];
//    _videoImage.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"loadVideo"]];
//    _videoImage.tag = ViewTag_Offset + 1;
//    _videoImage.userInteractionEnabled = YES;
//    [self.view addSubview:_videoImage];
//    
//    //加载动画
//    NSMutableArray *imageArray = [NSMutableArray array];
//    for (NSInteger nIndex = 0; nIndex < 12; nIndex++)
//    {
//        NSString *imageName = [NSString stringWithFormat:@"loadVideo%ld",(long)nIndex];
//        UIImage *image = [UIImage imageNamed:imageName];
//        [imageArray addObject:image];
//    }
//    _loadVideoAnimationView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 132)/2, 152, 132, 1)];
//    _loadVideoAnimationView.animationImages = [NSArray arrayWithArray:imageArray];
//    _loadVideoAnimationView.animationRepeatCount = 0;
//    _loadVideoAnimationView.animationDuration = 1;
//    [_videoImage addSubview:_loadVideoAnimationView];
//    [_loadVideoAnimationView startAnimating];
//    nYOffset += 240;
//    
//    //点击视频区域响应
//    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnDisplayBackBtn)];
//    [self.videoImage addGestureRecognizer:singleTap];
//    
//    //跑马灯，加载房间最顶端
//    _scrollNotice = [[EWPScrollNotice alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 35) message:nil inParrentView:self.view];
//    _scrollNotice.linkColor = [CommonFuction colorFromHexRGB:@"F1E534"];
//    _scrollNotice.hidden = YES;
//    _scrollNotice.userInteractionEnabled = NO;
//    [self.view addSubview:_scrollNotice];
//    
//    //弹幕，加载房间视频区域最底端
//    _barrageView = [[EWPBarrageView alloc] initWithFrame:CGRectMake(0, _videoImage.frame.size.height - 66, 320, 66) showInView:self.view];
//    _barrageView.textColors = [NSMutableArray arrayWithObjects:[CommonFuction colorFromHexRGB:@"ff6666"],
//                               [CommonFuction colorFromHexRGB:@"e4c155"],
//                               [CommonFuction colorFromHexRGB:@"d14c49"],
//                               [UIColor whiteColor], nil];
//    _barrageView.fontSize = 12.0f;
//    _barrageView.dataSource = self;
//    _barrageView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"barrageMessageBK"]];
//    [self.view addSubview:_barrageView];
//    
//    _chatToolBar = [[ChatToolBar alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 81, SCREEN_WIDTH, 81) showInView:self.view];
//    _chatToolBar.delegate = self;
//    _chatToolBar.rootViewController = self;
//    [self.view addSubview:_chatToolBar];
//    
//    //默认tabmenu标题
//    _tabMenuTitles = [NSMutableArray arrayWithArray:@[Public_Chat_Title,Private_Chat_Title,RoomRank_Title,Audience_List_Title]];
//    _tabMenu = [[EWPTabMenuControl alloc] initWithFrame:CGRectMake(0, nYOffset, self.view.frame.size.width,self.view.frame.size.height - nYOffset)];
//    _tabMenu.dataSource = self;
//    _tabMenu.delegate = self;
//    _tabMenu.defaultSelectedSegmentIndex = 0;
//    [self.view addSubview:_tabMenu];
//   //滑动试图
//    [_tabMenu reloadData];
//    
//    //送礼动画
//    _singleGiftContainerView = [[SingleGiftContainerView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 235)/2, 80, 235, 160) showInView:self.view];
//    _singleGiftContainerView.dataSource = self;
//    [self.view addSubview:_singleGiftContainerView];
//    
//    _moreGiftContainerView = [[MoreGiftContainerView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 235)/2, 280,235,200) showInView:self.view];
//    _moreGiftContainerView.dataSource = self;
//    [self.view addSubview:_moreGiftContainerView];
//    
//       //获取个人档案信息
//    [self exitRoom:YES];
//    
//    //先获取主播信息,再获取room信息
//    [self getStarInfo];
//    
//    // 如果要检测网络状态的变化,必须用检测管理器的单例的startMonitoring
//    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
//    
//    // 检测网络连接的单例,网络变化时的回调方法
//    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//        if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == AFNetworkReachabilityStatusReachableViaWWAN)
//        {
//            [self showNoticeInWindow:@"您正使用4G/3G/2G网络，建议使用Wi-Fi观看直播,土豪随意。"];
//        }
//        [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
//        
//    }];
//    [self settingAudioSession];
//}

//- (void)didReceiveMemoryWarning
//{
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//    [self stopVideoPlayThread];
//}

- (void)argumentForCanvas:(id)argumentData
{
    if (argumentData && [argumentData isKindOfClass:[NSDictionary class]])
    {
        NSDictionary *params = (NSDictionary *)argumentData;
        NSNumber *object = [params objectForKey:@"staruserid"];
        if (object && [object isKindOfClass:[NSNumber class]])
        {
            self.staruserid = [object integerValue];
        }
        
        NSString *canvasName = [params objectForKey:@"className"];
        if (canvasName)
        {
            if ([canvasName isEqualToString:Login_Canvas] || [canvasName isEqualToString:Register_Success_Canvas])
            {
                self.changeCavasFromLogin = YES;
            }
        }
        
    }
    
}
//即将显示
//- (void)viewWillAppear:(BOOL)animated
//{
//    
//    [self.tableView reloadData];
//    
//    [super viewWillAppear:animated];
//
//    if (_tabMenu)
//    {
//        [_tabMenu viewWillAppear];
//    }
//    
//    if (_chatToolBar)
//    {
//        [_chatToolBar viewWillAppear];
//    }
//    
//    if (_entireview)
//    {
//        [_entireview viewWillAppear];
//    }
//
//    [UIApplication sharedApplication].statusBarHidden = YES;
//    self.navigationController.navigationBarHidden = YES;
//    [UIApplication sharedApplication].idleTimerDisabled = YES;
//    
//    [self addAllObserver];
//    
//    if([[AppDelegate shareAppDelegate].lrSliderMenuViewController respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)])
//        [[AppDelegate shareAppDelegate].lrSliderMenuViewController performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
//    
//    //获取用户最新信息
//    [[AppInfo shareInstance] refreshCurrentUserInfo:nil];
//    
//    if (self.changeCavasFromLogin && [AppInfo shareInstance].bLoginSuccess)
//    {
//        [self exitRoom:YES];
//        [self getStarInfo];
//    }
//}
//即将离开
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if (_tabMenu)
    {
        [_tabMenu viewwillDisappear];
    }
    if (_loginNoticeTimer)
    {
        [_loginNoticeTimer invalidate];
    }
    if (_showTimeApproveTimer)
    {
        [_showTimeApproveTimer invalidate];
    }
    
    if (self.showTimeSendFreeApproveNum > 0)
    {
        [self sendStarApproveWithPraiseType:1];
    }
    
    [UIApplication sharedApplication].idleTimerDisabled = NO;
    [UIApplication sharedApplication].statusBarHidden = NO;
    self.navigationController.navigationBarHidden = NO;
    [self removeAllObserver];
}
//已经显示
- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    EWPLog( @"===============set home key" );
}
//已经离开
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)addAllObserver
{
    //监听是否触发home键挂起程序.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationWillResignActive:)
                                                 name:UIApplicationWillResignActiveNotification
                                               object:[UIApplication sharedApplication]];
    
    //监听是否重新进入程序程序.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationDidBecomeActive:)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:[UIApplication sharedApplication]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(authSuccess:) name:AUTH_RESULT object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enterRoomResult:) name:ENTER_ROOM_RESULT object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveRoomMessage:) name:RECEIVE_ROOM_MESSAGE object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveGlobalMessage:) name:RECEIVE_GLOBAL_MESSAGE object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveGift:) name:RECEIVE_GIFT object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveSofa:) name:RECEIVE_SOFA object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiverErro:) name:RECEIVE_ERRO object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getApproveResult:) name:GET_APPROVE_RESULT object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveApproveResult:) name:SEND_APPROVE_RESULT object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveEnterRoomMessage:) name:RECEIVE_ENTNERROOM_MESSAGE object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tcpWillDisconnectWithErro) name:WILL_DISCONNECT_WITHERRO object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tcpDidDisconect) name:DISCONNECT_SUCCESS object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tcpConectSuccess) name:CONNECT_SUCCESS object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tcpSendDataFail) name:SEND_DATA_FAIL object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveBarageMessage:) name:RECEIVE_BARAGE_MESSAGE object:nil];
    
    //明星热波消息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveMusicChangeMessage:) name:RECEIVE_MUSICCHANGE_MESSAGE object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveShowTimeChangeMessage:) name:RECEIVE_SHOWTIMECHANGE_MESSAGE object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveShowTimeBeginMessage:) name:RECEIVE_SHOWTIMEBEGIN_MESSAGE object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveShowTimeEndMessage:) name:RECEIVE_SHOWTIMEEND_MESSAGE object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveShowTimeDataMessage:) name:RECEIVE_SHOWTIME_DATA_MESSAGE object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveShowTimeApproveResult:) name:SEND_SHOWTIME_APPROVE_RESULT object:nil];
}

- (void)removeAllObserver
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillResignActiveNotification object:[UIApplication sharedApplication]];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:[UIApplication sharedApplication]];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AUTH_RESULT object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:ENTER_ROOM_RESULT object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:RECEIVE_ROOM_MESSAGE object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:RECEIVE_GLOBAL_MESSAGE object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:RECEIVE_GIFT object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:RECEIVE_SOFA object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:RECEIVE_ERRO object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:GET_APPROVE_RESULT object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SEND_APPROVE_RESULT object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:RECEIVE_ENTNERROOM_MESSAGE object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:WILL_DISCONNECT_WITHERRO object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:DISCONNECT_SUCCESS object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:CONNECT_SUCCESS object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SEND_DATA_FAIL object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:RECEIVE_BARAGE_MESSAGE object:nil];
    
    //明星热波间消息
    [[NSNotificationCenter defaultCenter] removeObserver:self name:RECEIVE_MUSICCHANGE_MESSAGE object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:RECEIVE_SHOWTIMECHANGE_MESSAGE object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:RECEIVE_SHOWTIMEBEGIN_MESSAGE object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:RECEIVE_SHOWTIMEEND_MESSAGE object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:RECEIVE_SHOWTIME_DATA_MESSAGE object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SEND_SHOWTIME_APPROVE_RESULT object:nil];
}


//- (void) applicationWillResignActive: (NSNotification *)notification
//{
//    //if player is stopped by stopbutton, then press homebutton, we will do Nothing.
//    if ( self.stopType == rsStoptype_StopButton ) {
//        //do Nothing.
//    }
//    else
//    {
//        self.stopType = rsStoptype_HomeButton;
//        [self exitRoom:NO];
//    }
//}

- (void) applicationDidBecomeActive: (NSNotification *)notification
{
    //player is stopped by stopbutton, press it from background, we DO NOT need to restart.
    
    if (_entireview)
    {
        [_entireview viewWillAppear];
    }
    
    if ( self.stopType == rsStoptype_StopButton )
    {
        return;
    }

    if(![[TcpServerInterface shareServerInterface] isConnected])
    {
        [self resetConnect];
    }
}


- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    if (_reportUserDialog == nil)
    {
        [self moveInputBarWithKeyboardHeight:keyboardRect.size.height withDuration:animationDuration];
    }
    else
    {
        CGRect frame = _reportUserDialog.frame;
        if (frame.origin.y + frame.size.height > keyboardRect.origin.y + 5)
        {
            CGFloat offset = frame.origin.y + frame.size.height - keyboardRect.origin.y;
            frame.origin.y -= offset;
            frame.origin.y -= 5;
        }
        _reportUserDialog.frame = frame;
    }
    
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    NSDictionary* userInfo = [notification userInfo];
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    if (_reportUserDialog == nil)
    {
        [self moveInputBarWithKeyboardHeight:0.0 withDuration:animationDuration];
    }
    
}

- (void)moveInputBarWithKeyboardHeight:(float)keyboardHeight withDuration:(NSTimeInterval)animationDuration
{
    [UIView animateWithDuration:animationDuration delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        self.chatToolBar.frame = CGRectMake(0, SCREEN_HEIGHT - keyboardHeight - 81, self.view.frame.size.width, 81);
        
    } completion:^(BOOL finished) {
    }];
}

#pragma mark -后台音频播放设置
//- (void)settingAudioSession
//{
//    //后台播放音频设置
//    AVAudioSession *session = [AVAudioSession sharedInstance];
//    [session setActive:YES error:nil];
//    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
//}

#pragma mark -鉴权成功
- (void)authSuccess:(id)sender
{
    [self enterRoom];
}


#pragma mark - 进入房间结果 
//result 返回结果 0 失败 1 成功 2 房间不存在 3 房间人满 4 在黑名单中，禁止加入 5 踢人需要一个小时才能进入

//- (void)enterRoomResult:(NSNotification *)notification
//{
//    if (!self.reconnect)
//    {
////        [self stopAnimating];
//        [self stopLoadProgram];
//    }
//    
//    NSDictionary *bodyDic = [notification userInfo];
//    EWPLog(@"bodyDicRes = %@",bodyDic);
//    self.enterRoomResultCode = [[bodyDic objectForKey:@"result"] intValue];
//    
//    if (self.enterRoomResultCode == 1)
//    {
//        [self initRoomData];
//        [self initVideoViewData];
//        if (!self.reconnect)
//        {
//            [self initPublicViewData];
//        }
//        
//        if (self.roomInfoData.showtype == 1 || self.roomInfoData.showtype == 2)
//        {
//            if (!self.reconnect)
//            {
//                 [self initPrivateViewData];
//            }
//        }
//        if (self.roomInfoData.showtype == 3)
//        {
//            if (self.roomInfoData.bigstarstate == 2)
//            {
//                //showTime界面
//                [self initShowTimeViewData];
//            }
//            else if (self.roomInfoData.bigstarstate == 4)
//            {
//                //点歌界面
//                [self initVoteMusicViewData];
//            }
//            else
//            {
//                //默认点歌界面
//                [self initVoteMusicViewData];
//            }
//        }
//        [self initRoomRankViewData];
//        [self initAudienceViewData];
//    }
//    else if(self.enterRoomResultCode == 3)
//    {
//        if (self.roomInfoData.showtype == 3)
//        {
//            //明星热播间人满，2分钟提示后退出房间
//            [self initRoomData];
//            [self initVideoViewData];
//            
//            if (!self.reconnect)
//            {
//                [self initPublicViewData];
//            }
//            
//            if (self.roomInfoData.bigstarstate == 2)
//            {
//                //showTime界面
//                [self initShowTimeViewData];
//            }
//            else if (self.roomInfoData.bigstarstate == 4)
//            {
//                //点歌界面
//                [self initVoteMusicViewData];
//            }
//            else
//            {
//                //默认点歌界面
//                [self initVoteMusicViewData];
//            }
//
//            [self initAudienceViewData];
//        }
//        else
//        {
//            //普通房间人满退出房间
//            [self showNoticeInWindow:@"房间人数已满"];
//            [self performSelector:@selector(autoExitRoom) withObject:nil afterDelay:3];
//        }
//    }
//    else if (self.enterRoomResultCode == 2)
//    {
//        [self showNoticeInWindow:@"房间不存在"];
//    }
//    else if (self.enterRoomResultCode == 4)
//    {
//        [self showNoticeInWindow:@"在黑名单中，禁止加入"];
//    }
//    else if (self.enterRoomResultCode == 5)
//    {
//        [self showNoticeInWindow:@"您刚被踢出房间，一个小时后才能进入房间"];
//        [self performSelector:@selector(autoExitRoom) withObject:nil afterDelay:2];
//    }
//    self.reconnect = NO;
//    _livestream = nil;
//    _serverip = nil;
//    _showid = 0;
//}

//- (void)autoExitRoom
//{
//    [self exitRoom:YES];
//    
//    NSString *className = NSStringFromClass([self class]);
//    NSDictionary *param = [NSDictionary dictionaryWithObject:className forKey:@"className"];
//    [self popCanvasWithArgment:param];
//}


#pragma mark - 心跳
- (void)OnHeartTimer:(id)sender
{
    [HeartModel sendHeart];
}

#pragma mark 鉴权

- (void)sendAuthData
{
    [AuthModel sendAuth];
}

#pragma mark - 进入房间请求

//- (void)reEnterRoom:(BOOL)reconnect
//{
//    self.isPlayVideo = YES;
//    [self exitRoom:YES];
//    self.reconnect = reconnect;
//    [self getStarInfo];
//    EWPLog(@"reEnterRoom");
//}


- (void)enterRoom
{
    UserInfo *userInfo = [UserInfoManager shareUserInfoManager].currentUserInfo;
    StarInfo *starInfo = [UserInfoManager shareUserInfoManager].currentStarInfo;
   

    if (![[TcpServerInterface shareServerInterface] isConnected])//Tcp没有被连接
    {
        if (starInfo.serverip && [starInfo.serverip length] > 0 )
        {
            [[CommandManager shareInstance] connectServer:starInfo.serverip serverport:[TCP_SERVER_PORT integerValue]];
        }
    }
    else
    {
        [EnterRoomModel enterRoomWithUserId:userInfo.userId starUserId:starInfo.userId reconnect:self.reconnect];
    }
    
    
}

#pragma mark - 离开房间

//- (void)exitRoom:(BOOL)stopVideo
//{
//    [self stopAnimating];
//    
//    if (self.loginNoticeTimer)
//    {
//        [self.loginNoticeTimer invalidate];
//        self.loginNoticeTimer = nil;
//    }
//    
//    //关闭定时器
//    if (_getApproveTimer)
//    {
//        [_getApproveTimer invalidate];
//        _getApproveTimer = nil;
//    }
//    
//    if (_roomPersonFullTimer)
//    {
//        [_roomPersonFullTimer invalidate];
//        _roomPersonFullTimer = nil;
//    }
//    if (stopVideo)
//    {
//        [self stopVideoPlayThread];
//    }
//    
//    [[CommandManager shareInstance] disConnectServer];
//}

#pragma mark - 获取主播信息
//- (void)getStarInfo
//{
//    if (!self.reconnect)
//    {
////        [self startAnimating];
//        [self startLoadProgram];
//    }
//    
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    [dict setObject:[NSNumber numberWithInteger:self.staruserid] forKey:@"userid"];
//    GetUserInfoModel *model = [[GetUserInfoModel alloc] init];
//    [model requestDataWithParams:dict success:^(id object) {
//        /*成功返回数据*/
//        GetUserInfoModel *userInfoModel = object;
//        if (userInfoModel.result == 0)
//        {
//            if (userInfoModel.userInfo)
//            {
//                [UserInfoManager shareUserInfoManager].currentStarInfo = userInfoModel.userInfo;
//                if (_chatToolBar)
//                {
//                    [_chatToolBar addChatMember:userInfoModel.userInfo];
//                    _chatToolBar.targetUserInfo = userInfoModel.userInfo;
//                }
//                //主播信息获取成功后获取房间信息
//                [self performSelector:@selector(getRoomInfo) withObject:nil];
//            }
//            
//        }
//        else
//        {
//            [self showNetworkErroDialog];
//        }
//
//    } fail:^(id object) {
//        /*失败返回数据*/
//        [self stopAnimating];
//        [self showNetworkErroDialog];
//    }];
//}

#pragma mark - 获取房间信息
//- (void)getRoomInfo
//{
//    //获取房间个人档案信息
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    [dict setObject:[NSNumber numberWithInteger:[UserInfoManager shareUserInfoManager].currentStarInfo.userId] forKey:@"staruserid"];
//    
//     __weak typeof(self) weakSelf = self;
//    GetRoomInfoModel *model = [[GetRoomInfoModel alloc] init];
//    [model requestDataWithParams:dict success:^(id object) {
//        __strong typeof(self) strongSelf = weakSelf;
//        if (model.result == 0)
//        {
//            self.roomInfoData = model.roomInfoData;
//            if (self.roomInfoData.showid == 0)
//            {
//                self.roomInfoData.showid = self.showid;
//            }
//            
//            [UserInfoManager shareUserInfoManager].currentUserInfo.managerflag = self.roomInfoData.managerflag;
//            
//            StarInfo *starInfo = [UserInfoManager shareUserInfoManager].currentStarInfo;
//            starInfo.liveip = model.roomInfoData.liveip;
//            if (_livestream)
//            {
//                starInfo.livestream = self.livestream;
//            }
//            else
//            {
//               starInfo.livestream = model.roomInfoData.livestream;
//            }
//            
//            if (_serverip)
//            {
//                starInfo.serverip = self.serverip;
//            }
//            else
//            {
//                starInfo.serverip = model.roomInfoData.serverip;
//            }
//            
//            
//            starInfo.serverport = [model.roomInfoData.serverport intValue];
//            starInfo.showbegintime = model.roomInfoData.showbegintime;
//                                      
//            PersonData *personData =[[PersonData alloc] init];
//            personData.userId = starInfo.userId;
//            personData.userImg = starInfo.photo;
//            personData.idxcode = starInfo.idxcode;
//            personData.nick = starInfo.nick;
//            personData.starlevelid = starInfo.starlevelid;
//            personData.privlevelweight = starInfo.privlevelweight;
//            personData.notice = model.roomInfoData.roomad;
//            personData.attented = model.roomInfoData.attentionflag;
//            personData.showid = model.roomInfoData.showid;
//            personData.consumerlevelweight = starInfo.consumerlevelweight;
//            personData.showbegintime = model.roomInfoData.showbegintime;
//            personData.privatechatad = model.roomInfoData.privatechatad;
//            strongSelf.persondata = personData;
//            
//            BOOL isTestVersion = [[[NSBundle mainBundle] objectForInfoDictionaryKey:@"Test_Version"] boolValue];
//            if (isTestVersion)
//            {
//                [self showNoticeInWindow:starInfo.serverip duration:3];
//            }
//            //房间信息获取成功后，进入房间
//            [self performSelector:@selector(enterRoom) withObject:nil];
//        }
//        else
//        {
//            [self showNetworkErroDialog];
//        }
//    } fail:^(id object) {
//        /*失败返回数据*/
//        [self stopAnimating];
//        [self showNetworkErroDialog];
//    }];
//}


- (void)addChatMember:(ChatMessageModel *)chatMessageModel
{
    if (chatMessageModel.userid != 0 && [chatMessageModel.nick length] > 0)
    {
        UserInfo *userInfo = [[UserInfo alloc] init];
        userInfo.userId = chatMessageModel.userid;
        userInfo.nick = chatMessageModel.nick;
        userInfo.hidden = chatMessageModel.hidden;
        userInfo.hiddenindex = chatMessageModel.hiddenindex;
        userInfo.issupermanager = chatMessageModel.issupermanager;
        userInfo.staruserid = chatMessageModel.staruserid;
        [[UserInfoManager shareUserInfoManager] addMemberInfo:userInfo];
    }
    
    if (chatMessageModel.targetUserid != 0 && [chatMessageModel.targetNick length] > 0)
    {
        UserInfo *userInfo = [[UserInfo alloc] init];
        userInfo.userId = chatMessageModel.targetUserid;
        userInfo.nick = chatMessageModel.targetNick;
        userInfo.hidden = chatMessageModel.thidden;
        userInfo.hiddenindex = chatMessageModel.thiddenindex;
        userInfo.issupermanager = chatMessageModel.tissupermanager;
        userInfo.staruserid = chatMessageModel.staruserid;
        [[UserInfoManager shareUserInfoManager] addMemberInfo:userInfo];
    }
}

- (void)addChatMemberFromNotifyMessage:(NotifyMessageModel *)notifyMessageModel
{
    if (notifyMessageModel.fromuserid != 0 && [notifyMessageModel.fromusernick length] > 0)
    {
        UserInfo *userInfo = [[UserInfo alloc] init];
        userInfo.userId = notifyMessageModel.fromuserid;
        userInfo.nick = notifyMessageModel.fromusernick;
        userInfo.hidden = notifyMessageModel.hidden;
        userInfo.hiddenindex = notifyMessageModel.hiddenindex;
        userInfo.issupermanager = notifyMessageModel.issupermanager;
        [[UserInfoManager shareUserInfoManager] addMemberInfo:userInfo];
    }
    
    if (notifyMessageModel.touserid != 0 && [notifyMessageModel.tousernick length] > 0)
    {
        UserInfo *userInfo = [[UserInfo alloc] init];
        userInfo.userId = notifyMessageModel.touserid;
        userInfo.nick = notifyMessageModel.tousernick;
        userInfo.hidden = notifyMessageModel.thidden;
        userInfo.hiddenindex = notifyMessageModel.thiddenindex;
        userInfo.issupermanager = notifyMessageModel.tissupermanager;
        [[UserInfoManager shareUserInfoManager] addMemberInfo:userInfo];
    }
}

- (NSDictionary *)chatMemberDic
{
    return self.chatMemberMDic;
}

#pragma mark - NSNotification
//- (void)receiveRoomMessage:(NSNotification *)notification
//{
//    NSDictionary *bodyDic = [notification userInfo];
//    EWPLog(@"bodyDic = %@",bodyDic);
//    
//    NSInteger chatType = [[bodyDic objectForKey:@"chatType"] integerValue];
//    switch (chatType)
//    {
//        case 1:
//        case 2:
//        {
//            ChatMessageModel *model = [[ChatMessageModel alloc] initWithData:bodyDic];
//            
//            if(model.result == -1)
//            {
//                if(model.userid == [UserInfoManager shareUserInfoManager].currentUserInfo.userId && model.unspeak==1)
//                {
//                    [self showMarketDialogWithTitle:nil message:@"亲，你已经被禁言了，如果想说话，请提升VIP哦！" buyVipBlock:nil cancelBlock:nil];
//                }
//            }
//            else
//            {
//                [self addChatMember:model];
//
//                if (model.chatType == 1)
//                {
//                    PublicViewController *publicViewController = [self.tabMenuContentViewControllers objectForKey:Public_Chat_Title];
//                    if (publicViewController)
//                    {
//                        [publicViewController addChatMessage:model];
//                    }
//                }
//                else
//                {
//                    UserInfo *userInfo = [UserInfoManager shareUserInfoManager].currentUserInfo;
//                    if (model.targetUserid == userInfo.userId || model.userid == userInfo.userId)
//                    {
//                        PrivateViewController *privateViewController = [self.tabMenuContentViewControllers objectForKey:Private_Chat_Title];
//                        if (privateViewController)
//                        {
////                            [privateViewController addChatMessage:model];
//                        }
//                    }
//                }
//            }
//        }
//            break;
//        case 6:
//        case 7:
//        {
//            BroadcastModel *model = [[BroadcastModel alloc] initWithData:bodyDic];
//            if (model.staruserid != [UserInfoManager shareUserInfoManager].currentStarInfo.userId)
//            {
//                return;
//            }
//            
//            if (model.chatType == 6)
//            {
//                PublicViewController *publicViewController = [self.tabMenuContentViewControllers objectForKey:Public_Chat_Title];
//                if (publicViewController)
//                {
//                    [publicViewController addMessage:@"Star 开播了"];
//                }
//                self.staruserid = model.staruserid;
//                self.showid = model.showid;
//                self.livestream = model.livestream;
//                self.serverip = model.serverip;
//                [self reEnterRoom:YES];
//            }
//            else if (model.chatType == 7)
//            {
//                //主播停播
//                PublicViewController *publicViewController = [self.tabMenuContentViewControllers objectForKey:Public_Chat_Title];
//                if (publicViewController)
//                {
//                    [publicViewController addMessage:@"Star 停播了"];
//                }
//                [self stopPlay];
//            }
//        }
//            break;
//        case 11:
//        {
//            //踢人
//            NotifyMessageModel *model = [[NotifyMessageModel alloc] initWithData:bodyDic];
//            model.msg = [NSString stringWithFormat:@"{%ld}被{%ld}踢出了本房间！",(long)model.touserid,(long)model.fromuserid];
//            PublicViewController *publicViewController = [self.tabMenuContentViewControllers objectForKey:Public_Chat_Title];
//            if (publicViewController)
//            {
//                [publicViewController addRoomMessage:model];
//            }
//
//            if(model.touserid == [UserInfoManager shareUserInfoManager].currentUserInfo.userId)
//            {
//                //有空把这两个合并在一起
//                NSDictionary *dictionary = [[UserInfoManager shareUserInfoManager] allUserIdAndNick];
//                NSString *toUser = [dictionary objectForKey:[NSNumber numberWithInteger:model.touserid]];
//                NSString *fromUser = [dictionary objectForKey:[NSNumber numberWithInteger:model.fromuserid]];
//                NSString *message = [NSString stringWithFormat:@"%@被%@提出了本房间",toUser,fromUser];
//                [self showNoticeInWindow:message];
//                [self performSelector:@selector(popCanvasWithArgment:) withObject:nil afterDelay:2];
//            }
//        }
//            break;
//        case 12:
//        {
//            
//            NotifyMessageModel *model = [[NotifyMessageModel alloc] initWithData:bodyDic];
//            if (model.speaktype == 0)
//            {
//                //禁言
//                model.msg = [NSString stringWithFormat:@"{%ld}被{%ld}禁言5分钟！",(long)model.touserid,(long)model.fromuserid];
//            }
//            else if (model.speaktype == 1)
//            {
//                //恢复
//                model.msg = [NSString stringWithFormat:@"{%ld}被{%ld}恢复发言！",(long)model.touserid,(long)model.fromuserid];
//            }
//            
//            [self addChatMemberFromNotifyMessage:model];
//            PublicViewController *publicViewController = [self.tabMenuContentViewControllers objectForKey:Public_Chat_Title];
//            if (publicViewController)
//            {
//                [publicViewController addRoomMessage:model];
//            }
//            
//        }
//            break;
//        case 13:
//        {
//            //公聊设置
//            PublicTalkSettingModel *model = [[PublicTalkSettingModel alloc] initWithData:bodyDic];
//            self.roomInfoData.publictalkstatus = model.publictalkstatus;
//        }
//            break;
//        case 14:
//        {
//            //关注消息
//            AttentionNotifyModel *model = [[AttentionNotifyModel alloc] initWithData:bodyDic];
//            if (model)
//            {
//                PublicViewController *publicViewController = [self.tabMenuContentViewControllers objectForKey:Public_Chat_Title];
//                if (publicViewController)
//                {
//                    [publicViewController addAttionNotifyMessage:model];
//                }
//            }
//        }
//            break;
//        case 20:
//        {
//            //成为黄冠粉丝提醒
//            CrownModel *model = [[CrownModel alloc] initWithData:bodyDic];
//            if (model)
//            {
//                PublicViewController *publicViewController = [self.tabMenuContentViewControllers objectForKey:Public_Chat_Title];
//                if (publicViewController)
//                {
//                    [publicViewController addCrownMessage:model];
//                }
//            }
//        }
//            break;
//        case 23:
//        {
//            LevelUpgradeModel *model = [[LevelUpgradeModel alloc] initWithData:bodyDic];
//            if (model.upgradeType == 1)
//            {
//                //财富等级
//                UserInfo *userInfo = [UserInfoManager shareUserInfoManager].currentUserInfo;
//                if (userInfo.userId == model.userid)
//                {
//                    userInfo.consumerlevelweight = [UserInfo switchConsumerlevelweight:model.nowConsumerlevelweight];//model.nowConsumerlevelweight;
//                    [UserInfoManager shareUserInfoManager].currentUserInfo = userInfo;
//                }
//                
//                
//            }
//            else if (model.upgradeType == 2)
//            {
//                //明星等级
//                StarInfo *starInfo = [UserInfoManager shareUserInfoManager].currentStarInfo;
//                if (starInfo.userId == starInfo.userId)
//                {
//                    starInfo.starlevelid = model.nowStarlevelid;
//                    [UserInfoManager shareUserInfoManager].currentStarInfo = starInfo;
//                }
//                
//            }
//        }
//            break;
//        case 25:
//        {
//            //弹幕开关设置消息
//            self.roomInfoData.openflag = [[bodyDic objectForKey:@"openflag"] boolValue];
//            //不要主动去修改设置
////            [_chatToolBar updateBarageSwitch];
//        }
//            break;
//        case 50:
//        {
//            //提升房管
//            RoomManagerModel *model = [[RoomManagerModel alloc] initWithData:bodyDic];
//            if (model.userid == [UserInfoManager shareUserInfoManager].currentUserInfo.userId)
//            {
//                [UserInfoManager shareUserInfoManager].currentUserInfo.managerflag = YES;
//            }
//        }
//            break;
//        case 51:
//        {
//            //解除房管
//            RoomManagerModel *model = [[RoomManagerModel alloc] initWithData:bodyDic];
//            if (model.userid == [UserInfoManager shareUserInfoManager].currentUserInfo.userId)
//            {
//                [UserInfoManager shareUserInfoManager].currentUserInfo.managerflag = NO;
//            }
//        }
//            break;
//        default:
//            break;
//    }
//}

- (void)receiveGlobalMessage:(NSNotification *)notification
{
    NSDictionary *bodyDic = [notification userInfo];
    EWPLog(@"bodyDic = %@",bodyDic);
    
    NSInteger chatType = [[bodyDic objectForKey:@"chatType"] integerValue];
    GlobalMessageModel *model = [[GlobalMessageModel alloc] initWithData:bodyDic];
    
    switch (chatType)
    {
        case 3:
        {
            PublicViewController *publicViewController = [self.tabMenuContentViewControllers objectForKey:Public_Chat_Title];
            if (publicViewController)
            {
                [publicViewController addGlobalMessage:model];
            }
        }
            break;
        case 10:
        {
            [self addGlobalGiftInfo:model];
        }
            break;
        case 24:
        {
            GlobaMessageLuckyModel *globaModel = [[GlobaMessageLuckyModel alloc] initWithData:bodyDic];
            [self addGloableLuckyGiftsInfo:globaModel];
            
            PublicViewController *publicViewController = [self.tabMenuContentViewControllers objectForKey:Public_Chat_Title];
            if (publicViewController)
            {
                [publicViewController addGlobalLuckyGiftMessage:globaModel];
            }
        }
            break;
        case 40:
        {
            [self addGloableSofaInfo:model];
        }
            break;
        case 52:  //歌曲投票超过 5000 热币
        {
            GlobalMessageMusicModel *globaMusicModel = [[GlobalMessageMusicModel alloc] initWithData:bodyDic];
            [self addGloableMusicInfo:globaMusicModel];//#pragma mark -点歌投票中奖通知
        }
            break;
        default:
            break;
    }

}

#pragma mark __送礼物成功
- (void)receiveGift:(NSNotification *)notification
{
    NSDictionary *bodyDic = [notification userInfo];
    EWPLog(@"bodyDic = %@",bodyDic);
    
    GiveGiftModel *model = [[GiveGiftModel alloc] initWithData:bodyDic];
    UserInfo *userInfo = [UserInfoManager shareUserInfoManager].currentUserInfo;
    if (userInfo && userInfo.userId == model.useridfrom)
    {
        userInfo.coin = model.usercoin;
        [UserInfoManager shareUserInfoManager].currentUserInfo = userInfo;
    }
    PublicViewController *publicViewController = [self.tabMenuContentViewControllers objectForKey:Public_Chat_Title];
    if (publicViewController)
    {
        [publicViewController addGiftInfoToChatMessage:model];
        if (self.roomInfoData.showtype == 3)
        {
            //明星直播间
            if (model.bigStargiftList && model.bigStargiftList.count > 0)
            {
                [publicViewController updateBigStarGiftRankMessage:model];
            }
        }
    }

    if (model.useridto == model.staruserid && (model.giftcategory == 3 || model.giftcategory == 4 || model.objectnum > 1) && _shieldGift != YES)
    {
        EWPLog(@"送给的是主播");
        
        GiftAnimationData *giftAnimationData = [[GiftAnimationData alloc] init];

        NSString *giftImgUrl = [NSString stringWithFormat:@"%@%@",[AppInfo shareInstance].res_server,model.giftimgbig];
        if (model.objectnum == 1 && self.roomInfoData.showtype != 3)
        {
            giftAnimationData.giftMessage = model.usernickfrom;
            giftAnimationData.giftType = 1;
            giftAnimationData.giftUrl = giftImgUrl;
        }
        else if(model.objectnum > 1)
        {
            giftAnimationData.giftMessage = [NSString stringWithFormat:@"%@送%ld%@",model.usernickfrom,(long)model.objectnum,model.giftunit];
            giftAnimationData.giftType = 2;
            giftAnimationData.giftUrl = giftImgUrl;
        }
        if (model.useridfrom == userInfo.userId)
        {
            giftAnimationData.isSelf = YES;
        }
        else
        {
            giftAnimationData.isSelf = NO;
        }
        
        [_giftAnimationLock lock];
        [_giftAnimationMArray addObject:giftAnimationData];
        static NSInteger count = 0;
        count += 1;
        EWPLog(@"giftAnimationMArray 加入:%ld",(long)count);
        if (_giftAnimationMArray.count > 100)
        {
            NSMutableArray *newGiftAnimations = [NSMutableArray array];
            [newGiftAnimations addObjectsFromArray:[_giftAnimationMArray subarrayWithRange:NSMakeRange(_giftAnimationMArray.count - 30, 30)]];
            
            for (NSInteger nIndex = _giftAnimationMArray.count - 30; nIndex >= 0; nIndex--)
            {
                GiftAnimationData *tempgiftAnimationData = [_giftAnimationMArray objectAtIndex:nIndex];
                if (tempgiftAnimationData && tempgiftAnimationData.isSelf)
                {
                    [newGiftAnimations insertObject:tempgiftAnimationData atIndex:0];
                }
            }
            [_giftAnimationMArray removeAllObjects];
            [_giftAnimationMArray addObjectsFromArray:newGiftAnimations];
        }
        [_giftAnimationLock unlock];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.view bringSubviewToFront:_singleGiftContainerView];
            [self.view bringSubviewToFront:_moreGiftContainerView];
            [_singleGiftContainerView showGiftAnimation];
            [_moreGiftContainerView showGiftAnimation];
        });
    }
}

#pragma mark -GiftAnimationViewDataSource
- (GiftAnimationData *)getGiftAnimationDataFromQueue:(NSInteger)giftType
{
    GiftAnimationData *giftAnimationData = nil;
    [_giftAnimationLock lock];
    if (_giftAnimationMArray.count > 0)
    {
        EWPLog(@"giftAnimationMArray 剩余:%ld",(unsigned long)_giftAnimationMArray.count);
        GiftAnimationData * tempGiftAnimationData = [_giftAnimationMArray firstObject];
        if (tempGiftAnimationData.giftType == giftType)
        {
            giftAnimationData = tempGiftAnimationData;
            [_giftAnimationMArray removeObjectAtIndex:0];
        }
    }

    [_giftAnimationLock unlock];
    return giftAnimationData;
}


#pragma mark-收到沙发
- (void)receiveSofa:(NSNotification *)notification
{
    NSDictionary *bodyDic = [notification userInfo];
    EWPLog(@"bodyDic = %@",bodyDic);
    
    RobSofaModel *model = [[RobSofaModel alloc] initWithData:bodyDic];
    if (self.entireview && model.result == 1)
    {
        UserInfo *userInfo = [UserInfoManager shareUserInfoManager].currentUserInfo;
        
        if (userInfo && userInfo.userId == model.userid)
        {
            userInfo.coin = model.usercoin;
            [UserInfoManager shareUserInfoManager].currentUserInfo = userInfo;
        }
        SofaData *sofaData = [[SofaData alloc] init];
        sofaData.num = model.num;
        sofaData.coin = 100;
        sofaData.sofano = model.sofano;
        sofaData.userid = model.userid;
        sofaData.nick = model.nick;
        sofaData.photo = model.photo;
        sofaData.hidden = model.hidden;
        sofaData.hiddenindex = model.hiddenindex;
        sofaData.issupermanager = model.issupermanager;
        [self.entireview setSofaData:sofaData];
        if (userInfo.userId ==  model.userid)
        {
            [self showNoticeInWindow:@"抢沙发成功"];
        }

        PublicViewController *publicViewController = [self.tabMenuContentViewControllers objectForKey:Public_Chat_Title];
        if (publicViewController)
        {
            [publicViewController addSofaInfoToChatMessage:model];
        }
    }
}

#pragma mark _点完赞后获取剩余赞
- (void)receiveApproveResult:(NSNotification *)notification
{
    NSDictionary *bodyDic = [notification userInfo];
    EWPLog(@"receiveApproveResult bodyDic = %@",bodyDic);
    SendApproveModel *model = [[SendApproveModel alloc] initWithData:bodyDic];
    if (model)
    {
        UserInfo *userInfo = [UserInfoManager shareUserInfoManager].currentUserInfo;
        if (userInfo)
        {
            if (userInfo.userId == model.userid)
            {
                userInfo.leavecount = model.leavecount;
                userInfo.getcount = model.getcount;
                userInfo.sendcount = model.sendcount;
                userInfo.maxcount = model.maxcount;
                [UserInfoManager shareUserInfoManager].currentUserInfo = userInfo;
                _praiseCount.text = [NSString stringWithFormat:@"%ld",(long)model.leavecount];
            }
        }
        StarInfo *starInfo = [UserInfoManager shareUserInfoManager].currentStarInfo;
        starInfo.starmonthpraisecount = model.starmonthpraisecount;
        if (self.starApprove)
        {
            self.starApprove.hidden = NO;
            self.starApprove.text = [NSString stringWithFormat:@" %ld",(long)model.starmonthpraisecount];
        }
        
        if (self.roomInfoData)
        {
            if (self.roomInfoData.pubpraisenotice == 1)
            {
                //公聊区不展现点赞消息
                PublicViewController *publicViewController = [self.tabMenuContentViewControllers objectForKey:Public_Chat_Title];
                if (publicViewController)
                {
                    [publicViewController addApproveMessage:model];
                }
            }
        }
       
    }
}

- (void)receiveEnterRoomMessage:(NSNotification *)notification
{
    NSDictionary *bodyDic = [notification userInfo];
    EWPLog(@"bodyDic = %@",bodyDic);
    UserEnterRoomModel *model = [[UserEnterRoomModel alloc] initWithData:bodyDic];
    if (model.type != 2)
    {
        //机器人用户type == 2,机器人进来不显示欢迎语
        PublicViewController *publicViewController = [self.tabMenuContentViewControllers objectForKey:Public_Chat_Title];
        if (publicViewController)
        {
            [publicViewController addUserEnterRoomMessage:model];
        }
    }

}

#pragma mark - 收到弹幕消息
- (void)receiveBarageMessage:(NSNotification *)notification
{
    //如果弹幕被屏蔽，直接返回
    if (_shieldBarrage == YES)
    {
        return;
    }
    
    NSDictionary *bodyDic = [notification userInfo];
    EWPLog(@"bodyDic = %@",bodyDic);
    
    dispatch_async(_barrageMessageQueue, ^{
        BarrageMessageModel *model = [[BarrageMessageModel alloc] initWithData:bodyDic];
        if (model.content && [model.content length])
        {
            if (model.userid != 0 && [model.nick length] > 0)
            {
                UserInfo *userInfo = [[UserInfo alloc] init];
                userInfo.userId = model.userid;
                userInfo.nick = model.nick;
                userInfo.hidden = model.hidden;
                userInfo.hiddenindex = model.hiddenindex;
                userInfo.issupermanager = model.issupermanager;
                userInfo.staruserid = model.staruserid;
                [[UserInfoManager shareUserInfoManager] addChatMember:userInfo];
            }
            UserInfo *currentUserInfo = [UserInfoManager shareUserInfoManager].currentUserInfo;
            if (currentUserInfo && currentUserInfo.userId == model.userid)
            {
                currentUserInfo.coin = model.usercoin;
                [UserInfoManager shareUserInfoManager].currentUserInfo = currentUserInfo;
            }
            NSString *barageMessage = nil;
            if (model.userid != 0 && model.nick)
            {
                barageMessage = [NSString stringWithFormat:@"{%ld}说:%@",(long)model.userid,model.content];
            }
            
            //处理用户名
            NSArray *userArray = [CustomMethod addObjectArr:barageMessage beginFlage:@"{" endFlag:@"}"];
            if (userArray && [userArray count])
            {
                NSDictionary *chatMemberDic = [[UserInfoManager shareUserInfoManager] allUserIdAndNick];
                for (NSString *flagUserId in userArray)
                {
                    
                    NSString *userId = [[NSString alloc] initWithString:[flagUserId substringWithRange:NSMakeRange(1, [flagUserId length] - 2)]];
                    NSString *nick = [chatMemberDic objectForKey:[NSNumber numberWithInteger: [userId integerValue]]];
                    if (nick)
                    {
                        NSRange soureRange = [barageMessage rangeOfString:flagUserId];
                        barageMessage =  [barageMessage stringByReplacingCharactersInRange:NSMakeRange(soureRange.location, soureRange.length) withString:nick];
                    }
                }
            }
            [_barrageMessageLock lock];
            [_barrageMessageMArray addObject:barageMessage];
            if (_barrageMessageMArray.count > 50)
            {
                NSMutableArray *newBarrageMessages = [NSMutableArray array];
                [newBarrageMessages addObjectsFromArray:[_barrageMessageMArray subarrayWithRange:NSMakeRange(_barrageMessageMArray.count - 18, 18)]];
                
                for (NSInteger nIndex = _barrageMessageMArray.count - 18; nIndex >= 0; nIndex--)
                {
                    NSString *tempBarrageMessage = [_barrageMessageMArray objectAtIndex:nIndex];
                    if (tempBarrageMessage && [tempBarrageMessage containsString:currentUserInfo.nick])
                    {
                        [newBarrageMessages insertObject:tempBarrageMessage atIndex:0];
                    }
                }
                [_barrageMessageMArray removeAllObjects];
                [_barrageMessageMArray addObjectsFromArray:newBarrageMessages];
            }
            [_barrageMessageLock unlock];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.barrageView showBarrageView];
            });
        }
    });
}

#pragma mark -BbarrageMessageDataSource
- (NSString *)GetBarrageMessageFromQueue
{
    NSString *barrageMessage = nil;
    [_barrageMessageLock lock];
    if (_barrageMessageMArray.count)
    {
        barrageMessage = [_barrageMessageMArray firstObject];
        [_barrageMessageMArray removeObjectAtIndex:0];
    }

    [_barrageMessageLock unlock];
    return barrageMessage;
}

#pragma mark -CommandManager

- (void)tcpWillDisconnectWithErro
{
    if ([CommandManager shareInstance].connectSuccess)
    {
        self.tcpDisconnectWithErro = YES;
    }
}

- (void)tcpConectSuccess
{
    self.tcpDisconnectWithErro = NO;
    if(_heartTimer == nil)
    {
        _heartTimer = [NSTimer scheduledTimerWithTimeInterval:[AppInfo shareInstance].heart_time target:self selector:@selector(OnHeartTimer:) userInfo:nil repeats:YES];
    }
    [self sendAuthData];
}

- (void)tcpDidDisconect
{
    if (_heartTimer)
    {
        [_heartTimer invalidate];
        _heartTimer = nil;
    }
    
    if (_getApproveTimer)
    {
        [_getApproveTimer invalidate];
        _getApproveTimer = nil;
    }
    if (self.tcpDisconnectWithErro)
    {
        self.tcpDisconnectWithErro = NO;
        self.reconnect = YES;
        [self enterRoom];
    }
    

}

- (void)tcpSendDataFail
{
    [self showNoticeInWindow:@"网络异常操作失败，请稍后再试！"];
    self.reconnect = YES;
    if ([CommandManager shareInstance].tcpConnecting)
    {
        [self performSelector:@selector(enterRoom) withObject:nil afterDelay:EnterRoom_TimeOut];
    }
    else
    {
        [self enterRoom];
    }
}

#pragma mark _一分钟累加一个赞
- (void)getApproveResult:(NSNotification *)notification
{
    NSDictionary *bodyDic = [notification userInfo];
    EWPLog(@"bodyDic = %@",bodyDic);
    
    GetApproveModel *model = [[GetApproveModel alloc] initWithData:bodyDic];
    if (model)
    {
        UserInfo *userInfo = [UserInfoManager shareUserInfoManager].currentUserInfo;
        if (userInfo)
        {
            if (userInfo.userId == model.userid)
            {
                userInfo.leavecount = model.leavecount;
                userInfo.getcount = model.getcount;
                userInfo.sendcount = model.sendcount;
                userInfo.maxcount = model.maxcount;
                [UserInfoManager shareUserInfoManager].currentUserInfo = userInfo;
                _praiseCount.text = [NSString stringWithFormat:@"%ld",(long)model.leavecount];
                
                if (userInfo.getcount == userInfo.maxcount)
                {
                    //关闭定时器
                    [self stopGetApprove];
                    return;
                }
            }
            
        }
    }
}


#pragma mark _获取用户赞

//- (void)getUserPraiseNum
//{
//    if (![AppInfo shareInstance].bLoginSuccess)
//    {
//        _praiseCount.text = @"1";
//        return;
//    }
//    
//    UserInfo *userInfo = [UserInfoManager shareUserInfoManager].currentUserInfo;
//    if (userInfo)
//    {
//        GetPraisenumModel *model = [[GetPraisenumModel alloc] init];
//        [model requestDataWithParams:nil success:^(id object) {
//            if (model.result == 0)
//            {
//                userInfo.leavecount = model.leavecount; //剩下赞
//                userInfo.getcount = model.getcount;   //所有赞
//                userInfo.sendcount = model.sendcount;  //送出赞
//                userInfo.maxcount = model.maxcount;
//                [UserInfoManager shareUserInfoManager].currentUserInfo = userInfo;
//                
//                _praiseCount.text = [NSString stringWithFormat:@"%ld",(long)model.leavecount];
//                
//                if(_getApproveTimer == nil)
//                {
//                    [self getApprove];
//                }
//            }
//            else
//            {
//                if (model.code == 403)
//                {
//                    [[AppInfo shareInstance] loginOut];
//                    [self showOherTerminalLoggedDialog];
//                    [self autoExitRoom];
//                    return ;
//                }
//                
//                if (model.title && [model.title isEqualToString:@"用户没有登陆！"])
//                {
//                    [[AppInfo shareInstance] loginOut];
//                    [self showOherTerminalLoggedDialog];
//                    [self autoExitRoom];
//                    return;
//                }
//               
//            }
//
//        }
//        fail:^(id object) {
//            
//        }];
//    }
//
//}

//获取主播赞
- (void)getStarPraiseNum
{
    StarInfo *starInfo = [UserInfoManager shareUserInfoManager].currentStarInfo;
    if (starInfo)
    {
        NSDictionary *param = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:starInfo.userId] forKey:@"staruserid"];
        GetStarPraiseNumModel *model = [[GetStarPraiseNumModel alloc] init];
        [model requestDataWithParams:param success:^(id object) {
            if (model.result == 0)
            {
                starInfo.starmonthpraisecount = model.starmonthpraisecount;
                if (self.starApprove)
                {
                    if (starInfo.starmonthpraisecount)
                    {
                        self.starApprove.hidden = NO;
                    }
                    else
                    {
                        self.starApprove.hidden = YES;
                    }
                    self.starApprove.text = [NSString stringWithFormat:@"%ld",(long)starInfo.starmonthpraisecount];
                }
            }
        } fail:^(id object) {
            
        }];
    }
    
}

- (void)receiverErro:(NSNotification *)notification
{
    NSDictionary *bodyDic = [notification userInfo];
    EWPLog(@"bodyDic = %@",bodyDic);
    
    if (bodyDic)
    {
        NSInteger result = [[bodyDic objectForKey:@"result"] integerValue];
        NSString *msg = [bodyDic objectForKey:@"msg"];
        switch (result)
        {
            case 101:
            {
                //未登录或者token超时;
                [self showNoticeInWindow:@"未登录或者token超时"];
                [self performSelectorOnMainThread:@selector(autoExitRoom) withObject:nil waitUntilDone:NO];
            }
                break;
            case 102:
            {
                //输入非法
                if (msg == nil)
                {
                    msg = @"输入非法";
                }
                [self showNoticeInWindow:msg];
                
            }
                break;
            case 103:
            {
                //货币冻结
                if (msg == nil)
                {
                    msg = @"货币冻结";
                }
                
                [self showNoticeInWindow:msg];
                
            }
                break;
            case 0:
            {
                //失败
            }
                break;
            case 2:
            {
                //所送礼物不存在
                if (msg == nil)
                {
                    msg = @"所送礼物不存在";
                }
                [self showNoticeInWindow:msg];
            }
                break;
            case 4:
            {
                //送礼人金币不足
                if (self.entireview.bRobbingSofa)
                {
                    self.entireview.bRobbingSofa = NO;
                }
                [self showRechargeDialog];
            }
                break;
            case 5:
            {
                //送礼接收人不存在
                if (msg == nil)
                {
                    msg = @"送礼接收人不存在";
                }
                [self showNoticeInWindow:msg];
            }
                break;
            case 6:
            {
                //送礼人不存在
                if (msg == nil)
                {
                    msg = @"送礼人不存在";
                }
                [self showNoticeInWindow:msg];
            }
                break;
            case 11:
            {
                //被禁言提醒
                if (msg == nil)
                {
                    msg = @"您已被禁言,无法发言!";
                }
                [self showNoticeInWindow:msg];
            }
                break;
            case 201:
            {
                if (msg == nil)
                {
                    msg = @"抢沙发失败";
                }self.entireview.bRobbingSofa = NO;
                [self showNoticeInWindow:msg];
            }
                break;
            case 210:
            {
                if (msg == nil)
                {
                    msg = @"点赞失败";
                }
                [self showNoticeInWindow:msg];
            }
                break;
            default:
                break;
        }
    }
}

- (void)resetConnect
{
    self.reconnect = YES;
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
                
                [CommonFuction performMethodInMainThread:YES afterDelay:0.5 methodBlock:^{
                    [self pushCanvas:ActivityUrl_Canvas withArgument:param];
                }];
                
            }
            else if (currentShowType.actionLink == 2)
            {
                self.staruserid = [currentShowType.data integerValue];
            }
            else if (currentShowType.actionLink == 3)
            {
                [CommonFuction performMethodInMainThread:YES afterDelay:0.5 methodBlock:^{
                    [self pushCanvas:Mall_Canvas withArgument:nil];
                }];
                
            }
            else if (currentShowType.actionLink == 4)
            {
                if (![AppInfo shareInstance].bLoginSuccess)
                {
                    [CommonFuction performMethodInMainThread:YES afterDelay:0.5 methodBlock:^{
                        [self pushCanvas:Login_Canvas withArgument:nil];
                    }];
                    
                }
                else
                {
                    [CommonFuction performMethodInMainThread:YES afterDelay:0.5 methodBlock:^{
                        [self pushCanvas:SelectModePay_Canvas withArgument:nil];
                    }];
                }
                
            }
            
        }
        else if (currentShowType.messageType == 2)
        {
            [CommonFuction performMethodInMainThread:YES afterDelay:0.5 methodBlock:^{
                [self pushCanvas:PersonInfo_Canvas withArgument:nil];
            }];
            
        }
        else if (currentShowType.messageType == 3)
        {
            self.staruserid = currentShowType.staruserId;
        }
    }
    
    [self performSelector:@selector(getStarInfo) withObject:nil];
}

//- (void)disConnect
//{
//    [self stopVideoPlayThread];
//}

#pragma mark addMesage

- (void)addGlobalGiftInfo:(GlobalMessageModel *)model
{
    if (model.fromuserid != 0 && [model.fromnick length] > 0)
    {
        UserInfo *userInfo = [[UserInfo alloc] init];
        userInfo.userId = model.fromuserid;
        userInfo.nick = model.fromnick;
        userInfo.hidden = model.hidden;
        userInfo.hiddenindex = model.hiddenindex;
        userInfo.issupermanager = model.issupermanager;
        [[UserInfoManager shareUserInfoManager] addMemberInfo:userInfo];
    }
    
    if (model.touserid != 0 && [model.tonick length] > 0)
    {
        UserInfo *userInfo = [[UserInfo alloc] init];
        userInfo.userId = model.touserid;
        userInfo.nick = model.tonick;
        userInfo.hidden = model.thidden;
        userInfo.hiddenindex = model.thiddenindex;
        userInfo.issupermanager = model.tissupermanager;
        [[UserInfoManager shareUserInfoManager] addMemberInfo:userInfo];
    }
    
    
    NSString *headString = nil;
    
    if (model.fromuserid != 0 && model.touserid != 0)
    {
        headString = [NSString stringWithFormat:@"{%ld}送给{%ld}",(long)model.fromuserid,(long)model.touserid];
    }
    if([AppInfo shareInstance].res_server && model.giftimg)
    {
        //暂时屏蔽
//        NSString *giftUrl = [NSString stringWithFormat:@"%@%@",[AppInfo shareInstance].res_server,model.giftimg];
//        NSString *scrollMessage = [NSString stringWithFormat:@"%@%ld%@%@<%@>",headString,(long)model.giftnum,model.giftunit,model.giftname,giftUrl];
        NSString *scrollMessage = [NSString stringWithFormat:@"%@%ld%@%@",headString,(long)model.giftnum,model.giftunit,model.giftname];
        
        [self.scrollNotice addMessage:scrollMessage];
        [_scrollNotice start];
    }

}

- (void)addGloableSofaInfo:(GlobalMessageModel *)model
{
    if (model.fromuserid != 0 && [model.fromnick length] > 0)
    {
        UserInfo *userInfo = [[UserInfo alloc] init];
        userInfo.userId = model.fromuserid;
        userInfo.nick = model.fromnick;
        userInfo.hidden = model.hidden;
        userInfo.hiddenindex = model.hiddenindex;
        userInfo.issupermanager = model.issupermanager;
        [[UserInfoManager shareUserInfoManager] addMemberInfo:userInfo];
    }
    
    if (model.staruserid != 0 && [model.starnick length] > 0)
    {
        UserInfo *userInfo = [[UserInfo alloc] init];
        userInfo.userId = model.staruserid;
        userInfo.nick = model.starnick;
        userInfo.hidden = model.thidden;
        userInfo.hiddenindex = model.thiddenindex;
        userInfo.issupermanager = model.tissupermanager;
        [[UserInfoManager shareUserInfoManager] addMemberInfo:userInfo];
    }
    
    NSString *scrollMessage = [NSString stringWithFormat:@"{%ld}用%ld%@沙发抢得了{%ld}的贵宾席位",(long)model.fromuserid,(long)model.giftnum,model.giftunit,(long)model.staruserid];
    
    [self.scrollNotice addMessage:scrollMessage];
    [_scrollNotice start];

}

//幸运礼物中奖通知
-(void)addGloableLuckyGiftsInfo:(GlobaMessageLuckyModel *)model
{
    if (model.userid != 0 && [model.usernick length] > 0)
    {
        UserInfo *userInfo = [[UserInfo alloc] init];
        userInfo.userId = model.userid;
        userInfo.nick = model.usernick;
        userInfo.hidden = model.hidden;
        userInfo.hiddenindex = model.hiddenindex;
        userInfo.issupermanager = model.issupermanager;
        [[UserInfoManager shareUserInfoManager] addMemberInfo:userInfo];
    }
    
    NSString *headString = nil;
    
    if (model.rewardCoin >= 5000)
    {
        if (model.userid != 0 && model.rewardtype == 2)
        {
            headString = [NSString stringWithFormat:@"恭喜{%ld}获得幸运礼物大奖 %ld 倍 %@ 奖励，奖金 %ld 热币，小伙伴们快去试试手气吧。",(long)model.userid,(long)model.rewardbs,model.giftname,(long)model.rewardCoin];
        }
        else
        {
            headString = [NSString stringWithFormat:@"恭喜{%ld}获得幸运礼物大奖 %@ 奖励，奖金 %ld 热币，小伙伴们快去试试手气吧。",(long)model.userid,model.giftname,(long)model.rewardCoin];
        }
    }
   
    
    if([AppInfo shareInstance].res_server && model.giftimg)
    {
        [self.scrollNotice addMessage:headString];
        [_scrollNotice start];
    }
}


//- (void)OnDisplayBackBtn
//{
//    [self.chatToolBar hideKeyBoard];
//
//    if (_entireview == nil || (_entireview && _entireview.hidden == YES) )
//    {
//        //房间最顶端
//        UIControl *backView = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
//        backView.backgroundColor = [UIColor clearColor];
//        [backView addTarget:self action:@selector(hideToolBar) forControlEvents:UIControlEventTouchUpInside];
//        backView.tag = 1111;
//        [self.view addSubview:backView];
//        
//        NavBackBar *navBackBar = [[NavBackBar alloc] initWithFrame:CGRectMake(0, -40, SCREEN_WIDTH, 40) showInView:self.view];
//        navBackBar.tag = 2222;
//        navBackBar.title = [UserInfoManager shareUserInfoManager].currentStarInfo.nick;
//        [self.view addSubview:navBackBar];
//        __weak typeof(self) weakSelf = self;
//        navBackBar.backButtonBlock = ^(id sender)
//        {
//            __strong typeof(self) strongSelf = weakSelf;
//            [UserInfoManager shareUserInfoManager].currentStarInfo = nil;
//            [strongSelf autoExitRoom];
//        };
//        [self.view addSubview:navBackBar];
//        
//        //举报按钮,视图最顶端
//        EWPButton *reportBtn = [EWPButton buttonWithType:UIButtonTypeCustom];
//        reportBtn.tag = 3333;
//        reportBtn.frame = CGRectMake(self.view.frame.size.width - 42, 50, 40, 40);
//        [reportBtn setImage:[UIImage imageNamed:@"reportstar_normal"] forState:UIControlStateNormal];
//        reportBtn.buttonBlock = ^(id sender)
//        {
//            [self reportUser:[UserInfoManager shareUserInfoManager].currentStarInfo];
//        };
//        [self.view addSubview:reportBtn];
//        
//         
//        //接收礼物消息按钮
//        EWPButton *giftBtn = [EWPButton buttonWithType:UIButtonTypeCustom];
//        giftBtn.tag = 4444;
//        giftBtn.frame = CGRectMake(self.view.frame.size.width - 42, 96, 40, 40);
//        [giftBtn setImage:[UIImage imageNamed:@"shieldGift"] forState:UIControlStateNormal];
//        [giftBtn setImage:[UIImage imageNamed:@"shieldGift_Select"] forState:UIControlStateSelected];
//        giftBtn.selected = _shieldGift;
//        giftBtn.buttonBlock = ^(id sender)
//        {
//            EWPButton *btn = (EWPButton *)sender;
//            if (_shieldGift == YES)
//            {
//                _shieldGift = NO;
//                [self showNoticeInWindow:@"礼物动画已开启"];
//                btn.selected = NO;
//            }
//            else
//            {
//                _shieldGift = YES;
//                [_singleGiftContainerView hideGiftAnimation];
//                [_moreGiftContainerView hideGiftAnimation];
//                [_giftAnimationMArray removeAllObjects];
//                [self showNoticeInWindow:@"礼物动画已关闭"];
//                btn.selected = YES;
//            }
//        };
//        [self.view addSubview:giftBtn];
//        
//        
//        //接收弹幕消息按钮
//        EWPButton *barrageBtn = [EWPButton buttonWithType:UIButtonTypeCustom];
//        barrageBtn.tag = 5555;
//        barrageBtn.frame = CGRectMake(self.view.frame.size.width - 42, 143, 40, 40);
//        [barrageBtn setImage:[UIImage imageNamed:@"shieldBarrage"] forState:UIControlStateNormal];
//        [barrageBtn setImage:[UIImage imageNamed:@"shieldBarrage_Select"] forState:UIControlStateSelected];
//        barrageBtn.selected = _shieldBarrage;
//        barrageBtn.buttonBlock = ^(id sender)
//        {
//            EWPButton *btn = (EWPButton *)sender;
//            if (_shieldBarrage == YES)
//            {
//                _shieldBarrage = NO;
//                [self showNoticeInWindow:@"弹幕已开启"];
//                btn.selected = NO;
//            }
//            else
//            {
//                _shieldBarrage = YES;
//                [_barrageMessageMArray removeAllObjects];
//                [self.barrageView hideBarrageView];
//                [self showNoticeInWindow:@"弹幕已关闭"];
//                btn.selected = YES;
//            }
//        };
//        [self.view addSubview:barrageBtn];
//        
//        
//        //音视频切换按钮
//        if (_audioOrVideoBtn == nil)
//        {
//            _audioOrVideoBtn = [EWPButton buttonWithType:UIButtonTypeCustom];
//            _audioOrVideoBtn.tag = 6666;
//            _audioOrVideoBtn.frame = CGRectMake(self.view.frame.size.width - 42, 190, 40, 40);
//            [_audioOrVideoBtn setImage:[UIImage imageNamed:@"video"] forState:UIControlStateNormal];
//            [_audioOrVideoBtn setImage:[UIImage imageNamed:@"audio"] forState:UIControlStateSelected];
//        }
//        _audioOrVideoBtn.selected = _isPlayVideo;
//        
//        _audioOrVideoBtn.buttonBlock = ^(id sender)
//        {
//            __strong typeof(weakSelf) strongSelf = weakSelf;
//            if (strongSelf)
//            {
//                StarInfo *starInfo =  [UserInfoManager shareUserInfoManager].currentStarInfo;
//                if (starInfo)
//                {
//                    if (!starInfo.onlineflag)
//                    {
//                        [strongSelf showNoticeInWindow:@"Star未开播,不能切换音视频模式"];
//                        return;
//                    }
//                    
//                    if (strongSelf.isPlayVideo)
//                    {
//                        [strongSelf showNoticeInWindow:@"切换为音频模式"];
//                    }
//                    else
//                    {
//                        [strongSelf showNoticeInWindow:@"切换为视频模式"];
//                    }
//                    [strongSelf changePlayMode:[NSNumber numberWithBool:!strongSelf.isPlayVideo]];
//                }
//
//            }
//        };
//        [self.view addSubview:_audioOrVideoBtn];
//        
////        弹出下面的toolbar
//        if (_entireview == nil)
//        {
//            _entireview = [[EntireView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, self.view.frame.size.width, 195) showInView:self.view];
//            _entireview.delega = self;
//            _entireview.rootViewController = self;
//            [self.view addSubview:_entireview];
//        }
//        _entireview.hidden = NO;
//        _entireview.personData = self.persondata;
//        [_entireview viewWillAppear];
//              
//        [UIView animateWithDuration:0.1f animations:^{
//            _videoImage.userInteractionEnabled = NO;
//            CGRect navBackFrame = navBackBar.frame;
//            navBackFrame.origin.y += navBackFrame.size.height;
//            navBackBar.frame = navBackFrame;
//            
//            CGRect frame = self.entireview.frame;
//            frame.origin.y -= frame.size.height;
//            self.entireview.frame = frame;
//            
//            _audioOrVideoBtn.hidden = NO;
//        } completion:^(BOOL finished) {
//             _videoImage.userInteractionEnabled = YES;
//            
//            CGRect praiseBackViewFrame = _praiseBackView.frame;
//            praiseBackViewFrame.origin.y = 50;
//            _praiseBackView.frame = praiseBackViewFrame;
//        }];
//    }
//    else
//    {
//         [self hideToolBar];
//    }
//    [self.view bringSubviewToFront:self.entireview];
//}

- (void)hideToolBar
{
    [self.chatToolBar hideKeyBoard];
    
    NavBackBar *navBackBar = (NavBackBar *)[self.view viewWithTag:2222];
    EWPButton *reportBtn = (EWPButton *)[self.view viewWithTag:3333];
    EWPButton *giftBtn = (EWPButton *)[self.view viewWithTag:4444];
    EWPButton *barrageBtn = (EWPButton *)[self.view viewWithTag:5555];
    EWPButton *audioOrVideoBtn = (EWPButton *)[self.view viewWithTag:6666];
    UIView *backView = [self.view viewWithTag:1111];
    
    [UIView animateWithDuration:0.1f animations:^{
         _videoImage.userInteractionEnabled = NO;
        CGRect navBackFrame = navBackBar.frame;
        navBackFrame.origin.y -= navBackFrame.size.height;
        navBackBar.frame = navBackFrame;
        

        
        reportBtn.hidden = YES;
        giftBtn.hidden = YES;
        barrageBtn.hidden = YES;
        audioOrVideoBtn.hidden = YES;
        CGRect frame = self.entireview.frame;
        frame.origin.y += frame.size.height;
        self.entireview.frame = frame;
        
    } completion:^(BOOL finished) {
         _videoImage.userInteractionEnabled = YES;
        [backView removeFromSuperview];
        [navBackBar removeFromSuperview];
        [reportBtn removeFromSuperview];
        [giftBtn removeFromSuperview];
        [barrageBtn removeFromSuperview];
        self.entireview.hidden = YES;
        [self.entireview removeFromSuperview];
        self.entireview = nil;
        
        CGRect praiseBackViewFrame = _praiseBackView.frame;
        praiseBackViewFrame.origin.y = 0;
        _praiseBackView.frame = praiseBackViewFrame;
    }];
}


- (void)showChatToolBar:(BOOL)show
{
    if (self.chatToolBar == nil )
    {
        return;
    }
    [self.chatToolBar hideKeyBoard];
    if (self.showChatToolBar == show)
    {
        return;
    }
    if (show)
    {

        [UIView animateWithDuration:0.1f animations:^{
            CGRect frame = self.chatToolBar.frame;
            frame.origin.y -= frame.size.height;
            self.chatToolBar.frame = frame;
        } completion:^(BOOL finished) {
            self.showChatToolBar = YES;
        }];
    }
    else
    {
        [UIView animateWithDuration:0.1f animations:^{
            CGRect frame = self.chatToolBar.frame;
            frame.origin.y += frame.size.height;
            self.chatToolBar.frame = frame;
        } completion:^(BOOL finished) {
            self.showChatToolBar = NO;
        }];
    }
}

#pragma mark - ChatToolBarDelegate
- (void)sendMessage:(NSDictionary *)param
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:param];
    if (param)
    {
        if ([param objectForKey:@"chatType"])
        {
            NSInteger chatType = [[param objectForKey:@"chatType"] integerValue];
            if (chatType == 1)
            {
                UserInfo *currentUserInfo = [UserInfoManager shareUserInfoManager].currentUserInfo;
                if (!currentUserInfo.issupermanager)
                {
                    //不是超管
                    if (self.roomInfoData.publictalkstatus == 2)
                    {
                        [self showNoticeInWindow:@"本房间已关闭公聊"];
                        return;
                    }
                    else if (self.roomInfoData.publictalkstatus == 3)
                    {
                        if (!currentUserInfo.managerflag)
                        {
                            [self showNoticeInWindow:@"本房间不允许公聊"];
                            return;
                        }
                    }
                    else if (self.roomInfoData.publictalkstatus == 4)
                    {
                        BOOL bVip = NO;
                        if (currentUserInfo.isYellowVip)
                        {
                            bVip = YES;
                        }
                        else
                        {
                            if (currentUserInfo.isPurpleVip)
                            {
                                bVip = YES;
                            }
                        }
                        if (!bVip)
                        {
                            [self showNoticeInWindow:@"本房间禁止公聊，成为VIP可不受此限制"];
                            return;
                        }
                    }
                    //不是超管
                    if (self.roomInfoData.showtype == 3)
                    {
                        //明星直播间
                        if(self.roomInfoData.showid != 0)
                        {
                            //明星直播间正在直播,聊天时间间隔受限制
                            //超管和房管不收间隔限制
                            if (!currentUserInfo.managerflag)
                            {
                                //不是超管，也不是房管
                                if(_chatTimer == nil)
                                {
                                    if (currentUserInfo.isPurpleVip)
                                    {
                                        self.chatTime = self.roomInfoData.chatintervalpurplevip;
                                    }
                                    else if (currentUserInfo.isYellowVip)
                                    {
                                        self.chatTime = self.roomInfoData.chatintervalyellowvip;
                                    }
                                    else
                                    {
                                        self.chatTime = self.roomInfoData.chatintervalcommon;
                                    }
                                    if (self.chatTime != 0)
                                    {
                                        _chatTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(sendMessageTimer) userInfo:nil repeats:YES];
                                    }
                                    
                                }
                                else
                                {
                                    [self showNoticeInWindow:@"发言太快了，歇一会再聊吧！"];
                                    return;
                                }
                            }
                        }
                    }
                }
                self.tabMenu.currentSelectedSegmentIndex = 0;
            }
            else
            {
                self.tabMenu.currentSelectedSegmentIndex = 1;
            }
            [ChatMessageModel sendMessage:params];
        }
        else
        {
            if (!self.roomInfoData.openflag)
            {
                [self showNoticeInWindow:@"Star已关闭弹幕功能"];
                return;
            }
            if (self.persondata && self.persondata.showid != 0)
            {
                [params setObject:[NSNumber numberWithInteger: self.persondata.showid] forKey:@"showid"];
            }
            [BarrageMessageModel sendBarrageMessage:params];
        }  
        
    }
}

#pragma mark -送礼物
- (void)giveGift:(NSDictionary *)giftInfo
{
    if ([self showLoginDialog])
    {
        return;
    }
    
    NSInteger coin = [[giftInfo objectForKey:@"coin"] integerValue];
    if ([self showRechargeDialogWithCostCoin:coin])
    {
        return;
    }
    
    UserInfo *currentUserInfo = [UserInfoManager shareUserInfoManager].currentUserInfo;
    StarInfo *starInfo = [UserInfoManager shareUserInfoManager].currentStarInfo;

    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithDictionary:giftInfo];
    [dictionary setObject:[NSNumber numberWithInteger:currentUserInfo.userId] forKey:@"useridfrom"];
    [dictionary setObject:currentUserInfo.nick forKey:@"usernickfrom"];
    [dictionary setObject:[NSNumber numberWithInteger:starInfo.userId] forKey:@"staruserid"];
    [dictionary setObject:[NSNumber numberWithInteger:starInfo.starid] forKey:@"starid"];
    [dictionary setObject:[NSNumber numberWithInt:1] forKey:@"giftsource"];
    [dictionary setObject:[NSNumber numberWithInteger:starInfo.roomid] forKey:@"roomid"];
    [dictionary setObject:[CommonFuction getPlatformString] forKey:@"clienttypeinfo"];
    [dictionary removeObjectForKey:[giftInfo objectForKey:@"coin"]];
    [dictionary setObject:[NSNumber numberWithInteger:self.persondata.showid] forKey:@"showid"];
    [GiveGiftModel giveGift:dictionary];
    self.tabMenu.currentSelectedSegmentIndex = 0;
}

#pragma mark - 去充值
- (void)goToRechargeView
{
    if ([self showLoginDialog])
    {
        return;
    }
    NSString *className = NSStringFromClass([self class]);
    NSDictionary *param = [NSDictionary dictionaryWithObject:className forKey:@"className"];
    NSInteger hideSwitch = [[[AppInfo shareInstance].hideSwitch substringToIndex:1] integerValue];
    if (hideSwitch == 1)
    {
        [self pushCanvas:AppStore_Recharge_Canvas withArgument:param];
    }
    else
    {
        [self pushCanvas:SelectModePay_Canvas withArgument:param];
    }
}

#pragma mark - RobSofaViewDelegate
- (void)robSofaView:(EntireView *)entire sofaData:(SofaData *)sofaData
{
   if ([self showLoginDialog])
    {
        return;
    }
    
    sofaData.robSofaNum = sofaData.num + 1;
    
    _sofaDialog = [[EWPSimpleDialog alloc] initWithFrame:CGRectMake(0, 0, 270, 173)];
    _sofaDialog.layer.borderColor = [UIColor whiteColor].CGColor;
    _sofaDialog.backgroundColor = [UIColor whiteColor];
    _sofaDialog.layer.cornerRadius = 4.0f;
    _sofaDialog.layer.borderWidth = 1.0f;

    NSMutableString *priceTipString = [NSMutableString string];
    [priceTipString appendFormat:@"当前底价:%ld个沙发(1个沙发=100热币)",(long)sofaData.robSofaNum];
    
    CGSize size = [CommonFuction sizeOfString:priceTipString maxWidth:270 - 20 maxHeight:20 withFontSize:13.0f];
    
    UILabel *priceTipLable = [[UILabel alloc] initWithFrame:CGRectMake(15, 21, size.width, 20)];
    priceTipLable.text = priceTipString;
    priceTipLable.textColor = [CommonFuction colorFromHexRGB:@"575757"];
    priceTipLable.font = [UIFont systemFontOfSize:13.0f];
    [_sofaDialog addSubview:priceTipLable];
    
    UIImageView *hLineImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, 50, 240, 0.5)];
    hLineImg.backgroundColor = [CommonFuction colorFromHexRGB:@"e5e5e5"];
    [_sofaDialog addSubview:hLineImg];
    
    UILabel *myPrice = [[UILabel alloc] initWithFrame:CGRectMake(20, 70, 90, 30)];
    myPrice.text = @"我的出价";
    myPrice.font = [UIFont systemFontOfSize:12];
    myPrice.textColor = [CommonFuction colorFromHexRGB:@"575757"];
    [_sofaDialog addSubview:myPrice];
    UITextField *inputCoin = [[UITextField alloc] initWithFrame:CGRectMake(75, 70, 130, 30)];
    self.sofaCoin = inputCoin;
    inputCoin.font = [UIFont systemFontOfSize:15];
    inputCoin.userInteractionEnabled = NO;
    inputCoin.text = [NSString stringWithFormat:@"%ld个沙发",(long)sofaData.robSofaNum];
    [inputCoin setTextColor:[CommonFuction colorFromHexRGB:@"575757"]];
    inputCoin.backgroundColor = [CommonFuction colorFromHexRGB:@"e4e4e4"];
    inputCoin.textAlignment= NSTextAlignmentCenter;
    [_sofaDialog addSubview:inputCoin];
    
    self.robSofaData = sofaData;
    UIButton *add = [UIButton buttonWithType:UIButtonTypeCustom];
    add.frame = CGRectMake(inputCoin.frame.origin.x + inputCoin.frame.size.width, 70, 30, 30);
    [add setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [add setImage:[UIImage imageNamed:@"add_select"] forState:UIControlStateHighlighted];
    [add addTarget:self action:@selector(addSofaCoin:) forControlEvents:UIControlEventTouchUpInside];
    [_sofaDialog addSubview:add];
    
    __weak typeof(self) weakSelf = self;
//    [dialog setLeftBtnTitle:@"确认" normalImg:normalImg selectedImg:selectimg buttonBlock:^(id sender){
//        weakSelf.toolBar.bRobbingSofa = YES;
//        [weakSelf robSofa:sofaData];
//    }];
    
    UIImage *normalImg = [CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"d14c49" ] size:CGSizeMake(100, 32)];
    UIImage *selectImg = [CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"d14c49" ] size:CGSizeMake(100, 32)];

    EWPButton *confirmBtn = [[EWPButton alloc] initWithFrame:CGRectMake(140, 120, 100, 32)];
    [confirmBtn setBackgroundImage:normalImg forState:UIControlStateNormal];
    [confirmBtn setBackgroundImage:selectImg forState:UIControlStateHighlighted];
    confirmBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    [confirmBtn setTitleColor:[CommonFuction colorFromHexRGB:@"d14c49"] forState:UIControlStateNormal];
    [confirmBtn setTitleColor:[CommonFuction colorFromHexRGB:@"ffffff"] forState:UIControlStateHighlighted];
    confirmBtn.layer.cornerRadius = 16.0f;
    confirmBtn.layer.borderWidth = 1;
    confirmBtn.layer.masksToBounds = YES;
    confirmBtn.layer.borderColor = [CommonFuction colorFromHexRGB:@"d14c49"].CGColor;
    [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [_sofaDialog addSubview:confirmBtn];
    
    [confirmBtn setButtonBlock:^(id sender)
     {
         weakSelf.entireview.bRobbingSofa = YES;
         [weakSelf robSofa:sofaData];
     }];

    EWPButton *cancelBtn = [[EWPButton alloc] initWithFrame:CGRectMake(20, 120, 100, 32)];
    [cancelBtn setBackgroundImage:normalImg forState:UIControlStateNormal];
    [cancelBtn setBackgroundImage:selectImg forState:UIControlStateHighlighted];
    cancelBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    [cancelBtn setTitleColor:[CommonFuction colorFromHexRGB:@"d14c49"] forState:UIControlStateNormal];
    cancelBtn.layer.cornerRadius = 16.0f;
    cancelBtn.layer.borderWidth = 1;
    cancelBtn.layer.masksToBounds = YES;
    cancelBtn.layer.borderColor = [CommonFuction colorFromHexRGB:@"d14c49"].CGColor;
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [_sofaDialog addSubview:cancelBtn];
    
    [cancelBtn setButtonBlock:^(id sender)
     {
         [weakSelf hideReportDialog:nil];
     }];

    
    [_sofaDialog showInWindow];
}


- (void)changeNumber:(id)sender
{
    if ((long)self.robSofaData.robSofaNum >0) {
        self.robSofaData.robSofaNum--;
        self.sofaCoin.text = [NSString stringWithFormat:@"%ld个沙发",(long)self.robSofaData.robSofaNum];

    }
}

-(IBAction)addSofaCoin:(id)sender
{
    self.robSofaData.robSofaNum++;
    self.sofaCoin.text = [NSString stringWithFormat:@"%ld个沙发",(long)self.robSofaData.robSofaNum];
}

- (void)robSofa:(SofaData *)sofaData
{
    StarInfo *starInfo = [UserInfoManager shareUserInfoManager].currentStarInfo;
    UserInfo *userInfo = [UserInfoManager shareUserInfoManager].currentUserInfo;
    
    [self hideReportDialog:nil];
    
    if (!starInfo.onlineflag)
    {
        [self showNoticeInWindow:@"未直播，不能抢沙发"];
        self.entireview.bRobbingSofa = NO;
        return;
    }
    
    long long costCoin = 100 * sofaData.robSofaNum;
    if ([self showRechargeDialogWithCostCoin:costCoin])
    {
        self.entireview.bRobbingSofa = NO;
        return;
    }
    
    //抢沙发发送数据
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[NSNumber numberWithInteger:1] forKey:@"objectid"];
    [dic setObject:[NSNumber numberWithInteger:sofaData.robSofaNum] forKey:@"num"];
    [dic setObject:[NSNumber numberWithLongLong:sofaData.coin] forKey:@"coin"];
    [dic setObject:[NSNumber numberWithInteger:starInfo.starid] forKey:@"starid"];
    [dic setObject:[NSNumber numberWithInteger:starInfo.userId] forKey:@"staruserid"];
    [dic setObject:starInfo.nick forKey:@"usernickto"];
    [dic setObject:userInfo.nick forKey:@"usernickfrom"];
    [dic setObject:[NSNumber numberWithInteger: userInfo.userId] forKey:@"useridfrom"];
    [dic setObject:[NSNumber numberWithInteger:starInfo.roomid] forKey:@"roomid"];
    [dic setObject:[NSNumber numberWithInteger:self.persondata.showid] forKey:@"showid"];
    [dic setObject:@"2" forKey:@"actiontype"];
    [dic setObject:[NSNumber numberWithInteger:sofaData.sofano] forKey:@"sofano"];
    if (sofaData.num == 0)
    {
        [dic setObject:[NSNumber numberWithInteger:0] forKey:@"isupdateflag"];
    }
    else
    {
        [dic setObject:[NSNumber numberWithInteger:1] forKey:@"isupdateflag"];
    }
    
    [RobSofaModel robSofa:dic];
}

#pragma mark _- 点赞
- (void)sendApprove
{
    if ([self showLoginDialog])
    {
        return;
    }

    if (self.roomInfoData.showtype == 3)
    {
        if (self.showTimeInProgress)
        {
            if (_showTimeFreeApproveNumLock == nil)
            {
                _showTimeFreeApproveNumLock = [[NSLock alloc] init];
            }
            [_showTimeFreeApproveNumLock lock];
            self.showTimeSendFreeApproveNum++;
            [_showTimeFreeApproveNumLock unlock];
            self.showTimeTotalApproveCount = self.showTimeTotalApproveCount + 1;
            
            return;
        }
    }
    
    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionary];
    UserInfo *userInfo = [UserInfoManager shareUserInfoManager].currentUserInfo;
    if (userInfo )
    {
        if (userInfo.leavecount == 0 && userInfo.getcount == userInfo.maxcount)
        {
            [self showNoticeInWindow:@"今天的赞送完了哦！明天再送吧！"];
            return;
        }
        else if(userInfo.leavecount == 0 )
        {
            [self showNoticeInWindow:@"您还没有赞可以送哦！再等等吧！"];
            return;
        }
    }

    
    StarInfo *starInfo = [UserInfoManager shareUserInfoManager].currentStarInfo;
    
    [bodyDic setObject:[NSNumber numberWithInteger:userInfo.userId] forKey:@"userid"];
    [bodyDic setObject:userInfo.nick forKey:@"nick"];
    [bodyDic setObject:[NSNumber numberWithInteger:starInfo.userId] forKey:@"staruserid"];
    [bodyDic setObject:[NSNumber numberWithInteger:starInfo.starid] forKey:@"starid"];
    [bodyDic setObject:starInfo.nick forKey:@"starnick"];
    [bodyDic setObject:[NSNumber numberWithInteger:starInfo.roomid] forKey:@"roomid"];
    [bodyDic setObject:[NSNumber numberWithInteger:self.persondata.showid] forKey:@"showid"];
    
    [SendApproveModel sendApprove:bodyDic];
}

#pragma mark -获取赞
//- (void)getApprove
//{
//    if (self.roomInfoData.bigstarstate == 2 && self.roomInfoData.showtimestatus == 1)
//    {
//        //showtime正在进行时不获取赞
//        return;
//    }
//    UserInfo *userInfo = [UserInfoManager shareUserInfoManager].currentUserInfo;
//    StarInfo *starInfo = [UserInfoManager shareUserInfoManager].currentStarInfo;
//
//    if ((starInfo.onlineflag && userInfo.maxcount > userInfo.getcount))
//    {
//        if (_praiseBtn == nil)
//        {
//            [self showApproveView];
//        }
//        
//        if (_praiseView == nil)
//        {
//            if (self.playing)
//            {
//                self.praiseView = [[PraiseView alloc] initWithFrame:CGRectMake(-2, -1, 36, 36)];
//                self.praiseView.delegate = self;
//                [self.praiseBtn addSubview:self.praiseView];
//            }
//        }
//         
//        if (_getApproveTimer == nil)
//        {
//            if (self.playing)
//            {
//                _getApproveTimer= [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(onGetPraiseTimer) userInfo:nil repeats:YES];
//                //如果当天第一次进入房间通过getcount来判断，主动获取一个赞，然后返回
//                if (userInfo.getcount == 0)
//                {
//                    [self performSelector:@selector(getApprove) withObject:nil];
//                }
//            }
//            return;
//        }
//        
//        //获取赞请求
//        NSMutableDictionary *bodyDic = [NSMutableDictionary dictionary];
//        if (starInfo.onlineflag)
//        {
//            [bodyDic setObject:[NSNumber numberWithInteger:userInfo.userId] forKey:@"userid"];
//            [bodyDic setObject:[NSNumber numberWithInteger:starInfo.userId] forKey:@"staruserid"];
//            
//            [GetApproveModel getApprove:bodyDic];
//        }
//    }
//}

#pragma mark - 停止获取赞
- (void)stopGetApprove
{
    
    if (_getApproveTimer)
    {
        _prossTimes = 0;
        [_getApproveTimer invalidate];
        _getApproveTimer = nil;
    }

    if (_praiseView)
    {
        [_praiseView removeFromSuperview];
        _praiseView = nil;
    }
    _prossTimes = 0;
}


#pragma mark - 直播处理

//- (seeku *)currentSeeku:(BOOL)isVideo
//{
//    seeku *seekuInstance = nil;
//    
//    if (isVideo)
//    {
//        if (seeku_all == nil)
//        {
//            seeku_all = [[seeku alloc] init];
//            [seeku_all lib_audioSession_initialize];
//        }
//        seekuInstance = seeku_all;
//    }
//    else
//    {
//        if (seeku_audio == nil)
//        {
//            seeku_audio = [[seeku alloc] init];
//            [seeku_audio lib_audioSession_initialize];
//        }
//        seekuInstance = seeku_audio;
//    }
//
//    return seekuInstance;
//
//}

//- (void)changePlayMode:(NSNumber *)isPlayVideo
//{
//    [self stopVideoPlayThread];
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//            int try_count = 10;
//            while ( try_count-- )
//            {
//                [NSThread sleepForTimeInterval:0.5];
//                seeku *seekuInstance = [self currentSeeku:_isPlayVideo];
//                if ( [seekuInstance playing] == NO )
//                {
//                    dispatch_sync(dispatch_get_main_queue(), ^{
//                        [self startVideoPlay:isPlayVideo];
//                    });
//                    break;
//                }
//            }//while
//    });
//}

#pragma mark 开始直播
//- (void)startVideoPlay:(NSNumber *)isPlayVideo
//{
//    @autoreleasepool
//    {
//        BOOL isVideo = [isPlayVideo boolValue];
//        _isPlayVideo = isVideo;
//        _videoImage.hidden = NO;
//        
//        StarInfo *starInfo = [UserInfoManager shareUserInfoManager].currentStarInfo;
//
//        self.stopType = rsStopType_None;
//        NSString *liveUrl = nil;
//        if ([starInfo.liveip rangeOfString:@"://"].length > 0)
//        {
//            liveUrl = [NSString stringWithFormat:@"%@%@",starInfo.liveip,starInfo.livestream];
//        }
//        else
//        {
//            liveUrl = [NSString stringWithFormat:@"rtmp://%@/live/%@",starInfo.liveip,starInfo.livestream];
//        }
//        if (!isVideo)
//        {
//            liveUrl = [NSString stringWithFormat:@"%@?only-audio=1",liveUrl];
//            
//            [UIApplication sharedApplication].idleTimerDisabled = NO;
//        }
//        else
//        {
//            [UIApplication sharedApplication].idleTimerDisabled = YES;
//        }
////        视频播放
//        NSDictionary *myDict = [NSDictionary dictionaryWithObjectsAndKeys:_videoImage,@"imgview",liveUrl,@"playAdress", nil];
//        seeku *seekuInstance = [self currentSeeku:isVideo];
//        if (seekuInstance)
//        {
//            _videoImage.image = nil;
//            _loadVideoAnimationView.hidden = NO;
//            if (![_loadVideoAnimationView isAnimating])
//            {
//                [_loadVideoAnimationView startAnimating];
//            }
//            
//            [seekuInstance lib_seeku_single_play_hook: hook_func_call args:(void *)self];
//            [NSThread detachNewThreadSelector:@selector(lib_seeku_single_play_start:) toTarget:seekuInstance withObject:myDict];
//        }
//        if (_audioOrVideoBtn)
//        {
//            _audioOrVideoBtn.selected = _isPlayVideo;
//        }
//        EWPLog(@"liveUrl = %@",liveUrl);
//    }
//    
//}



//- (void)stopVideoPlayThread
//{
//    seeku *seekuInstance = [self currentSeeku:_isPlayVideo];
//    if (seekuInstance)
//    {
//        [NSThread detachNewThreadSelector:@selector(lib_seeku_single_play_stop) toTarget:seekuInstance withObject:nil];
//    }
//}

void hook_func_call(void *args)
{
    ChatRoomViewController *viewController = (__bridge ChatRoomViewController *)args;
    dispatch_sync(dispatch_get_main_queue(), ^{
        viewController.loadVideoAnimationView.hidden = YES;
        if (!viewController.isPlayVideo)
        {
            viewController.videoImage.image = [UIImage imageNamed:@"audioBK0"];
            [viewController showRoomImagesOrAudioAnimation];
        }
        else
        {
            UIImageView *audioAnimationView = (UIImageView *)[viewController.view viewWithTag:1000];
            if (audioAnimationView)
            {
                [audioAnimationView removeFromSuperview];
                audioAnimationView = nil;
            }
        }
            
        [viewController.videoImage setNeedsDisplay];
    });

}

#pragma mark - 显示推荐主播
- (void)showRecommendView
{
    
    //主播推荐
    if (_recommendStarView == nil)
    {
        _recommendStarView = [[HotStarsView alloc] initNoHotStarWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 240) title:@"本房间暂无直播" message:@"可以关注其他正在直播的Star哦！"];
        _recommendStarView.delegate = self;
        [_videoImage addSubview:_recommendStarView];
    }
    _recommendStarView.hidden = NO;
    if (_praiseBackView)
    {
        [_videoImage bringSubviewToFront:_praiseBackView];
    }
    [self getRecommendStarList];

}

#pragma mark - 显示主播照片集
//- (void)showRoomImages:(NSArray *)images
//{
//    if(_roomImgeView == nil)
//    {
//        _roomImgeView = [[EWPADView alloc] initWithFrame:CGRectMake(0, 0, 320, 240) placeHolderImg:[UIImage imageNamed:@"hotRecommendBigBtn.png"] adImgUrlArray:nil adBlock:nil];
//        _roomImgeView.hidePageControl = YES;
//        _roomImgeView.backgroundColor = [UIColor blackColor];
//        __weak typeof(self) weakSelf = self;
//        _roomImgeView.adBlock = ^(int nIndex)
//        {
//            __strong typeof(self) strongSelf = weakSelf;
//            [strongSelf OnDisplayBackBtn];
//        };
//        [self.videoImage addSubview:_roomImgeView];
//    }
//    _roomImgeView.hidden = NO;
//    if (_praiseBackView)
//    {
//        [_videoImage bringSubviewToFront:_praiseBackView];
//    }
//    if (images && [images count])
//    {
//        NSMutableArray *imageMArray = [NSMutableArray array];
//        for (int nIndex = 0; nIndex < [images count]; nIndex++)
//        {
//            NSString *url = [NSString stringWithFormat:@"%@%@",[AppInfo shareInstance].res_server,images[nIndex]];
//            [imageMArray addObject:url];
//        }
//        if (_roomImgeView)
//        {
//            _roomImgeView.adImgUrlArray = imageMArray;
//        }
//    }
//}

- (void)requestRoomImagesDataAnShow
{
    GetRoomImageModel *model = [[GetRoomImageModel alloc] init];
    NSDictionary *param = [NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"%ld",(long)self.persondata.userId]forKey:@"staruserid"];
    [model requestDataWithParams:param success:^(id object) {
        if (model.result == 0)
        {
            if (model.dataMArray && model.dataMArray.count > 0)
            {
                [self performSelectorOnMainThread:@selector(showRoomImages:) withObject:model.dataMArray waitUntilDone:NO];
            }
        }
    } fail:^(id object) {
        
    }];

}

- (void)showRoomImagesOrRecommendView
{
    GetRoomImageModel *model = [[GetRoomImageModel alloc] init];
    NSDictionary *param = [NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"%ld",(long)self.persondata.userId]forKey:@"staruserid"];
    [model requestDataWithParams:param success:^(id object) {
        if (model.result == 0)
        {
            if (model.dataMArray && model.dataMArray.count > 0)
            {
                [self performSelectorOnMainThread:@selector(showRoomImages:) withObject:model.dataMArray waitUntilDone:NO];
            }
            else
            {
                [self showRecommendView];
            }
            
        }
        else
        {
            [self showRecommendView];
        }
    } fail:^(id object) {
        [self showRecommendView];
    }];
}

- (void)showRoomImagesOrAudioAnimation
{
    GetRoomImageModel *model = [[GetRoomImageModel alloc] init];
    NSDictionary *param = [NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"%ld",(long)self.persondata.userId]forKey:@"staruserid"];
    [model requestDataWithParams:param success:^(id object) {
        if (model.result == 0)
        {
            if (model.dataMArray && model.dataMArray.count > 0)
            {
                [self performSelectorOnMainThread:@selector(showRoomImages:) withObject:model.dataMArray waitUntilDone:NO];
            }
            else
            {
                [self showAudioAnimation];
            }
            
        }
        else
        {
            [self showAudioAnimation];
        }
    } fail:^(id object) {
        [self showAudioAnimation];
    }];
}

- (void)showAudioAnimation
{
    UIImageView *audioAnimationView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 240)];
    audioAnimationView.tag = 1000;
    NSArray *imagesArray = [NSArray arrayWithObjects:
                            [UIImage imageNamed:@"audioBK1"],
                            [UIImage imageNamed:@"audioBK2"],
                            [UIImage imageNamed:@"audioBK3"],nil];
    audioAnimationView.animationImages = imagesArray;
    audioAnimationView.animationDuration = 0.25;//设置动画时间
    audioAnimationView.animationRepeatCount = 0;//设置动画次数 0 表示无限
    [audioAnimationView startAnimating];//开始播放动画
    [self.view insertSubview:audioAnimationView aboveSubview:self.videoImage];
}

#pragma mark - 显示点赞相关view
//- (void)showApproveView
//{
//    if (_praiseBackView == nil)
//    {
//        _praiseBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 95, 50)];
//        _praiseBackView.backgroundColor = [UIColor clearColor];
//        [_praiseBackView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sendApprove)]];
//        [_videoImage addSubview:_praiseBackView];
//        
//        //点赞按钮
//        _praiseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        _praiseBtn.frame = CGRectMake(10, 11, 33, 33);
//        [_praiseBtn setImage:[UIImage imageNamed:@"zan"] forState:UIControlStateNormal];
//        [_praiseBtn setImage:[UIImage imageNamed:@"praiseBg"] forState:UIControlStateHighlighted];
//        [_praiseBtn setBackgroundImage:[UIImage imageNamed:@"praiseBg"] forState:UIControlStateNormal];
//        [self.praiseBtn addTarget:self action:@selector(sendApprove) forControlEvents:UIControlEventTouchUpInside];
//        [_praiseBackView addSubview:_praiseBtn];
//    }
//    else
//    {
//        [_videoImage bringSubviewToFront:_praiseBackView];
//    }
//    
//    
//    if (_praiseCount == nil)
//    {
//        //积累赞个数
//        _praiseCount = [[UILabel alloc] initWithFrame:CGRectMake(35, 8, 10, 10)];
//        _praiseCount.layer.masksToBounds = YES;
//        _praiseCount.layer.cornerRadius = 5;
//        _praiseCount.text = @"0";
//        _praiseCount.textColor = [UIColor whiteColor];
//        _praiseCount.textAlignment = NSTextAlignmentCenter;
//        _praiseCount.font = [UIFont systemFontOfSize:6.5f];
//        _praiseCount.backgroundColor = [CommonFuction colorFromHexRGB:@"ff6666"];
//        _praiseCount.userInteractionEnabled = NO;
//        [_praiseBackView addSubview:_praiseCount];
//        
//        //主播获取赞个数
//    
//        _starApprove = [[UILabel alloc] initWithFrame:CGRectMake(48, 21, 47, 15)];
//        _starApprove.font = [UIFont systemFontOfSize:11.0f];
//        _starApprove.textAlignment = NSTextAlignmentCenter;
//        _starApprove.layer.borderWidth = 0.5;
//        _starApprove.layer.borderColor = [UIColor whiteColor].CGColor;
//        _starApprove.layer.cornerRadius = 7.5;
//        _starApprove.layer.masksToBounds = YES;
//        _starApprove.textColor = [UIColor whiteColor];
//        _starApprove.backgroundColor = [CommonFuction colorFromHexRGB:@"000000" alpha:0.2];
//        _starApprove.hidden = YES;
//        _starApprove.userInteractionEnabled = NO;
//        [_praiseBackView addSubview:_starApprove];
//
//    }
//    else
//    {
//        [_videoImage bringSubviewToFront:_praiseBackView];
//    }
//    
//    if (self.roomInfoData.bigstarstate == 2 && self.roomInfoData.showtimestatus == 1)
//    {
//        //showtime正在进行时不请求用户赞，直接设为99，否则请求用户赞
//        
//        if ([AppInfo shareInstance].bLoginSuccess)
//        {
//            _praiseCount.text = @"99";
//        }
//        else
//        {
//            _praiseCount.text = @"0";
//        }
//    }
//    else
//    {
//        //获取用户赞信息
//        [self getUserPraiseNum];
//    }
//    
//    //获取主播赞信息
//    [self getStarPraiseNum];
//}


#pragma mark -AudienceViewControllerDelegate

- (void)audienceViewController:(AudienceViewController *)audienceViewController chatWithUser:(UserInfo *)userInfo
{
    if ([self showLoginDialog])
    {
        return;
    }
    
    if (_tabMenu)
    {
        _tabMenu.currentSelectedSegmentIndex = 0;
        //聊天
        if (_chatToolBar)
        {
            [_chatToolBar chatWithUserInfo:userInfo];
        }
    }
}

- (void)audienceViewController:(AudienceViewController *)audienceViewController forbidSpeak:(UserInfo *)userInfo
{
    if ([self showLoginDialog])
    {
        return;
    }
    if (userInfo)
    {
        [self forbidSpeak:userInfo];
    }
}

- (void)audienceViewController:(AudienceViewController *)audienceViewController kickPerson:(UserInfo *)userInfo
{
    if ([self showLoginDialog])
    {
        return;
    }
    
    if (userInfo.userId == [UserInfoManager shareUserInfoManager].currentUserInfo.userId)
    {
        [self showTakeFailure:@"踢人失败!" Message:@"亲，自己不能踢自己哦!"];
    }
    else
    {
        [self performSelector:@selector(kickPerson:) withObject:userInfo];
    }
}

- (void)audienceViewController:(AudienceViewController *)audienceViewController showGift:(UserInfo *)userInfo
{
    if ([self showLoginDialog])
    {
        return;
    }
    
    if (_chatToolBar)
    {
        [_chatToolBar giveGiftWithUserInfo:userInfo];
    }
}

- (void)audienceViewController:(AudienceViewController *)audienceViewController report:(UserInfo *)userInfo
{
    //举报用户
    [self reportUser:userInfo];
}

//更新观众标题人数
- (void)updateTouristCount:(NSInteger)touristCount recordCountshowGift:(NSInteger)recordCount
{
    NSArray *sectionTitles;
    if (self.roomInfoData.showtype == 3)//类型->热波间
    {
        if(self.roomInfoData.bigstarstate == 2)
        {
          sectionTitles =@[Public_Chat_Title,ShowTime_Title,[NSString stringWithFormat:@"%@(%ld)",Audience_List_Title,(long)touristCount + recordCount],More_Content_Title];
          sectionTitles =@[Public_Chat_Title,ShowTime_Title,RoomRank_Title,[NSString stringWithFormat:@"%@(%ld)",Audience_List_Title,(long)touristCount + recordCount]];
        }
        else
        {
            sectionTitles =@[Public_Chat_Title,VoteMusic_Title,RoomRank_Title,[NSString stringWithFormat:@"%@(%ld)",Audience_List_Title,(long)touristCount + recordCount]];
        }
    }
    else
    {
        sectionTitles =@[Public_Chat_Title,Private_Chat_Title,RoomRank_Title,[NSString stringWithFormat:@"%@(%ld)",Audience_List_Title,(long)touristCount + recordCount]];
    }
    if (self.tabMenu)
    {
        [self.tabMenu updateTabMenuTitles:sectionTitles];
    }
}

#pragma mark-禁言

- (void)forbidSpeak:(UserInfo *)userInfo
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInteger:[UserInfoManager shareUserInfoManager].currentStarInfo.userId] forKey:@"staruserid"];
    [dict setObject:[NSNumber numberWithInteger:userInfo.userId] forKey:@"touserid"];
    
    StarInfo *starInfo = [UserInfoManager shareUserInfoManager].currentStarInfo;
    TakeUnSpeak *model = [[TakeUnSpeak alloc] init];
    NSString *serverIp= [NSString stringWithFormat:@"http://%@:%ld/mobile/dispatch.mobile",starInfo.serverip,(long)starInfo.serverport];
    [dict addEntriesFromDictionary:[model signParamWithMethod:TakeUnSpeak_Method]];
    NSDictionary *header = [model httpHeaderWithMethod:TakeUnSpeak_Method];
    
    __weak typeof(self) weakSelf = self;
    [model requestDataWithBaseUrl:serverIp requestType:nil method:TakeUnSpeak_Method httpHeader:header params:dict success:^(id object) {
        __strong typeof(self) strongSelf = weakSelf;
        /*成功返回数据*/
        if (model.result == 0)
        {
            [strongSelf showNotice:@"禁言成功!"];
            strongSelf.tabMenuBar.selectedSegmentIndex = 0;
        }
        else
        {
            [strongSelf showNoticeInWindow:model.msg];
        }

    } fail:^(id object) {
        
    }];
}

#pragma mark - 踢人
- (void)kickPerson:(UserInfo *)userInfo
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInteger:[UserInfoManager shareUserInfoManager].currentStarInfo.userId] forKey:@"staruserid"];
    [dict setObject:[NSNumber numberWithInteger:userInfo.userId] forKey:@"touserid"];
    if (userInfo.clientId)
    {
        [dict setObject:userInfo.clientId forKey:@"clientid"];
    }
    
    StarInfo *starInfo = [UserInfoManager shareUserInfoManager].currentStarInfo;
    TakeoutModel *model = [[TakeoutModel alloc] init];
    NSString *serverIp= [NSString stringWithFormat:@"http://%@:%ld/mobile/dispatch.mobile",starInfo.serverip,(long)starInfo.serverport];
    [dict addEntriesFromDictionary:[model signParamWithMethod:Takeout_Method]];
     NSDictionary *header = [model httpHeaderWithMethod:Takeout_Method];
    
    __weak typeof(self) weakSelf = self;
    [model requestDataWithBaseUrl:serverIp requestType:nil method:Takeout_Method httpHeader:header params:dict success:^(id object) {
      __strong typeof(self) strongSelf = weakSelf;
        /*成功返回数据*/
        if (model.result == 0)
        {
            AudienceViewController *audienceViewController = [self.tabMenuContentViewControllers objectForKey:Audience_List_Title];
            if (audienceViewController)
            {
                [audienceViewController deleteUserByUserId:userInfo.userId];
            }
            strongSelf.tabMenu.currentSelectedSegmentIndex = 0;
        }
        else
        {
            [strongSelf showNoticeInWindow:model.msg];
        }
    } fail:^(id object) {
        
    }];

}

/**
 *  举报用户
 *
 *  @return 空
 */

- (void)reportUser:(UserInfo *)userInfo
{
    if ([self showLoginDialog])
    {
        return;
    }
    
    if (userInfo == nil)
    {
        return;
    }
 
    _reportedUserId = userInfo.userId;
    
    UserInfo *currentUserInfo = [UserInfoManager shareUserInfoManager].currentUserInfo;
    
    _reportUserDialog = [[EWPSimpleDialog alloc] initWithFrame:CGRectMake(0, 0, 271, 229)];
    _reportUserDialog.layer.borderColor = [UIColor whiteColor].CGColor;
    _reportUserDialog.backgroundColor = [UIColor whiteColor];
    _reportUserDialog.layer.cornerRadius = 4.0f;
    _reportUserDialog.layer.borderWidth = 1.0f;
    
    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(225, 5, 40, 40)];
    [closeBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(hideReportDialog:) forControlEvents:UIControlEventTouchUpInside];
    [_reportUserDialog addSubview:closeBtn];
    
    //举报人
    UILabel *reporterLable = [[UILabel alloc] initWithFrame:CGRectMake(20, 22, 200, 15)];
    reporterLable.font = [UIFont boldSystemFontOfSize:12.0f];
    reporterLable.textColor = [CommonFuction colorFromHexRGB:@"575757"];
    if (currentUserInfo)
    {
        reporterLable.text = [NSString stringWithFormat:@"举报人：%@",currentUserInfo.nick];
    }
    else
    {
        reporterLable.text = @"举报人：游客";
    }
    [_reportUserDialog addSubview:reporterLable];
    
    //被举报人
    UILabel *reportedUserLable = [[UILabel alloc] initWithFrame:CGRectMake(20, 42, 200, 15)];
    reportedUserLable.font = [UIFont boldSystemFontOfSize:12.0f];
    reportedUserLable.textColor = [CommonFuction colorFromHexRGB:@"575757"];
    reportedUserLable.text = [NSString stringWithFormat:@"被举报人：%@",userInfo.nick];
    [_reportUserDialog addSubview:reportedUserLable];
    
    //举报内容
    _reportContent = [[EWPTextView alloc] initWithFrame:CGRectMake(20, 62, 231, 60)];
    _reportContent.placeHolder = @"请补充您的举报理由(50字内)";
    _reportContent.limitCharacterCount = 50;
    _reportContent.font = [UIFont systemFontOfSize:13.f];
    [_reportUserDialog addSubview:_reportContent];
    
    _reportContact = [[UITextField alloc] initWithFrame:CGRectMake(20, 132, 231, 27)];
    _reportContact.placeholder = @"请留下邮箱或电话,方便我们和您联系";
    _reportContact.layer.borderWidth = 1.0f;
    _reportContact.font = [UIFont systemFontOfSize:13.0f];
    _reportContact.layer.borderColor = [CommonFuction colorFromHexRGB:@"cbcbcb"].CGColor;
    _reportContact.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    _reportContact.leftViewMode = UITextFieldViewModeAlways;
    [_reportUserDialog addSubview:_reportContact];
    
    UIImage *normalImg = [CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"ffffff" alpha:0.5] size:CGSizeMake(231, 36)];
    UIImage *selectImg = [CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"d14c49"] size:CGSizeMake(231, 36)];
    
    UIButton *commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    commitBtn.frame = CGRectMake(20, 167, 231, 36);
    commitBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    commitBtn.layer.cornerRadius = 18.0f;
    commitBtn.layer.masksToBounds = YES;
    commitBtn.layer.borderWidth = 0.8;
    commitBtn.layer.borderColor = [CommonFuction colorFromHexRGB:@"d14c49"].CGColor;
    [commitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [commitBtn setTitleColor:[CommonFuction colorFromHexRGB:@"d14c49"] forState:UIControlStateNormal];
    [commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [commitBtn setBackgroundImage:normalImg forState:UIControlStateNormal];
    [commitBtn setBackgroundImage:selectImg forState:UIControlStateHighlighted];
    [commitBtn addTarget:self action:@selector(OnCommitReport:) forControlEvents:UIControlEventTouchUpInside];
    [_reportUserDialog addSubview:commitBtn];

    [_reportUserDialog showInWindow];
    [_reportContent becomeFirstResponder];
}

- (void)OnCommitReport:(id)sender
{
    [_reportContent resignFirstResponder];
    [_reportContact resignFirstResponder];
    
    if ([_reportContent.text length] == 0)
    {
        [self showNoticeInWindow:@"请输入举报内容" duration:2];
        [_reportContent performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:2];
        return;
    }
    
    if ([_reportContact.text length] > 30)
    {
        _reportContact.text = [_reportContact.text substringToIndex:30];
    }
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:_reportContent.text forKey:@"proof"];
    [dict setObject:[NSNumber numberWithInteger:_reportedUserId] forKey:@"touserid"];
    if ([_reportContact.text length] > 0)
    {
        [dict setObject:_reportContact.text forKey:@"contact"];
    }
    ReportModel *model = [[ReportModel alloc] init];
    [model requestDataWithParams:dict success:^(id object) {
        if (model.result == 0)
        {
            [self showNoticeInWindow:@"举报成功"];
        }
        else
        {
            [self showNoticeInWindow:model.msg];
        }
    } fail:^(id object) {
        [self showNoticeInWindow:@"举报成功"];
    }];

    [self hideReportDialog:nil];
}

- (void)hideReportDialog:(id)sender
{
    if (_reportUserDialog)
    {
        [_reportUserDialog hide];
        _reportUserDialog = nil;
        _reportContent = nil;
        _reportContact = nil;
    }
    
    if (_sofaDialog)
    {
        [_sofaDialog hide];
    }
}

#pragma mark - timer检测2分钟内是否登录

- (void)showLoginNotice
{
    if ([AppInfo shareInstance].bLoginSuccess)
    {
        [self.loginNoticeTimer invalidate];
        _loginNoticeTimer = nil;
    }
    else
    {
        if ([self showLoginDialog])
        {
            return;
        }
    }
}

#pragma mark - tcp服务器超时
//- (void)OnTimerOut
//{
//    [self showNetworkErroDialog];
//}

#pragma mark - 余额不足提示

- (BOOL)showRechargeDialogWithCostCoin:(long long)costCoin
{
    long long coin = [UserInfoManager shareUserInfoManager].currentUserInfo.coin;
    if (coin < costCoin)
    {
        [self showRechargeDialog];
        return YES;
    }
    return NO;
}

#pragma mark - 踢人结果
-(void)showTakeFailure:(NSString *)title Message:(NSString *)message
{
    RXAlertView *alertView = [[RXAlertView alloc] initWithFrame:CGRectMake(0, 0, 271, 147) title:title message:message];
    
    NSString *leftText;
    if([UserInfoManager shareUserInfoManager].currentUserInfo.privlevelweight==0)
        leftText = @"我要升V";
    else
        leftText = @"继续升V";
    
    UIImage *normalImg = [CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"01b6a1"] size:CGSizeMake(114, 38)];
    UIImage *selectimg = [CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"d14c49"] size:CGSizeMake(114, 38)];
    
    __weak typeof(self) weakSelf = self;
    [alertView setLeftBtnTitle:leftText normalImg:normalImg selectedImg:selectimg buttonBlock:^(id sender) {
       
        [weakSelf pushCanvas:Mall_Canvas withArgument:nil];
        
    }];
    
    [alertView setRightBtnTitle:@"放TA一马" normalImg:normalImg selectedImg:selectimg buttonBlock:^(id sender) {
        
    }];
    [alertView showInWindow];
    
}



#pragma mark - showRechargeDialog

- (void)showRechargeDialog
{
    EWPAlertView *alertView = [[EWPAlertView alloc] initWithTitle:@"提示" message:@"您的账户余额不足,请充值!" leftBtnTitle:@"取消" rightBtnTitle:@"立即充值" clickBtnBlock:^(NSInteger nIndex) {
        if (nIndex == 0)
        {
            
        }
        else if(nIndex == 1)
        {
            NSInteger hideSwitch = [[[AppInfo shareInstance].hideSwitch substringToIndex:1] integerValue];
            if (hideSwitch == 1)
            {
                [self pushCanvas:AppStore_Recharge_Canvas withArgument:[NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:@"bRootType"]];
            }
            else
            {
                [self pushCanvas:SelectModePay_Canvas withArgument:[NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:@"bRootType"]];
            }
        }
    }];
    [alertView show];
}

#pragma mark - 商城对话框
- (void)showMarketDialogWithTitle:(NSString *)title message:(NSString *)message buyVipBlock:(void (^)())buyVipBlock cancelBlock:(void (^)())cancelBlock
{
    NSInteger hideSwitch = [[[AppInfo shareInstance].hideSwitch substringFromIndex:1] integerValue];
    if (hideSwitch == 2)
    {
        RXAlertView *alertView = [[RXAlertView alloc] initWithFrame:CGRectMake(0, 0, 271, 147) title:title message:message];
        __weak typeof(self) weakSelf = self;
        [alertView setLeftBtnTitle:@"取消" normalImg:nil selectedImg:nil buttonBlock:^(id sender) {
            if (cancelBlock)
            {
                cancelBlock();
            }
        }];
        
        [alertView setRightBtnTitle:@"成为VIP" normalImg:nil selectedImg:nil buttonBlock:^(id sender) {
            if (buyVipBlock)
            {
                buyVipBlock();
            }
            else
            {
                [weakSelf pushCanvas:Mall_Canvas withArgument:nil];
            }
        }];
        
        
        [alertView showInWindow];

    }
}

#pragma mark- 分享
-(void) shareBoxiu
{
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

    NSString *sharelink = [NSString stringWithFormat:@"http://www.51rebo.cn/%ld",(long)[UserInfoManager shareUserInfoManager].currentStarInfo.idxcode];
    NSString *shareContent = [NSString stringWithFormat:@"%@/%ld",UMengShareText,(long)[UserInfoManager shareUserInfoManager].currentStarInfo.idxcode];
    [UMSocialData defaultData].extConfig.wechatSessionData.url = sharelink;
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = sharelink;
    [UMSocialData defaultData].extConfig.qqData.url = sharelink;
    [UMSocialData defaultData].extConfig.qzoneData.url = sharelink;

    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:nil
                                      shareText:shareContent
                                     shareImage:[UIImage imageNamed:@"reboLogo"]
                                shareToSnsNames:@[UMShareToSina,UMShareToTencent,UMShareToQQ,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSms]
                                       delegate:self];

}


- (void)didSelectSocialPlatform:(NSString *)platformName withSocialData:(UMSocialData *)socialData
{
    NSString *sharelink = [NSString stringWithFormat:@"http://www.51rebo.cn/%ld",(long)[UserInfoManager shareUserInfoManager].currentStarInfo.idxcode];
    if ([platformName isEqualToString:UMShareToWechatSession])
    {
        [UMSocialData defaultData].extConfig.wechatSessionData.title = @"热波间";
        [UMSocialData defaultData].extConfig.wechatSessionData.url = sharelink;
    }
    else if ([platformName isEqualToString:UMShareToWechatTimeline])
    {
        [UMSocialData defaultData].extConfig.wechatTimelineData.url = sharelink;
    }
    else if ([platformName isEqualToString:UMShareToQQ])
    {
        [UMSocialData defaultData].extConfig.qqData.title = @"热波间";
        [UMSocialData defaultData].extConfig.qqData.url = sharelink;
    }
    else if ([platformName isEqualToString:UMShareToQzone])
    {
        [UMSocialData defaultData].extConfig.qzoneData.title = @"热波间";
        [UMSocialData defaultData].extConfig.qzoneData.url = sharelink;
    }
    else if ([platformName isEqualToString:UMShareToSina])
    {
        [UMSocialData defaultData].extConfig.sinaData.shareImage = [UIImage imageNamed:@"share"];
    }
    else if([platformName isEqualToString:UMShareToTencent])
    {
        [UMSocialData defaultData].extConfig.tencentData.shareImage = [UIImage imageNamed:@"share"];
    }
    else if ([platformName isEqualToString:UMShareToSms])
    {
        [UMSocialData defaultData].extConfig.smsData.shareImage = nil;
    }
    
}

#pragma mark -获取推荐用户进入房间
//- (void)didHotStarUserIdData:(HotStarsData *)hotData
//{
//    StarInfo *starInfo = (StarInfo *)hotData;
//    self.staruserid = starInfo.userId;
//    
//    [self reEnterRoom:NO];
//}

#pragma mark - 获取推荐主播
- (void)getRecommendStarList
{
    QueryHotStarsModel *model = [[QueryHotStarsModel alloc] init];
    [model requestDataWithParams:nil success:^(id object) {
        /*成功返回数据*/
        QueryHotStarsModel *hotStarModel = object;
        
        if (hotStarModel.result == 0)
        {
            self.recommendStarView.hidden = NO;
            [self.recommendStarView setHotStarViewMary:hotStarModel.hotStarMutable];
        }

    } fail:^(id object) {
        
    }];
}

#pragma mark- 每隔一定60s获取一个赞
//-(void)onGetPraiseTimer
//{
//    float progress = _prossTimes/60.0f;
//    
//    [self.praiseView setProgress:progress];
//    
//    if (_prossTimes == 60)
//    {
//        _prossTimes = 0;
//        
//       [self getApprove];
//    }
//    else
//    {
//        _prossTimes++;
//    }
//}

#pragma mark - 请求数据时候动画

//- (void)startAnimating
//{
//    if (_mbProgressHud == nil)
//    {
//        _mbProgressHud = [[MBProgressHUD alloc] initWithView:self.view];
//        _mbProgressHud.removeFromSuperViewOnHide = YES;
//        [self.view addSubview:_mbProgressHud];
//        
//        NavBackBar *navBackBar = [[NavBackBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40) showInView:self.view];
//        navBackBar.tag = 2222;
//        navBackBar.title = [UserInfoManager shareUserInfoManager].currentStarInfo.nick;
//
//        __weak typeof(self) weakSelf = self;
//        navBackBar.backButtonBlock = ^(id sender)
//        {
//            __strong typeof(self) strongSelf = weakSelf;
//            [UserInfoManager shareUserInfoManager].currentStarInfo = nil;
//            [strongSelf stopAnimating];
//            [strongSelf autoExitRoom];
//        };
//        [_mbProgressHud addSubview:navBackBar];
//        
//        
//        self.mbProgressHudTimer = [NSTimer scheduledTimerWithTimeInterval:EnterRoom_TimeOut target:self selector:@selector(OnTimerOut) userInfo:nil repeats:NO];
//    }
//    [_mbProgressHud show:YES];
//}

- (void)stopAnimating
{
    if (self.mbProgressHudTimer)
    {
        [self.mbProgressHudTimer invalidate];
        self.mbProgressHudTimer = nil;
    }
    
    if (_mbProgressHud)
    {
        [_mbProgressHud hide:YES];
        _mbProgressHud = nil;
    }
}


#pragma mark - EWPBarrageDataSource
- (NSInteger)numberOfBarrageViewItem
{
    return 3;
}

- (CGFloat)heightOfBarrageViewItem
{
    return 22.0f;
}

- (CGFloat)spaceOfBarrageViewItem
{
    return 0.0f;
}

#pragma mark - EWPTabMenuDataSource

- (EWPSegmentedControl *)ewpSegmentedControl
{
    EWPSegmentedControl *segmentedControl = [[EWPSegmentedControl alloc] initWithSectionTitles:self.tabMenuTitles];
    segmentedControl.frame = CGRectMake(0, 0, self.view.frame.size.width, 30);
    segmentedControl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    segmentedControl.backgroundColor = [CommonFuction colorFromHexRGB:@"ffffff"];
    segmentedControl.textColor = [CommonFuction colorFromHexRGB:@"575757"];
    segmentedControl.selectionStyle = EWPSegmentedControlSelectionStyleFullWidthStripe;
    segmentedControl.selectionIndicatorLocation = EWPSegmentedControlSelectionIndicatorLocationDown;
    segmentedControl.selectionIndicatorColor = [CommonFuction colorFromHexRGB:@"d14c49"];
    segmentedControl.selectedTextColor = [CommonFuction colorFromHexRGB:@"d14c49"];
    segmentedControl.selectionIndicatorHeight = 1.5f;
    segmentedControl.font = [UIFont systemFontOfSize:12.0f];
    segmentedControl.indicatorBKColor = [UIColor clearColor];
    segmentedControl.segmentEdgeInset = UIEdgeInsetsMake(0,0,0,0);
    segmentedControl.segmentWidthStyle = EWPSegmentedControlSegmentWidthStyleEqually;
    return segmentedControl;
}

- (UIViewController *)ewpTabMenuControl:(EWPTabMenuControl *)ewpTabMenuControl tabViewOfindex:(NSInteger)index
{
    ViewController *itemViewController = nil;
    if (_tabMenuContentViewControllers == nil)
    {
        [self loadTabMenuContentView];
    }
    if (self.tabMenuTitles.count > index)
    {
        NSString *tabMenuTitle = [self.tabMenuTitles objectAtIndex:index];
        itemViewController = [self.tabMenuContentViewControllers objectForKey:tabMenuTitle];
    }
    return itemViewController;
}

- (void)loadTabMenuContentView
{
    if (_tabMenuContentViewControllers == nil)
    {
        _tabMenuContentViewControllers = [NSMutableDictionary dictionary];
    }
    
    for (int nIndex = 0; nIndex < [_tabMenuTitles count]; nIndex++)
    {
        ViewController *viewController;
        NSString *tabMenuTitle = [_tabMenuTitles objectAtIndex:nIndex];
        if ([tabMenuTitle isEqualToString:Public_Chat_Title])
        {
            PublicViewController *publicViewController = [[PublicViewController alloc] init];
            publicViewController.chatToolBar = self.chatToolBar;
            publicViewController.popupMenuDelegate = self;
            viewController = publicViewController;
        }
        else if([tabMenuTitle isEqualToString:Private_Chat_Title])
        {
            PrivateViewController *privateViewController = [[PrivateViewController alloc] init];
            privateViewController.chatToolBar = self.chatToolBar;
            privateViewController.popupMenudelegate = self;
            viewController = privateViewController;
        }
        else if ([tabMenuTitle isEqualToString:VoteMusic_Title])
        {
            viewController = [[VoteMusicViewController alloc] init];
        }
        else if ([tabMenuTitle isEqualToString:ShowTime_Title])
        {
            viewController = [[ShowTimeViewController alloc] init];
        }
        else if ([tabMenuTitle isEqualToString:RoomRank_Title])
        {
             viewController = [[RoomRankViewController alloc] init];
        }
        else if ([tabMenuTitle isEqualToString:RoomWork_Title])
        {
             viewController = [[RoomWorkViewController alloc] init];
        }
        else if ([tabMenuTitle isEqualToString:Audience_List_Title])
        {
            AudienceViewController *audienceViewController = [[AudienceViewController alloc] init];
            audienceViewController.delegate = self;
            viewController = audienceViewController;
        }
        viewController.rootViewController = self;
        [_tabMenuContentViewControllers setObject:viewController forKey:tabMenuTitle];
    }
}


#pragma mark - 更新公聊界面数据以及设置
- (void)initPublicViewData
{
    PublicViewController *viewController = [self.tabMenuContentViewControllers objectForKey:Public_Chat_Title];
    if (viewController)
    {
        [viewController initData:self.roomInfoData.showtype];
    }
}

#pragma mark - 更新私聊界面数据以及设置
- (void)initPrivateViewData
{
    //默认显示私聊
    PrivateViewController *viewController = [self.tabMenuContentViewControllers objectForKey:Private_Chat_Title];
    if (viewController)
    {
        [viewController initData];
        
        if ([AppInfo shareInstance].bLoginSuccess)
        {
            ChatMessageModel *model = [[ChatMessageModel alloc] init];
            StarInfo *starInfo = [UserInfoManager shareUserInfoManager].currentStarInfo;
            UserInfo *userInfo = [UserInfoManager shareUserInfoManager].currentUserInfo;
            model.userid = starInfo.userId;
            model.nick = starInfo.nick;
            model.targetUserid = userInfo.userId;
            model.targetNick = userInfo.nick;
            model.msg = self.persondata.privatechatad;
            
            [self addChatMember:model];
            [viewController addChatMessage:model];

        }
        else
        {
            [viewController addChatMessage:nil];
        }
    }
}
#pragma mark - 更新榜单界面数据以及设置
- (void)initRoomRankViewData
{
    RoomRankViewController *viewController = [self.tabMenuContentViewControllers objectForKey:RoomRank_Title];
    if (viewController)
    {
        [viewController initData];
    }
}

#pragma mark -更新作品界面数据以及设置
- (void)initRoomWorkViewData
{
    RoomWorkViewController *viewController = [self.tabMenuContentViewControllers objectForKey:RoomWork_Title];
    if (viewController)
    {
        [viewController initData];
    }
}

#pragma mark - 更新观众列表数据以及设置
- (void)initAudienceViewData
{
    AudienceViewController *viewController = [self.tabMenuContentViewControllers objectForKey:Audience_List_Title];
    if (viewController)
    {
        [viewController initData:self.roomInfoData.showtype];
    }
}


#pragma mark -更新视频区域界面数据以及设置
//- (void)initVideoViewData
//{
//    if (self.roomInfoData.showtype == 1)
//    {
//        StarInfo *starInfo = [UserInfoManager shareUserInfoManager].currentStarInfo;
//        if (starInfo.onlineflag)
//        {
//            //正在直播
//            [self startPlay];
//        }
//        else
//        {
//            //如果有图片轮播则显示图片轮播，否则显示推荐主播
//            [self showRoomImagesOrRecommendView];
//        }
//    }
//    else if(self.roomInfoData.showtype == 2)
//    {
//        //显示图片画廊
//        [self requestRoomImagesDataAnShow];
//    }
//    else if(self.roomInfoData.showtype == 3)
//    {
//        //明星直播间,开播显示视频，为开播显示图片走廊
//        if (self.roomInfoData.showid == 0)
//        {
//            //未开播
//            [self requestRoomImagesDataAnShow];
//            [self showStartTime];
//            [self.chatToolBar setNeedsLayout];
//        }
//        else
//        {
//            //开播
//            [self startPlay];
//        }
//    }
//    //显示点赞相关,以及获取主播赞
//    [self showApproveView];
//}

#pragma mark - 初始化房间设置以及数据
- (void)initRoomData
{
    if (self.roomInfoData.showtype == 3)
    {
        //明星直播间
        if (self.enterRoomResultCode == 3)
        {
            //人满结果码是3
            if (_roomPersonFullTimer == nil)
            {
                _roomPersonFullTimer = [NSTimer scheduledTimerWithTimeInterval:60 * 2 target:self selector:@selector(showRoomPersonFullNotice) userInfo:nil repeats:NO];
            }
        }
    }
    else
    {
        //普通房间未登录提示
        if (![AppInfo shareInstance].bLoginSuccess)
        {
            if (_loginNoticeTimer == nil)
            {
                _loginNoticeTimer = [NSTimer scheduledTimerWithTimeInterval:60 * 2 target:self selector:@selector(showLoginNotice) userInfo:nil repeats:YES];
            }

        }
    }

    //查询表情数据。礼物数据,如果有数据就不会再查询了
    [self queryRoomAllData];
    
    //设置chattoolbar
    if (_chatToolBar)
    {
        UserInfo *currentStarInfo = [UserInfoManager shareUserInfoManager].currentStarInfo;
        if (currentStarInfo)
        {
            [_chatToolBar chatWithUserInfo:currentStarInfo];
        }
        [_chatToolBar setNeedsLayout];
    }
    //重置聊天成员信息，和送礼物成员信息
    [[UserInfoManager shareUserInfoManager] resetRoomUserInfo];
}

#pragma mark - 主播开播
//- (void)startPlay
//{
//    self.playing = YES;
//    //主播开播获取用户赞
//    [self getApprove];
//    
//    //主播照片集去掉
//    if (_roomImgeView)
//    {
//        _roomImgeView.hidden = YES;
//    }
//    
//    //开播倒计时去掉
//    if (_startTimeLable)
//    {
//        [_startTimeLable removeFromSuperview];
//        _startTimeLable = nil;
//    }
//    if (_startTitleLabel)
//    {
//        [_startTitleLabel removeFromSuperview];
//        _startTitleLabel = nil;
//    }
//    
//    
//    //开播推荐yinc
//    if (_recommendStarView)
//    {
//        _recommendStarView.hidden = YES;
//    }
//    
//    seeku *seekuInstance = [self currentSeeku:_isPlayVideo];
//    if (!seekuInstance.playing)
//    {
//        [self startVideoPlay:[NSNumber numberWithBool:_isPlayVideo]];
//    }
//    
//    //开播时把歌曲列表刷新
//    if(self.roomInfoData.showtype == 3)
//    {
//        VoteMusicViewController *voteMusicViewController = [self.tabMenuContentViewControllers objectForKey:VoteMusic_Title];
//        if (voteMusicViewController)
//        {
//            [voteMusicViewController initData];
//        }
//    }
//}

#pragma  mark - 主播停播
//- (void)stopPlay
//{
//    self.playing = NO;
//    //主播主动关闭直播通知，将视频img置为黑
////    self.videoImage.image = [CommonFuction imageWithColor:[UIColor blackColor] size:CGSizeMake(320, 240)];
//    //1.视频直播 3.明星直播间
//    if (self.roomInfoData.showtype == 1)
//    {
//        [self showRecommendView];
//    }
//    else if (self.roomInfoData.showtype == 3)
//    {
//        [self requestRoomImagesDataAnShow];
//        [self showStartTime];
//    }
//    [self showApproveView];
//
//    
//    if (self.roomInfoData.showtype == 3)
//    {
//        VoteMusicViewController *voteMusicViewController = [self.tabMenuContentViewControllers objectForKey:VoteMusic_Title];
//        if (voteMusicViewController)
//        {
//            [voteMusicViewController initData];
//        }
//    }
//    
//    [self stopGetApprove];
//    
//    [self stopVideoPlayThread];
//}

#pragma mark -查询更房间有关的数据
- (void)queryRoomAllData
{
    [[GiftDataManager shareInstance] queryGiftData];
    [[EmotionManager shareInstance] queryAllEmotion];
}

#pragma mark -PopupMenuDelegate
- (void)showPopupMenu:(UserInfo *)userInfo
{
    if (!userInfo)
    {
        return;
    }
    self.userInfoOfPopupMenu = userInfo;
    
    UserInfo *currentUserInfo = [UserInfoManager shareUserInfoManager].currentUserInfo;
    if (userInfo.userId == currentUserInfo.userId)
    {
        return;
    }
    else
    {
        if (userInfo.hidden == 2)
        {
            if (currentUserInfo.issupermanager)
            {
                if (userInfo.issupermanager)
                {
                    return;
                }
            }
            else
            {
                return;
            }
            
        }
    }
    
    if (_popMenuTitles == nil)
    {
        _popMenuTitles = [NSMutableArray array];
    }
    [_popMenuTitles removeAllObjects];
    
    [_popMenuTitles addObjectsFromArray:@[@"送Ta礼物",@"与Ta聊天",@"踢出房间",@"禁言5分钟",@"举报TA"]];
    if (self.roomInfoData.showtype == 3)
    {
        [self.popMenuTitles removeObjectAtIndex:0];
    }
    
    NSString *nickName = userInfo.nick;
    [self.popMenuTitles insertObject:nickName atIndex:0];
    
    
    CGRect rect = CGRectMake(0, 0, 96, 158);
    if (self.roomInfoData.showtype == 3)
    {
        rect = CGRectMake(0, 0, 96, 133);
    }
    
    UIPopoverListView *poplistview = [[UIPopoverListView alloc] initWithFrame:rect];
    poplistview.listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    poplistview.layer.borderColor = [CommonFuction colorFromHexRGB:@"ff6666"].CGColor;
    poplistview.layer.borderWidth = 1;
    poplistview.layer.cornerRadius = 4.0f;
    poplistview.delegate = self;
    poplistview.datasource = self;
    poplistview.listView.scrollEnabled = NO;
    [poplistview showInCenter:self.tabMenu.center];
}

#pragma mark - UIPopoverListViewDataSource

- (UITableViewCell *)popoverListView:(UIPopoverListView *)popoverListView
                    cellForIndexPath:(NSIndexPath *)indexPath
{
    static NSString *menuCellIdentifier = @"menuCell";
    RightMenuCell *cell = [popoverListView.listView dequeueReusableCellWithIdentifier:menuCellIdentifier];
    if (cell == nil)
    {
        cell = [[RightMenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:menuCellIdentifier];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    cell.textLabel.text = [_popMenuTitles objectAtIndex:indexPath.row];
    UIView *selectedBKView = [[UIView alloc] initWithFrame:cell.bounds];
    selectedBKView.backgroundColor = [CommonFuction colorFromHexRGB:@"ff6666"];
    cell.selectedBackgroundView = selectedBKView;
    
    if (indexPath.row == 0)
    {
        cell.userInteractionEnabled = NO;
        cell.textLabel.font = [UIFont systemFontOfSize:17.0f];
        cell.textLabel.textColor = [CommonFuction colorFromHexRGB:@"ff6666"];
    }
    else
    {
        cell.userInteractionEnabled = YES;
        cell.textLabel.font = [UIFont systemFontOfSize:13.0f];
        cell.textLabel.textColor = [CommonFuction colorFromHexRGB:@"7F7A6D"];
    }
    
    return cell;
}

- (NSInteger)popoverListView:(UIPopoverListView *)popoverListView
       numberOfRowsInSection:(NSInteger)section
{
    return [_popMenuTitles count];
}

#pragma mark - UIPopoverListViewDelegate
- (void)popoverListView:(UIPopoverListView *)popoverListView
     didSelectIndexPath:(NSIndexPath *)indexPath
{
    [self popupMenuIndex:indexPath.row userInfo:self.userInfoOfPopupMenu];
}

- (CGFloat)popoverListView:(UIPopoverListView *)popoverListView
   heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return 30.0f;
    }
    return 25.0f;
}

#pragma mark 点击弹出菜单选项
- (void)popupMenuIndex:(NSInteger)index userInfo:(UserInfo *)userInfo
{
    if (index != 5)
    {
        if ([self showLoginDialog])
        {
            return;
        }
        
    }
    if (self.roomInfoData.showtype == 3)
    {
        index += 1;
    }
    switch (index)
    {
        case 1:
        {
            //送礼物
            [self.chatToolBar giveGiftWithUserInfo:userInfo];
        }
            break;
        case 2:
        {
            //聊天
            if (_tabMenu)
            {
                _tabMenu.currentSelectedSegmentIndex = 0;
                //聊天
                if (_chatToolBar)
                {
                    [_chatToolBar chatWithUserInfo:userInfo];
                }
            }
        }
            break;
        case 3:
        {
            //踢出房间
            [self kickPerson:(userInfo)];
        }
            break;
        case 4:
        {
            //禁言
            [self forbidSpeak:userInfo];
        }
            break;
        case 5:
        {
            //举报用户
            [self reportUser:userInfo];
        }
        default:
            break;
    }
}

#pragma mark - 明星热播间
#pragma mark - 更新点歌界面数据以及设置
- (void)initVoteMusicViewData
{
    NSInteger tabIndex = self.tabMenu.currentSelectedSegmentIndex;
    VoteMusicViewController *viewController = [self.tabMenuContentViewControllers objectForKey:VoteMusic_Title];
    if (!viewController)
    {
        viewController = [[VoteMusicViewController alloc] init];
        viewController.rootViewController = self;
        
    }
    
    //移除私聊或者showTime界面
    [_tabMenuTitles removeObjectAtIndex:1];
    
    //只需要移除私聊界面,因为私聊界面不会再用刀了。showTime界面保存在内存里
    [_tabMenuContentViewControllers removeObjectForKey:Private_Chat_Title];

    [_tabMenuTitles insertObject:VoteMusic_Title atIndex:1];
    [_tabMenuContentViewControllers setObject:viewController forKey:VoteMusic_Title];
    [_tabMenu reloadData];
    self.tabMenu.currentSelectedSegmentIndex = tabIndex;
    if (viewController)
    {
        [viewController initData];
    }
}

#pragma mark -更新showtime界面数据以及设置
- (void)initShowTimeViewData
{
    NSInteger tabIndex = self.tabMenu.currentSelectedSegmentIndex;
    ShowTimeViewController *viewController = [self.tabMenuContentViewControllers objectForKey:ShowTime_Title];
    if (!viewController)
    {
        viewController = [[ShowTimeViewController alloc] init];
        viewController.delegate = self;
        viewController.rootViewController = self;
    }
    
    //移除私聊或者showTime界面
    [_tabMenuTitles removeObjectAtIndex:1];
    
    //只需要移除私聊界面,因为私聊界面不会再用刀了。点歌界面界面保存在内存里
    [_tabMenuContentViewControllers removeObjectForKey:Private_Chat_Title];
    
    [_tabMenuTitles insertObject:ShowTime_Title atIndex:1];
    [_tabMenuContentViewControllers setObject:viewController forKey:ShowTime_Title];
    [_tabMenu reloadData];
     self.tabMenu.currentSelectedSegmentIndex = tabIndex;
    if (viewController)
    {
        //初始化当前用户送给当前主播所有得赞
        self.showTimeTotalApproveCount = [[RecordApproveManager shareInstance] approveCountOfShowId:self.roomInfoData.showid];
        viewController.approveCount = self.showTimeTotalApproveCount;
        [viewController initData];
        
    }
}

#pragma mark - 明星直播间人满提示
//- (void)showRoomPersonFullNotice
//{
//    if (_roomPersonFullTimer)
//    {
//        [_roomPersonFullTimer invalidate];
//        _roomPersonFullTimer = nil;
//        [self exitRoom:YES];
//        [self showMarketDialogWithTitle:@"房间人数已达上限" message:@"成为VIP可继续观看" buyVipBlock:^{
//            
//            NSInteger hideSwitch = [[[AppInfo shareInstance].hideSwitch substringFromIndex:1] integerValue];
//            if (hideSwitch == 2)
//            {//商城显示的时候才可以进入商城界面
//                [self pushCanvas:Mall_Canvas withArgument:nil];
//            }
//
//        } cancelBlock:^{
//            [self popCanvasWithArgment:nil];
//        }];
//        
//    }
//}

#pragma mark - 查询明星直播间礼物排行榜数据
- (void)queryStarRoomGiftRankData
{
    StarInfo *starInfo = [UserInfoManager shareUserInfoManager].currentStarInfo;
    NSDictionary *param = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:starInfo.userId] forKey:@"staruserid"];
    StarGiftRankModel *model = [[StarGiftRankModel alloc] init];
    [model requestDataWithParams:param success:^(id object) {
        if (model.result == 0)
        {
            if (_starGiftRankMArray == nil)
            {
                _starGiftRankMArray = [NSMutableArray array];
            }
            [_starGiftRankMArray removeAllObjects];
            [_starGiftRankMArray addObjectsFromArray:model.dataMArray];
        }
    } fail:^(id object) {
        
    }];
    
}

#pragma mark - 明星直播间开播时间
- (void)showStartTime
{
    if (self.roomInfoData)
    {
        GetSystemTimeModel *model = [[GetSystemTimeModel alloc] init];
        [model requestDataWithParams:nil success:^(id object) {
            NSString *startTime = self.roomInfoData.bigstarstarttime;
            NSDate *startTimeDate = [CommonFuction dateFromString:startTime];
            NSDate *serverTimeDate = [NSDate dateWithTimeIntervalSince1970:model.systemTime/1000];
            if ([startTimeDate compare:serverTimeDate] == NSOrderedDescending)
            {
                if (_startTimeLable == nil)
                {
                    _startTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.videoImage.frame.size.width - 130)/2,60, 130, 15)];
                    _startTitleLabel.textColor = [UIColor whiteColor];
                    _startTitleLabel.backgroundColor = [UIColor clearColor];
                    _startTitleLabel.font = [UIFont systemFontOfSize:14.0f];
                    _startTitleLabel.textAlignment = NSTextAlignmentCenter;
                    [_startTitleLabel setShadowColor:[CommonFuction colorFromHexRGB:@"575757"]];
                    [_startTitleLabel setShadowOffset:CGSizeMake(1, 1)];
                    [self.view addSubview:_startTitleLabel];

                    
                    
                    _startTimeLable = [[UILabel alloc] initWithFrame:CGRectMake((self.videoImage.frame.size.width - 165)/2,80, 165, 15)];
                    _startTimeLable.textColor = [UIColor whiteColor];
                    _startTimeLable.backgroundColor = [UIColor clearColor];
                    _startTimeLable.font = [UIFont systemFontOfSize:14.0f];
                    _startTimeLable.textAlignment = NSTextAlignmentCenter;
                    [_startTimeLable setShadowColor:[CommonFuction colorFromHexRGB:@"575757"]];
                    [_startTimeLable setShadowOffset:CGSizeMake(1, 1)];
                    [self.view addSubview:_startTimeLable];
                    NSTimeInterval timeInterval = [startTimeDate timeIntervalSinceDate:[NSDate date]];
                    self.timeInterval = [[NSNumber numberWithDouble:timeInterval] longLongValue];
                    if (_starTimeTimer == nil)
                    {
                        _starTimeTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateStartTimeLableText) userInfo:nil repeats:YES];
                    }
                }
            }
            
        } fail:^(id object) {
            
        }];
    }
}

#pragma mark - 明星直播间开播倒计时更新内容
//- (void)updateStartTimeLableText
//{
//    long long time = self.timeInterval;
//    NSInteger day = (NSInteger)(time / (24 * 60 * 60));
//    time = time % (24 * 60 * 60);
//    NSInteger hour = (NSInteger)(time  / (60 * 60));
//    time = time  % (60 * 60);
//    NSInteger minute = (NSInteger)(time / 60);
//    time = time % 60;
//    NSInteger second = (NSInteger)time;
//    
//    if (_startTitleLabel)
//    {
//        _startTitleLabel.text = @"距离直播开始";
//    }
//
//    
//    if (_startTimeLable)
//    {
//        _startTimeLable.text = [NSString stringWithFormat:@"%ld天 / %.2ld小时 / %.2ld分 /%.2ld秒",(long)day,(long)hour,(long)minute,(long)second];
//    }
//    self.timeInterval--;
//    if (self.timeInterval == 0)
//    {
//        [_starTimeTimer invalidate];
//        _starTimeTimer = nil;
//        _startTimeLable = nil;
//        _startTitleLabel = nil;
//        
//        [self startVideoPlay:[NSNumber numberWithBool:YES]];
//    }
//}

- (void)sendMessageTimer
{
    self.chatTime--;
    if (self.chatTime == 0)
    {
        [_chatTimer invalidate];
        _chatTimer = nil;
    }
}

#pragma mark -点歌投票中奖通知
- (void)addGloableMusicInfo:(GlobalMessageMusicModel *)model
{
    if (model.userid != 0 && [model.usernick length] > 0)
    {
        UserInfo *userInfo = [[UserInfo alloc] init];
        userInfo.userId = model.userid;
        userInfo.nick = model.usernick;
        userInfo.hidden = model.hidden;
        userInfo.hiddenindex = model.hiddenindex;
        userInfo.issupermanager = model.issupermanager;
        [[UserInfoManager shareUserInfoManager] addMemberInfo:userInfo];
    }
    
    if (model.staruserid != 0 && [model.starnick length] > 0)
    {
        UserInfo *userInfo = [[UserInfo alloc] init];
        userInfo.userId = model.staruserid;
        userInfo.nick = model.starnick;
        [[UserInfoManager shareUserInfoManager] addMemberInfo:userInfo];
    }
    
    NSString *scrollMessage = [NSString stringWithFormat:@"{%ld}给{%ld}的 %@ 投了 %ld 票",(long)model.userid,(long)model.staruserid,model.musicName,(long)model.ticketNum];
    
    [self.scrollNotice addMessage:scrollMessage];
    [_scrollNotice start];
}

#pragma mark -明星热播间消息
- (void)receiveMusicChangeMessage:(NSNotification *)notification
{
    //切换到点歌界面
    self.roomInfoData.bigstarstate = 4;
    [self initVoteMusicViewData];
    AudienceViewController *audieceViewController = [self.tabMenuContentViewControllers objectForKey:Audience_List_Title];
    if (audieceViewController)
    {
        [self updateTouristCount:audieceViewController.touristCount recordCountshowGift:audieceViewController.recordCount];
    }
}

- (void)receiveShowTimeChangeMessage:(NSNotification *)notification
{
    //切换到showTime界面
    self.roomInfoData.bigstarstate = 2;
    [self initShowTimeViewData];
    
    AudienceViewController *audieceViewController = [self.tabMenuContentViewControllers objectForKey:Audience_List_Title];
    if (audieceViewController)
    {
        [self updateTouristCount:audieceViewController.touristCount recordCountshowGift:audieceViewController.recordCount];
    }
}

- (void)receiveShowTimeBeginMessage:(NSNotification *)notification
{
    NSDictionary *bodyDic = [notification userInfo];
    EWPLog(@"bodyDic = %@",bodyDic);
    __block NSInteger timeSecond = [[bodyDic objectForKey:@"timeSecond"] integerValue];
    
    [self getServerTimeWithBlock:^(long long serverTime) {
        if (serverTime > 0)
        {
            long long endTime = [[bodyDic objectForKey:@"endTime"] longLongValue];
            timeSecond = (NSInteger)(endTime - serverTime)/1000;
        }
        
        ShowTimeViewController *viewController = [self.tabMenuContentViewControllers objectForKey:ShowTime_Title];
        if (viewController)
        {
            [viewController beginShowTime:timeSecond];
        }
    }];
}

- (void)receiveShowTimeEndMessage:(NSNotification *)notification
{
    NSDictionary *bodyDic = [notification userInfo];
    EWPLog(@"bodyDic = %@",bodyDic);

    ShowTimeViewController *viewController = [self.tabMenuContentViewControllers objectForKey:ShowTime_Title];
    if (viewController)
    {
        [viewController endShowTimeWithData:bodyDic];
    }
}

- (void)receiveShowTimeDataMessage:(NSNotification *)notification
{
    NSDictionary *bodyDic = [notification userInfo];
    EWPLog(@"bodyDic = %@",bodyDic);
    
    ShowTimeViewController *viewController = [self.tabMenuContentViewControllers objectForKey:ShowTime_Title];
    if (viewController)
    {
        [viewController setShowTimeData:bodyDic];
    }
}

- (void)receiveShowTimeApproveResult:(NSNotification *)notification
{
    //明星直播间点赞结果
    NSDictionary *bodyDic = [notification userInfo];
    EWPLog(@"bodyDic = %@",bodyDic);
    ShowTimeViewController *viewController = [self.tabMenuContentViewControllers objectForKey:ShowTime_Title];
    if (viewController)
    {
        [viewController receiveSendApproveResult:bodyDic];
    }
}

#pragma mark定时获取免费赞发送
- (void)OnSendShowTimeApprove:(NSTimer *)timer
{
    [self sendStarApproveWithPraiseType:1];
}

#pragma mark -明星热播间开始后点赞接口
- (void)sendStarApproveWithPraiseType:(NSInteger)praiseType
{
    if (praiseType == 1 && self.showTimeSendFreeApproveNum == 0)
    {
        
        return;
    }

    UserInfo *currentInfo = [UserInfoManager shareUserInfoManager].currentUserInfo;
    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionary];
    //clienttype：2是安卓;3是ios
    [bodyDic setObject:[NSNumber numberWithInt:3] forKey:@"clienttype"];
    if (self.roomInfoData.showid != 0)
    {
        [bodyDic setObject:[NSNumber numberWithInteger:self.roomInfoData.showid] forKey:@"showId"];
    }
    [bodyDic setObject:[NSNumber numberWithInteger:praiseType] forKey:@"praiseType"];
    if (praiseType == 1)
    {
        if(self.showTimeSendFreeApproveNum > 0)
        {
            [bodyDic setObject:[NSNumber numberWithInteger:self.showTimeSendFreeApproveNum] forKey:@"praiseNum"];
            [_showTimeFreeApproveNumLock lock];
            self.showTimeSendFreeApproveNum = 0;
            [_showTimeFreeApproveNumLock unlock];
        }
    }

    [bodyDic setObject:[NSNumber numberWithInteger:praiseType] forKey:@"praiseType"];
    [bodyDic setObject:[NSNumber numberWithInteger:currentInfo.userId] forKey:@"userid"];
    [SendShowTimeApproveModel sendApprove:bodyDic];
}

#pragma mark - 设置明星直播间状态
//- (void)setShowTimeInProgress:(BOOL)showTimeInProgress
//{
//    _showTimeInProgress = showTimeInProgress;
//    if (showTimeInProgress)
//    {
//        //停止定时获取赞
//        [self stopGetApprove];
//        if ([AppInfo shareInstance].bLoginSuccess)
//        {
//             _praiseCount.text = @"99";
//        }
//        else
//        {
//             _praiseCount.text = @"1";
//        }
//       
//        
//        if (_showTimeApproveTimer == nil)
//        {
//            _showTimeApproveTimer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(OnSendShowTimeApprove:) userInfo:nil repeats:YES];
//        }
//    }
//    else
//    {
//        self.roomInfoData.showtimestatus = 2;
//        //重新开启定时获取赞
//        [self showApproveView];
//        
//        [_showTimeApproveTimer invalidate];
//        _showTimeApproveTimer = nil;
//        _showTimeFreeApproveNumLock = nil;
//        _showTImeTotalApproveNumLock = nil;
//    }
//}

#pragma mark - 设置我送出的赞数
- (void)setShowTimeTotalApproveCount:(NSInteger)showTimeTotalApproveCount
{
    if(showTimeTotalApproveCount == 0)
    {
        return;
    }
    if (_showTImeTotalApproveNumLock == nil)
    {
        _showTImeTotalApproveNumLock = [[NSLock alloc] init];
    }
    [_showTImeTotalApproveNumLock lock];
    _showTimeTotalApproveCount = showTimeTotalApproveCount;
    [_showTImeTotalApproveNumLock unlock];
    [[RecordApproveManager shareInstance] saveApproveCount:showTimeTotalApproveCount showId:self.roomInfoData.showid];
    ShowTimeViewController *viewController = [self.tabMenuContentViewControllers objectForKey:ShowTime_Title];
    if (viewController)
    {
        viewController.approveCount = showTimeTotalApproveCount;
    }

}

#pragma mark -设置主播在showtime收到的赞，
- (void)setStarApproveCount:(NSInteger)approveCount
{
    if (_starApprove)
    {
        _starApprove.text = [NSString stringWithFormat:@"%ld",(long)approveCount];
    }
}

/**
 *  显示网络连接失败，请重试提示框
 */

//- (void)showNetworkErroDialog
//{
//    if (!_showingErroDialog)
//    {
//        EWPAlertView *alertView = [[EWPAlertView alloc] initWithTitle:@"提示" message:@"网络连接失败，请重试" leftBtnTitle:@"取消" rightBtnTitle:@"重试" clickBtnBlock:^(NSInteger nIndex) {
//            if (nIndex == 0)
//            {
//                [self exitRoom:YES];
//                [self popToRootCanvasWithArgment:nil];
//            }
//            else if(nIndex == 1)
//            {
//                [self exitRoom:YES];
//                self.reconnect = NO;
//                [self performSelector:@selector(getStarInfo) withObject:nil];
//            }
//            _showingErroDialog = NO;
//        }];
//        [alertView show];
//        _showingErroDialog = YES;
//    }
//
//}
@end
