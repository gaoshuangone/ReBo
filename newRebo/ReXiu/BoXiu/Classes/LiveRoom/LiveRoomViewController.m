
//  LiveRoomViewController.m
//  BoXiu
//
//  Created by andy on 15/6/11.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import "LiveRoomViewController.h"
#import "UserInfoManager.h"
#import "CommandManager.h"
//#import "seeku.h"

#import "GetStreamInfoModel.h"
#import "LiveRoomLeftView.h"
#import "LiveRoomMiddleView.h"
#import "LiveRoomRightView.h"
#import "EWPIconLable.h"
#import "GetUserInfoModel.h"
#import "EnterRoomModel.h"
#import "AuthModel.h"
#import "HeartModel.h"
#import "GiftDataManager.h"
#import "EmotionManager.h"
#import "RXAlertView.h"
#import "GetRoomImageModel.h"
#import "LoadingView.h"
#import "GiftView.h"
#import "StarGiftView.h"
#import "ChatToolBar.h"
#import "ChatMessageModel.h"
#import "BarrageMessageModel.h"
#import "RoomMessageModel.h"
#import "PersonData.h"
#import "GiveGiftModel.h"
#import "GetStarPraiseNumModel.h"
#import "ChatmemberModel.h"
#import "GetPraisenumModel.h"
#import "PrivateMessageVC.h"
#import "RightMenuCell.h"
#import "TakeoutModel.h"
#import "AudienceViewController.h"
#import "EWPSimpleDialog.h"
#import "EWPTextView.h"
#import "ReportModel.h"
#import "TakeUnSpeak.h"
#import "PublicMessageVC.h"
#import "PraiseView.h"
#import "GetApproveModel.h"
#import "StartView.h"
#import "GetRoomServerForMobileStar.h"
#import "LoginViewController.h"
#import "StopLIvingModel.h"
#import "CanShowOnMobile.h"
#import "BeforeLiveView.h"
#import "UIImage+Blur.h"
#import "SearchUserModel.h"
#import "LiveProtocolViewController.h"
#import "OHAttributedLabel.h"
#import "LiveRoomUtil.h"
#import "AudienceHeaderView.h"
#import "LiveLoadingView.h"
#import "LiveBottomView.h"
#import "LiveRankViewController.h"

#import "LiveRoomHelper.h"
#import "LiveEndView.h"
#import "LiveShareView.h"
#import "PrivateChatView.h"



#import "LiveRoomIamgeView.h"
#import "LiveRoomUserCarView.h"



#import "PLCameraStreamingKit.h"

#import "Reachability.h"


#import "LivePlayer.h"


#define Expression_View_Height (245)
#define Gift_View_Height (188)

#define EnterRoom_TimeOut (15)
#define ButtonDalay   1.5//防止多次点击


// Transform values for full screen support:
#define CAMERA_TRANSFORM_X 1
// this works for iOS 4.x
#define CAMERA_TRANSFORM_Y 1.24299

@interface LiveRoomViewController () <GiftViewDelegate, LiveRoomMiddleViewDeleagte, LiveRoomMiddleViewDeleagte, ChatToolBarDelegate,  UIPopoverListViewDataSource, UIPopoverListViewDelegate, AudienceViewControllerDelegate,BeforeLiveViewDeleate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIGestureRecognizerDelegate,UIActionSheetDelegate,PLCameraStreamingSessionDelegate,PLStreamingSendingBufferDelegate,LivePlayerDelegate>
//{
//    seeku *seeku_all;
//    seeku *seeku_audio;
//}

@property (nonatomic,strong) LiveRoomLeftView   *leftView;
@property (nonatomic,strong) LiveRoomRightView  *rightView;

@property (nonatomic,strong) UIControl       *statusView;      //最顶端状态栏
@property (nonatomic,strong) UIImageView  *praiseView;      //点赞图标
@property (nonatomic,strong) UILabel      *praiseLabel;     //点赞
@property (nonatomic,strong) UILabel      *praise;     //点赞数
@property (nonatomic,strong) UILabel      *audience;     //在线

//@property (nonatomic,strong) EWPIconLable *liveStatusView;  //直播状态
@property (nonatomic,strong) UIImageView *liveActivity;  //正在连接的活动指示器
@property (nonatomic,strong) EWPButton    *muteBtn;         //静音功能
@property (nonatomic,strong) EWPButton    *changeCameraBtn; //摄像头切换
@property (nonatomic,strong) EWPButton    *openFlashLight;  //打开闪光灯

//@property (nonatomic,strong) UIControl *startLivingView;
@property (nonatomic,strong) EWPButton *startLivingButton;   //开始直播
@property (nonatomic,strong) EWPButton *bigChangeCameraButton;   //切换摄像头大按钮
@property (nonatomic,strong) EWPButton *bigChangeFalshButton;     //切换闪光等大按钮


@property (nonatomic,assign) BOOL isFlashOn;
@property (nonatomic,assign) BOOL isSoundOn;


//@property (nonatomic,strong) LoadingView *loadingView;
@property (nonatomic,strong) ChatToolBar *chatToolBar;

@property (nonatomic,strong) BaseView *giftBaseView;//showType = 3是StarGiftView类型；否则是GiftView

@property (nonatomic,strong) NSTimer *chatTimer;
@property (nonatomic,assign) NSInteger chatTime;

@property (nonatomic,assign) BOOL showingErroDialog;        //控制同一时间只显示一个

@property (nonatomic,strong) NSTimer *heartTimer;

@property (nonatomic,strong) UIView *stopLiveView;          //主播停播menu
@property (nonatomic,assign) BOOL   stopLiveViewShowing;    //正在显示主播停播按钮

//进入状态 0: 失败1:成功2: 房间不存在3: 房间人满4: 在黑名单中,禁止加入
@property (nonatomic,assign) NSInteger enterRoomResultCode; //进入房间返回码
@property (nonatomic,assign) BOOL      changeCavasFromLogin;

@property (nonatomic,strong) UIView *sendView;

@property (nonatomic,strong) UIImageView *videoImage;
@property (nonatomic,strong) EWPADView   *roomImgeView;//轮播图片

@property (nonatomic,assign) BOOL reconnect;
@property (nonatomic,assign) BOOL isPlayVideo;              //当前是音频或视频



@property (nonatomic,assign) BOOL tcpDisconnectWithErro;    //tcp异常断开

@property (nonatomic,strong) NSTimer *loginNoticeTimer;//超时未登录
@property (nonatomic,strong) NSTimer *getApproveTimer;
@property (nonatomic,strong) NSTimer *starPlayTImer;//开播心跳
@property (nonatomic,strong) NSTimer *roomPersonFullTimer;  //房间人满倒计时

@property (nonatomic,strong) NSMutableArray *tabMenuTitles;
@property (nonatomic,strong) NSMutableDictionary *tabMenuContentViews;

@property (nonatomic,assign) BOOL playing;//记录是否正在直播。
//@property (nonatomic,assign) BOOL loading;


@property (nonatomic,strong) PersonData *persondata;//个人档案数据

@property (nonatomic,strong) UIImageView *liveBg;

@property (nonatomic,strong) NSMutableArray *popMenuTitles;
@property (nonatomic,strong) UserInfo *userInfoOfPopupMenu;

@property (nonatomic,strong) EWPSimpleDialog *reportUserDialog;
@property (nonatomic,strong) EWPTextView *reportContent;
@property (nonatomic,strong) UITextField *reportContact;
@property (nonatomic,assign) NSInteger reportedUserId;

@property (nonatomic,strong) EWPSimpleDialog *sofaDialog;
//沙发
@property (nonatomic,weak) UITextField *sofaCoin;
@property (nonatomic,weak) SofaData *robSofaData;

@property (nonatomic,strong) AudienceViewController *audienceViewController;
@property (nonatomic,assign) CGFloat prossTimes; //获取赞60秒后自动加1

@property (nonatomic,strong) StartView* startView;

@property (nonatomic,assign) BOOL phoneLivingStarted;

@property (nonatomic,strong) NSTimer *tempLongTimer;//码流临时timer
@property (nonatomic,assign)long tempLongLast;//码流临时变量
@property (nonatomic,assign)float floatAngle;

@property (nonatomic,strong) NSTimer *activityIng;//正在连接活动指示器
@property (nonatomic,strong) NSTimer *playingTimer;//正在连接活动指示器
@property (nonatomic,strong) NSTimer *stopPlayingTimer;//正在连接活动指示器
@property (nonatomic,strong) NSString* strUploadUrl;//录制上传url
@property (nonatomic,strong) NSString* strServerport;//停播时候上传
@property (nonatomic,strong) NSString* strserverIP;//停播时候上传
@property (nonatomic,assign) BOOL isPersonalInfo;//从同意直播页面返回，用于区分直播返回页面
@property (nonatomic,assign) NSInteger heartCount;
@property (nonatomic,strong) NSString* strShowID;//开播本人的showid
@property (nonatomic,strong) NSTimer* stopPreAndUpLod;//开始直播预览前是否停止成功
@property (assign,nonatomic) NSInteger chenkStopPreAndUpLodCount;//开始直播预览前是否停止成功检查次数
@property (nonatomic,strong) NSTimer *mbProgressHudTimer;
@property (nonatomic,assign) BOOL isAddNotification;
@property (strong,nonatomic) BeforeLiveView* beforeLiveView;//自己开播前view
@property (assign,nonatomic) BOOL isSelfLivPrepareTime;//自己直播开播前准备海报阶段

@property (assign,nonatomic) BOOL isRequestOnce;//获取房间信息时候失败的情况下重试一次
@property (strong ,nonatomic)EWPButton* closeBtn;//自己直播时候的关闭按钮


@property (strong, nonatomic)LiveLoadingView* liveLoadingView;//加载中视图
@property (strong, nonatomic)LiveBottomView*  liveBottomView;//底部视图
@property (strong, nonatomic)AudienceHeaderView* liveAudienceHeaderView;//观众头像列表
@property (strong , nonatomic)LiveEndView* liveEndView;//直播结束页面
@property (strong , nonatomic)LiveShareView* liveShareView;//直播分享
@property (strong, nonatomic)PrivateChatView* priVateChatView;//私聊界面
@property (strong, nonatomic)PublicMessageVC* publicMessages;//     公聊界面
@property (strong, nonatomic)EWPSimpleDialog* dialogliveEnd;//确认关闭
@property (strong, nonatomic)LiveRoomUserCarView* liveRoomUserCarView;//用户车辆进入
@property (strong, nonatomic)UIView* viewGuide;//分享引导页
@property (nonatomic,strong) UIImageView *headImageView;

@property (strong, nonatomic)EWPAlertView* alertview;

@property (nonatomic,strong) UIImageView *headView; //主播头像
@property (nonatomic,strong) UIView *headbag;
@property (nonatomic,strong) UILabel  *nilkLabel;   //主播昵称

@property (nonatomic,strong) UIImageView *sexView;  //性别
@property (nonatomic,strong) UIImageView *vipView;  //VIP
@property (nonatomic,strong) UIImageView *wealthView;  //等级图标
@property (nonatomic,strong) UIImageView *cityView; //坐标
@property (nonatomic,strong) UILabel *cityName;    //地址
@property (nonatomic,strong) UILabel *inforLable;   //签名
@property (nonatomic,strong) UILabel *attention;    //关注
@property (nonatomic,strong) UILabel *attentionNumber;    //关注数
@property (nonatomic,strong) UILabel *sendLabel;    //送出
@property (nonatomic,strong) UIImageView *coinView; //热币
@property (nonatomic,strong) UILabel *sendNumber;   //送出数量
@property (nonatomic,strong) UILabel *coinLabel;    //热豆
@property (nonatomic,strong) UILabel *coinNumber;   //热豆数量
@property (nonatomic,strong) UIView *backView;    //颜色
@property (nonatomic,strong) UIButton *touchBut1;    //按钮事件
@property (nonatomic,assign) NSInteger seleate;     //判断是否获取用户信息
@property (nonatomic,strong) UIButton *starInforBut;

@property (nonatomic,assign) NSInteger userstate;   //根据这个字段判断是不是主播,1是用户
@property (nonatomic,assign) NSInteger userIdcount; //用户ID


@property (nonatomic,strong) EWPSimpleDialog *starInforlog;
@property (nonatomic,strong) UIActionSheet *sheet;

@property (assign, nonatomic)BOOL isTouchHomeEd;//切换到home键，正在直播继续运行，心跳照常发送，加个状态
@property (strong, nonatomic)UIActivityIndicatorView*  activityIndicatorView;//加载中活动指示器





@property (assign , nonatomic) BOOL isJianQuan;

@property(nonatomic,readonly,retain) UIWindow    *window;


//推流会话
@property (nonatomic, strong) PLCameraStreamingSession * session;
@property (nonatomic, strong) Reachability * internetReachability;
@property (nonatomic, strong) dispatch_queue_t sessionQueue;
@property (nonatomic, strong) NSArray   *videoConfigurations;
@property (nonatomic, strong) NSDate    *keyTime;

@property (nonatomic, strong) UIView * preview;

//播放
@property (nonatomic) LivePlayer *livePlayer;

//第一次直播的引导视图  喜欢就分享吧
@property (nonatomic, strong) UIImageView* imageViewGuide;




//初始化用户界面
- (void)initUserView;

//初始化主播界面
- (void)initStarView;

//初始化统一界面
- (void)initGeneralView;

- (void)initRoomSetting;

- (void)showNetworkErroDialog;

- (void)queryRoomAllData;

@end

@implementation RoomSettingData
@end

@implementation LiveRoomViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.baseViewType = kbaseScroolViewType;
    }
    return self;
}

#pragma mark viewDidLoad

//- (void)viewDidLoad {
//    [super viewDidLoad];
////    [self initGeneralView];
//    [self pLCameraStreamingConfigure];
//    [self achieveJSON];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.liveRoomVC = LiveRoomVC_LiveRoomViewController;
    self.isTouchHomeEd = NO;
    self.isFrontCamera = NO;
    NSLog(@"!!!%ld",(long)self.staruserid);
    
    [AppDelegate shareAppDelegate].isNeedReturnLiveRoom = YES;
    
    // Do any additional setup after loading the view.
    
    [self initGeneralView];  //初始化scrollView以及loadingView

    //    主播信息
    UserInfo *userInfo = [UserInfoManager shareUserInfoManager].currentUserInfo;
    if (self.staruserid > 0)//主播id
    {
        if (userInfo == nil)//游客的情况
        {
            [self initUserView];//顶部正在直播和退出
            [self initToolBar];//初始化聊天界面
        }
        else if (userInfo.userId == self.staruserid && [AppDelegate shareAppDelegate].isSelfWillLive)//主播id和用户id一样
        {
            [self pLCameraStreamingConfigure];//初始化七牛推流
            [self initStarView];//自己主播
            
        }
        else
        {
            [self initUserView];//看别人直播
            [self initToolBar];//初始化聊天界面
        }
    }
    
    [self initRoomSetting];//初始化房间定时等信息1.后台播放音频设置，2，进入之前先退出房间，关闭定时器，停止播放，断开TCP。加载loadView，初始化主播信息
    

    //屏幕常亮
    [ [ UIApplication sharedApplication] setIdleTimerDisabled:YES ];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (_liveRoomVC == LiveRoomVC_LiveRankViewController) {
        
    }else{
        [self addAllObserver];
        
        if (_chatToolBar)
        {
            [_chatToolBar viewWillAppear];
        }
        
       
    }
 
    //全屏
    [UIApplication sharedApplication].statusBarHidden = YES;
    self.navigationController.navigationBarHidden = YES;
    [UIApplication sharedApplication].idleTimerDisabled = YES;
    //获取用户最新信息
    [[AppInfo shareInstance] refreshCurrentUserInfo:nil];
    
    if (self.changeCavasFromLogin && [AppInfo shareInstance].bLoginSuccess)
    {
        [self exitRoom:YES];
        [self.middleView clearAllMessage];
        [self getStarInfo];// 获取主播信息 初始化页面数据,连接Tcp
    }
    
    _liveRoomVC  =  LiveRoomVC_LiveRoomViewController;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    if (_alertview) {
        [ _alertview dismissWithClickedButtonIndex:0 animated:NO];
    }
    
    if (_liveRoomVC==LiveRoomVC_LiveRankViewController) {
        
    }else{
    [self removeAllObserver];

    }
    //退出全屏
    [UIApplication sharedApplication].idleTimerDisabled = NO;
    [UIApplication sharedApplication].statusBarHidden = NO;
    self.navigationController.navigationBarHidden = NO;
    
}



#pragma mark - 七牛 推流

//一些网络的状态
const char *networkStatus[] = {
    "Not Reachable",
    "Reachable via WiFi",
    "Reachable via CELL"
};
//推流的状态
const char *stateNames[] = {
    "Unknow",
    "Connecting",
    "Connected",
    "Disconnecting",
    "Disconnected",
    "Error"
};

#define kReloadConfigurationEnable  0

// 假设在 videoFPS 低于预期 50% 的情况下就触发降低推流质量的操作，这里的 40% 是一个假定数值，你可以更改数值来尝试不同的策略
#define kMaxVideoFPSPercent 0.5

// 假设当 videoFPS 在 10s 内与设定的 fps 相差都小于 5% 时，就尝试调高编码质量
#define kMinVideoFPSPercent 0.05
#define kHigherQualityTimeInterval  10


//初始化和一些默认配置.线程串行,网络状态监控.

- (void)pLCameraStreamingConfigure {
    
    //视频尺寸
//    CGSize videoSize = CGSizeMake(320, 480);
    CGSize videoSize = [UIScreen mainScreen].bounds.size;
    self.videoConfigurations = @[
                                 [[PLVideoStreamingConfiguration alloc] initWithVideoSize:videoSize videoFrameRate:15 videoMaxKeyframeInterval:45 videoBitrate:800 * 1000 videoProfileLevel:AVVideoProfileLevelH264Baseline31],
                                 [[PLVideoStreamingConfiguration alloc] initWithVideoSize:videoSize videoFrameRate:24 videoMaxKeyframeInterval:72 videoBitrate:800 * 1000 videoProfileLevel:AVVideoProfileLevelH264Baseline31],
                                 [[PLVideoStreamingConfiguration alloc] initWithVideoSize:videoSize videoFrameRate:30 videoMaxKeyframeInterval:90 videoBitrate:800 * 1000 videoProfileLevel:AVVideoProfileLevelH264Baseline31],
                                 ];
    //串行线程
//    self.sessionQueue = dispatch_queue_create("pili.queue.streaming", DISPATCH_QUEUE_SERIAL);
    
    // 网络状态监控
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    self.internetReachability = [Reachability reachabilityForInternetConnection];
    [self.internetReachability startNotifier];
    
}

- (dispatch_queue_t)sessionQueue {
    if (!_sessionQueue) {
        _sessionQueue = dispatch_queue_create("pili.queue.streaming", DISPATCH_QUEUE_SERIAL);
    }
    return _sessionQueue;
}


//获取请求的JSON字典.
- (void)achieveJSON {
    NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
    
    NSString * userId = [NSString stringWithFormat:@"%ld",(long)[UserInfoManager shareUserInfoManager].currentUserInfo.userId];
    [dict setObject:userId forKey:@"staruserid"];
    
    __weak __typeof(&*self) weakSelf = self;
    GetStreamInfoModel * model = [[GetStreamInfoModel alloc] init];
    [model requestDataWithParams:dict success:^(id object) {
        
        GetStreamInfoModel * model = object;
        
        if (model.result == 0) {
            if ([model.data isKindOfClass:[NSString class]]) {
                NSString * jsonStr = model.data;
                NSData * jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
                NSDictionary * jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
                //开始接受JSON Dic.
                [weakSelf configureVideoAndAudioWithStreamJSON:jsonDic];
            }

            
            
        }else {
            EWPLog(@"推流JSon请求失败");
        }

    } fail:^(id object) {
        EWPLog(@"推流JSon请求发生错误");
    }];
    
}

//根据提供的streamJSON,设置音视频的触发条件以及设置代理.
- (void)configureVideoAndAudioWithStreamJSON:(NSDictionary *)streamJSON {
    
    PLStream *stream = [PLStream streamWithJSON:streamJSON];
    
    void (^permissionBlock)(void) = ^{
        dispatch_async(self.sessionQueue, ^{
            // 视频编码配置
            PLVideoStreamingConfiguration *videoConfiguration = [self.videoConfigurations lastObject];
            // 音频编码配置
            PLAudioStreamingConfiguration *audioConfiguration = [PLAudioStreamingConfiguration defaultConfiguration];
            
            // 推流 session
            self.session = [[PLCameraStreamingSession alloc] initWithVideoConfiguration:videoConfiguration
                                                                     audioConfiguration:audioConfiguration
                                                                                 stream:stream
                                                                       videoOrientation:AVCaptureVideoOrientationPortrait];
            self.session.delegate = self;
            self.session.bufferDelegate = self;
            dispatch_async(dispatch_get_main_queue(), ^{
                
//                UIView * view1 = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//                [self.view addSubview:view1];
                
//                self.session.previewView = self.view;
                self.session.previewView = self.preview;
                
                NSString *log = [NSString stringWithFormat:@"Zoom Range: [1..%.0f]", self.session.videoActiveFormat.videoMaxZoomFactor];
                NSLog(@"%@", log);
//                [self startSession];
            });
        });
    };
    
    void (^noAccessBlock)(void) = ^{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"No Access", nil)
                                                            message:NSLocalizedString(@"!", nil)
                                                           delegate:nil
                                                  cancelButtonTitle:NSLocalizedString(@"Cancel", nil)
                                                  otherButtonTitles:nil];
        [alertView show];
    };
    
    //摄像头授权
    switch ([PLCameraStreamingSession cameraAuthorizationStatus]) {
            //授权的情况
        case PLAuthorizationStatusAuthorized:
            permissionBlock();
            break;
            //还没确定是否授权.
        case PLAuthorizationStatusNotDetermined: {
            [PLCameraStreamingSession requestCameraAccessWithCompletionHandler:^(BOOL granted) {
                granted ? permissionBlock() : noAccessBlock();
            }];
        }
            break;
            
        default:
            noAccessBlock();
            break;
    }
}


//结束会话
- (void)stopSession {
    __weak typeof(self)weakSelf = self;
    dispatch_async(self.sessionQueue, ^{
        self.keyTime = nil;
        [self.session stop];
        //_liveLoadingView消失
        if (weakSelf.liveLoadingView) {
            weakSelf.liveLoadingView.hidden = YES;
        }

    });
}

//开始会话
- (void)startSession {
    self.keyTime = nil;
//    self.actionButton.enabled = NO;
    __weak typeof(self)weakSelf = self;
    dispatch_async(self.sessionQueue, ^{
        [self.session startWithCompleted:^(BOOL success) {
            dispatch_async(dispatch_get_main_queue(), ^{
//                self.actionButton.enabled = YES;
                
                //_liveLoadingView消失
                if (weakSelf.liveLoadingView) {
                    weakSelf.liveLoadingView.hidden = YES;
                }
            });
        }];
    });
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
    
    dispatch_sync(self.sessionQueue, ^{
        [self.session destroy];
    });
    self.session = nil;
    self.sessionQueue = nil;
}



#pragma mark - 判断网络状态
- (void)reachabilityChanged:(NSNotification *)notif{
    Reachability *curReach = [notif object];
    NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
    NetworkStatus status = [curReach currentReachabilityStatus];
    
    if (NotReachable == status) {
        // 对断网情况做处理
        [self stopSession];
    }
    
    NSString *log = [NSString stringWithFormat:@"Networkt Status: %s", networkStatus[status]];
    NSLog(@"%@", log);
}

#pragma mark - <PLStreamingSendingBufferDelegate> buffer的代理
//buffer满的时候
- (void)streamingSessionSendingBufferDidFull:(id)session {
    NSString *log = @"Buffer is full";
    NSLog(@"%@", log);
}

//
- (void)streamingSession:(id)session sendingBufferDidDropItems:(NSArray *)items {
    NSString *log = @"Frame dropped";
    NSLog(@"%@", log);
}

#pragma mark - <PLCameraStreamingSessionDelegate>

//当流状态变更为非 Error时,会回调这里.
- (void)cameraStreamingSession:(PLCameraStreamingSession *)session streamStateDidChange:(PLStreamState)state {
    NSString *log = [NSString stringWithFormat:@"Stream State: %s", stateNames[state]];
    NSLog(@"%@", log);
    // 除 PLStreamStateError 外的其余状态会回调在这个方法
    // 这个回调会确保在主线程，所以可以直接对 UI 做操作
    if (PLStreamStateConnected == state) {
//        [self.actionButton setTitle:NSLocalizedString(@"Stop", nil) forState:UIControlStateNormal];
        //如果流正常连接
        
    } else if (PLStreamStateDisconnected == state) {
//        [self.actionButton setTitle:NSLocalizedString(@"Start", nil) forState:UIControlStateNormal];
        //如果流未连接
        
    }
    NSLog(@"%s,%d",__FUNCTION__,__LINE__);
}

//流状态为Error时,回调这里.
- (void)cameraStreamingSession:(PLCameraStreamingSession *)session didDisconnectWithError:(NSError *)error {
    NSString *log = [NSString stringWithFormat:@"Stream State: Error. %@", error];
    NSLog(@"%@", log);
    // PLStreamStateError 都会回调在这个方法
    // 尝试重连，注意这里需要你自己来处理重连尝试的次数以及重连的时间间隔
//    [self.actionButton setTitle:NSLocalizedString(@"Reconnecting", nil) forState:UIControlStateNormal];
//流错误时界面的改变
    
    [self startSession];

    
}
//开始推流时,每隔3秒回调方法反馈该3秒的流状态,包括视频帧率,音频帧率,音视频总码率.
- (void)cameraStreamingSession:(PLCameraStreamingSession *)session streamStatusDidUpdate:(PLStreamStatus *)status {
    NSString *log = [NSString stringWithFormat:@"%@", status];
    NSLog(@"%@", log);
    
#if kReloadConfigurationEnable
    NSDate *now = [NSDate date];
    if (!self.keyTime) {
        self.keyTime = now;
    }
    
    double expectedVideoFPS = (double)self.session.videoConfiguration.videoFrameRate;
    double realtimeVideoFPS = status.videoFPS;
    if (realtimeVideoFPS < expectedVideoFPS * (1 - kMaxVideoFPSPercent)) {
        // 当得到的 status 中 video fps 比设定的 fps 的 50% 还小时，触发降低推流质量的操作
        self.keyTime = now;
        
        [self lowerQuality];
    } else if (realtimeVideoFPS >= expectedVideoFPS * (1 - kMinVideoFPSPercent)) {
        if (-[self.keyTime timeIntervalSinceNow] > kHigherQualityTimeInterval) {
            self.keyTime = now;
            
            [self higherQuality];
        }
    }
#endif  // #if kReloadConfigurationEnable
}

#pragma mark - 直播高低质量

- (void)higherQuality {
    NSUInteger idx = [self.videoConfigurations indexOfObject:self.session.videoConfiguration];
    NSAssert(idx != NSNotFound, @"Oops");
    
    if (idx >= self.videoConfigurations.count - 1) {
        return;
    }
    PLVideoStreamingConfiguration *newConfiguration = self.videoConfigurations[idx + 1];
    [self.session reloadVideoConfiguration:newConfiguration];
}

- (void)lowerQuality {
    NSUInteger idx = [self.videoConfigurations indexOfObject:self.session.videoConfiguration];
    NSAssert(idx != NSNotFound, @"Oops");
    
    if (0 == idx) {
        return;
    }
    PLVideoStreamingConfiguration *newConfiguration = self.videoConfigurations[idx - 1];
    [self.session reloadVideoConfiguration:newConfiguration];
}



#pragma mark - NodeMedia 播放

- (void)playVideoWithUrlString:(NSString *)urlString {
    if (!_livePlayer) {
        _livePlayer = [[LivePlayer alloc] init];
        }
    
    [_livePlayer setLivePlayerDelegate:self];
    [_livePlayer setUIView:_videoImage ContentMode:UIViewContentModeScaleAspectFit];
    [_livePlayer setBufferTime:1000];
    [_livePlayer setMaxBufferTime:2000];
    
    [_livePlayer startPlay:urlString];
    
    NSLog(@"开始时间");
}

//nodeMedia 停止播放
- (void)stopPlayWithLivePlayer {
    //停止播放视频
    dispatch_async(dispatch_queue_create("close_dispatch",0), ^{
        if(_livePlayer) {
            [_livePlayer stopPlay]; //停止播放,同步操作,所有线程退出后返回,有一定等待时间
            _livePlayer = nil;      //释放LivePlayer对象
        }
    });
}



//NodeMedia的回调
-(void) onEventCallback:(int)event msg:(NSString *)msg {
    NSLog(@"onEventCallback:%d %@",event,msg);
    switch (event) {
        case 1000:
            //开始连接播放流
//            NSLog(@"+++1000");
            break;
        case 1001:
            //播放流连接成功 开始播放
            //_liveLoadingView消失
//            NSLog(@"+++1001  结束时间");
            break;
        case 1002:
            //播放流连接失败
//            NSLog(@"1002");
            break;
        case 1003:
            //播放流连接失败或播放过程中网络异常断开,进入自动重连
            //            [_lp stopPlay];
//            NSLog(@"1003");
            break;
        case 1004:
            //播放停止 所有资源处于可释放状态.
//            NSLog(@"1004");
            break;
        case 1005:
            //播放中遇到网络异常
            //            [_lp stopPlay];
//            NSLog(@"1005");
            break;
        case 1100:
            //NetStream.Buffer.Empty        数据缓冲为空 播放停止
//            NSLog(@"1100");
            break;
        case 1101:
            //NetStream.Buffer.Buffering    开始缓冲数据
//            NSLog(@"1101");
            break;
        case 1102:
            //NetStream.Buffer.Full         数据缓冲足够 开始播放
//            NSLog(@"1102");
            if (_liveLoadingView.isHidden == NO) {
                [self performSelectorOnMainThread:@selector(hiddenLiveLoadingView) withObject:nil waitUntilDone:NO];
            }
            
            break;
        case 1103:
            //收到 Stream EOF 或者 NetStream.Play.UnpublishNotify
            //            [_lp stopPlay];
//            NSLog(@"1103");
            break;
        default:
            break;
    }
    
}

- (void)hiddenLiveLoadingView {
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.25 animations:^{
        weakSelf.liveLoadingView.alpha = 0.0;
    } completion:^(BOOL finished) {
        weakSelf.liveLoadingView.hidden = YES;
    }];
    

}


#pragma mark -

- (void)initToolBar
{
    self.chatToolBar = [[ChatToolBar alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT , SCREEN_WIDTH, 33) showInView:self.view];
    [_chatToolBar viewWillAppear];
    _chatToolBar.delegate = self;
    _chatToolBar.rootViewController = self;
    _chatToolBar.containerView = self.view;
    [self.chatToolBar addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
    [self.view addSubview:_chatToolBar];
    
    
}
-(void)chatToolBarBarageSwitchChange{
    [self.chatToolBar updateBarageSwitch];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"frame"])
    {
        if (object == self.chatToolBar)
        {
            if (_chatToolBar.isPrivateChat) {
                _priVateChatView.frame = CGRectMake(0,  _chatToolBar.frameY-570/2+33  , SCREEN_WIDTH, 570/2);
                DLogRect(self.chatToolBar.frame);
                return;
            }
            
            self.middleView.center = CGPointMake(self.middleView.center.x, CGRectGetMinY(self.chatToolBar.frame) - self.middleView.frame.size.height / 2 + self.middleView.bottomView.frame.size.height);
            
            if (self.middleView.frame.origin.y > 0)
            {
                CGRect frame = self.middleView.frame;
                frame.origin.y = 0;
                self.middleView.frame = frame;
            }else {
            }
            
            
        }
        else if (object == self.giftBaseView)
        {
            self.middleView.center = CGPointMake(self.middleView.center.x, CGRectGetMinY(self.giftBaseView.frame) - self.middleView.frame.size.height / 2 + self.middleView.bottomView.frame.size.height);
            if (self.middleView.frame.origin.y > 0)
            {
                CGRect frame = self.middleView.frame;
                frame.origin.y = 0;
                self.middleView.frame = frame;
            }else{
                
            }
        }
        
        if (self.middleView.frame.origin.y < 0)
        {
            //            self.middleView.bottomView.hidden = YES;
            self.liveBottomView.hidden = YES;
        }
        else
        {
            //            self.middleView.bottomView.hidden = NO;
            self.liveBottomView.hidden = NO;
        }
    }
}


#pragma mark - 加载显示视频的imageView 以及背景 ，loadingView
- (void)initGeneralView
{

    
    //音视频画布
    if ([self phoneLiving]) {
        //如果自己是主播,布局.
        _liveRoomIamgeView = [[LiveRoomIamgeView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _liveRoomIamgeView.userInteractionEnabled = YES;
        [self.view addSubview:_liveRoomIamgeView];
        
        _preview = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [_liveRoomIamgeView addSubview:_preview];
        
        self.liveBg = [[UIImageView alloc] initWithFrame:_liveRoomIamgeView.bounds];
        self.liveBg.image = [UIImage imageNamed:@"liveBg"];
        [_liveRoomIamgeView addSubview:self.liveBg];
        
    }else{
        _videoImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//        _videoImage.backgroundColor =  [UIColor colorWithPatternImage:[UIImage imageNamed:@"livrRoomPram"]];
        //    _videoImage.contentMode = UIViewContentModeScaleAspectFill;
        _videoImage.clipsToBounds = YES;
        [self.view addSubview:_videoImage];
        self.liveBg = [[UIImageView alloc] initWithFrame:_videoImage.bounds];
        self.liveBg.image = [UIImage imageNamed:@"liveBg"];
        [_videoImage addSubview:self.liveBg];
    }
    
    
    
    
    //加载loadingView
    _liveLoadingView  = [[LiveLoadingView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:_liveLoadingView];
    
    
    
    //公聊区
    _middleView = [[LiveRoomMiddleView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) showInView:self.view];
    _middleView.rootViewController = self;
    _middleView.delegate = self;
    [self.view addSubview:_middleView];
    
    
    [LiveRoomHelper shareLiveRoomHelper].rootLiveRoomViewController = self;
    

    
    
    //头像列表
    _liveAudienceHeaderView = [[AudienceHeaderView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-10, 0+2, SCREEN_WIDTH -(SCREEN_WIDTH/2-10), 14+35) showInView:self.view];
    __weak typeof(self) weakself = self;
    _liveAudienceHeaderView.rootLiveRoomViewController = self;
    _liveAudienceHeaderView.audienceHeaderViewTouch = ^(UserInfo* userInfo){
        _userIdcount = userInfo.userId;
        [weakself userInfor:userInfo];
    };

    [self.view addSubview:_liveAudienceHeaderView];
    
    
    
    //底部栏
    _liveBottomView = [[LiveBottomView alloc]initView:CGRectMake(0, SCREEN_HEIGHT-35-10, SCREEN_WIDTH, 35+10) withType:[self phoneLiving]?BottomType_ZhuBo:BottomType_GuanZHong];
    _liveBottomView.userInteractionEnabled = YES;
    
    _liveBottomView.backgroundColor = [UIColor clearColor];
    
    __weak typeof(self) weakself1 = self;
    _liveBottomView.LiveBottomViewTouch = ^(NSInteger tag){
        
        if (tag==0) {//公聊
            
            [weakself1.chatToolBar.messageCotent becomeFirstResponder];
            weakself1.chatToolBar.typeKey = TypeKey_GONGLIAO;
            
        }else if (tag==1){//私聊
           
            
            if ([weakself1 showLoginDialog]){
                return ;
            }
                
            weakself1.chatToolBar.isPrivateChat = YES;
            [weakself1.priVateChatView changeFieldText];
            [weakself1.priVateChatView  hidPrivateChatViewWithisHid:NO];
            weakself1.chatToolBar.frame =  CGRectMake (0, SCREEN_HEIGHT-33 , SCREEN_WIDTH, 33);
            
        }else if (tag==2){//分享
            
            
            [weakself1.liveShareView hidSelfWithisHid:NO];
            
            
        }else if (tag==3){//礼物
            if (_liveBottomView.type == BottomType_ZhuBo) {//关闭
                [weakself1 liveEndDealog];
            }else {
                [weakself1 giftAction:nil];
            }
            
            
        }else if (tag==4){//关闭
            NSLog(@"右下角关闭按钮");
            [weakself1 autoExitRoom];
            
        }
        
    };
    [self.view addSubview:_liveBottomView];

    

    
    
    _liveShareView = [[LiveShareView alloc]initWithFrame:[self phoneLiving]?CGRectMake(SCREEN_WIDTH-10-(4-2)*(35+7)+7+35/2-103/2, SCREEN_HEIGHT-_liveBottomView.frameHeight-9-6-150/2, 103, 150/2+6):CGRectMake(SCREEN_WIDTH-10-(5-2)*(35+7)+7+35/2-103/2, SCREEN_HEIGHT-_liveBottomView.frameHeight-9-6-354/2, 103, 354/2+6) showInView:self.view];

    _liveShareView.rootLiveRoomViewController = self;
    [_liveShareView hidSelfWithisHid:YES];
    _liveShareView.liveShareViewTouche = ^(NSInteger tag){
      
#pragma mark 分享&相机设置
        if (tag==0) {//闪光灯
            
            if (weakself.liveBottomView.type == BottomType_ZhuBo) {//闪光灯
                if (weakself.liveRoomIamgeView.isAVCaptureTorchModeOn) {
                    [weakself showNoticeInWindow:@"闪光灯已关闭" duration:1];
                    [weakself.liveRoomIamgeView setFlashMode:AVCaptureTorchModeOff];
                }else{
                    
                    if (weakself.isFrontCamera == YES) {
                        [weakself showNoticeInWindow:@"当前摄像头不支持闪光灯" duration:1];
                        return ;
                    }
                    [weakself showNoticeInWindow:@"闪光灯已打开" duration:1];
                    [weakself.liveRoomIamgeView setFlashMode:AVCaptureTorchModeOn];
                }
                
            }else{
                [[LiveRoomHelper shareLiveRoomHelper] helperShareWithNumber:0 withShareTyep:@[UMShareToWechatSession] withParms:weakself1.headImageView.image];
            }
            
        }else if (tag==1){//前后摄像头
            
            if (weakself.liveBottomView.type == BottomType_ZhuBo) {//翻转
                
                
//                [weakself.liveRoomIamgeView rotateCamera];
                dispatch_async(weakself.sessionQueue, ^{
                    
                    if (weakself.liveRoomIamgeView.isAVCaptureTorchModeOn) {
                        [weakself.liveRoomIamgeView setFlashMode:AVCaptureTorchModeOff];
                    }
                    
                    [weakself.session toggleCamera];
                    weakself.isFrontCamera = !weakself.isFrontCamera;
                    NSLog(@"%@",weakself.isFrontCamera?@"是前置摄像头":@"不是前置摄像头");
                });
                
                
            }else{
                [[LiveRoomHelper shareLiveRoomHelper] helperShareWithNumber:0 withShareTyep:@[UMShareToWechatTimeline] withParms:weakself1.headImageView.image];
            }
            
            
        }else if (tag==2){//QQ
            [[LiveRoomHelper shareLiveRoomHelper] helperShareWithNumber:0 withShareTyep:@[UMShareToQQ] withParms:weakself1.headImageView.image];
        }else if (tag==3){//QQ空间
            [[LiveRoomHelper shareLiveRoomHelper] helperShareWithNumber:0 withShareTyep:@[UMShareToQzone] withParms:weakself1.headImageView.image];
        }else if (tag==4){//微博
            
            [[LiveRoomHelper shareLiveRoomHelper] helperShareWithNumber:0 withShareTyep:@[UMShareToSina] withParms:weakself1.headImageView.image];
        }
        
    };
    [self.view addSubview:_liveShareView];
    
    _priVateChatView = [[PrivateChatView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-570/2, SCREEN_WIDTH, 570/2) showInView:self.view];
    [_priVateChatView hidPrivateChatViewWithisHid:YES];
    _priVateChatView.rootLiveRoomViewController = self;
    [self.view addSubview:_priVateChatView];
    [self.view bringSubviewToFront:self.chatToolBar];
    
    [self initStatusView];   //顶部赞个观众

    
    _liveEndView = [[LiveEndView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _liveEndView.rootLiveRoomController = self;
    _liveEndView.hidden = YES;
    [self.view addSubview:_liveEndView];
    
    [self hidLiveRoomBeforLiveViewHid:YES];

    if (![AppManager  valueForKey:@"isLiveGuideFirst"]&&![self phoneLivingSelf]) {//引导层
    
        
        _imageViewGuide = [[ UIImageView alloc]initWithFrame:CGRectMake(0, 0, 270/2, 78/2)];
        _imageViewGuide.center = CGPointMake(SCREEN_WIDTH-10-(5-4)*(35+7)+7-270/2/2, SCREEN_HEIGHT-35-10-78/2/2-5);
        [self.view addSubview:_imageViewGuide];
        _imageViewGuide.image =[UIImage imageNamed:@"LRLiveShare.png"];
        
        
        
        __weak  UIImageView* safeGuide = _imageViewGuide;
        EWPButton*buttonGuide= [[EWPButton alloc]initWithFrame:CGRectMake(0, 0  , SCREEN_WIDTH, SCREEN_HEIGHT)];
        __weak EWPButton* button =buttonGuide;
        buttonGuide.buttonBlock = ^(EWPButton* sender){
            [AppManager setUserBoolValue:YES key:@"isLiveGuideFirst"];
            [safeGuide removeFromSuperview];
            [button removeFromSuperview];
            
            
        };
        
        [self.view addSubview:buttonGuide];
    }

    
    _liveRoomUserCarView = [[LiveRoomUserCarView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-375/2-40, SCREEN_WIDTH,80/2 )];

    [self.view addSubview:_liveRoomUserCarView];
}
-(void)liveEndDealog{
    _dialogliveEnd = [[EWPSimpleDialog alloc] initWithFrame:CGRectMake(0, 0, 270, 173)];
    _dialogliveEnd.layer.borderColor = [UIColor whiteColor].CGColor;
    _dialogliveEnd.backgroundColor = [UIColor whiteColor];
    _dialogliveEnd.layer.cornerRadius = 4.0f;
    _dialogliveEnd.layer.borderWidth = 1.0f;
    
    
    NSMutableString *priceTipString = [NSMutableString string];
    [priceTipString appendFormat:@"确定结束直播？"];
    
    CGSize size = [CommonFuction sizeOfString:priceTipString maxWidth:290 - 20 maxHeight:20 withFontSize:13.0f];
    
    UILabel *priceTipLable = [[UILabel alloc] initWithFrame:CGRectMake(270/2-size.width/2-10, 173/2-30, size.width+20, 20)];
    priceTipLable.text = priceTipString;
    priceTipLable.textAlignment = NSTextAlignmentCenter;
    priceTipLable.textColor = [CommonFuction colorFromHexRGB:@"454a4d"];
    priceTipLable.font = [UIFont systemFontOfSize:14.0f];
    [_dialogliveEnd addSubview:priceTipLable];
    
    
    UIImage *normalImg = [CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"ffffff" ] size:CGSizeMake(100, 32)];
    UIImage *selectImg = [CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"d14c49" ] size:CGSizeMake(100, 32)];
    
    __weak typeof(self) weakSelf = self;
    
    EWPButton *confirmBtn = [[EWPButton alloc] initWithFrame:CGRectMake((270-100*2-20)/2+120, 120, 100, 32)];
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
    [_dialogliveEnd addSubview:confirmBtn];
    confirmBtn.isSoonCliCKLimit = YES;
    [confirmBtn setButtonBlock:^(id sender)
     {
        
         [weakSelf autoExitRoom];
         [weakSelf.dialogliveEnd hide];
          weakSelf.liveRoomType =LiveRoomType_OutLiveRoom;
         
     }];
    
    EWPButton *cancelBtn = [[EWPButton alloc] initWithFrame:CGRectMake((270-100*2-20)/2, 120, 100, 32)];
    [cancelBtn setBackgroundImage:normalImg forState:UIControlStateNormal];
    [cancelBtn setBackgroundImage:selectImg forState:UIControlStateHighlighted];
    cancelBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    [cancelBtn setTitleColor:[CommonFuction colorFromHexRGB:@"d14c49"] forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[CommonFuction colorFromHexRGB:@"ffffff"] forState:UIControlStateHighlighted];
    cancelBtn.layer.cornerRadius = 16.0f;
    cancelBtn.layer.borderWidth = 1;
    cancelBtn.layer.masksToBounds = YES;
    cancelBtn.layer.borderColor = [CommonFuction colorFromHexRGB:@"d14c49"].CGColor;
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [_dialogliveEnd addSubview:cancelBtn];
    
    [cancelBtn setButtonBlock:^(id sender)
     {
         [weakSelf.dialogliveEnd hide];
     }];
    
    
    [_dialogliveEnd showInWindow];
    
    
}

-(void)hidLiveRoomBeforLiveViewHid:(BOOL)hid{
    if (self.phoneLiving) {
        NSInteger number = [[AppInfo shareInstance].coin.text integerValue];
        _statusView.hidden = hid;
        _liveLoadingView.hidden = hid;
        _liveBottomView.hidden = hid;
        _liveAudienceHeaderView.hidden = hid;
        _middleView.hidden = hid;
        _liveRoomUserCarView.hidden = hid;
        if (!hid) {
            if (number >0) {
                [AppInfo shareInstance].coinbackview.hidden = NO;
            }else{
                _seleate = 0;
                [AppInfo shareInstance].coinbackview.hidden = YES;
            }
        }else{
            [AppInfo shareInstance].coinbackview.hidden = YES;
        }

    }
 
}

#pragma mark -           顶部状态控制栏
- (void)initStatusView
{
    if (_statusView == nil)
    {
        _statusView = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, 125, 60)];
        [self.view addSubview:_statusView];
    }
    UIView *starView = [[UIView alloc] initWithFrame:CGRectMake(10, 13.5, 105, 40)];
    starView.layer.cornerRadius = 20.0f;
    starView.layer.borderColor = [UIColor whiteColor].CGColor;
    starView.layer.borderWidth = 0.5f;
    [_statusView addSubview:starView];
    
    [AppInfo shareInstance].coinbackview = [[UIView alloc] initWithFrame:CGRectMake(0, 63,50, 25)];
    //    _coinbackview.layer.cornerRadius = 20.0f;
    [AppInfo shareInstance].coinbackview.backgroundColor = [CommonFuction colorFromHexRGB:@"000000" alpha:0.3];
    [self.view addSubview:[AppInfo shareInstance].coinbackview];
    UITapGestureRecognizer *touch = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchCoin:)];
    [[AppInfo shareInstance].coinbackview addGestureRecognizer:touch];
    
    UILabel *coinlabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 34, 25)];
    coinlabel.text = @"热豆";
    coinlabel.font = [UIFont systemFontOfSize:13.0f];
    coinlabel.textColor = [CommonFuction colorFromHexRGB:@"ffd178"];
    [[AppInfo shareInstance].coinbackview addSubview:coinlabel];
    
    [AppInfo shareInstance].coin = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 45, 25)];
    [AppInfo shareInstance].coin.textColor = [CommonFuction colorFromHexRGB:@"ffffff"];
    [AppInfo shareInstance].coin.font = [UIFont systemFontOfSize:14.0f];
    [AppInfo shareInstance].coin.text = @"0";
    [[AppInfo shareInstance].coinbackview addSubview:[AppInfo shareInstance].coin];
    
    [AppInfo shareInstance].coinImg = [[UIImageView alloc] initWithFrame:CGRectMake(80, 4.5, 16, 16)];
    [AppInfo shareInstance].coinImg.image = [UIImage imageNamed:@"arrow"];
    [AppInfo shareInstance].coinbackview.hidden = YES;
    [[AppInfo shareInstance].coinbackview addSubview:[AppInfo shareInstance].coinImg];
    
    _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    _headImageView.layer.cornerRadius = 20.0f;
    _headImageView.layer.masksToBounds = YES;
    _headImageView.image = [UIImage imageNamed:@"leftBtn_normal"];
    [starView addSubview:_headImageView];
    
    _starInforBut= [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 40, 40)];
    _starInforBut.layer.cornerRadius = 20.0f;
    [_starInforBut addTarget:self action:@selector(starInfor:) forControlEvents:UIControlEventTouchUpInside];
    [starView addSubview:_starInforBut];
    
    _praiseView = [[UIImageView alloc] initWithFrame:CGRectMake(45, 9, 11, 11)];
    _praiseView.image = [UIImage imageNamed:@"praiseCount"];
    [starView addSubview:_praiseView];
    
    _praise = [[UILabel alloc] initWithFrame:CGRectMake(56, 9, 15, 11)];
    _praise.text = @"赞:  ";
    _praise.textColor = [CommonFuction colorFromHexRGB:@"ffffff"];
    _praise.font = [UIFont systemFontOfSize:10.0f];
    _praise.textAlignment = NSTextAlignmentLeft;
    [starView addSubview:_praise];
    
    _praiseLabel = [[UILabel alloc] initWithFrame:CGRectMake(74, 9, 30, 11)];
    _praiseLabel.text = @"0";
    _praiseLabel.textColor = [CommonFuction colorFromHexRGB:@"ffffff"];
    _praiseLabel.font = [UIFont systemFontOfSize:10.0f];
    _praiseLabel.textAlignment = NSTextAlignmentLeft;
    _praiseLabel.backgroundColor = [UIColor clearColor];
    [starView addSubview:_praiseLabel];
    
    //    //观众个数
    _audience = [[UILabel alloc] initWithFrame:CGRectMake(46, 23, 30, 11)];
    _audience.textColor = [CommonFuction colorFromHexRGB:@"ffffff"];
    _audience.font = [UIFont systemFontOfSize:10.0f];
    _audience.text = @"在线:  ";
    _audience.textAlignment = NSTextAlignmentLeft;
    [starView addSubview:_audience];
    
    //    //观众个数
    self.audienceLabel = [[UILabel alloc] initWithFrame:CGRectMake(74, 23, 30, 11)];
    self.audienceLabel.textColor = [CommonFuction colorFromHexRGB:@"ffffff"];
    self.audienceLabel.font = [UIFont systemFontOfSize:10.0f];
    self.audienceLabel.textAlignment = NSTextAlignmentLeft;
    self.audienceLabel.backgroundColor = [UIColor clearColor];
    [starView addSubview:self.audienceLabel];
    
    
    //    [self.view  bringSubviewToFront:_priVateChatView];
    [self.view  insertSubview:_priVateChatView aboveSubview:starView];
    
    _starInforlog = [[EWPSimpleDialog alloc] initWithFrame:CGRectMake((SCREEN_WIDTH -256)/2, (SCREEN_HEIGHT -311)/2, 256, 311)];
    _starInforlog.layer.cornerRadius = 7.0f;
    _starInforlog.backgroundColor = [CommonFuction colorFromHexRGB:@"ffffff"];
    _starInforlog.userInteractionEnabled = YES;
    
    _headbag = [[UIView alloc] initWithFrame: CGRectMake(88, -40, 80, 80)];
    _headbag.layer.cornerRadius = 40;
    _headbag.backgroundColor = [UIColor whiteColor];
    [_starInforlog addSubview:_headbag];
    
    _headView= [[UIImageView alloc] initWithFrame:CGRectMake(3, 3, 74, 74)];
    _headView.image = [UIImage imageNamed:@"leftBtn_normal"];
    _headView.layer.cornerRadius = 38.5;
    _headView.layer.masksToBounds = YES;
    [_headbag addSubview:_headView];
    
    _nilkLabel = [[UILabel alloc] initWithFrame:CGRectMake(43, 77, 75, 15)];
    _nilkLabel.textColor = [CommonFuction colorFromHexRGB:@"454a4d"];
    _nilkLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    [_starInforlog addSubview:_nilkLabel];
    
    _sexView = [[UIImageView alloc] initWithFrame:CGRectMake(124, 75, 20, 20)];
    [_starInforlog addSubview:_sexView];
    
    _vipView = [[UIImageView alloc] initWithFrame:CGRectMake(146, 75, 40, 21)];
    [_starInforlog addSubview:_vipView];
    
    _wealthView = [[UIImageView alloc] initWithFrame:CGRectMake(170, 75, 33, 15)];
    [_starInforlog addSubview:_wealthView];
    
    _cityView = [[UIImageView alloc] initWithFrame:CGRectMake(95, 108, 10, 14)];
    _cityView.image = [UIImage imageNamed:@"coordinate"];
    [_starInforlog addSubview:_cityView];
    
    _cityName = [[UILabel alloc] initWithFrame:CGRectMake(85, 105, 90, 15)];
    _cityName.textColor = [CommonFuction colorFromHexRGB:@"959596"];
    _cityName.font = [UIFont systemFontOfSize:10.0f];
    [_starInforlog addSubview:_cityName];
    
    _inforLable = [[UILabel alloc] initWithFrame:CGRectMake(35, 140, 190, 45)];
    _inforLable.numberOfLines = 3;
    _inforLable.lineBreakMode = NSLineBreakByWordWrapping;
    _inforLable.textAlignment = NSTextAlignmentCenter;
    _inforLable.textColor = [CommonFuction colorFromHexRGB:@"959596"];
    _inforLable.font = [UIFont boldSystemFontOfSize:12.0f];
    [_starInforlog addSubview:_inforLable];
    
    _attention = [[UILabel alloc] initWithFrame:CGRectMake(25, 205, 40, 17)];
    _attention.textColor = [CommonFuction colorFromHexRGB:@"959596"];
    _attention.text = @"关注 :";
    _attention.font = [UIFont systemFontOfSize:13.0f];
    [_starInforlog addSubview:_attention];
    
    _attentionNumber = [[UILabel alloc] initWithFrame:CGRectMake(_attention.frame.origin.x + _attention.frame.size.width - 3, 205, 50, 17)];
    _attentionNumber.textColor = [CommonFuction colorFromHexRGB:@"454a4d"];
    _attentionNumber.font = [UIFont systemFontOfSize:16.0f];
    _attentionNumber.text = @"0";
    [_starInforlog addSubview:_attentionNumber];
    
    _audience = [[UILabel alloc] initWithFrame:CGRectMake(142.5, 205, 40, 17)];
    _audience.textColor = [CommonFuction colorFromHexRGB:@"959596"];
    _audience.text = @"粉丝 :";
    _audience.font = [UIFont systemFontOfSize:13.0f];
    [_starInforlog addSubview:_audience];
    
    [AppInfo shareInstance].audienceNumber = [[UILabel alloc] initWithFrame:CGRectMake(_audience.frame.origin.x + _audience.frame.size.width - 3, 205, 50, 17)];
    [AppInfo shareInstance].audienceNumber.textColor = [CommonFuction colorFromHexRGB:@"454a4d"];
    [AppInfo shareInstance].audienceNumber.font = [UIFont systemFontOfSize:16.0f];
    [AppInfo shareInstance].audienceNumber.text = @"0";
    [_starInforlog addSubview:[AppInfo shareInstance].audienceNumber];
    
    _sendLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 233, 40, 17)];
    _sendLabel.textColor = [CommonFuction colorFromHexRGB:@"959596"];
    _sendLabel.font = [UIFont systemFontOfSize:13.0f];
    _sendLabel.text = @"送出 :";
    [_starInforlog addSubview:_sendLabel];
    
    _sendNumber = [[UILabel alloc] init];
    _sendNumber.frame = CGRectMake(_sendLabel.frame.origin.x + _sendLabel.frame.size.width - 3, 233, 70, 17);
    _sendNumber.textColor = [CommonFuction colorFromHexRGB:@"d14c49"];
    _sendNumber.font = [UIFont systemFontOfSize:16.0f];
    _sendNumber.text = @"0";
    [_starInforlog addSubview:_sendNumber];
    
    _coinView = [[UIImageView alloc] initWithFrame:CGRectMake(76, 233, 18, 18)];
    _coinView.image = [UIImage imageNamed:@"coin"];
    [_starInforlog addSubview:_coinView];
    
    _coinLabel = [[UILabel alloc] initWithFrame:CGRectMake(142.5, 233, 40, 17)];
    _coinLabel.textColor = [CommonFuction colorFromHexRGB:@"959596"];
    _coinLabel.font = [UIFont systemFontOfSize:13.0f];
    _coinLabel.text = @"热豆 :";
    [_starInforlog addSubview:_coinLabel];
    
    _coinNumber = [[UILabel alloc] initWithFrame:CGRectMake(_coinLabel.frame.origin.x + _coinLabel.frame.size.width - 3, 233, 60, 17)];
    _coinNumber.textColor = [CommonFuction colorFromHexRGB:@"ffd178"];
    _coinNumber.font = [UIFont systemFontOfSize:16.0f];
    _coinNumber.text = @"0";
    [_starInforlog addSubview:_coinNumber];
    
    _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 275 , 256, 41)];
    _backView.backgroundColor = [CommonFuction colorFromHexRGB:@"f792a0"];
    [_starInforlog addSubview:_backView];
    
    CAShapeLayer *confirmButtonLayer = [CAShapeLayer layer];
    UIBezierPath *radiusPath = [UIBezierPath bezierPathWithRoundedRect:_backView.bounds
                                                     byRoundingCorners:(UIRectCornerBottomLeft|UIRectCornerBottomRight)
                                                           cornerRadii:CGSizeMake(7.0f, 7.0f)];
    confirmButtonLayer.path = radiusPath.CGPath;
    _backView.layer.mask = confirmButtonLayer;
    
    _touchBut1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 64, 41)];
    _touchBut1.backgroundColor = [UIColor clearColor];
    [_touchBut1 setTitle:@"关注" forState:UIControlStateNormal];
    _touchBut1.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    _touchBut1.tag = 0;
    [_touchBut1 addTarget:self action:@selector(touchMethod:) forControlEvents:UIControlEventTouchUpInside];
    [_backView addSubview:_touchBut1];
    
    NSArray *tabTitles = [[NSArray alloc] initWithObjects:@"私聊",@"对ta说",@"主页",nil];
    for (int nIndex = 0; nIndex <3; ) {
        UIButton *touchBut = [[UIButton alloc] initWithFrame:CGRectMake(64 * (nIndex + 1), 0, 64, 41)];
        touchBut.backgroundColor = [UIColor clearColor];
        [touchBut setTitle:[tabTitles objectAtIndex:nIndex] forState:UIControlStateNormal];
        touchBut.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        touchBut.tag = nIndex +1;
        [touchBut addTarget:self action:@selector(touchMethod:) forControlEvents:UIControlEventTouchUpInside];
        [_backView addSubview:touchBut];
        nIndex ++;
    }
    
    for (int i=1; i<4; i++) {
        UIView *LineView1 = [[UIView alloc] initWithFrame:CGRectMake(64* i, 9.5, 1, 20)];
        LineView1.backgroundColor = [UIColor whiteColor];
        [_backView addSubview:LineView1];
    }
    // 关闭
    UIView *closeview = [[UIView alloc] initWithFrame:CGRectMake(210, 0, 40, 40)];
    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(223, 8, 27, 27)];
    [closeBtn setImage:[UIImage imageNamed:@"closeStar"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
    [_starInforlog addSubview:closeview];
    [_starInforlog addSubview:closeBtn];
    UITapGestureRecognizer *closeinfor = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close:)];
    [closeview addGestureRecognizer:closeinfor];

    //    操作
    UIView *warningview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    UIButton *warning = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 17, 17)];
    [warning setImage:[UIImage imageNamed:@"warning"] forState:UIControlStateNormal];
    [warning addTarget:self action:@selector(warning:) forControlEvents:UIControlEventTouchUpInside];
    [_starInforlog addSubview:warningview];
    [_starInforlog addSubview:warning];
    UITapGestureRecognizer *warninginfor = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(warning:)];
    [warningview addGestureRecognizer:warninginfor];
    
    _sheet= [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"举报",@"踢人",@"禁言", nil];
    
}

#pragma mark 点击主播头像
-(void)starInfor:(id)sender
{
    _userstate =2;
    _seleate = 1;
    [self getStarInfo];
//添加头像出现时候的动画
    
//    _starInforlog.transform = CGAffineTransformMakeScale(0.01f, 0.01f);
//    [UIView beginAnimations:@"scale" context:nil];
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//    [UIView setAnimationDuration:1];
//    _starInforlog.transform=CGAffineTransformMakeScale(1.0f, 1.0f);
//    [UIView commitAnimations];
    [_starInforlog showInView:self.view];
}
#pragma mark 点击排行榜
-(void)touchCoin:(id)sender
{
    LiveRankViewController *fansRank = [[LiveRankViewController alloc] init];
    _liveRoomVC = LiveRoomVC_LiveRankViewController;
    [self.navigationController pushViewController:fansRank animated:YES];
}
#pragma mark 踢人，禁言，举报
-(void)warning:(id)sender
{
    [_sheet showInView:self.view];
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UserInfo *userInfo ;
    
    if(_userstate == 1)
    {
        userInfo = [AppInfo shareInstance].user;
    }else if(_userstate == 2)
    {
        userInfo = [UserInfoManager shareUserInfoManager].currentStarInfo;
    }else if (userInfo == nil)
    {
        userInfo = [AppInfo shareInstance].user;
    }
    
    if (buttonIndex == 0) {
        //        举报1
        [self reportLeft:userInfo];
    }else if (buttonIndex == 1)
    {
        //        踢人
        [self kickPersonLeft:userInfo];
    }else if (buttonIndex == 2)
    {
        //        禁言
        [self forbidSpeakLeft:userInfo];
    }else
    {
        //        其他
    }
    

    
}


-(void)userInfor:(UserInfo *)userInfo
{
    if (userInfo)
    {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [AppInfo shareInstance].user = userInfo;
        [dict setObject:[NSNumber numberWithInteger:userInfo.userId] forKey:@"userid"];
        GetUserInfoModel *userInfoModel = [[GetUserInfoModel alloc] init];
        userInfoModel.isNotUseToken = YES;
        [userInfoModel requestDataWithParams:dict success:^(id object) {
            /*成功返回数据*/
            if (userInfoModel.result == 0)
            {
                if (userInfoModel.userInfo)
                {
                    
                    NSURL *headUrl = [NSURL URLWithString: [NSString stringWithFormat:@"%@/%@",[AppInfo shareInstance].res_server,userInfoModel.userInfo.photo]];
                    //               主播头像
                    [_headView sd_setImageWithURL:headUrl placeholderImage:[UIImage imageNamed:@"leftBtn_normal"]];
                      [UserInfoManager shareUserInfoManager].tempHederImage =_headView.image;
                    //                昵称
                    _nilkLabel.text = userInfoModel.userInfo.nick;
                    
                    //                性别图标
                    if (userInfoModel.userInfo.sex == 1) {
                        _sexView.image = [UIImage imageNamed:@"boy"];
                    }
                    else if (userInfoModel.userInfo.sex == 2)
                    {
                        _sexView.image = [UIImage imageNamed:@"girl"];
                    }else
                    {
                        _sexView.image = [UIImage imageNamed:@""];
                    }
                    
                    //                VIP图标
                    if(userInfoModel.userInfo.isPurpleVip)
                    {
                        _vipView.image = [UIImage imageNamed:@"pvip"];
                    }else if (userInfoModel.userInfo.isYellowVip)
                    {
                        _vipView.image = [UIImage imageNamed:@"yvip"];
                    }else
                    {
                        _vipView.image = [UIImage imageNamed:@""];
                    }
                    
                    //                 明星等级
                    _wealthView.image = [[UserInfoManager shareUserInfoManager] imageOfconsumerlevelweight:userInfoModel.userInfo.consumerlevelweight];
                    
                    //                城市
                    if(userInfoModel.userInfo.provincename || userInfoModel.userInfo.cityname)
                    {
                        _cityName.text = [NSString stringWithFormat:@"%@%@",userInfoModel.userInfo.provincename,userInfoModel.userInfo.cityname];
                    }
                    else
                    {
                        _cityName.text = @"太阳系火星";
                    }
                    //                个性签名
                    if(userInfoModel.userInfo.introduction)
                    {
                        _inforLable.text = userInfoModel.userInfo.introduction;
                    }else
                    {
                        _inforLable.text = @"全民星直播互动平台，娱乐你的生活";
                    }
                    
                    //                关注数量
                    _attentionNumber.text = [NSString stringWithFormat:@"%ld",(long)userInfoModel.userInfo.attentionnum];
                    
                    //                粉丝数量
                    if(userInfoModel.userInfo.fansnum)
                    {
                    }
                    [AppInfo shareInstance].fansNumber = (long)userInfoModel.userInfo.fansnum;
                    [AppInfo shareInstance].audienceNumber.text = [NSString stringWithFormat:@"%ld",[AppInfo shareInstance].fansNumber];
                    
                    //                送出数量 sendNumber
                    if(userInfoModel.userInfo.costcoin <1000)
                    {
                        _sendNumber.text = [NSString stringWithFormat:@"%ld",(long)userInfoModel.userInfo.costcoin];

                    }else if (userInfoModel.userInfo.costcoin >=1000 && userInfoModel.userInfo.costcoin <999950)
                    {
                         _sendNumber.text = [NSString stringWithFormat:@"%.1fK",(float)userInfoModel.userInfo.costcoin/1000];
                    }else{
                        _sendNumber.text = [NSString stringWithFormat:@"%.1fM",(float)userInfoModel.userInfo.costcoin/1000000];

                    }
                    
                    //                热豆数量
                    
                    if(userInfoModel.userInfo.getcoin <1000)
                    {
                        _coinNumber.text = [NSString stringWithFormat:@"%ld",(long)userInfoModel.userInfo.getcoin];
                    }else if (userInfoModel.userInfo.getcoin >=1000 && userInfoModel.userInfo.getcoin <999950)
                    {
                        _coinNumber.text = [NSString stringWithFormat:@"%.1fK",(float)userInfoModel.userInfo.getcoin/1000];
                    }else{
                        _coinNumber.text = [NSString stringWithFormat:@"%.1fM",(float)userInfoModel.userInfo.getcoin/1000000];
                        
                    }

                    
                    if(userInfoModel.userInfo.attentionflag)
                    {
                        [AppInfo shareInstance].state = 1;
                        [_touchBut1 setTitle:@"已关注" forState:UIControlStateNormal];
                    }else
                    {
                        [AppInfo shareInstance].state = 0;
                        [_touchBut1 setTitle:@"关注" forState:UIControlStateNormal];
                    }
                    
                    CGSize citySize = [_cityName sizeThatFits:CGSizeMake(110, MAXFLOAT)];
                    _cityName.frame = CGRectMake((256 - citySize.width )/2, 105, citySize.width, 15);
                    _cityView.frame = CGRectMake((256 - citySize.width )/2 - 17, 105, 10, 14);
                    
                    CGSize sendSize = [_sendNumber sizeThatFits:CGSizeMake(70, MAXFLOAT)];
                    _coinView.frame = CGRectMake(_sendNumber.frame.origin.x + sendSize.width + 3 , 233, 18, 18);
                    
                    CGSize nickSize = [_nilkLabel sizeThatFits:CGSizeMake(110, MAXFLOAT)];
                    for (int count = 0; count <3; count++) {
                        if (count == 1) {
                            _nilkLabel.frame =CGRectMake(0, 77, nickSize.width, 15);
                        }else
                        {
                            _nilkLabel.frame =CGRectMake((256 - 33 - _wealthView.frame.origin.x)/2 , 77, nickSize.width, 15);
                        }
                        if(userInfoModel.userInfo.sex >0)
                        {
                            _sexView.frame=CGRectMake(_nilkLabel.frame.origin.x + nickSize.width + 5, 72, 20, 20);
                            if(userInfoModel.userInfo.isPurpleVip ||userInfoModel.userInfo.isYellowVip)
                            {
                                _vipView.frame = CGRectMake(_nilkLabel.frame.origin.x + nickSize.width + 28, 72, 40, 21);
                                _wealthView.frame = CGRectMake(_nilkLabel.frame.origin.x + nickSize.width + 71, 75, 33, 15);
                            }else
                            {
                                _wealthView.frame = CGRectMake(_nilkLabel.frame.origin.x + nickSize.width + 28, 75, 33, 15);
                            }
                            
                        }else
                        {
                            if(userInfoModel.userInfo.isPurpleVip ||userInfoModel.userInfo.isYellowVip)
                            {
                                _vipView.frame = CGRectMake(_nilkLabel.frame.origin.x + nickSize.width + 5, 72, 40, 21);
                                _wealthView.frame = CGRectMake(_nilkLabel.frame.origin.x + nickSize.width + 48, 75, 33, 15);
                            }else
                            {
                                _wealthView.frame = CGRectMake(_nilkLabel.frame.origin.x + nickSize.width + 5, 75, 33, 15);
                            }
                        }//256
                    }
                    
                }
                
            }
//            显示动画
//            _starInforlog.transform = CGAffineTransformMakeScale(0.01f, 0.01f);
//            [UIView beginAnimations:@"scale" context:nil];
//            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//            [UIView setAnimationDuration:1];
//            _starInforlog.transform=CGAffineTransformMakeScale(1.0f, 1.0f);
//            [UIView commitAnimations];
            _userstate =1;
            [_starInforlog showInView:self.view];
            
        
        } fail:^(id object) {
            /*失败返回数据*/
            
        }];
    };
}

-(void)touchMethod:(id)sender
{

    UIButton *button = (UIButton *)sender;
    if (button.tag == 0) {
        if([AppInfo shareInstance].state == 1)
        {
            return;
        }
        
        if(_userstate == 1)
        {
            if(![AppInfo shareInstance].state)
            {
                if ([AppInfo shareInstance].user.userId == [UserInfoManager shareUserInfoManager].currentUserInfo.userId) {
                    [[AppInfo shareInstance]showNoticeInWindow:@"无法关注自己" duration:1.5];
                    return ;
                }
            }
            
            [[LiveRoomHelper shareLiveRoomHelper]starid:[AppInfo shareInstance].user.userId ButState:button Attention:[AppInfo shareInstance].state];
            
        }else if(_userstate == 2)
        {
            if (![AppInfo shareInstance].state) {
                if([UserInfoManager shareUserInfoManager].currentStarInfo.userId == [UserInfoManager shareUserInfoManager].currentUserInfo.userId)
                {
                    [[AppInfo shareInstance]showNoticeInWindow:@"无法关注自己" duration:1.5];
                    return ;
                }
            }

            [[LiveRoomHelper shareLiveRoomHelper]starid:[UserInfoManager shareUserInfoManager].currentStarInfo.userId ButState:button Attention:[AppInfo shareInstance].state];
        }else{
        
        }
            
        
    }else if (button.tag ==1)
    {
        
        if (_chatToolBar)
        {
            UserInfo *userInfo = nil;
            if(_userstate == 1)//用户
            {
                
                userInfo =  [AppInfo shareInstance].user;

            }else if(_userstate == 2)
            {
     
                userInfo = [UserInfoManager shareUserInfoManager].currentStarInfo;
                
                
            }
            self.chatToolBar.isPrivateChat = YES;
            [self.priVateChatView changeFieldText];
            [self.priVateChatView  hidPrivateChatViewWithisHid:NO];
            self.chatToolBar.frame =  CGRectMake (0, SCREEN_HEIGHT-33 , SCREEN_WIDTH, 33);
            [self.priVateChatView setTargetUserInfo:userInfo];
            [self close: nil];
        }
      
    }else if (button.tag == 2)
    {
        UserInfo *userInfo = nil;
        if(_userstate == 1)//用户
        {
            
            userInfo =  [AppInfo shareInstance].user;
            
        }else if(_userstate == 2)
        {
            userInfo =[UserInfoManager shareUserInfoManager].currentStarInfo;
            
            
        }
        [_chatToolBar chatWithUserInfo:userInfo showToolBar:YES];
        [self close: nil];
    }else if (button.tag == 3)
    {
        if (_headView.image) {
            [UserInfoManager shareUserInfoManager].tempHederImage =_headView.image;
        }
        if(_userstate == 1)
        {
            UserInfo *userInfo  = [AppInfo shareInstance].user;//缓存的时候需要将user转为starinfo样式
            [UserInfoManager shareUserInfoManager].tempStarInfo.idxcode = userInfo.idxcode;
            [UserInfoManager shareUserInfoManager].tempStarInfo.issupermanager = userInfo.issupermanager;
            [UserInfoManager shareUserInfoManager].tempStarInfo.consumerlevelweight = userInfo.consumerlevelweight;
            [UserInfoManager shareUserInfoManager].tempStarInfo.levelWeight = userInfo.levelWeight;
            [UserInfoManager shareUserInfoManager].tempStarInfo.nick = userInfo.nick;
            [UserInfoManager shareUserInfoManager].tempStarInfo.photo  = userInfo.photo ;
            [UserInfoManager shareUserInfoManager].tempStarInfo.privlevelweight = userInfo.privlevelweight;
            [UserInfoManager shareUserInfoManager].tempStarInfo.userId = userInfo.userId;
            [UserInfoManager shareUserInfoManager].tempStarInfo.staruserid = userInfo.staruserid;
      
            NSMutableDictionary *param = [NSMutableDictionary dictionary];
            [param setObject:[NSNumber numberWithInteger:_userIdcount] forKey:@"userid"];
            [param setObject:NSStringFromClass([self class]) forKey:@"className"];
            [self pushCanvas:PersonInfo_Canvas withArgument:param];
            
        }else if(_userstate == 2)
        {
            
        [UserInfoManager shareUserInfoManager].tempStarInfo =[UserInfoManager shareUserInfoManager].currentStarInfo;
            
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param setObject:[NSNumber numberWithInteger:[UserInfoManager shareUserInfoManager].currentStarInfo.userId] forKey:@"userid"];
        [param setObject:NSStringFromClass([self class]) forKey:@"className"];
        [self pushCanvas:PersonInfo_Canvas withArgument:param];
            
        }
        
    }else
    {
        NSLog(@"else");
    }
    
}
-(void)close:(id)sender
{
    _userstate =0;
    if (_starInforlog)
    {
        [_starInforlog hide];
    }
}
- (UIView*)hitTest:(CGPoint)point
         withEvent:(UIEvent*)event{
    
    UIView *view = [[UIView alloc] init];
    return view;
}
#pragma mark 触摸开始
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];   //实例一个uitouch
    
    NSUInteger tapCount = [touch tapCount]; //计算touch的tapCount次数
    
    switch (tapCount)
    {
        case 1:
            NSLog(@"触摸事件：1");
            break;
            
        case 2:
            NSLog(@"触摸事件：2");
            break;
    }
}
#pragma mark 触摸移动
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{

}

#pragma mark 触摸结束
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{

}
//手势委托代理
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{

    return YES;
}

#pragma mark  直播房间顶部退出按钮等
- (void)initUserView
{
    
}



#pragma mark-argumentForCanvas
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
            }else if ([canvasName isEqualToString:@"PersonInfoViewController"] || [canvasName isEqualToString:@"RankViewController"]){
//                self.isPersonalInfo = YES;
            }else if ([canvasName isEqualToString:Search_Canvas]){
                [AppInfo shareInstance].pushType=2;
                
            }
            
            
            
        }
        
    }
    
}



#pragma mark-  获取主播赞
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

                if (starInfo.starmonthpraisecount<9950) {
                    _praiseLabel.text =[NSString stringWithFormat:@"%ld",(long)starInfo.starmonthpraisecount];
                }
                else
                {
                    _praiseLabel.text =[NSString stringWithFormat:@"%.1fW",(float)starInfo.starmonthpraisecount/10000];
                }
            }
        } fail:^(id object) {
            /*失败返回数据*/
            [self stopAnimating];
            //        [self stopLoadProgram];
            [self showNetworkErroDialog];
        }];
    }
    
}



#pragma mark _- 点赞
- (BOOL)sendApprove
{
    if ([AppInfo shareInstance].network ==0 || ![AppInfo IsEnableConnection])
    {
        [[AppInfo shareInstance] showNoticeInWindow:@"您的网络有问题,请检查网络" duration:1.5];
        return NO;
    }
    
    if ([self showLoginDialog])
    {
        return NO;
    }
    
    if (self.roomInfoData.showtype == 3)
    {

    }
    
    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionary];
    UserInfo *userInfo = [UserInfoManager shareUserInfoManager].currentUserInfo;
    if (userInfo == nil) {
        [self showNoticeInWindow:@"网络连接失败，请重试"];
        return  NO;
    }
    
    StarInfo *starInfo = [UserInfoManager shareUserInfoManager].currentStarInfo;
    if (starInfo == nil) {
        [self showNoticeInWindow:@"网络连接失败，请重试"];
        return NO;
    }
    
#pragma mark 无限点赞
    if (userInfo )
    {
        if (userInfo.leavecount == 0 && userInfo.getcount == userInfo.maxcount)//获取到个人信息后没有获取到赞个数，到这里会提示，所以放开，第二次会重新获取赞的信息
        {
            //            [self showNoticeInWindow:@"今天的赞送完了哦！明天再送吧！"];
            //            return NO;
            
            
        }
        else if(userInfo.leavecount == 0 )
        {
            [self showNoticeInWindow:@"您还没有赞可以送哦！再等等吧！"];
            return NO;
        }
    }
    
    
    
    [bodyDic setObject:[NSNumber numberWithInteger:userInfo.userId] forKey:@"userid"];
    [bodyDic setObject:userInfo.nick forKey:@"nick"];
    [bodyDic setObject:[NSNumber numberWithInteger:starInfo.userId] forKey:@"staruserid"];
    [bodyDic setObject:[NSNumber numberWithInteger:starInfo.starid] forKey:@"starid"];
    [bodyDic setObject:starInfo.nick forKey:@"starnick"];
    [bodyDic setObject:[NSNumber numberWithInteger:starInfo.roomid] forKey:@"roomid"];
    
    if (self.persondata.showid!=0) {
        [bodyDic setObject:[NSNumber numberWithInteger:self.persondata.showid] forKey:@"showid"];
    }else{
        [bodyDic setObject:[NSNumber numberWithInteger:self.showid] forKey:@"showid"];
    }
    
    
    [SendApproveModel sendApprove:bodyDic];
    return YES;
}



#pragma mark- 每隔一定60s获取一个赞
-(void)onGetPraiseTimer
{

}



#pragma mark - LiveRoomMiddleViewDelegate发言，送礼，点赞
- (void)giftAction:(LiveRoomMiddleView *)liveRoomMiddleView//送礼
{
    [self.view endEditing:YES];
    [self giveGiftWithUserInfo:[UserInfoManager shareUserInfoManager].currentStarInfo];
}
#pragma mark - ********************************点解发言->middle调用父View方法，主播开播***************
- (void)chatAction:(LiveRoomMiddleView *)liveRoomMiddleView//点击发言
{
    UserInfo* userInfo = [UserInfoManager shareUserInfoManager].currentStarInfo;//加载中的时候聊天键盘起来
    if (userInfo== nil || userInfo.userId==0) {
        return;
    }
    
    [self.chatToolBar.messageCotent becomeFirstResponder];
}

- (BOOL)praiseAction:(LiveRoomMiddleView *)liveRoomMiddleView//点赞
{
    return [self sendApprove];
}

#pragma mark - GiftViewDelegate

- (void)giftView:(BaseView *)giftView  giveGiftInfo:(NSDictionary *)giftInfo
{
    [self giveGift:giftInfo];
    [self hideGift];
}

- (void)goToRecharge
{
    [self goToRechargeView];
}

#pragma mark - GiftViewDelegate
#pragma mark 送礼物
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
    self.middleView.tabMenu.currentSelectedSegmentIndex = 0;
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


#pragma mark - addGiftGuideView
- (void)addGiftGuideView
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"GiftGuide"] == nil)
    {
        NSString *giftGuideImgName = nil;
        if (IPHONE_5)
        {
            giftGuideImgName = @"giftGuide2";
        }
        else
        {
            giftGuideImgName = @"giftGuide1";
        }
        
        UIView *giftGuideView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        giftGuideView.backgroundColor = [UIColor blackColor];
        giftGuideView.alpha = 0.8;
        [giftGuideView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideGiftGuideView:)]];
        [self.view addSubview:giftGuideView];
        
        UIImageView *backImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT)];
        backImg.image = [UIImage imageNamed:giftGuideImgName];
        [giftGuideView addSubview:backImg];
        
        [UIView animateWithDuration:1.0f animations:^{
            giftGuideView.userInteractionEnabled = NO;
            CGRect rect = backImg.frame;
            rect.origin.y -= rect.size.height;
            backImg.frame = rect;
        } completion:^(BOOL finished) {
            giftGuideView.userInteractionEnabled = YES;
        }];
        
        [defaults setObject:@"YES" forKey:@"GiftGuide"];
        [defaults synchronize];
    }
}

- (void)hideGiftGuideView:(UITapGestureRecognizer *)tapGestureRecognizer
{
    [tapGestureRecognizer.view removeFromSuperview];
}



-(void)userInterEnabledTimer{
    self.bigChangeCameraButton.userInteractionEnabled = YES;
    self.bigChangeFalshButton.userInteractionEnabled = YES;
    self.muteBtn.userInteractionEnabled = YES;
    self.changeCameraBtn.userInteractionEnabled = YES;
    self.openFlashLight.userInteractionEnabled = YES;
}




-(void)transfe{
    self.floatAngle = self.floatAngle+1;
    if (self.floatAngle>6.28) {
        self.floatAngle = 0;
    }
    self.liveActivity.transform = CGAffineTransformMakeRotation(self.floatAngle);
}

#pragma mark 加入TCP通知>>>>>>>>
- (void)addAllObserver
{
    if (!self.isAddNotification)
    {
        self.isAddNotification = YES;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(authSuccess:) name:AUTH_RESULT object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enterRoomResult:) name:ENTER_ROOM_RESULT object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveRoomMessage:) name:RECEIVE_ROOM_MESSAGE object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveGlobalMessage:) name:RECEIVE_GLOBAL_MESSAGE object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveGift:) name:RECEIVE_GIFT object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveSofa:) name:RECEIVE_SOFA object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiverErro:) name:RECEIVE_ERRO object:nil];
        //        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getApproveResult:) name:GET_APPROVE_RESULT object:nil];//累计赞
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveApproveResult:) name:SEND_APPROVE_RESULT object:nil];//收到赞
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveEnterRoomMessage:) name:RECEIVE_ENTNERROOM_MESSAGE object:nil];//进入房间通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveOutRoomMessage:) name:RECEIVE_OUTROOM_MESSAGE object:nil];//退出房间通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveSendNotice:) name:RECEIVE_SENDNOTICE_MESSAGE object:nil];  //首次触发点赞效果
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tcpWillDisconnectWithErro) name:WILL_DISCONNECT_WITHERRO object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tcpDidDisconect) name:DISCONNECT_SUCCESS object:nil];//TCP链接失败
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tcpConectSuccess) name:CONNECT_SUCCESS object:nil];//TCP链接成功
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tcpSendDataFail) name:SEND_DATA_FAIL object:nil];//TCP链接异常
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveBarageMessage:) name:RECEIVE_BARAGE_MESSAGE object:nil];//弹幕
        
        //明星热波消息
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveMusicChangeMessage:) name:RECEIVE_MUSICCHANGE_MESSAGE object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveShowTimeChangeMessage:) name:RECEIVE_SHOWTIMECHANGE_MESSAGE object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveShowTimeBeginMessage:) name:RECEIVE_SHOWTIMEBEGIN_MESSAGE object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveShowTimeEndMessage:) name:RECEIVE_SHOWTIMEEND_MESSAGE object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveShowTimeDataMessage:) name:RECEIVE_SHOWTIME_DATA_MESSAGE object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveShowTimeApproveResult:) name:SEND_SHOWTIME_APPROVE_RESULT object:nil];
        if ([self phoneLiving]) {
            
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(coloseSelfStar) name:@"ColoseSelfStar" object:nil];
        }
        
    }
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stopPlayingautoExitRoom)
    //                                                 name:UIApplicationWillResignActiveNotification object:nil]; //监听是否触发home键挂起程序.
}

- (void)removeAllObserver
{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    self.isAddNotification = NO;
    [self.leftView removeNoti];
    
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
    [[NSNotificationCenter defaultCenter] removeObserver:self name:RECEIVE_OUTROOM_MESSAGE object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:RECEIVE_SENDNOTICE_MESSAGE object:nil];
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
    
    if ([self phoneLiving]) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ColoseSelfStar" object:nil];
        
    }
    
}

#pragma mark - 初始化房间定时等信息
- (void)initRoomSetting
{
    [self settingAudioSession];
    
    [self exitRoom:YES];
    
    //    self.loading = YES;
    self.phoneLivingStarted = NO;
    [self getStarInfo];
    //获取主播赞信息
    
}

#pragma mark -后台音频播放设置
- (void)settingAudioSession
{
    //后台播放音频设置
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setActive:YES error:nil];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    
}
#pragma mark- <<------获取star信息  -->>获取房间信息
- (void)getStarInfo
{
    if (!self.reconnect)
    {
        [self startAnimating];
        //        [self startLoadProgram];
    }
    
    
    
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInteger:self.staruserid] forKey:@"userid"];//adphoto上传完后，调用没有实时更新头像，SearchUserModel可以实时更新，需要用到[UserInfoManager shareUserInfoManager].getUserInfoModel.userInfo.nick && userId
    GetUserInfoModel *model = [[GetUserInfoModel alloc] init];
    model.isNotUseToken = YES;
    [model requestDataWithParams:dict success:^(id object) {
        /*成功返回数据*/
        GetUserInfoModel *userInfoModel = object;
        if (userInfoModel.result == 0)
        {
            if (userInfoModel.userInfo)
            {
            
//                [UserInfoManager shareUserInfoManager].currentUserInfo = userInfoModel.userInfo;
                NSURL *headUrl = [NSURL URLWithString: [NSString stringWithFormat:@"%@/%@",[AppInfo shareInstance].res_server,userInfoModel.userInfo.photo]];
                //               主播头像
                [_headImageView sd_setImageWithURL:headUrl placeholderImage:[UIImage imageNamed:@"leftBtn_normal"]];//左侧头像
                [_headView sd_setImageWithURL:headUrl placeholderImage:[UIImage imageNamed:@"leftBtn_normal"]];//面板头像
                
                //                昵称
                _nilkLabel.text = userInfoModel.userInfo.nick;
                
                //                性别图标
                if (userInfoModel.userInfo.sex == 1) {
                    _sexView.image = [UIImage imageNamed:@"boy"];
                }
                else if (userInfoModel.userInfo.sex == 2)
                {
                    _sexView.image = [UIImage imageNamed:@"girl"];
                }else
                {
                    _sexView.image = [UIImage imageNamed:@""];
                }
                
                //                VIP图标
                if(userInfoModel.userInfo.isPurpleVip)
                {
                    _vipView.image = [UIImage imageNamed:@"pvip"];
                }else if (userInfoModel.userInfo.isYellowVip)
                {
                    _vipView.image = [UIImage imageNamed:@"yvip"];
                }else
                {
                    _vipView.image = [UIImage imageNamed:@""];
                }
                
                
                //                 明星等级
                _wealthView.image = [[UserInfoManager shareUserInfoManager] imageOfStar:userInfoModel.userInfo.starlevelid];
                
                //                城市
                if(userInfoModel.userInfo.provincename || userInfoModel.userInfo.cityname)
                {
                    _cityName.text = [NSString stringWithFormat:@"%@%@",userInfoModel.userInfo.provincename,userInfoModel.userInfo.cityname];
                }
                else
                {
                    _cityName.text = @"太阳系火星";
                }
                //                个性签名
                if(userInfoModel.userInfo.introduction)
                {
                    _inforLable.text = userInfoModel.userInfo.introduction;
                }else
                {
                    _inforLable.text = @"全民星直播互动平台，娱乐你的生活";
                }
                
                //                关注数量
                _attentionNumber.text = [NSString stringWithFormat:@"%ld",(long)userInfoModel.userInfo.attentionnum];
                
                //                粉丝数量
                if(userInfoModel.userInfo.fansnum)
                {
                }
                [AppInfo shareInstance].fansNumber = (long)userInfoModel.userInfo.fansnum;
                [AppInfo shareInstance].audienceNumber.text = [NSString stringWithFormat:@"%ld",(long)[AppInfo shareInstance].fansNumber];
                
                //                送出数量 sendNumber
                if(userInfoModel.userInfo.costcoin <1000)
                {
                    _sendNumber.text = [NSString stringWithFormat:@"%ld",(long)userInfoModel.userInfo.costcoin];
                    
                }else if (userInfoModel.userInfo.costcoin >=1000 && userInfoModel.userInfo.costcoin <999950)
                {
                    _sendNumber.text = [NSString stringWithFormat:@"%.1fK",(float)userInfoModel.userInfo.costcoin/1000];
                }else{
                    _sendNumber.text = [NSString stringWithFormat:@"%.1fM",(float)userInfoModel.userInfo.costcoin/1000000];
                    
                }
                
                //                热豆数量
                if(userInfoModel.userInfo.getcoin <1000)
                {
                    _coinNumber.text = [NSString stringWithFormat:@"%ld",(long)userInfoModel.userInfo.getcoin];
                }else if (userInfoModel.userInfo.getcoin >=1000 && userInfoModel.userInfo.getcoin <999950)
                {
                    _coinNumber.text = [NSString stringWithFormat:@"%.1fK",(float)userInfoModel.userInfo.getcoin/1000];
                }else{
                    _coinNumber.text = [NSString stringWithFormat:@"%.1fM",(float)userInfoModel.userInfo.getcoin/1000000];
                    
                }
                
                [AppInfo shareInstance].coin.text = [NSString stringWithFormat:@"%ld",(long)userInfoModel.userInfo.bean];

                if(userInfoModel.userInfo.attentionflag)
                {
                    [AppInfo shareInstance].state = 1;
                    [_touchBut1 setTitle:@"已关注" forState:UIControlStateNormal];
                }else
                {
                    [AppInfo shareInstance].state = 0;
                    [_touchBut1 setTitle:@"关注" forState:UIControlStateNormal];
                }
                
                CGSize coinSize = [[AppInfo shareInstance].coin sizeThatFits:CGSizeMake(250, MAXFLOAT)];
                [AppInfo shareInstance].coinbackview.frame = CGRectMake(0, 64, coinSize.width + 71, 25);
                [AppInfo shareInstance].coin.frame = CGRectMake(45, 0, coinSize.width, 25);
                [AppInfo shareInstance].coinImg.frame = CGRectMake(coinSize.width + 51, 4, 16, 16);
                CAShapeLayer *confirmButtonLayer1 = [CAShapeLayer layer];
                UIBezierPath *radiusPath1 = [UIBezierPath bezierPathWithRoundedRect:[AppInfo shareInstance].coinbackview.bounds
                                                                  byRoundingCorners:(UIRectCornerTopRight|UIRectCornerBottomRight)
                                                                        cornerRadii:CGSizeMake(12.5f, 12.5f)];
                confirmButtonLayer1.path = radiusPath1.CGPath;
                [AppInfo shareInstance].coinbackview.layer.mask = confirmButtonLayer1;
                
                if (_seleate != 0) {
                    if (userInfoModel.userInfo.bean >0) {
                        [AppInfo shareInstance].coinbackview.hidden = NO;
                    }else{
                        [AppInfo shareInstance].coinbackview.hidden = YES;
                    }
                }else if (userInfoModel.userInfo.userId != [UserInfoManager shareUserInfoManager].currentUserInfo.userId) {
                    if (userInfoModel.userInfo.bean >0) {
                        [AppInfo shareInstance].coinbackview.hidden = NO;
                    }else{
                        [AppInfo shareInstance].coinbackview.hidden = YES;
                    }
                }
                
                CGSize citySize = [_cityName sizeThatFits:CGSizeMake(110, MAXFLOAT)];
                _cityName.frame = CGRectMake((256 - citySize.width )/2, 105, citySize.width, 15);
                _cityView.frame = CGRectMake((256 - citySize.width )/2 - 17, 105, 10, 14);
                
                CGSize sendSize = [_sendNumber sizeThatFits:CGSizeMake(70, MAXFLOAT)];
                _coinView.frame = CGRectMake(_sendNumber.frame.origin.x + sendSize.width + 3 , 233, 18, 18);

                CGSize nickSize = [_nilkLabel sizeThatFits:CGSizeMake(110, MAXFLOAT)];
                for (int count = 0; count <3; count++) {
                    if (count == 1) {
                        _nilkLabel.frame =CGRectMake(0, 77, nickSize.width, 15);
                    }else
                    {
                        _nilkLabel.frame =CGRectMake((256 - 33 - _wealthView.frame.origin.x)/2 , 77, nickSize.width, 15);
                    }
                    if(userInfoModel.userInfo.sex >0)
                    {
                        _sexView.frame=CGRectMake(_nilkLabel.frame.origin.x + nickSize.width + 5, 72, 20, 20);
                        if(userInfoModel.userInfo.isPurpleVip ||userInfoModel.userInfo.isYellowVip)
                        {
                            _vipView.frame = CGRectMake(_nilkLabel.frame.origin.x + nickSize.width + 28, 72, 40, 21);
                            _wealthView.frame = CGRectMake(_nilkLabel.frame.origin.x + nickSize.width + 71, 75, 33, 15);
                        }else
                        {
                            _wealthView.frame = CGRectMake(_nilkLabel.frame.origin.x + nickSize.width + 28, 75, 33, 15);
                        }
                        
                    }else
                    {
                        if(userInfoModel.userInfo.isPurpleVip ||userInfoModel.userInfo.isYellowVip)
                        {
                            _vipView.frame = CGRectMake(_nilkLabel.frame.origin.x + nickSize.width + 5, 72, 40, 21);
                            _wealthView.frame = CGRectMake(_nilkLabel.frame.origin.x + nickSize.width + 48, 75, 33, 15);
                        }else
                        {
                            _wealthView.frame = CGRectMake(_nilkLabel.frame.origin.x + nickSize.width + 5, 75, 33, 15);
                        }
                    }//256
                }
                
                if (_headImageView.image==nil) {
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                        
                        NSData* data = [[NSData alloc]initWithContentsOfURL:headUrl];
                        _headImageView.image = [UIImage imageWithData:data];
                        _headView.image = [UIImage imageWithData:data];
                    });
                }
                
                StarInfo* starInfo =[UserInfoManager shareUserInfoManager].currentStarInfo;//同步获取房间信息后给starinfo赋值
                userInfoModel.userInfo.liveip = starInfo.liveip;
                userInfoModel.userInfo.roomad = starInfo.roomad;
                userInfoModel.userInfo.livestream = starInfo.livestream;
                userInfoModel.userInfo.serverip = starInfo.serverip;
                userInfoModel.userInfo.serverport = starInfo.serverport;
                userInfoModel.userInfo.showbegintime = starInfo.showbegintime;
                userInfoModel.userInfo.showbegintime = starInfo.showbegintime;
                
                [UserInfoManager shareUserInfoManager].currentStarInfo = userInfoModel.userInfo;
                
                if (_chatToolBar)
                {
//                    [_chatToolBar addChatMember:userInfoModel.userInfo];
//                    _chatToolBar.targetUserInfo = userInfoModel.userInfo;
                }
                if(_seleate!=1)
                {
                    [self performSelector:@selector(getRoomInfo) withObject:nil];
                }else{
                    [UserInfoManager shareUserInfoManager].tempHederImage =_headImageView.image;
                }
                _seleate = 0;
                
            }
            
        }
        else
        {
            if (model.code == 403)
            {
                
                [self pressedShowOherTerminalLoggedDialog];
                return ;
            }
            
            [self showNetworkErroDialog];
            
            
        }
        [self stopAnimating];
    } fail:^(id object) {
        /*失败返回数据*/
        [self stopAnimating];
        //        [self stopLoadProgram];
        [self showNetworkErroDialog];
    }];
}
#pragma mark- <<------获取房间信息 -->> 开始进入房间 || 获取自己直播房间信息
- (void)getRoomInfo
{
    //获取房间个人档案信息
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInteger:[UserInfoManager shareUserInfoManager].currentStarInfo.userId] forKey:@"staruserid"];
    
    
    GetRoomInfoModel *model = [[GetRoomInfoModel alloc] init];
    [model requestDataWithParams:dict success:^(id object) {
        if (model.result == 0)
        {
            self.roomInfoData = model.roomInfoData;
            
            StarInfo *starInfo = [UserInfoManager shareUserInfoManager].currentStarInfo;
            starInfo.liveip = model.roomInfoData.liveip;
            starInfo.roomad =model.roomInfoData.roomad;
//            [UserInfoManager shareUserInfoManager].currentStarInfo.roomad = model.roomInfoData.roomad;
            if (_livestream)
            {
                starInfo.livestream = self.livestream;
            }
            else
            {
                starInfo.livestream = model.roomInfoData.livestream;
            }
            
            if (_serverip)
            {
                starInfo.serverip = self.serverip;
            }
            else
            {
                starInfo.serverip = model.roomInfoData.serverip;
            }
            
            
            starInfo.serverport = [model.roomInfoData.serverport intValue];
            starInfo.showbegintime = model.roomInfoData.showbegintime;
            
            PersonData *personData =[[PersonData alloc] init];
            personData.userId = starInfo.userId;
            personData.userImg = starInfo.photo;
            personData.idxcode = starInfo.idxcode;
            personData.nick = starInfo.nick;
            personData.starlevelid = starInfo.starlevelid;
            personData.privlevelweight = starInfo.privlevelweight;
            personData.notice = model.roomInfoData.roomad;
            personData.attented = model.roomInfoData.attentionflag;
            personData.showid = model.roomInfoData.showid;
            personData.consumerlevelweight = starInfo.consumerlevelweight;
            personData.showbegintime = model.roomInfoData.showbegintime;
            personData.privatechatad = model.roomInfoData.privatechatad;
            self.persondata = personData;
            _leftView.personData = personData;
            
            
            
            
            [UserInfoManager shareUserInfoManager].currentStarInfo = starInfo;
            
            if (_liveRoomType == LiveRoomType_Stop || (![self phoneLiving]&&model.roomInfoData.showid ==0) ) {
               
                [_liveEndView setGuanZhuCount:[NSString stringWithFormat:@"%ld",model.roomInfoData.enteredcount]];
                _liveEndView.personData = personData;
                _liveEndView.hidden = NO;
                if (_imageViewGuide) {
                    [_imageViewGuide removeFromSuperview];
                    _imageViewGuide = nil;
                }
                
                if (  _liveRoomOtherThings == LiveRoomOtherThing_receiveWillStop) {
                    _liveRoomOtherThings  = LiveRoomOtherThing_Normol;
                    return   ;
                }

            }
            //主播在直播的时候  &&  服务器地址未nil    && 不是图片轮询模式
            if (model.roomInfoData.showid !=0 && [model.roomInfoData.liveip toString].length==0 && model.roomInfoData.showtype != 2 ) {
                if (!self.isRequestOnce) {
                    self.isRequestOnce = YES;
                    [self getRoomInfo];
                }else{
                    
                    [self showAlertView:@"获取视频服务器信息失败" message:@"是否重试" confirm:^(id sender) {
                        [self getRoomInfo];
                    } cancel:^(id sender) {
                        [self stopPlayingautoExitRoom];
                    }];
                }
                
                return  ;
                
            }
            
            
            
            
            
            
            
            
            if (self.roomInfoData.showid == 0)
            {
                self.roomInfoData.showid = self.showid;
            }
            
            [UserInfoManager shareUserInfoManager].currentUserInfo.managerflag = self.roomInfoData.managerflag;
            
            
            BOOL isTestVersion = [[[NSBundle mainBundle] objectForInfoDictionaryKey:@"Test_Version"] boolValue];
            if (isTestVersion)
            {
                if (![self phoneLiving]) {
                    [self showNoticeInWindow:self.roomInfoData.serverip duration:1.5];
                }
                
            }
            //房间信息获取成功后，进入房间
            if (self.phoneLiving)//如果自己是主播的
            {
                [self getLivingInfo];
            }
            else
            {
                [self initVideoViewData];//更新视频区域界面数据以及设置(轮播/推荐主播或者直播)
                [self performSelector:@selector(enterRoom) withObject:nil];
            }
            
            
        }
        else
        {
            
            if (model.code == 403)
            {
                
                [self pressedShowOherTerminalLoggedDialog];
                return ;
            }
            
        }
        
        
        
        
    } fail:^(id object) {
        /*失败返回数据*/
        [self stopAnimating];
        //        [self stopLoadProgram];
        [self showNetworkErroDialog];
    }];
    
    
}

#pragma mark<<------获取自己直播房间信息  -->>开始进入房间
- (void)getLivingInfo
{
    
    GetRoomServerForMobileStar *getLivingInfo = [[GetRoomServerForMobileStar alloc] init];
    [getLivingInfo requestDataWithParams:nil success:^(id object) {
        NSLog(@"livingInfo : %@", object);
        if (getLivingInfo.result == 0)
        {
            
            
            self.strServerport = [NSString stringWithFormat:@"%ld",(long)getLivingInfo.serverport];
            self.strserverIP = getLivingInfo.serverip;
            
            if ([getLivingInfo.downmobileliveip rangeOfString:@"rtmp"].length==4) {
                self.strUploadUrl = [NSString stringWithFormat:@"%@%@",getLivingInfo.liveip,getLivingInfo.livestream];
            }else{
                self.strUploadUrl =[NSString stringWithFormat:@"rtmp://%@/live/%@",getLivingInfo.liveip,getLivingInfo.livestream];
                
            }
            if (getLivingInfo.liveip.length==0 || getLivingInfo.livestream ==0) {
                self.strUploadUrl = @"";
            }
            NSLog(@"%lu",(unsigned long)[getLivingInfo.cdnp toString].length);
            if (![[getLivingInfo.cdnp toString]isEqualToString:@"0"]&&self.strUploadUrl.length!=0) {
                NSString* str =[self.strUploadUrl substringFromIndex:7];
                self.strUploadUrl = [NSString stringWithFormat:@"rtmp://%@/%@",getLivingInfo.cdnp,str];
            }
            
            if ( self.liveRoomOtherThings == LiveRoomOtherThing_SelfLiveIpError) {
                
                if (self.strUploadUrl.length==0) {
                    [self showAlertView:@"获取视频服务器信息失败" message:@"是否重试" confirm:^(id sender) {
                        self.liveRoomOtherThings = LiveRoomOtherThing_SelfLiveIpError;
                     
                        [self getLivingInfo];
                    } cancel:^(id sender) {
                        [self stopPlayingautoExitRoom];
                    }];
 
                }else{
                    [self startLiving];
                }
                return ;
        }
            
         
            
            if (!self.roomInfoData)
            {
                self.roomInfoData = [[RoomInfoData alloc] init];
            }
            
            self.roomInfoData.liveip = getLivingInfo.liveip;
            self.roomInfoData.livestream = getLivingInfo.livestream;
            self.roomInfoData.serverip = getLivingInfo.serverip;
            self.roomInfoData.serverport = [NSString stringWithFormat:@"%ld", (long)getLivingInfo.serverport];
            
            StarInfo *starInfo = [UserInfoManager shareUserInfoManager].currentStarInfo;
            starInfo.liveip = self.roomInfoData.liveip;
            
            starInfo.livestream = self.roomInfoData.livestream;
            starInfo.serverip = self.roomInfoData.serverip;
            starInfo.serverport = [self.roomInfoData.serverport intValue];
            
            BOOL isTestVersion = [[[NSBundle mainBundle] objectForInfoDictionaryKey:@"Test_Version"] boolValue];
            if (isTestVersion)
            {
                
            }
            //房间信息获取成功后，进入房间
            [self performSelector:@selector(enterRoom) withObject:nil];
            
            
        }else{
            if (getLivingInfo.code == 403)
            {
                
                [self pressedShowOherTerminalLoggedDialog];
                return ;
            }
            
            
            
            
        }
        
        
    } fail:^(id object)
     {
         
     }];
}


#pragma mark - <<------开始进入房间【通用】>>显示聊天区域内容
- (void)enterRoom
{
    
    
    
//    [self.middleView showTableBarMenu];
//    [self.middleView showChatView];
    
    UserInfo *userInfo = [UserInfoManager shareUserInfoManager].currentUserInfo;
    StarInfo *starInfo = [UserInfoManager shareUserInfoManager].currentStarInfo;
    
    
    if (![[TcpServerInterface shareServerInterface] isConnected])
    {
        if (self.roomInfoData.serverip && [self.roomInfoData.serverip length] > 0 )
        {
            
            {
                [[CommandManager shareInstance] connectServer:self.roomInfoData.serverip serverport:[TCP_SERVER_PORT integerValue]];
                
                
            }
        }
    }
    else
    {
//        控制是否显示历史消息
        
        [EnterRoomModel enterRoomWithUserId:userInfo.userId starUserId:starInfo.userId reconnect:self.reconnect];
    }
    
}




#pragma mark - -【【【【【【【【【【【【【【【【【【【【【【【【【【【【【【【【【自己直播】】】】】】】】】】】】】】】】】】】】】】******【自己直播】
#pragma mark- 自己开播，初始化UI界面
- (void)initStarView
{
    __weak LiveRoomViewController *stongSelf = self;

    if (![self checkAVCaptureDevice]) {
        return;
    }
    
    
    _beforeLiveView = [[BeforeLiveView alloc]initWithFrame:CGRectMake(0,0,[[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
    _beforeLiveView.rootViewController = self;
    _beforeLiveView.deleate =self;
    _beforeLiveView.isSelfLivPrepareTime = YES;
    _beforeLiveView.opaque = YES;
    [self.view addSubview:_beforeLiveView];
    
    
    
}


#pragma mark- 自己是主播而且将要主播(从首页进入的)
- (BOOL)phoneLiving
{
    UserInfo *userInfo = [UserInfoManager shareUserInfoManager].currentUserInfo;
    
    if (userInfo.userId == self.staruserid&& [AppDelegate shareAppDelegate].isSelfWillLive)
    {
        self.liveRoomUserType = liveRoomUserType_StarUser;
        return YES;
    }
     self.liveRoomUserType = liveRoomUserType_NormalUser;
    return NO;
}
#pragma mark-自己是主播
- (BOOL)phoneLivingSelf
{
    UserInfo *userInfo = [UserInfoManager shareUserInfoManager].currentUserInfo;
    
    if (userInfo.userId == self.staruserid)
    {
        self.liveRoomUserType = liveRoomUserType_StarUser;
        return YES;
    }
    self.liveRoomUserType = liveRoomUserType_NormalUser;
    return NO;
}


#pragma mark - 自己开播前页面代理 BeforeLiveViewDeleate
-(void)beforeLiveViewDeleateWithIndex:(NSInteger)index{
    switch (index) {
        case 1:
                [self.liveRoomIamgeView rotateCamera];
            break;
        case 2:
        {
            
            [UserInfoManager shareUserInfoManager].currentStarInfo = nil;
            [self autoExitRoom];
            
            
        }
            break;
        case 3://拍照
            
            [_liveRoomIamgeView tackPicture];
            
            break;
        case 4:
            
            break;
        case 5:{//返回
            
            [_liveRoomIamgeView setImageViewHaiBaoHid:YES];
        }
            break;
        case 6:{//重拍
            [_liveRoomIamgeView setImageViewHaiBaoHid:YES];
        }
            break;

        case 10://开始直播
        {
            __weak typeof(self) safeSelf = self;
            //开播成功后，上传签名和海报信息
            [self.beforeLiveView setQianMing:^(BOOL isNew) {
                __strong typeof(safeSelf) strongSelf = safeSelf;
//                strongSelf.liveLoadingView.hidden = NO;
//                strongSelf.liveBottomView.hidden = NO;
                [strongSelf hidLiveRoomBeforLiveViewHid:NO];
                [strongSelf readyToLive];
                
                if (strongSelf.liveRoomIamgeView.isAVCaptureDevicePositionFront) {
                    [strongSelf.liveRoomIamgeView rotateCamera];
                 
                }
                //                strongSelf.loading = NO;
                strongSelf.beforeLiveView.buttonLiving.userInteractionEnabled = NO;
                //                strongSelf.activityIndicatorView = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-22, SCREEN_HEIGHT/2-22, 44, 44)];
                //                strongSelf.activityIndicatorView.center = strongSelf.view.center;
                //                [strongSelf.view addSubview:strongSelf.activityIndicatorView];
                //                [strongSelf.activityIndicatorView startAnimating];
                
                strongSelf.closeBtn.userInteractionEnabled = NO;
                [strongSelf initToolBar];
                [strongSelf.beforeLiveView removeFromSuperview];
                
                
                //防止点击开始直播快了头像还没有获取到的情况
                strongSelf.liveRoomIamgeView.imageViewHaiBao.hidden = YES;
                [strongSelf.liveRoomIamgeView.imageViewHaiBao removeFromSuperview];
                strongSelf.liveRoomIamgeView.imageViewHaiBao = nil;
  
                
            } failed:^(BOOL isNew) {
                __strong typeof(safeSelf) strongSelf = safeSelf;
                if (isNew) {
                    [safeSelf showNoticeInWindow:@"修改签名失败,签名不能包含敏感词"];
                }else{
                    [safeSelf showNetworkErroDialog];
                }
                strongSelf.beforeLiveView.buttonLiving.userInteractionEnabled = YES;
                
                
            }];
            
            
            
            
        }
            break;
            
        case 13:{
            //
            
            LiveProtocolViewController* lP = [[LiveProtocolViewController alloc]init];
            [self pushCanvas:@"LiveProtocolViewController" withArgument:nil];
            
        }
            break;
 
        default:
            break;
    }
}





#pragma mark - >>>>>>>>开始预览>>是否可以开播


-(BOOL)checkAVCaptureDevice{
    
    AVCaptureDevice *captureDevice=[self getCameraDeviceWithPosition:AVCaptureDevicePositionBack];//取得后置摄像头
    if (!captureDevice) {
        NSLog(@"取得后置摄像头时出现问题.");
    }
    
    
    NSError *error=nil;
    //根据输入设备初始化设备输入对象，用于获得输入数据
    AVCaptureDeviceInput  *captureDeviceInput=[[AVCaptureDeviceInput alloc]initWithDevice:captureDevice error:&error];
    if (error) {
        
    }
    
    //            检测麦克风功能是否打开
    [[AVAudioSession sharedInstance]requestRecordPermission:^(BOOL granted) {
        if (!granted)
        {
            
            [self showAlertView:@"热波间需要访问你的麦克风" message:@"使用手机直播，热波间需要访问你的麦克风权限。点击“设置”前往系统设置允许热波间访问你的麦克风" confirm:^(id sender) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                NSLog(@"麦克风没有权限,退出");
                [self stopPlayingautoExitRoom];
            } cancel:^(id sender) {
                NSLog(@"麦克风没有权限,退出");
                [self stopPlayingautoExitRoom];
            }];
            return ;
        }else{
            
            
        }
        
        
    }];
    
    
    //检测摄像头功能是否打开
    NSString *mediaType1 = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus1 = [AVCaptureDevice authorizationStatusForMediaType:mediaType1];
    
    if (authStatus1 == 0) {
        [self stopPlayingautoExitRoom];
        NSLog(@"相机没有权限,退出");
        return NO;
    }
    if(authStatus1 == AVAuthorizationStatusRestricted || authStatus1 == AVAuthorizationStatusDenied ){
        
        [self showAlertView:@"热波间需要访问你的相机" message:@"使用手机直播，热波间需要访问你的相机权限。点击“设置”前往系统设置允许热波间访问你的相机" confirm:^(id sender) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
            NSLog(@"相机没有权限,退出");
            [self stopPlayingautoExitRoom];
        } cancel:^(id sender) {
            NSLog(@"相机没有权限,退出");
            [self stopPlayingautoExitRoom];
        }];
        
        
        return NO;
    }
    return YES;
}
#pragma mark - <<<<<<<< 预览>> 可以直播 >>开播是否成功
-(void)readyToLive{
    
//    if (![[SeekuSingle shareSeekuSingle] streamInitialized])
//        [[SeekuSingle shareSeekuSingle]lib_seeku_stream_initialize];//预览的
    
    

    //code 1 表示可以直播；2表示因为全民直播开关没打开而不能直播；3表示还没同意开播协议(此时手机端需要跳转到协议页面)；4表示已经在开播了，不允许重复开播；5表示当前用户已经同意过协议，但是被平台禁止直播了。
    __block CanShowOnMobile *model = [[CanShowOnMobile alloc] init];
    typeof(self) weakSelf = self;
    
    
    [self requestDataWithAnalyseModel:[CanShowOnMobile class] params:nil success:^(id object) {
        model = object;
        typeof(weakSelf) stongSelf = weakSelf;
        if (model.code == 1)
        {
            
            
            
            BaseHttpModel *model = [[BaseHttpModel alloc] init];
            [model requestDataWithMethod:ShowLiveBtnOnMobile_Method params:nil success:^(id object)
             {
                 if (model.result == 0)
                 {
                     if (model.code == 1)
                     {
                         //开始直播
                         [stongSelf startLiving];
                         
                         
                         if (stongSelf.isFrontCamera) {//当为前置摄像头时候关闭闪光灯
                             [stongSelf.openFlashLight setImage:[UIImage imageNamed:@"Star_LiveRoom_lightning_no.png"] forState:UIControlStateNormal];
                             _isFlashOn  = NO;
                             
                         }
                     }
                     else
                     {
                         [stongSelf showNoticeInWindow:@"手机直播未开启"];
                         NSLog(@"手机直播未开启,退出");
                         [stongSelf  stopPlayingautoExitRoom];
                         stongSelf.beforeLiveView.buttonLiving.userInteractionEnabled = YES;
                     }
                     
                 }else{
                     if (model.code == 403)
                     {
                       
                         [stongSelf pressedShowOherTerminalLoggedDialog];
                         stongSelf.beforeLiveView.buttonLiving.userInteractionEnabled = YES;
                     }
                 }
             } fail:^(id object)
             {
                 
             }];
            
        }
        else if (model.code == 3)//未同意过协议，默认同意
        {
            
            __block BaseHttpModel *model = [[BaseHttpModel alloc] init];
            [model requestDataWithMethod:SubmitAgreeAllShow params:nil success:^(id object)
             {
                 model = object;
                 
                 
                 if (model.result == 0 || model.result == 1)
                 {
                     
                     model = object;
                     [AppDelegate shareAppDelegate].isSelfWillLive = NO;
                     [AppDelegate shareAppDelegate].isSelfWillLive = YES;
                     
                     [stongSelf startLiving];
                     
                     if (stongSelf.isFrontCamera) {//当为前置摄像头时候关闭闪光灯
                         [stongSelf.openFlashLight setImage:[UIImage imageNamed:@"Star_LiveRoom_lightning_no.png"] forState:UIControlStateNormal];
                         _isFlashOn  = NO;
                     }
                     
                 }
                 
             } fail:^(id object)
             {
                 
                 [self showNotice:@"出错了，请重试" duration:2.0f];
             }];
            
            
            
            
        } else if(model.code == 2)
        {
            [stongSelf showNoticeInWindow:@"手机直播未开启"];
            [stongSelf  stopPlayingautoExitRoom];
        }  else if(model.code == 4)
        {
            
            [stongSelf showNoticeInWindow:@"你已经在开播了，不允许重复开播"];
            [stongSelf  stopPlayingautoExitRoom];
        }  else if(model.code == 5)
        {
            
            [stongSelf showNoticeInWindow:@"你已被禁止手机直播"];
            [stongSelf  stopPlayingautoExitRoom];
        } else{
            
            if (model.code == 403)
            {
                
                [stongSelf pressedShowOherTerminalLoggedDialog];
                
                return ;
            }else{
            }
        }
        
        
        
        
    } fail:^(id object) {
        typeof(weakSelf) stongSelf = weakSelf;
        
        stongSelf.startLivingButton.userInteractionEnabled = YES;
        self.closeBtn.userInteractionEnabled = YES;
        [stongSelf showNetworkErroDialog];
        stongSelf.beforeLiveView.buttonLiving.userInteractionEnabled = YES;
    }];
}


#pragma mark- <<<<<<<<开播成功 >>开始录制上传视频流
- (void)startLiving
{
    
    [self achieveJSON];

    if (self.strUploadUrl.length==0) {

    __weak typeof(self) weakself = self;
        [self showAlertView:@"获取视频服务器信息失败" message:@"是否重试" confirm:^(id sender) {
            weakself.liveRoomOtherThings = LiveRoomOtherThing_SelfLiveIpError;
            [weakself getLivingInfo];
        } cancel:^(id sender) {
             NSLog(@"获取自己直播时，视频服务器信息失败，退出");
            [weakself stopPlayingautoExitRoom];
        }];
        return;
    }
    
//    const char* a= [self.strUploadUrl UTF8String];
// 
//    int result = -1 ;
//  NSString * str =[UserInfoManager shareUserInfoManager].currentStarInfo.roomfmt;
//       const char * pargs =[str cStringUsingEncoding:NSASCIIStringEncoding];
////    if ([[SeekuSingle shareSeekuSingle] streamInitialized])
////    {
////        result = [[SeekuSingle shareSeekuSingle] lib_seeku_stream_start:a args:pargs];
////    }
//   
//    if (result<0) {
//        self.beforeLiveView.buttonLiving.userInteractionEnabled = YES;
//        [self showNoticeInWindow:@"获取视频失败，请稍后重试" duration:2];
//
//    }else{
//        
//        [_liveRoomIamgeView setCanUpLoad ];
    
        [self upLodSeeku];
//    }
    
    
}
-(void)upLodSeeku{
    
    
    
   _isZhiBoIng = YES;
    _liveRoomType = LiveRoomType_Living;
    
    __weak typeof(self) weakSelf = self;
    __block BaseHttpModel *model = [[BaseHttpModel alloc] init];
    [model requestDataWithMethod:BeginShowAjax4Mobile_Method params:nil success:^(id object)
     {
         __strong typeof(weakSelf) strongSelf = weakSelf;
         model = object;
         if (model.result == 0 )
         {
             
             //             [strongSelf.activityIndicatorView stopAnimating];
             //             strongSelf.activityIndicatorView = nil;
             
             //开播
             [self startSession];
             
             strongSelf.strShowID = [[[model valueForKey:@"data"]valueForKey:@"id"] toString];
             
             if (_liveRoomType == LiveRoomType_OutLiveRoom) {
                 [strongSelf stopLiving];
                 
                 return;
             }
             
             NSLog(@"开播了");
             StarInfo *starInfo = [UserInfoManager shareUserInfoManager].currentStarInfo;
             starInfo.onlineflag = YES;
             
            
             
             
             
             if (strongSelf.starPlayTImer) {
                 [strongSelf.starPlayTImer invalidate];
                 strongSelf.starPlayTImer = nil;
             }
             
             if (strongSelf.isTouchHomeEd) {
                 NSLog(@"点击home后后台上传异常,退出");
                 [self stopPlayingautoExitRoom];
                 return ;
             }
             
             
             
             strongSelf.starPlayTImer = [NSTimer scheduledTimerWithTimeInterval:30  target:self selector:@selector(postHeart) userInfo:nil repeats:YES];
             [strongSelf.starPlayTImer fire];
             
            
             _closeBtn.userInteractionEnabled = YES;
             strongSelf.statusView.hidden = NO;
             strongSelf.phoneLivingStarted = YES;
             [strongSelf showNoticeInWindow:@"开播成功" duration:2];
             
             
             
             
             [AppInfo shareInstance].isHaiBaoNew = YES;
             if (  [AppInfo shareInstance].isHaiBaoUp) {
                 [AppInfo shareInstance].isHaiBaoUp = NO;
                 [AppInfo shareInstance].isHaiBaoNew = NO;
                 
                 [strongSelf performSelector:@selector(setHaiB) withObject:strongSelf  afterDelay:3];
                 
             }
             
             //                 [self performSelectorOnMainThread:@selector(setimageH) withObject:self waitUntilDone:NO];
             
             
         }else{
             if (model.code == 403)
             {
                 
                 [strongSelf pressedShowOherTerminalLoggedDialog];
                 return ;
             }
             
             //             [self showNetworkErroDialog];
             
             [strongSelf performSelectorOnMainThread:@selector(setimageHidd) withObject:self waitUntilDone:NO];
         }
         
         
     } fail:^(id object)
     {
         [self showNotice:@"出错了，请重试" duration:2.0f];
         [self performSelectorOnMainThread:@selector(setimageHidd) withObject:self waitUntilDone:NO];
     }];
    
//    _liveLoadingView.hidden = YES;
    [self enterRoomLodingData];
}





-(void)setHaiB{
    [self.beforeLiveView setHaiB];
}
-(void)setHaiBaoUp{
    if ([AppInfo shareInstance].isHaiBaoNew ) {
        [AppInfo shareInstance].isHaiBaoUp = NO;
        [AppInfo shareInstance].isHaiBaoNew = NO;
        [self performSelector:@selector(setHaiB) withObject:self  afterDelay:3];
    }
    
}
#pragma mark-开始录制上传视频流
- (void)startUpload
{

}



#pragma mark- <<<<<<直播 ,关闭预览和录制
- (void)stopLiving
{
    
    NSLog(@"soopbo!!!-----1");
    [_liveRoomIamgeView stopCameraCapture];
    //    _liveRoomIamgeView.videoCamera = nil;
    [_liveRoomIamgeView removeFromSuperview];
    
//    if ([[SeekuSingle shareSeekuSingle] isStreaming]) {
//        [[SeekuSingle shareSeekuSingle] lib_seeku_stream_stop];
//        
//        NSLog(@"soopbo!!!-----2");
//        
//    }
    
//    if ([[SeekuSingle shareSeekuSingle] streamInitialized]) {
//           NSLog(@"soopbo!!!-----55");
//        [[SeekuSingle shareSeekuSingle] lib_seeku_stream_release];
//        NSLog(@"soopbo!!!-----3");
//    }
    
    if ([self phoneLivingSelf]) {
        [self stopSession];
    }
    
    
    if (self.liveRoomIamgeView.isAVCaptureTorchModeOn) {
//        [self showNoticeInWindow:@"闪光灯已关闭" duration:1];
        [self.liveRoomIamgeView setFlashMode:AVCaptureTorchModeOff];
    }

    
    
    if  (_liveRoomIamgeView.captureSession){
        _liveRoomIamgeView.captureSession = nil;
    }
    
    if (_liveRoomType == LiveRoomType_OutLiveRoom) {
        
    }
    NSLog(@"soopbo!!!-----4");
    if (self.isZhiBoIng) {
        if (self.strShowID == nil ) {
            NSLog(@"roomshowid = nil");
            return;
        }
        if(_isZhiBoIng) {
            [self showNoticeInWindow:@"直播已结束"];
        }
        
        NSString *serverIp= [NSString stringWithFormat:@"http://%@:%@/mobile/dispatch.mobile",self.strserverIP,self.strServerport];
        if (self.strserverIP == nil)
        {
            serverIp = [AppInfo shareInstance].requestServerBaseUrl;
        }
        
        StopLIvingModel *addAttentionModel = [[StopLIvingModel alloc] init];
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict addEntriesFromDictionary:[addAttentionModel signParamWithMethod:EndShowAjax_Method]];
        
     
        [dict setObject:self.strShowID forKey:@"roomshowid"];
        __weak typeof(self) weakSelf = self;
        [addAttentionModel requestDataWithBaseUrl:serverIp requestType:nil method:EndShowAjax_Method httpHeader:[addAttentionModel httpHeaderWithMethod:EndShowAjax_Method] params:dict success:^(id object) {
            
            __strong typeof(weakSelf) strongSelf = weakSelf;
            /*成功返回数据*/
            if (addAttentionModel.result == 0)
            {
                  [[NSNotificationCenter defaultCenter]postNotificationName:@"refresList" object:self];
                _liveRoomType = LiveRoomType_Stop;
                strongSelf.isZhiBoIng = NO;
                strongSelf.phoneLivingStarted = YES;
            }
            else
            {
                [strongSelf showNoticeInWindow:addAttentionModel.msg];
            }
            
        } fail:^(id object) {
            [weakSelf showNotice:@"出错了，请重试" duration:2.0f];
        }];
        
        
    }
    
}


#pragma mark - -发送心跳,以及其他界面设置方法
-(void)postHeart{
    
    NSMutableData *packetData = [NSMutableData data];
    //body
    //    NSDictionary *bodyDic = [NSDictionary dictionaryWithDictionary:giftInfo];
    
    NSData *bodyData = [NSData data];
    //    EWPLog(@"bodyDic = %@",bodyDic);
    //bodylen
    char buffer[4] = {0};
    [SUByteConvert intToByteArray:[bodyData length] bytes:buffer];
    [packetData appendBytes:buffer length:sizeof(int)];
    
    //cmd
    memset(buffer, 0, sizeof(char) * 4);
    COMMAND_ID cmd = CM_Hert;
    [SUByteConvert shortToByteArray:cmd bytes:buffer];
    [packetData appendBytes:buffer length:sizeof(COMMAND_ID)];
    
    //保留4个空字节
    memset(buffer, 0, sizeof(char) * 4);
    [packetData appendBytes:buffer length:4];
    
    
    //bodydata
    [packetData appendBytes:[bodyData bytes] length:[bodyData length]];
    
    [[CommandManager shareInstance] sendData:packetData];
    

    
    
}

//-(void)setimageH{
//    
//    
//    
//    
//}
-(AVCaptureDevice *)getCameraDeviceWithPosition:(AVCaptureDevicePosition )position{
    NSArray *cameras= [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *camera in cameras) {
        if ([camera position]==position) {
            return camera;
        }
    }
    return nil;
}
-(void)setimageHidd{
    _closeBtn.userInteractionEnabled = YES;
    _statusView.hidden = NO;
}










#pragma mark - 进入房间请求->middle调用父View方法，主播开播

- (void)reEnterRoom:(BOOL)reconnect
{
    self.isPlayVideo = YES;
    [self exitRoom:YES];
    //    if (!self.phoneLiving) {
    //        self.loading = YES;
    //        self.phoneLivingStarted = NO;
    //    }
    
    self.reconnect = NO;
    _liveRoomType = LiveRoomType_EnterRoom;
    if (!_liveEndView.hidden) {
        _liveEndView.hidden = YES;
        _liveLoadingView.hidden = NO;
    }
      [_liveAudienceHeaderView  cleanAudienceHeaderData];

    [self getStarInfo];
    EWPLog(@"reEnterRoom");

}



#pragma mark 鉴权
- (void)sendAuthData
{
    [AuthModel sendAuth];
}

#pragma mark - 心跳
- (void)OnHeartTimer:(id)sender
{
    [HeartModel sendHeart];
}

#pragma mark -鉴权成功
- (void)authSuccess:(id)sender
{
    
    //        if (!self.isJianQuan) {
    [self enterRoom];
    //    self.isJianQuan = YES;
    //        }
    
}

#pragma mark -查询更房间有关的数据
- (void)queryRoomAllData
{
    [[GiftDataManager shareInstance] queryGiftData];
    [[EmotionManager shareInstance] queryAllEmotion];
}


#pragma mark - 初始化房间设置以及数据
- (void)initRoomData
{
    //查询表情数据。礼物数据,如果有数据就不会再查询了
    [self queryRoomAllData];
    
    //重置聊天成员信息，和送礼物成员信息
    [[UserInfoManager shareUserInfoManager] resetRoomUserInfo];
    
    UserInfo *userInfo = [[UserInfo alloc] init];//先把主播加进去
    userInfo.userId = [UserInfoManager shareUserInfoManager].currentStarInfo.userId;
    userInfo.nick = [UserInfoManager shareUserInfoManager].currentStarInfo.nick;
    userInfo.hidden = [UserInfoManager shareUserInfoManager].currentStarInfo.hidden;
    userInfo.hiddenindex = [UserInfoManager shareUserInfoManager].currentStarInfo.hiddenindex;
    userInfo.issupermanager = [UserInfoManager shareUserInfoManager].currentStarInfo.issupermanager;
    userInfo.staruserid = [UserInfoManager shareUserInfoManager].currentStarInfo.staruserid;
    [[UserInfoManager shareUserInfoManager] addChatMember:userInfo];
}

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

#pragma mark-【【【【【【【【【【【【【【【【【【【【【TCP通知】】】】】】】】】】】】】】】】】】】********【TCP通知】
#pragma mark - >>>>>>>进入房间结果 >>被T退出房间 || 获取赞 || 获取主播赞 || 获取用户赞 || 获取观众人数，关注数量 || 关闭TCP超时  || 初始化人满倒计时 || 初始化房间设置以及数据 || 更新视频区域界面数据以及设置 || 初始化livemmiddleRoom leftRoom  rightroom数据界面 || 更新私聊数据
//result 返回结果 0 失败 1 成功 2 房间不存在 3 房间人满 4 在黑名单中，禁止加入 5 踢人需要一个小时才能进入

- (void)enterRoomResult:(NSNotification *)notification
{
    
    NSDictionary *bodyDic = [notification userInfo];
    EWPLog(@"bodyDicRes = %@",bodyDic);
    self.enterRoomResultCode = [[bodyDic objectForKey:@"result"] intValue];
    if (self.enterRoomResultCode == 5&&self.phoneLiving )//自己直播被T的情况下直接退出
    {
        [self showNoticeInWindow:@"您刚被踢出房间，一个小时后才能进入房间"];
        [self performSelector:@selector(autoExitRoom) withObject:nil afterDelay:2];
        return;
    }
    
    
    
    
    if (self.phoneLiving ) {
        
        
        return;
    }else if (self.phoneLiving){
//        [self getApprove];
    }
    
    _isPlayVideo = YES;
    
    [self enterRoomLodingData];
    
}
-(void)enterRoomLodingData{
    
    //获取主播赞信息
    [self getStarPraiseNum];

    
    if (!self.reconnect)
    {
        [self stopAnimating];
        //        [self stopLoadProgram];
    }
    
    
    
    
    if (self.enterRoomResultCode == 1)
    {
        
        @autoreleasepool {
            dispatch_queue_t queue=dispatch_get_main_queue();
            dispatch_async(queue, ^{
                
                //进入房间成功
                [self initTimer];
                [self initRoomData];
                //                [self initVideoViewData];//更新视频区域界面数据以及设置(轮播/推荐主播或者直播)
                [self initLiveRoomMiddleViewData];
                [self initLiveRoomRightViewData];
                [self initLiveRoomLeftViewData];
                
               
                [_liveAudienceHeaderView  initAudienceHeaderViewData];//刷新头像列表
                
            });
        }
        
        
        
        if (self.roomInfoData.showtype == 1 || self.roomInfoData.showtype == 2)
        {
            if (!self.reconnect)
            {
                [self initPrivateViewData];
            }
        }
        if (self.roomInfoData.showtype == 3)
        {
            if (self.roomInfoData.bigstarstate == 2)
            {
                //showTime界面
                [self initShowTimeViewData];
            }
            else if (self.roomInfoData.bigstarstate == 4)
            {
                //点歌界面
                [self initVoteMusicViewData];
            }
            else
            {
                //默认点歌界面
                [self initVoteMusicViewData];
            }
        }
        
        
    }
    else if (self.enterRoomResultCode == 2)
    {
        [self showNoticeInWindow:@"房间不存在"];
    }
    else if(self.enterRoomResultCode == 3)
    {
        if (self.roomInfoData.showtype == 3)
        {
            //明星热播间人满，2分钟提示后退出房间
            [self initTimer];
            [self initVideoViewData];
            [self initLiveRoomLeftViewData];
            [self initLiveRoomMiddleViewData];
            [self initLiveRoomRightViewData];
        }
        else
        {
            //普通房间人满退出房间
            [self showNoticeInWindow:@"房间人数已满"];
            [self performSelector:@selector(autoExitRoom) withObject:nil afterDelay:3];
        }
    }
    else if (self.enterRoomResultCode == 4)
    {
        [self showNoticeInWindow:@"在黑名单中，禁止加入"];
    }
    else if (self.enterRoomResultCode == 5)
    {
        [self showNoticeInWindow:@"您刚被踢出房间，一个小时后才能进入房间"];
        [self performSelector:@selector(autoExitRoom) withObject:nil afterDelay:2];
    }
    self.reconnect = NO;
    _showid = 0;
    
}
#pragma mark - ->>>>>>初始化人满倒计时 >> 明星直播间人满提示
- (void)initTimer
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
    
}

#pragma mark - 明星直播间人满提示 >>>  商城对话框
- (void)showRoomPersonFullNotice
{
    if (_roomPersonFullTimer)
    {
        [_roomPersonFullTimer invalidate];
        _roomPersonFullTimer = nil;
        [self exitRoom:YES];
        [self showMarketDialogWithTitle:@"房间人数已达上限" message:@"成为VIP可继续观看" buyVipBlock:^{
            
            NSInteger hideSwitch = [[[AppInfo shareInstance].hideSwitch substringFromIndex:1] integerValue];
            if (hideSwitch == 2)
            {//商城显示的时候才可以进入商城界面
                [self pushCanvas:Mall_Canvas withArgument:nil];
            }
            
        } cancelBlock:^{
            [self popCanvasWithArgment:nil];
        }];
        
    }
}
#pragma mark - >>>>>>商城对话框
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

#pragma mark - >>>>>>更新视频区域界面数据以及设置>> 开始看别人直播startPlay || 如果有图片轮播则显示图片轮播，否则显示推荐主播 || 显示图片画廊
- (void)initVideoViewData
{
    
    
    if (self.phoneLiving)
    {
        return;
    }
    if (self.roomInfoData.showtype == 1)
    {
        StarInfo *starInfo = [UserInfoManager shareUserInfoManager].currentStarInfo;
        if (starInfo.onlineflag)
        {
//            [self.middleView changeRecommendView];//点击推荐主播后如果有直播去掉推荐主播
            //开始看别人直播
            [self startPlay];
            
        }
        else
        {
//            //如果有图片轮播则显示图片轮播，否则显示推荐主播
//            [self showRoomImagesOrRecommendView];
            self.playing = NO;
     
        }
    }
    else if(self.roomInfoData.showtype == 2)
    {
//        //显示图片画廊
//        [self requestRoomImagesDataAnShow];
        self.playing = NO;

    }
    else if(self.roomInfoData.showtype == 3)
    {
        //明星直播间,开播显示视频，为开播显示图片走廊
        if (self.roomInfoData.showid == 0)
        {
            //未开播
//            [self requestRoomImagesDataAnShow];
//            [self showStartTime];//显示主播开播时间
            self.playing = NO;
      
        }
        else
        {
            //开播
            [self startPlay];
            
        }
    }
}






#pragma mark - >>>>>>更新中间界面数据以及设置
- (void)initLiveRoomMiddleViewData
{
    if (_middleView)
    {
        [_middleView initData];
        if ([UserInfoManager shareUserInfoManager].currentStarInfo.userId != [UserInfoManager shareUserInfoManager].currentUserInfo.userId) {
            [_middleView receiveRoomMessage:nil];

        }

    }
    
}

#pragma mark ->>>>>>更新左侧界面数据以及设置
- (void)initLiveRoomLeftViewData
{
    if (_leftView)
    {
        [_leftView initData];
    }
}

#pragma mark ->>>>>>更新左侧界面数据以及设置
- (void)initLiveRoomRightViewData
{
    if (_rightView)
    {
        [_rightView initData];
    }
}

#pragma mark -更新公聊界面数据以及设置
- (void)initPublicViewData
{

}

#pragma mark ->>>>>>更新私聊界面数据以及设置
- (void)initPrivateViewData
{
    
    if (!self.phoneLivingSelf)

    [self lrTaskNumberWithParms:nil withMumber:5];
    
}


#pragma mark -更新showtime界面数据以及设置
- (void)initShowTimeViewData
{
    
}

//#pragma mark -明星热播间
#pragma mark -更新点歌界面数据以及设置
- (void)initVoteMusicViewData
{
    
}



#pragma mark - 接收到房间消息
- (void)receiveRoomMessage:(NSNotification *)notification
{
    if (_middleView)
    {
        [_middleView receiveRoomMessage:notification];
    }
}

#pragma mark - 接收到全局消息
- (void)receiveGlobalMessage:(NSNotification *)notification
{
    if (_middleView)
    {
        [_middleView receiveGlobalMessage:notification];
    }
}

#pragma mark - 送礼物消息

- (void)receiveGift:(NSNotification *)notification
{
    if (_middleView)
    {
        [_middleView receiveGift:notification];
    }
}

#pragma mark - 接受到错误信息的通知
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
                [_chatToolBar hideKeyBoard];
                [self exitRoom:NO];
                [AppInfo shareInstance].bLoginSuccess = NO;
                [self performSelector:@selector(pressedShowOherTerminalLoggedDialog) withObject:self afterDelay:0.5];
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
                //                if (self.entireview.bRobbingSofa)
                //                {
                //                    self.entireview.bRobbingSofa = NO;
                //                }
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
                }
                //                self.entireview.bRobbingSofa = NO;
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





#pragma mark - 收到赞的通知
- (void)receiveApproveResult:(NSNotification *)notification
{
    NSDictionary *bodyDic = [notification userInfo];
    EWPLog(@"receiveApproveResult bodyDic = %@",bodyDic);
    [_middleView praiseAnimation];
    if ([[bodyDic objectForKey:@"c"] integerValue]<9950) {
        _praiseLabel.text = [NSString stringWithFormat:@"%ld",[[bodyDic objectForKey:@"c"] integerValue]];
    }
    else
    {
        _praiseLabel.text = [NSString stringWithFormat:@"%.1fW",(float)[[bodyDic objectForKey:@"c"] integerValue]/10000];
    }
}

#pragma mark - 接收到进入房间通知
- (void)receiveEnterRoomMessage:(NSNotification *)notification
{
    if (_middleView)
    {
        [_middleView receiveEnterRoomMessage:notification];
    }
}

#pragma mark - 接受推出房间通知
-(void)receiveOutRoomMessage:(NSNotification *)notification
{
    if (_middleView)
    {
        [_middleView receiveOutRoomMessage:notification];
    }
}

#pragma mark - 首次触发点赞效果
-(void)receiveSendNotice:(NSNotification *)notification
{
    if (_middleView) {
        [_middleView receiveSendNotice:notification];
    }
}

#pragma mark - 接收到弹幕通知
- (void)receiveBarageMessage:(NSNotification *)notification
{
    if (!self.hideBarrage)
    {
        if (_middleView)
        {
            [_middleView receiveBarageMessage:notification];
        }
    }
    
}

#pragma mark - 接收到音乐改变通知
- (void)receiveMusicChangeMessage:(NSNotification *)notification
{
    if (_middleView)
    {
        [_middleView receiveMusicChangeMessage:notification];
    }
    
}
#pragma mark - 收到沙发的通知
- (void)receiveSofa:(NSNotification *)notification
{
    
}


#pragma mark -CommandManager TCP连接失败的通知
- (void)tcpWillDisconnectWithErro
{
    if ([CommandManager shareInstance].connectSuccess)
    {
        self.tcpDisconnectWithErro = YES;
    }
    
}
#pragma mark -CommandManager TCP连接成功的通知
- (void)tcpConectSuccess
{
    
    self.tcpDisconnectWithErro = NO;
    if(_heartTimer == nil)
    {
        _heartTimer = [NSTimer scheduledTimerWithTimeInterval:[AppInfo shareInstance].heart_time target:self selector:@selector(OnHeartTimer:) userInfo:nil repeats:YES];
    }
    
    [self sendAuthData];
    
   
}
#pragma mark -CommandManager TCP已经连接失败的通知
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
    
    if ( self.liveRoomType >=LiveRoomType_OutLiveRoom) {
        return;
    }
    
    if (self.tcpDisconnectWithErro)
    {
        self.tcpDisconnectWithErro = NO;
        self.reconnect = NO;
        [self enterRoom];
    }
    
    
}
#pragma mark -CommandManager TCP发送数据失败的通知
- (void)tcpSendDataFail
{
       self.reconnect = NO;
    if ( self.liveRoomType >=LiveRoomType_OutLiveRoom) {
        return;
    }
    
    [self showNoticeInWindow:@"网络异常操作失败，请稍后再试！"];
 
    if ([CommandManager shareInstance].tcpConnecting)
    {
        [self performSelector:@selector(enterRoom) withObject:nil afterDelay:EnterRoom_TimeOut];
        
    }
    else
    {
        [self enterRoom];
    }
}








#pragma mark -【【【【【【【【【【【【【【【【【【【【【退出房间】】】】】】】】】】】】】】】】】】】】】】】】】】】】】******【退出房间】
#pragma mark -离开房间

- (void)exitRoom:(BOOL)stopVideo
{
    
    [[CommandManager shareInstance] disConnectServer];
    [self stopAnimating];
    self.reconnect =NO;
    _showingErroDialog = NO;
    
    //    [self stopLoadProgram];
    
    if (self.loginNoticeTimer)
    {
        [self.loginNoticeTimer invalidate];
        self.loginNoticeTimer = nil;
    }
    
    //关闭定时器
    if (_getApproveTimer)
    {
        [_getApproveTimer invalidate];
        _getApproveTimer = nil;
    }
    
    if (_roomPersonFullTimer)
    {
        [_roomPersonFullTimer invalidate];
        _roomPersonFullTimer = nil;
    }
    
    
    
    if (stopVideo  &&  _liveRoomType == LiveRoomType_Living  && !_changeCavasFromLogin) {
        _liveRoomType = LiveRoomType_Stop;
        [self stopVideoPlayThread];
    }
    
    if (![self phoneLivingSelf] && stopVideo) {
        //退出播放视频
        [self stopPlayWithLivePlayer];
    }
//
//    }
//    
//
//    if (stopVideo  &&  _liveRoomType == LiveRoomType_Living  && !_changeCavasFromLogin)
//    {
//
//        
//    }else{
//
//    }
 

    
  
}
#pragma mark -点击colose退出房间
- (void)autoExitRoom
{
    [self exitRoom:YES];
    
    [self performSelector:@selector(stopPlayingautoExitRoom) withObject:self afterDelay:0.5];
}

-(void)coloseSelfStar{
    if (self.isZhiBoIng) {//自己直播的时候按home键的时候推出直播间
        self.isTouchHomeEd = YES;
        
        [self stopPlayingautoExitRoom];
        
    }
}
-(void)stopPlayingautoExitRoom{
    _liveRoomType = LiveRoomType_OutLiveRoom;
    [AppInfo shareInstance].pushType=0;
    [[CommandManager shareInstance] disConnectServer];
    self.reconnect = NO;
    self.isTouchHomeEd = YES;
    if (self.playingTimer) {
        [self.playingTimer invalidate];
        self.playingTimer = nil;
    }
    
    [ _alertview dismissWithClickedButtonIndex:0 animated:NO];
    
    
    
    [self.liveEndView removeFromSuperview];
    self.liveEndView = nil;
    
    
    //    seeku *seekuInstance = [self currentSeeku:NO];
    //    if (self.isFlashOn) {
    //        [seekuInstance lib_seeku_video_setFlashMode:0];
    //    }
    
    if ([self phoneLiving]) {
        
        [self stopLiving];
        _liveRoomIamgeView.isCanUpLoad = NO;
    }//停止录制
    
    [AppDelegate shareAppDelegate].isSelfWillLive = NO;
    
//    [[SeekuSingle shareSeekuSingle] lib_audioSession_uninitialize];
    
    
    if (self.stopPlayingTimer) {
        
        [self.stopPlayingTimer invalidate];
        self.stopPlayingTimer = nil;
        
    }
    if (self.stopPreAndUpLod) {
        [self.stopPreAndUpLod invalidate];
        self.stopPreAndUpLod = nil;
    }
    if (self.activityIng) {
        [self.activityIng invalidate];
        self.activityIng = nil;
    }
    
    if (self.stopPlayingTimer) {
        [self.stopPlayingTimer invalidate];
        self.stopPlayingTimer = nil;
    }
    
    if (self.starPlayTImer) {
        [self.starPlayTImer invalidate];
        self.starPlayTImer = nil;
    }
    if (self.stopPreAndUpLod) {
        [self.stopPreAndUpLod invalidate];
        self.stopPreAndUpLod = nil;
    }
    
    NSString *className = NSStringFromClass([self class]);
    NSDictionary *param = [NSDictionary dictionaryWithObject:className forKey:@"className"];
    
        [self popCanvasWithArgment:param];
//    }
    
    
    
    if (self.middleView) {
        [self.middleView viewwillDisappear];
        [self.middleView removeFromSuperview];
        
    }
    
    if (self.chatToolBar) {
        [self.chatToolBar viewwillDisappear];
 
    }
    
    
    if (self.startView) {
        [self.startView viewwillDisappear];
        [self.startView removeFromSuperview];
    }
    
    if (_liveRoomIamgeView) {
        [_liveRoomIamgeView viewwillDisappear];
        [_liveRoomIamgeView removeFromSuperview];
        _liveRoomIamgeView = nil;
    }
    if (_liveLoadingView) {
        [_liveLoadingView removeFromSuperview];
        _liveLoadingView = nil;
    }
    
    if (_liveBottomView) {
        [_liveBottomView removeFromSuperview];
        _liveBottomView = nil;
    }
    
    if (_liveAudienceHeaderView) {
        [_liveAudienceHeaderView removeFromSuperview];
        _liveAudienceHeaderView = nil;
    }
    
    
    
}

#pragma mark -音频模式，显示动态节奏先
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
- (void)showApproveView
{
    if (_middleView)
    {
        [_middleView showApproveView];
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
- (void)OnTimerOut
{
}

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

- (void)showRechargeDialog
{
    //    [self.view endEditing:YES];
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
    [alertView performSelector:@selector(show) withObject:nil afterDelay:0.5f];
}



#pragma mark - OnPan
- (void)OnSwipGestureRecognizer:(UISwipeGestureRecognizer *)swipGestureRecognizer
{
    if (swipGestureRecognizer.direction == UISwipeGestureRecognizerDirectionUp)
    {
        [self showStopLiveMenu:NO];
    }
    else if (swipGestureRecognizer.direction == UISwipeGestureRecognizerDirectionDown)
    {
        [self showStopLiveMenu:YES];
    }
}

- (void)showStopLiveMenu:(BOOL)show
{
    if (show == _stopLiveViewShowing)
    {
        return;
    }
    
    _stopLiveViewShowing = show;
    
    self.view.userInteractionEnabled = NO;
    [UIView animateWithDuration:0.3 animations:^{
        if (show)
        {
            CGRect frame = self.view.frame;
            frame.origin.y += _stopLiveView.frame.size.height;
            self.view.frame = frame;
        }
        else
        {
            CGRect frame = self.view.frame;
            frame.origin.y -= _stopLiveView.frame.size.height;
            self.view.frame = frame;
        }
    } completion:^(BOOL finished) {
        if (finished)
        {
            self.view.userInteractionEnabled = YES;
        }
    }];
}


#pragma mark - -【【【【【【【【【【【【【【【【【【【【【【【【【【【【【【【【【LiveRoomView】】】】】】】】】】】】】】】】】】】】】】】
#pragma mark - 看主播开播
- (void)startPlay
{
    self.isZhiBoIng = YES;
    
    if (self.phoneLiving)
    {
        [self startUpload];
    }
    else
    {
//        seeku *seekuInstance = [self currentSeeku:_isPlayVideo];
//        if (!seekuInstance.playing)
//        {
//            [self startVideoPlay:[NSNumber numberWithBool:_isPlayVideo]];
//        }
        [self startVideoPlay:YES];
    }
    
}
#pragma mark -开始直播 >>>>>> 设置正在连接 || 音频视频切换状态  ||  集赞，加载中消失
- (void)startVideoPlay:(BOOL )isPlayVideo
{
    @autoreleasepool
    {
        _roomImgeView.hidden = YES;
        _isPlayVideo = isPlayVideo;
//        if ([self.roomInfoData.liveip rangeOfString:@"://"].length > 0)
//        {
//            liveUrl = [NSString stringWithFormat:@"%@%@",self.roomInfoData.liveip,self.roomInfoData.livestream];
//        }
//        else
//        {
//            liveUrl = [NSString stringWithFormat:@"rtmp://%@/live/%@",self.roomInfoData.liveip,self.roomInfoData.livestream];
//        }
//        if (!isPlayVideo)
//        {
//            liveUrl = [NSString stringWithFormat:@"%@?only-audio=1",liveUrl];
//            
//            [UIApplication sharedApplication].idleTimerDisabled = NO;
//        }
//        else
//        {
//            [UIApplication sharedApplication].idleTimerDisabled = YES;
//        }
        
        
        NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
        
        NSString * userId = [NSString stringWithFormat:@"%ld",(long)[UserInfoManager shareUserInfoManager].currentStarInfo.userId];
        [dict setObject:userId forKey:@"staruserid"];
        
        __weak __typeof(&*self) weakSelf = self;
        GetStreamInfoModel * model = [[GetStreamInfoModel alloc] init];
        [model requestDataWithParams:dict success:^(id object) {
            
            GetStreamInfoModel * model = object;
            
            if (model.result == 0) {
                if ([model.data isKindOfClass:[NSString class]]) {
                    NSString * jsonStr = model.data;
                    NSData * jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
                    NSDictionary * jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
                    //开始接受JSON Dic.
                    EWPLog(@"StreamJSON data : %@",jsonDic);
                    
                    
                    NSString * hub = [jsonDic objectForKey:@"hub"];
                    NSString * title = [jsonDic objectForKey:@"title"];
                    NSDictionary * hdl = [[[jsonDic objectForKey:@"hosts"] objectForKey:@"live"] objectForKey:@"hdl"];
                    
                    NSString *liveUrl = [NSString stringWithFormat:@"http://%@/%@/%@.flv",hdl,hub,title];
                    EWPLog(@"liveUrl = %@",liveUrl);
                    if (![self phoneLivingSelf]) {
                        [self playVideoWithUrlString:liveUrl];
//                        _liveLoadingView.hidden = YES;
                        NSLog(@"开始播放网址!!!!");
                    }
                    
                    
                }
                
                
                
            }else {
                EWPLog(@"推流JSon请求失败");
            }
            
        } fail:^(id object) {
            EWPLog(@"推流JSon请求发生错误");
        }];
        
        
        
         _liveRoomType = LiveRoomType_Living;
        _videoImage.contentMode = UIViewContentModeScaleToFill;
//        NSDictionary *myDict = [NSDictionary dictionaryWithObjectsAndKeys:_videoImage,@"imgview",liveUrl,@"playAdress", nil];
        
        

        
//        seeku *seekuInstance = [self currentSeeku:isPlayVideo];
//        if (seekuInstance)
//        {
//            
//            
//            @autoreleasepool {
//                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                    [seekuInstance lib_seeku_single_play_start:myDict];
//                });
//            }
//            
//            self.tempLongLast =[seekuInstance lib_seeku_single_play_getStreamTotal];
//            
//            
//            self.tempLongTimer=   [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(tempLongTime) userInfo:nil repeats:YES];
//            [self.tempLongTimer fire];
//            
//            
//            
//        }

    }
    
}


#pragma  mark ->>>>>> 集赞，加载中消失
//-(void)tempLongTime{
////    seeku *seekuInstance = [self currentSeeku:self.isPlayVideo];
////    long lontNew =[seekuInstance lib_seeku_single_play_getStreamTotal];
////    if ( lontNew-self.tempLongLast>0) {
////        [self.tempLongTimer invalidate];
////        self.tempLongTimer =nil;
////        if (self.isPlayVideo) {
////            _liveLoadingView.hidden = YES;
////        }
////        
////        
////    }
////    self.tempLongLast = lontNew;
//    
//}


#pragma  mark - 主播停播 >> 如果有图片轮播则显示图片轮播，否则显示推荐主播 || 显示图片画廊  ||  停止视频播放 || 停止获取赞 || 明星直播间开播时间
- (void)stopPlay
{
    
    self.liveEndView.hidden = NO;
    self.playing = NO;

    [self stopVideoPlayThread];
    
    self.playingTimer = [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(videoImageChange) userInfo:nil repeats:YES];
    [self.playingTimer fire];
    
    _roomImgeView.hidden = YES;
}
-(void)videoImageChange{
//    seeku *seekuInstance = [self currentSeeku:_isPlayVideo];
//    if (!seekuInstance.playing ) {
//        _videoImage.image = nil;
//        [self.playingTimer invalidate];
//        self.playingTimer = nil;
//    }
    
}
#pragma mark ->>>>>>停止视频播放
- (void)stopVideoPlayThread
{
    
    if (_beforeLiveView.isSelfLivPrepareTime) {//如果在设置海报期间
        return;
    }
//    seeku *seekuInstance = [self currentSeeku:_isPlayVideo];
//    if (seekuInstance)
//    {
//        @autoreleasepool {
//            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                [seekuInstance lib_seeku_single_play_stop];
//            });
//        }
//
//    }
    
    
    if ([self phoneLivingSelf]) {
        [self stopSession];
    }
}






#pragma mark - -键盘隐藏与关闭调整聊天框与表情框位置
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
        if (!self.chatToolBar.emotionView)
        {
            if (self.chatToolBar.isPrivateChat) {
                [self moveInputBarWithKeyboardHeight:0 withDuration:animationDuration];
            }else{
                [self moveInputBarWithKeyboardHeight:-33 withDuration:animationDuration];
            }
        }
        
    }
    
}

- (void)moveInputBarWithKeyboardHeight:(float)keyboardHeight withDuration:(NSTimeInterval)animationDuration
{
    [UIView animateWithDuration:animationDuration delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^
     {
         
         self.chatToolBar.frame = CGRectMake(0, SCREEN_HEIGHT - keyboardHeight - 33, self.view.frame.size.width, 33);
         
     } completion:^(BOOL finished) {
     }];
}


#pragma mark - -禁言
- (void)forbidSpeakLeft:(UserInfo *)userInfo
{
    if ([self showLoginDialog])
    {        return;
    }
    if (userInfo.userId == [UserInfoManager shareUserInfoManager].getUserInfoModel.userInfo.userId)
    {
        [self showNoticeInWindow:@"亲，自己不能禁言自己哦!"];
    }
    if (userInfo)
    {
        [self forbidSpeak:userInfo];
    }

}

#pragma mark - -踢人
- (void)kickPersonLeft:(UserInfo *)userInfo
{
    if ([self showLoginDialog])
    {
        return;
    }
    
    if (userInfo.userId == [UserInfoManager shareUserInfoManager].getUserInfoModel.userInfo.userId)
    {
        [self showNoticeInWindow:@"亲，自己不能踢自己哦!"];
        //        [self showTakeFailure:@"踢人失败!" Message:@"亲，自己不能踢自己哦!"];
    }
    else
    {
        [self performSelector:@selector(kickPerson:) withObject:userInfo];
    }

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
#pragma mark - 送礼
- (void)showGiftLeft:(UserInfo *)userInfo
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
#pragma mark - 举报
- (void)reportLeft:(UserInfo *)userInfo
{
    //举报用户
    [self reportUser:userInfo];
}


#pragma mark - -【【【【【【【【【【【【【【【【【【【【【【【【【【【【【【【【【MiddleRoomView】】】】】】】】】】】】】】】】】】】】】】】
#pragma mark - -隐藏输入框
- (void)hideToolbar
{
    [self.chatToolBar hideKeyBoard];
}


#pragma mark - -聊天信息已隐藏显示
- (void)setHideChat:(BOOL)hideChat
{
    _hideChat = hideChat;
    self.middleView.tabMenu.hidden = hideChat;
}
#pragma mark - -弹幕开启关闭
- (void)setHideBarrage:(BOOL)hideBarrage
{
    _hideBarrage = hideBarrage;
}
#pragma mark - -举报
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

#pragma mark -PopupMenuDelegate
- (void)showPopupMenu:(UserInfo *)userInfo
{
    _userIdcount = userInfo.userId;
    if ([UserInfoManager shareUserInfoManager].currentStarInfo.userId == userInfo.userId) {
        _userstate =2;
        _seleate = 1;
        [self getStarInfo];
        [_starInforlog showInView:self.view];

    }else{
        [self userInfor:userInfo];
    }
    return;
    
    /**
     *  由于需求变更所以聊天区域的列表变为 弹框，下面的代码就不让走了
     */
    if (!userInfo)
    {
        return;
    }
    self.userInfoOfPopupMenu = userInfo;
    
    UserInfo *currentUserInfo = [UserInfoManager shareUserInfoManager].currentUserInfo;
//      StarInfo *currentUserInfo11 = [UserInfoManager shareUserInfoManager].currentStarInfo;
    if (userInfo.userId == [UserInfoManager shareUserInfoManager].tempSelfStarInfo.userId)
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
    
    
    CGFloat width = 96;
    CGFloat height = 213;
    
    
    if (self.roomInfoData.showtype == 3)
    {
        height = 133;
    }
    CGRect rect = CGRectMake(0, 0, width, height);
    
    NSString *string = [[NSUserDefaults standardUserDefaults] objectForKey:@"popupPoint"];
    CGPoint pt = CGPointFromString(string);
    
    CGFloat margin = 5;
    
    if (pt.x - width / 2 < margin )
    {
        pt.x = margin + width / 2;
    }
    else if (pt.x + width / 2 > SCREEN_WIDTH - margin)
    {
        pt.x = SCREEN_WIDTH - margin - width / 2;
    }
    
    if (pt.y - height / 2 < margin )
    {
        pt.y = margin + height / 2;
    }
    else if (pt.y + width / 2 > SCREEN_HEIGHT - margin)
    {
        pt.y = SCREEN_HEIGHT - margin - height / 2;
    }
    
    _poplistview = [[UIPopoverListView alloc] initWithFrame:rect];
    _poplistview.listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _poplistview.layer.cornerRadius = 4.0f;
    _poplistview.delegate = self;
    _poplistview.datasource = self;
    _poplistview.listView.scrollEnabled = NO;
    [_poplistview showInCenter:pt];
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
    selectedBKView.backgroundColor = [CommonFuction colorFromHexRGB:@"f7c250"];
    cell.selectedBackgroundView = selectedBKView;
    
    if (indexPath.row == 0)
    {
        cell.userInteractionEnabled = NO;
        cell.textLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        cell.textLabel.textColor = [CommonFuction colorFromHexRGB:@"f7c250"];
    }
    else
    {
        cell.userInteractionEnabled = YES;
        cell.textLabel.font = [UIFont systemFontOfSize:13.0f];
        cell.textLabel.textColor = [CommonFuction colorFromHexRGB:@"ffffff"];
    }
    cell.backgroundColor = [UIColor colorWithWhite:0 alpha:0.35];
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
        return 38.0f;
    }
    return 33.0f;
}

#pragma mark -点击弹出菜单选项>>  送礼  ||  聊天 || 踢出房间  || 禁言 ||举报
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
            
            [self.view endEditing:YES];
            [self giveGiftWithUserInfo:userInfo];
        }
            break;
        case 2:
        {
            //聊天
            if (_chatToolBar)
            {
                [_chatToolBar chatWithUserInfo:userInfo showToolBar:YES];
                
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

#pragma mark - -送礼
- (void)giveGiftWithUserInfo:(UserInfo *)userInfo
{
    
    if (userInfo== nil || userInfo.userId==0) {
        return;
    }
    //    [_messageCotent resignFirstResponder];
    //    [self hideEmotionView];
    
    if (_giftBaseView == nil)
    {
        
        if (self.roomInfoData.showtype == 3)
        {
            
            
            
        }
        else
        {
            [[UserInfoManager shareUserInfoManager] addGiftMember:userInfo];
            UIControl *backView = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - Gift_View_Height)];
            backView.backgroundColor = [UIColor clearColor];
            [backView addTarget:self action:@selector(hideGift) forControlEvents:UIControlEventTouchUpInside];
            backView.tag = 2222;
            [self.view addSubview:backView];
            
            GiftView *giftView = [[GiftView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, self.view.frame.size.width, Gift_View_Height) showInView:self.view];
            giftView.delegate = self;
            [self.view addSubview:giftView];
            _giftBaseView = giftView;
            [_giftBaseView addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
            
            [UIView animateWithDuration:0.3f animations:^{
                giftView.userInteractionEnabled = NO;
                CGRect rect = giftView.frame;
                rect.origin.y -= Gift_View_Height;
                giftView.frame = rect;
            } completion:^(BOOL finished) {
//                [self addGiftGuideView];
                giftView.userInteractionEnabled = YES;
            }];
            
            
        }
    }
    else
    {
        [self hideGift];
    }
}

- (void)hideGift
{
    if (self.roomInfoData.showtype == 3)
    {
        [UIView animateWithDuration:0.1f animations:^{
            CGRect rect = self.giftBaseView.frame;
            rect.origin.y += 120;
            self.giftBaseView.frame = rect;
            
        } completion:^(BOOL finished) {
            
            UIView *backView = [self.view viewWithTag:3333];
            [backView removeFromSuperview];
            
            [self.giftBaseView removeObserver:self forKeyPath:@"frame"];
            [self.giftBaseView removeFromSuperview];
            self.giftBaseView = nil;
        }];
    }
    else
    {
        [UIView animateWithDuration:0.1f animations:^{
            CGRect rect = self.giftBaseView.frame;
            rect.origin.y += Expression_View_Height;
            self.giftBaseView.frame = rect;
            
        } completion:^(BOOL finished) {
            
            UIView *backView = [self.view viewWithTag:2222];
            [backView removeFromSuperview];
            
            [self.giftBaseView removeObserver:self forKeyPath:@"frame"];
            [self.giftBaseView removeFromSuperview];
            self.giftBaseView = nil;
        }];
    }
    
}
#pragma mark - -踢人
/* 踢人和禁言都是staruserid传主播id，touserid传被T人的id */
- (void)kickPerson:(UserInfo *)userInfo
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInteger:[UserInfoManager shareUserInfoManager].currentStarInfo.userId] forKey:@"staruserid"];
    [dict setObject:[NSNumber numberWithInteger:userInfo.userId] forKey:@"touserid"];
    if (userInfo.clientId)
    {
        [dict setObject:userInfo.clientId forKey:@"clientid"];
    }
//    1415 小沫5
//    30251
    [self startAnimating];
    StarInfo *starInfo = [UserInfoManager shareUserInfoManager].currentStarInfo;
    TakeoutModel *model = [[TakeoutModel alloc] init];
    NSString *serverIp= [NSString stringWithFormat:@"http://%@:%ld/mobile/dispatch.mobile",starInfo.serverip,(long)starInfo.serverport];
    [dict addEntriesFromDictionary:[model signParamWithMethod:Takeout_Method]];
    NSDictionary *header = [model httpHeaderWithMethod:Takeout_Method];
    
    __weak typeof(self) weakSelf = self;
    [model requestDataWithBaseUrl:serverIp requestType:nil method:Takeout_Method httpHeader:header params:dict success:^(id object) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        /*成功返回数据*/

        if (model.result == 0)
        {
      
             [strongSelf  performSelector:@selector(showNoti:) withObject:@"踢人成功" afterDelay:0.5];
            [_starInforlog hide ];
            
        }
        else
        {
           
   [strongSelf  performSelector:@selector(showNoti:) withObject:model.msg afterDelay:0.5];
        }
       

        [self stopAnimating];
    } fail:^(id object) {
        [self stopAnimating];
        [self showNoticeInWindow:@"踢人失败"];
    }];
    
}

#pragma mark - -禁言
/* 踢人和禁言都是staruserid传主播id，touserid传被T人的id */
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
        __strong typeof(weakSelf) strongSelf = weakSelf;
        /*成功返回数据*/
        if (model.result == 0)
        {
            
           
            
            [strongSelf  performSelector:@selector(showNoti:) withObject:@"禁言成功!" afterDelay:0.5];
            strongSelf.middleView.tabMenu.currentSelectedSegmentIndex = 0;
        }
        
        else
        {
          
            [strongSelf  performSelector:@selector(showNoti:) withObject:model.msg afterDelay:0.5];

        }
        
    } fail:^(id object) {
        
    }];
}
-(void)showNoti:(NSString*)string{
     [self showNoticeInWindow:string duration:2];
}
#pragma mark -举报
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
    
    NSInteger userid = [UserInfoManager shareUserInfoManager].getUserInfoModel.userInfo.userId;
    
    _reportUserDialog = [[EWPSimpleDialog alloc] initWithFrame:CGRectMake(0, 0, 271, 229)];
    _reportUserDialog.layer.borderColor = [UIColor whiteColor].CGColor;
    _reportUserDialog.backgroundColor = [UIColor whiteColor];
    _reportUserDialog.layer.cornerRadius = 4.0f;
    _reportUserDialog.layer.borderWidth = 1.0f;
    
    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(225, 5, 40, 40)];
    [closeBtn setImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(hideReportDialog:) forControlEvents:UIControlEventTouchUpInside];
    [_reportUserDialog addSubview:closeBtn];
    
    //举报人
    UILabel *reporterLable = [[UILabel alloc] initWithFrame:CGRectMake(20, 22, 200, 15)];
    reporterLable.font = [UIFont boldSystemFontOfSize:12.0f];
    reporterLable.textColor = [CommonFuction colorFromHexRGB:@"575757"];
    if (userid)
    {
        reporterLable.text = [NSString stringWithFormat:@"举报人：%@",[UserInfoManager shareUserInfoManager].getUserInfoModel.userInfo.nick];
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
    
    [_reportUserDialog showInView:self.view];
    [_reportContent becomeFirstResponder];
}

#pragma mark -聊天【通用】
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
                self.middleView.tabMenu.currentSelectedSegmentIndex = 0;
            }
            else
            {
                
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
            self.chatToolBar.frame =  CGRectMake (0, SCREEN_HEIGHT , SCREEN_WIDTH, 33);
            _chatToolBar.isPrivateChat = NO;
        }
        
    }
}
- (void)sendMessageTimer
{
    self.chatTime--;
    if (self.chatTime == 0)
    {
        [_chatTimer invalidate];
        _chatTimer = nil;
    }
}



#pragma mark - 一些提示
#pragma mark - 多端登录
-(void)pressedShowOherTerminalLoggedDialog{
  
        if (!self.showingLoginMoreAlertView)
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"refashHead" object:nil];
            EWPAlertView *alertView = [[EWPAlertView alloc] initWithTitle:@"警告" message:@"您的账号已在其他移动设备登录，如非本人操作，则账号可能存在安全风险！" leftBtnTitle:@"确定" rightBtnTitle:@"取消" clickBtnBlock:^(NSInteger nIndex) {
                if (nIndex == 0)
                {
                      [_chatToolBar hideKeyBoard];
                    [[AppInfo shareInstance] loginOut];
                    LoginViewController *viewController = [[LoginViewController alloc] init];
                    [[AppDelegate shareAppDelegate].lrSliderMenuViewController closeSliderMenu];
                    [[AppDelegate shareAppDelegate].navigationController pushViewController:viewController animated:YES];
                }
                else
                {
                    [AppInfo shareInstance].pushType=0;
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"ShowLiveBtnOnMain" object:self userInfo:nil];
                     if ([self phoneLivingSelf]) {//自己是主播
                         [self stopPlayingautoExitRoom];
                     }
                }
                self.showingLoginMoreAlertView = NO;
                [[AppInfo shareInstance] loginOut];
            }];
            [alertView show];
            self.showingLoginMoreAlertView = YES;
        }
        
 
}




/**
 *  显示网络连接失败，请重试提示框
 */
- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}
- (void)showNetworkErroDialog
{
    
    if (_mbProgressHudTimer) {
        [_mbProgressHudTimer invalidate];
        _mbProgressHudTimer = nil;
    }
    if (self.starPlayTImer) {
        [self.starPlayTImer invalidate];
        self.starPlayTImer = nil;
    }
    if (self.isTouchHomeEd) {
        return ;
    }
    if (!_showingErroDialog)
    {
        _showingErroDialog = YES;
        _alertview = [[EWPAlertView alloc] initWithTitle:@"提示" message:@"网络连接失败，请重试" leftBtnTitle:@"取消" rightBtnTitle:@"重试" clickBtnBlock:^(NSInteger nIndex) {
            if (nIndex == 0)
            {
                NSLog(@"网络连接失败，退出");
                [self autoExitRoom];
                
                
                _showingErroDialog = NO;
            }
            else if(nIndex == 1)
            {
                _showingErroDialog = NO;
                if ([AppInfo shareInstance].network ==0 || ![AppInfo IsEnableConnection])
                {
                    [self showNetworkErroDialog];
                    return;
                }
                [self exitRoom:YES];
                self.reconnect = NO;
                [self performSelector:@selector(getStarInfo) withObject:nil];
                
            }
            
        }];
        [_alertview show];
        
    }
    
    if (_chatToolBar) {
        [_chatToolBar hideKeyBoard];
    }
}

//获取用户最新信息

//其它类不初始化互相调用的总开关
-(void)lrTaskNumberWithParms:(id)parms withMumber:(NSInteger)number{
    if (number==0) {
        if (parms != nil) {
            [_liveAudienceHeaderView addAudienceHeaderWithModel:parms];
            
            UserEnterRoomModel* model = parms;
            UserInfo* userInfo =[[UserInfo alloc]init];
            userInfo.clientId =model.memberData.clientId;
            userInfo.hidden = model.memberData.hidden;
            userInfo.hiddenindex = model.memberData.hiddenindex;
            userInfo.issupermanager = model.memberData.issupermanager;
            userInfo.consumerlevelweight = model.memberData.consumerlevelweight;
            userInfo.levelWeight = model.memberData.levelWeight;
            userInfo.nick =model.memberData.nick;
            userInfo.photo = model.memberData.photo;
            userInfo.privlevelweight = model.memberData.privlevelweight;
            //    userInfo.realUserId = [[chatMemberDic objectForKey:@"realUserId"] integerValue];
            //    userInfo.time =model.memberData.time;
            userInfo.userId = model.memberData.userId;
            userInfo.staruserid = model.memberData.staruserid;
            userInfo.idxcode =model.memberData.idxcode;
            userInfo.cardata  = model.carData;
            
            
            [_priVateChatView addChatMember:userInfo];
            
            if ([self phoneLivingSelf]) {
                //自己是主播就不显示
            }else {
                //自己是普通用户就判断
                //判断刚进去不用提示.
                
                if (![self phoneLiving]&&_liveEndView.isHidden == NO) {
                    //刚进播放页面,主播就停播
                }else{
                    //
                    [_liveRoomUserCarView showUserCarWithUserInfo:userInfo];
                }
                
            }
            
            
//            if (userInfo.userId == self.staruserid && [AppDelegate shareAppDelegate].isSelfWillLive) {
//                //主播是自己就不显示.
//            } else {
//                //是别人就显示
//                if (userInfo.cardata ) {
//                    [_liveRoomUserCarView showUserCarWithUserInfo:userInfo];
//                }
//            }

          
        }
        
    }
    if (number==1) {
        if (parms != nil) {
            [_liveAudienceHeaderView delAudienceHeaderWithModel:parms];
        }
    }
    if (number==2) {//收到停播消息

            _liveRoomType = LiveRoomType_Stop;
//        [_chatToolBar.messageCotent resignFirstResponder];
        
        [self lrTaskNumberWithParms:nil withMumber:3];
        _liveRoomOtherThings = LiveRoomOtherThing_receiveWillStop;
            [self getRoomInfo];
     
    }
    if (number==3) {//隐藏私聊框
        self.chatToolBar.frame =  CGRectMake (0, SCREEN_HEIGHT , SCREEN_WIDTH, 33);
        _chatToolBar.isPrivateChat = NO;
        _liveBottomView.imageviewRound.hidden = YES;//新消息小红点
        
    }
    if (number==4) {//私聊targetInfo和textField名称同步
        UserInfo* info =(UserInfo*)parms;
        if (_chatToolBar.isPrivateChat ) {
              self.chatToolBar.targetUserInfo = info;
            self.chatToolBar.messageCotent.text = @"";
            self.chatToolBar.messageCotent.placeholder = [NSString stringWithFormat:@"@%@:",info.nick];
        }
    }
    if (number==5) {//增加私聊信息
        
        [_priVateChatView addChatMessage:parms];
        _liveBottomView.imageviewRound.hidden = NO;//新消息小红点
    }
    if(number == 6){
//        [_priVateChatView addChatMessage:parms];
//        _publicMessages = [[PublicMessageVC alloc] init];
//        [_publicMessages addGlobalMessage:parms];

    }
    
}





@end
