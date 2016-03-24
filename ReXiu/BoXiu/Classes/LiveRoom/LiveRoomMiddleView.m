//
//  LiveRoomMiddleView.m
//  BoXiu
//
//  Created by andy on 15/6/11.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import "LiveRoomMiddleView.h"
#import "ChatBar.h"
#import "PublicMessageVC.h"
#import "PrivateMessageVC.h"
#import "SystemMessageVC.h"
#import "EWPScrollNotice.h"
#import "EWPBarrageView.h"
#import "HotStarsView.h"
#import "QueryHotStarsModel.h"
#import "LiveRoomViewController.h"
#import "GetSystemTimeModel.h"
#import "GetPraisenumModel.h"
#import "GetStarPraiseNumModel.h"
#import "GiftDataManager.h"
#import "GlobalMessageModel.h"
#import "GlobalMessageMusicModel.h"
#import "RXAlertView.h"
#import "BroadcastModel.h"
#import "GiftContainerView.h"
#import "BarrageMessageModel.h"
#import "CustomMethod.h"
#import "PublicTalkSettingModel.h"
#import "LevelUpgradeModel.h"
#import "RoomManagerModel.h"
#import "NSAttributedString+Attributes.h"
#import "AudienceHeaderView.h"

@interface LiveRoomMiddleView ()<ChatTbarDelegate,HotStarsViewDelegate,EWPTabMenuControlDataSource,EWPTabMenuControlDelegate, EWPBarrageViewDataSource, PraiseViewDelegate,UIGestureRecognizerDelegate>


@property (nonatomic,strong) NSMutableArray *tabMenuTitles; //tabMenu标题 ： 公聊，系统，私聊


@property (nonatomic,strong) UIView *praiseAnimationView; // 点赞动画

@property (nonatomic,strong) EWPScrollNotice *scrollNotice;
@property (nonatomic,strong) EWPBarrageView *barrageView;//弹幕

@property (nonatomic,strong) HotStarsView *recommendStarView;

@property (nonatomic,strong) UIControl *showOrHideTabMenuControl;


@property (nonatomic,strong) ChatBar *chatBar;

@property (nonatomic,strong) EWPButton *sendPraiseBtn;
@property (nonatomic,strong) UILabel *praiseCount;
@property (nonatomic,strong) NSTimer *getApproveTimer;

//明星直播间聊天时间限制
@property (nonatomic,strong) UILabel *startTitleLabel; //明星直播间未开播时提示
@property (nonatomic,strong) UILabel *startTimeLable;//明星直播间为开播时显示的开播时间。
@property (nonatomic,strong) NSTimer *starTimeTimer;//开播倒计时
@property (nonatomic,assign) long long timeInterval;//离开播剩余秒。

@property (nonatomic,weak,readonly) RoomInfoData *roomInfoData;

@property (nonatomic,assign) BOOL shieldGift;

//动画
@property (nonatomic,strong) NSMutableArray *giftAnimationMArray;
@property (nonatomic,strong) NSLock *giftAnimationLock;
@property (nonatomic,strong) dispatch_queue_t giftAnimationQueue;

//弹幕
@property (nonatomic,strong) NSMutableArray *barrageMessageMArray;
@property (nonatomic,strong) NSLock *barrageMessageLock;
@property (nonatomic,strong) dispatch_queue_t barrageMessageQueue;

@property (nonatomic,assign) BOOL isLiveEd;//标记是否已经开播过了

@end
@implementation LiveRoomMiddleView

- (void)initView:(CGRect)frame
{
    self.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(send)];
    singleTap.delegate = self;
    [self addGestureRecognizer:singleTap];
    
    CGFloat nYOffset = 15;
#pragma mark 将聊天区域唤醒
    _showOrHideTabMenuControl = [[UIControl alloc] initWithFrame:CGRectMake(0, nYOffset, SCREEN_WIDTH, 240)];
    [_showOrHideTabMenuControl addTarget:self action:@selector(OnShowTabMenu) forControlEvents:UIControlEventAllEvents];
    //    _showOrHideTabMenuControl.backgroundColor  =[UIColor redColor];
    [self addSubview:_showOrHideTabMenuControl];
    nYOffset += 240;
    
    //跑马灯，加载房间最顶端
    _scrollNotice = [[EWPScrollNotice alloc] initWithFrame:CGRectMake(0, 75+18, SCREEN_WIDTH, 35) message:nil inParrentView:self];
    _scrollNotice.linkColor = [CommonFuction colorFromHexRGB:@"FFFFFF"];
    _scrollNotice.hidden = YES;
    _scrollNotice.userInteractionEnabled = NO;
    [self addSubview:_scrollNotice];
    
    //弹幕
    _barrageMessageMArray = [NSMutableArray array];
    _barrageMessageLock = [[NSLock alloc] init];
    _barrageMessageQueue = dispatch_queue_create("barrageMessageQueue", DISPATCH_QUEUE_SERIAL);
    
    //弹幕，加载房间视频区域最底端
    _barrageView = [[EWPBarrageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_scrollNotice.frame) + 15, frame.size.width, 110) showInView:self];
    _barrageView.textColors = [NSMutableArray arrayWithObjects:
                               //                               [CommonFuction colorFromHexRGB:@"ff6666"],
                               //                               [CommonFuction colorFromHexRGB:@"e4c155"],
                               //                               [CommonFuction colorFromHexRGB:@"00c1b9"],
                               [UIColor whiteColor], nil];
    _barrageView.fontSize = 12.0f;
    _barrageView.dataSource = self;
    _barrageView.backgroundColor = [UIColor clearColor];//[UIColor colorWithPatternImage:[UIImage imageNamed:@"barrageMessageBK"]];
    //    _barrageView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_barrageView];
    
    //默认tabmenu标题
    //    _tabMenuTitles = [NSMutableArray arrayWithArray:@[Public_Chat_Title,Private_Chat_Title,System_Chat_Title]];
    _tabMenuTitles = [NSMutableArray arrayWithArray:@[Public_Chat_Title]];
    
    _tabMenu = [[EWPTabMenuControl alloc] initWithFrame:CGRectMake(0, 405 - 60, frame.size.width + 10,SCREEN_HEIGHT - 395 )];
    _tabMenu.dataSource = self;
    _tabMenu.delegate   = self;
    _tabMenu.backgroundColor = [UIColor clearColor];
    _tabMenu.defaultSelectedSegmentIndex = 0;
    [self addSubview:_tabMenu];
    
    //滑动视图
    [_tabMenu reloadData];
    [self initPraiseAnimationView];
    [self performSelector:@selector(setHide) withObject:self afterDelay:2.0f];
    
    
    [self initBottomView];//公聊，私聊，系统，聊天，送礼，点赞按钮，本房间暂无直播#######################
//    [self showTableBarMenu];
    [self showChatView];
}

-(void)send
{
    [AppInfo shareInstance].send = 1;
    [self sendApprove];
}
#pragma mark UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    //放过OHAttributedLabel点击拦截
    
    if ([touch.view isKindOfClass:[OHAttributedLabel class]]) {
        [AppInfo shareInstance].send = 0;
        return NO;
    }
    return YES;
}

- (void)initPraiseAnimationView//点赞动画
{
    _praiseAnimationView = [[UIView alloc] initWithFrame:CGRectMake(_tabMenu.frame.size.width, _tabMenu.frame.origin.y, self.frame.size.width - _tabMenu.frame.size.width, _tabMenu.frame.size.height)];
    _praiseAnimationView.backgroundColor = [UIColor redColor];
    [self addSubview:_praiseAnimationView];
}
#pragma mark>>>>>>>>>>>>>>>>>>>>>>>>>>>点击发言---聊天----送礼>>>>>>>>>>>>>>>>>>>>>>>>>>>
- (void)initBottomView//公聊，私聊，系统，聊天，送礼，点赞按钮，本房间暂无直播
{
    if (_chatBar == nil)
    {
        _chatBar = [[ChatBar alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 80, SCREEN_WIDTH, 80) showInView:self];
        _chatBar.hidden = YES;
        _chatBar.delegate = self;
        [self addSubview:_chatBar];
    }
    
    if (_bottomView == nil)
    {
        //底端view
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 55, SCREEN_WIDTH, 60)];
        [self addSubview:_bottomView];
        
        //点赞 和赞飘起来的位置
        _sendPraiseBtn = [EWPButton buttonWithType:UIButtonTypeCustom];
        _sendPraiseBtn.frame = CGRectMake(255, 10, 34, 34);
        [_sendPraiseBtn setImage:[UIImage imageNamed:@" "] forState:UIControlStateNormal];
        _sendPraiseBtn.adjustsImageWhenHighlighted = NO;
        [_bottomView addSubview:_sendPraiseBtn];
        
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showBarAndChatView) name:ShowBarAndChat object:nil];
}


- (void)showTableBarMenu//显示聊天区域上方，SegmentedControl，3秒后隐藏
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [UIView animateKeyframesWithDuration:0.5f delay:0 options:UIViewKeyframeAnimationOptionBeginFromCurrentState animations:^{
        self.tabMenu.ewpSegmentedControl.alpha = 1;
    } completion:^(BOOL finished) {
        [self performSelector:@selector(hideTableBarMenu) withObject:nil afterDelay:3];
    }];
    
}

- (void)showChatView//显示聊天区域内容tabMenu，8秒后隐藏
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [UIView animateKeyframesWithDuration:0.5f delay:0 options:UIViewKeyframeAnimationOptionBeginFromCurrentState animations:^{
        self.tabMenu.alpha = 1;
    } completion:^(BOOL finished) {
//        [self performSelector:@selector(hideChatView) withObject:nil afterDelay:8];
    }];
    //    popMenuTitles
}

- (void)hideTableBarMenu
{
    [UIView animateKeyframesWithDuration:0.5f delay:0 options:UIViewKeyframeAnimationOptionBeginFromCurrentState animations:^{
        self.tabMenu.ewpSegmentedControl.alpha = 0;
    } completion:^(BOOL finished)
     {
         
     }];
}

- (void)hideChatView
{
    LiveRoomViewController* liveC = (LiveRoomViewController*)self.rootViewController;
    [liveC.poplistview dismiss];
    [UIView animateKeyframesWithDuration:0.5f delay:0 options:UIViewKeyframeAnimationOptionBeginFromCurrentState animations:^{
        self.tabMenu.alpha = 0;
    } completion:^(BOOL finished) {
        
        
    }];
}

- (void)showBarAndChatView
{

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event//全视图，点击后后显示聊天内容
{

}

- (void)initData//LiveRoom得到信息后刷新界面
{
//    //显示点赞相关,以及获取主播赞
//    [self showRoomPraiseInfo];
    
    //查询表情数据。礼物数据,如果有数据就不会再查询了
    [self queryRoomAllData];
}

#pragma mark - 点赞动画
- (void)praiseAnimation
{
    if (![AppInfo shareInstance].send) {
        return;
    }
    static int tagNumber = 500000;
    tagNumber ++;
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[self randomHeartImageName]]];
    imageView.center = CGPointMake(-5000, -5000);
    imageView.tag = tagNumber;
    //    imageView.alpha = (arc4random() % (60 + 1) + 40) / 100.0f;
    [_bottomView addSubview:imageView];
    
    // 设定为缩放
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    // 动画选项设定
    animation.duration = 0.5f; // 动画持续时间
    //    animation.autoreverses = NO; // 动画结束时执行逆动画
    animation.removedOnCompletion=NO;
    
    // 缩放倍数
    animation.fromValue = [NSNumber numberWithFloat:0.1]; // 开始时的倍率
    animation.toValue = [NSNumber numberWithFloat:1.0]; // 结束时的倍率
    
    CAKeyframeAnimation *keyAnima=[CAKeyframeAnimation animation];
    keyAnima.keyPath=@"position";
    
    //1.1告诉系统要执行什么动画
    //创建一条路径
    CGMutablePathRef path=CGPathCreateMutable();
    
    //设置一个圆的路径
    //    CGPathAddEllipseInRect(path, NULL, CGRectMake(150, 100, 100, 100));
    CGPathMoveToPoint(path, NULL, self.sendPraiseBtn.center.x, self.sendPraiseBtn.center.y);
    int controlX = (arc4random() % (100 + 1)) - 50;
    int controlY = (arc4random() % (130 + 1)) + 50;
    int entX = (arc4random() % (100 + 1)) - 50;
    CGPathAddQuadCurveToPoint(path, NULL, self.sendPraiseBtn.center.x - controlX, self.sendPraiseBtn.center.y - controlY, self.sendPraiseBtn.center.x + entX, self.sendPraiseBtn.center.y - 260);
    
    keyAnima.path=path;
    //有create就一定要有release
    CGPathRelease(path);
    //1.2设置动画执行完毕后，不删除动画
    keyAnima.removedOnCompletion=NO;
    //1.3设置保存动画的最新状态
    keyAnima.fillMode=kCAFillModeForwards;
    //1.4设置动画执行的时间
    keyAnima.duration=2.0;
    //1.5设置动画的节奏
    keyAnima.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    
    // 动画选项设定
    alphaAnimation.duration = 1.5f; // 动画持续时间
    alphaAnimation.removedOnCompletion=NO;
    
    alphaAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    alphaAnimation.toValue = [NSNumber numberWithFloat:0.1f];
    alphaAnimation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    alphaAnimation.beginTime = 0.5f;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    
    // 动画选项设定
    group.duration = 2.0;
    group.repeatCount = 1;
    group.animations = [NSArray arrayWithObjects:animation, keyAnima, alphaAnimation, nil];
    group.delegate = self;
    
    [group setValue:[NSNumber numberWithInteger:tagNumber] forKey:@"animationName"];
    
    [imageView.layer addAnimation:group forKey:@"wendingding"];
}

- (NSString *)randomHeartImageName
{
    NSInteger number = arc4random() % (4 + 1);
    NSString *randomImageName;
    switch (number) {
        case 1:
            randomImageName = @"bHeart";
            break;
        case 2:
            randomImageName = @"gHeart";
            break;
        case 3:
            randomImageName = @"rHeart";
            break;
        case 4:
            randomImageName = @"yHeart";
            break;
        default:
            randomImageName = @"bHeart";
            break;
    }
    return randomImageName;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    //    NSLog(@"anim.tag:%@", [anim defaultValueForKey]);
    
    //    NSString *s = objc_getAssociatedObject(anim, &associatedkey);
    
    //    NSLog(@"anim:%@ ld:%ld", anim, anim.tag);
    
    NSNumber *number = [anim valueForKey:@"animationName"];
    NSInteger tag = [number integerValue];
    NSLog(@"%ld",(long)tag);
    UIView *view = [self viewWithTag:tag];
    [view removeFromSuperview];
}

- (RoomInfoData *)roomInfoData
{
    LiveRoomViewController *liveRoomViewController = (LiveRoomViewController *)self.rootViewController;
    return liveRoomViewController.roomInfoData;
}

- (void)addPraiseView
{
    self.praiseView = [[PraiseView alloc] initWithFrame:CGRectMake(0, 0, 36, 36)];
    self.praiseView.center = CGPointMake(self.sendPraiseBtn.frame.size.width / 2, self.sendPraiseBtn.frame.size.height / 2);
    self.praiseView.delegate = self;
    [self.sendPraiseBtn addSubview:self.praiseView];
    
    [self.sendPraiseBtn bringSubviewToFront:self.praiseCount];
}

- (void)sendApprove
{
    
    if ([self.delegate respondsToSelector:@selector(praiseAction:)])
    {
        if ([self.delegate praiseAction:self])
        {
//            [self praiseAnimation];
        }
        
    }
}

#pragma mark - 显示或隐藏
- (void)OnShowTabMenu
{
    if (_tabMenu)
    {
        _tabMenu.hideSegmentedControl = !_tabMenu.hideSegmentedControl;
        _tabMenu.hideSegmentedControl = NO;
        _tabMenu.alpha = 1;
        [self performSelector:@selector(setHide) withObject:self afterDelay:5.0f];
    }
}

-(void) setHide
{
    BOOL reult = [[NSUserDefaults standardUserDefaults] boolForKey:@"hideChat"];
    if (reult) {
        _tabMenu.hideSegmentedControl =  YES;
        [UIView animateWithDuration:1.0f animations:^{_tabMenu.alpha = 0;}];
    }
}

#pragma mark - ChatBarDelegate
- (void)tapOutViewOfChatBar:(ChatBar *)chatBar
{
    if (chatBar)     {
        if (!_bottomView.hidden)
        {
            _bottomView.hidden = YES;
            _chatBar.hidden = NO;
        }
        else
        {
            _bottomView.hidden = NO;
            _chatBar.hidden = YES;
        }
        
    }
}

- (void)chatTbarSendAction:(ChatBar *)charBar
{
    if (charBar)
    {
        charBar.text;
    }
}

#pragma mark - EWPTabMenuControlDataSource
- (EWPSegmentedControl *)ewpSegmentedControl
{
    EWPSegmentedControl *segmentedControl = [[EWPSegmentedControl alloc] initWithSectionTitles:self.tabMenuTitles];
    segmentedControl.frame = CGRectMake(0, 0, self.frame.size.width / 2+15, 30);
    segmentedControl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    segmentedControl.backgroundColor = [UIColor clearColor];
    segmentedControl.textColor = [CommonFuction colorFromHexRGB:@"ffffff"];
    segmentedControl.selectionStyle = EWPSegmentedControlSelectionStyleTextWidthStripe;
    segmentedControl.selectionIndicatorLocation = EWPSegmentedControlSelectionIndicatorLocationDown;
    segmentedControl.selectionIndicatorColor = [UIColor clearColor];
    segmentedControl.selectedTextColor = [CommonFuction colorFromHexRGB:@"f7c250"];
    segmentedControl.selectionIndicatorHeight = 2.0f;
    segmentedControl.font = [UIFont boldSystemFontOfSize:13.0f];
    segmentedControl.indicatorBKColor = [UIColor clearColor];
    
    segmentedControl.segmentEdgeInset = UIEdgeInsetsMake(0,0,0,0);
    segmentedControl.segmentWidthStyle = EWPSegmentedControlSegmentWidthStyleEqually;
    segmentedControl.showShadow = YES;
    
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
            viewController = [[PublicMessageVC alloc] init];
            //            [self performSelector:@selector(hideView:) withObject:viewController afterDelay:5];
        }
        else if([tabMenuTitle isEqualToString:System_Chat_Title])
        {
            viewController = [[SystemMessageVC alloc] init];
            //            [self performSelector:@selector(hideView:) withObject:viewController afterDelay:5];
        }
        else if ([tabMenuTitle isEqualToString:Private_Chat_Title])
        {
            viewController = [[PrivateMessageVC alloc] init];
            //            [self performSelector:@selector(hideView:) withObject:viewController afterDelay:5];
        }
        [_tabMenuContentViewControllers setObject:viewController forKey:tabMenuTitle];
    }
}

- (void)setRootViewController:(BaseViewController *)rootViewController
{
    [super setRootViewController:rootViewController];
    
    
    
    PrivateMessageVC *privateViewController = [self.tabMenuContentViewControllers objectForKey:Private_Chat_Title];
    privateViewController.rootViewController = self.rootViewController;
    
    PublicMessageVC *publicViewController = [self.tabMenuContentViewControllers objectForKey:Public_Chat_Title];
    publicViewController.rootViewController = self.rootViewController;
    
    SystemMessageVC *systemViewController = [self.tabMenuContentViewControllers objectForKey:System_Chat_Title];
    systemViewController.rootViewController = self.rootViewController;
}

//-(void)hideView: (UIViewController *)viewController
//{
////    viewController.view.alpha = 0;
//    [UIView animateWithDuration:.5f animations:^{viewController.view.alpha = 0;}];
//}


#pragma mark - EWPTabMenuControlDelegate

- (void)progressEdgePanGestureRecognizer:(UIPanGestureRecognizer *)panGestureRecognizer tabMenuOfIndex:(NSInteger)index
{

}

#pragma mark - 界面跳转
- (void )pushCanvas:(NSString *) canvasName withArgument:(id)argumentData
{
    LiveRoomViewController *liveRoomViewController = (LiveRoomViewController *)self.rootViewController;
    if (liveRoomViewController)
    {
        [liveRoomViewController pushCanvas:canvasName withArgument:argumentData];
    }
}


#pragma mark - 处理全局消息
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
            PublicMessageVC *publicViewController = [self.tabMenuContentViewControllers objectForKey:Public_Chat_Title];
            if (publicViewController)
            {
                [publicViewController addGlobalMessage:model];
                
                
            }
            
            SystemMessageVC *systemViewController = [self.tabMenuContentViewControllers objectForKey:System_Chat_Title];
            if (systemViewController)
            {
                [systemViewController addGlobalMessage:model];
            }
            
        }
            break;
        case 10:
        {
            [self progressGlobalGiftInfo:bodyDic];
        }
            break;
        case 24:
        {
            [self progressGlobalLuckyGiftInfo:bodyDic];
            PublicMessageVC *publicViewController = [self.tabMenuContentViewControllers objectForKey:Public_Chat_Title];
            if (publicViewController)
            {
                [publicViewController addGlobalLuckyGiftMessage:bodyDic];
            }
            
            SystemMessageVC *systemViewController = [self.tabMenuContentViewControllers objectForKey:System_Chat_Title];
            if (systemViewController)
            {
                [systemViewController addGlobalLuckyGiftMessage:bodyDic];
            }
        }
            break;
        case 40:
        {
            [self progressGlobalSofaInfo:bodyDic];
        }
            break;
        case 52:
        {
//            //歌曲投票超过 5000 热币
//            [self progressGlobalMusicInfo:bodyDic];
        }
            break;
        default:
            break;
    }
}

#pragma mark - 处理房间消息
- (void)receiveRoomMessage:(NSNotification *)notification
{
    [AppInfo shareInstance].history ++;
    PublicMessageVC *publicViewController = [self.tabMenuContentViewControllers objectForKey:Public_Chat_Title];
    if ([UserInfoManager shareUserInfoManager].currentStarInfo.userId == [UserInfoManager shareUserInfoManager].currentUserInfo.userId) {
        if ([AppInfo shareInstance].history == 1) {
            NSMutableDictionary *param = [NSMutableDictionary dictionary];
            [param setObject:[NSNumber numberWithInt:3] forKey:@"chatType"];
            [param setObject:@" " forKey:@"nick"];
            if ([UserInfoManager shareUserInfoManager].currentStarInfo.introduction == nil) {
                [param setObject:@"欢迎来我的直播间！" forKey:@"msg"];
            }else{
                [param setObject:[UserInfoManager shareUserInfoManager].currentStarInfo.roomad forKey:@"msg"];
            }
            [param setObject:@" " forKey:@"href"];
            GlobalMessageModel *model = [[GlobalMessageModel alloc] initWithData:param];
            [publicViewController addGlobalMessage:model];
        }

    }else if (notification == nil) {
        //        在获取历史聊天信息的时候加载一下房间公告
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param setObject:[NSNumber numberWithInt:3] forKey:@"chatType"];
        [param setObject:@" " forKey:@"nick"];
        if ([UserInfoManager shareUserInfoManager].currentStarInfo.introduction == nil) {
            [param setObject:@"欢迎来我的直播间！" forKey:@"msg"];
        }else{
            [param setObject:[UserInfoManager shareUserInfoManager].currentStarInfo.roomad forKey:@"msg"];
        }
        [param setObject:@" " forKey:@"href"];
        GlobalMessageModel *model = [[GlobalMessageModel alloc] initWithData:param];
        [publicViewController addGlobalMessage:model];
    }
    
    NSDictionary *bodyDic = [notification userInfo];
    EWPLog(@"bodyDic = %@",bodyDic);
    NSInteger chatType = [[bodyDic objectForKey:@"chatType"] integerValue];
    switch (chatType)
    {
        case 1:
        case 2:
        {
            ChatMessageModel *model = [[ChatMessageModel alloc] initWithData:bodyDic];
            
            if(model.result == -1)
            {
                if(model.userid == [UserInfoManager shareUserInfoManager].currentUserInfo.userId && model.unspeak==1)
                {
                    [self showMarketDialogWithTitle:nil message:@"亲，你已经被禁言了，如果想说话，请提升VIP哦！" buyVipBlock:nil cancelBlock:nil];//商城对话
                }
            }
            else
            {
                [self addChatMember:bodyDic];
                
                
                if (model.chatType == 1)
                {
                    if (publicViewController)
                    {
                        [publicViewController addChatMessage:model];
                        
                    }

                }
                else
                {
                    
                    
                    UserInfo *userInfo = [UserInfoManager shareUserInfoManager].currentUserInfo;
                    if (model.targetUserid == userInfo.userId || model.userid == userInfo.userId)
                    {
                         LiveRoomViewController* lr = (LiveRoomViewController*)self.rootViewController;
                        [lr lrTaskNumberWithParms:model withMumber:5];
                    }
                    
//                    PublicMessageVC *publicViewController = [self.tabMenuContentViewControllers objectForKey:Public_Chat_Title];
//                    if (publicViewController)
//                    {
//                        [publicViewController addChatMessage:model];
//                    }
                }
            }
        }
            break;
        case 6:
        case 7:
        {
            BroadcastModel *model = [[BroadcastModel alloc] initWithData:bodyDic];
            if (model.staruserid != [UserInfoManager shareUserInfoManager].currentStarInfo.userId)
            {
                return;
            }
            
            if (model.chatType == 6)
            {
                PublicMessageVC *publicViewController = [self.tabMenuContentViewControllers objectForKey:Public_Chat_Title];
                if (publicViewController)
                {
//                    [publicViewController addMessage:@"Star 开播了"];
                }
                
                SystemMessageVC *systemViewController = [self.tabMenuContentViewControllers objectForKey:System_Chat_Title];
                if (systemViewController)
                {
//                    [systemViewController addMessage:@"Star 开播了"];
                }
                LiveRoomViewController *liveRoomViewController = (LiveRoomViewController *)self.rootViewController;
                liveRoomViewController.isZhiBoIng = YES;
                liveRoomViewController.staruserid = model.staruserid;
                liveRoomViewController.showid = model.showid;
                liveRoomViewController.livestream = model.livestream;
                liveRoomViewController.serverip = model.serverip;
                
                if (!liveRoomViewController.phoneLiving) {
                    [liveRoomViewController reEnterRoom:YES];
                }
                
            }
            else if (model.chatType == 7)
            {
                
                //主播停播
                PublicMessageVC *publicViewController = [self.tabMenuContentViewControllers objectForKey:Public_Chat_Title];
                if (publicViewController)
                {
                    [publicViewController addMessage:@"Star 停播了"];
                }
                
                SystemMessageVC *systemViewController = [self.tabMenuContentViewControllers objectForKey:System_Chat_Title];
                if (systemViewController)
                {
                    [systemViewController addMessage:@"Star 停播了"];
                }
                LiveRoomViewController *liveRoomViewController = (LiveRoomViewController *)self.rootViewController;
                liveRoomViewController.isZhiBoIng = NO;
                [liveRoomViewController stopPlay];
                
                if ([liveRoomViewController phoneLiving] || liveRoomViewController.isZhiBoIng   ) {
                    [liveRoomViewController stopPlayingautoExitRoom];
                    
                }else {
                    [liveRoomViewController lrTaskNumberWithParms:nil withMumber:2];
                }
                //                [self.rootViewController stopPlay];
            }
        }
            break;
        case 11:
        {
            //踢人
            NotifyMessageModel *model = [[NotifyMessageModel alloc] initWithData:bodyDic];
            model.msg = [NSString stringWithFormat:@"{%ld}被{%ld}踢出了本房间！",(long)model.touserid,(long)model.fromuserid];
            PublicMessageVC *publicViewController = [self.tabMenuContentViewControllers objectForKey:Public_Chat_Title];
            if (publicViewController)
            {
                [publicViewController addRoomMessage:model];
            }
            
            SystemMessageVC *systemViewController = [self.tabMenuContentViewControllers objectForKey:System_Chat_Title];
            if (systemViewController)
            {
                [systemViewController addRoomMessage:model];
            }
            
            if(model.touserid == [UserInfoManager shareUserInfoManager].currentUserInfo.userId)
            {
                //有空把这两个合并在一起
                NSDictionary *dictionary = [[UserInfoManager shareUserInfoManager] allUserIdAndNick];
                NSString *toUser = [dictionary objectForKey:[NSNumber numberWithInteger:model.touserid]];
                NSString *fromUser = [dictionary objectForKey:[NSNumber numberWithInteger:model.fromuserid]];
                //                        NSString *message = [NSString stringWithFormat:@"%@被%@踢出了本房间",toUser,fromUser];
                NSString *message = [NSString stringWithFormat:@"您已被%@踢出了本房间",fromUser];
                LiveRoomViewController *liveRoomViewController = (LiveRoomViewController *)self.rootViewController;
                [liveRoomViewController autoExitRoom];
                [self.rootViewController showNoticeInWindow:message];
                [self.rootViewController performSelector:@selector(popCanvasWithArgment:) withObject:nil afterDelay:2];
            }
        }
            break;
        case 12:
        {
            
            NotifyMessageModel *model = [[NotifyMessageModel alloc] initWithData:bodyDic];
            if (model.speaktype == 0)
            {
                //禁言
                model.msg = [NSString stringWithFormat:@"{%ld}被{%ld}禁言5分钟！",(long)model.touserid,(long)model.fromuserid];
            }
            else if (model.speaktype == 1)
            {
                //恢复
                model.msg = [NSString stringWithFormat:@"{%ld}被{%ld}恢复发言！",(long)model.touserid,(long)model.fromuserid];
            }
            
            //                        [self addChatMemberFromNotifyMessage:model];
            PublicMessageVC *publicViewController = [self.tabMenuContentViewControllers objectForKey:Public_Chat_Title];
            if (publicViewController)
            {
                [publicViewController addRoomMessage:model];
            }
            
            SystemMessageVC *systemViewController = [self.tabMenuContentViewControllers objectForKey:System_Chat_Title];
            if (systemViewController)
            {
                [systemViewController addRoomMessage:model];
            }
            
        }
            break;
        case 13:
        {
            //公聊设置
            PublicTalkSettingModel *model = [[PublicTalkSettingModel alloc] initWithData:bodyDic];
            self.roomInfoData.publictalkstatus = model.publictalkstatus;
        }
            break;
        case 14:
        {
            //关注消息
            AttentionNotifyModel *model = [[AttentionNotifyModel alloc] initWithData:bodyDic];
            if (model)
            {
                PublicMessageVC *publicViewController = [self.tabMenuContentViewControllers objectForKey:Public_Chat_Title];
                if (publicViewController)
                {
                    [publicViewController addAttionNotifyMessage:model];
                }
                
                SystemMessageVC *systemViewController = [self.tabMenuContentViewControllers objectForKey:System_Chat_Title];
                if (systemViewController)
                {
                    [systemViewController addAttionNotifyMessage:model];
                }
            }
        }
            break;
        case 20:
        {
            //成为黄冠粉丝提醒
            CrownModel *model = [[CrownModel alloc] initWithData:bodyDic];
            if (model)
            {
                PublicMessageVC *publicViewController = [self.tabMenuContentViewControllers objectForKey:Public_Chat_Title];
                if (publicViewController)
                {
                    [publicViewController addCrownMessage:model];
                }
            }
            
            SystemMessageVC *systemViewController = [self.tabMenuContentViewControllers objectForKey:System_Chat_Title];
            if (systemViewController)
            {
                [systemViewController addCrownMessage:model];
            }
            
        }
            break;
        case 23:
        {
            LevelUpgradeModel *model = [[LevelUpgradeModel alloc] initWithData:bodyDic];
            if (model.upgradeType == 1)
            {
                //财富等级
                UserInfo *userInfo = [UserInfoManager shareUserInfoManager].currentUserInfo;
                if (userInfo.userId == model.userid)
                {
                    userInfo.consumerlevelweight = [UserInfo switchConsumerlevelweight:model.nowConsumerlevelweight];//model.nowConsumerlevelweight;
                    [UserInfoManager shareUserInfoManager].currentUserInfo = userInfo;
                }
                
                
            }
            else if (model.upgradeType == 2)
            {
                //明星等级
                StarInfo *starInfo = [UserInfoManager shareUserInfoManager].currentStarInfo;
                if (starInfo.userId == starInfo.userId)
                {
                    starInfo.starlevelid = model.nowStarlevelid;
                    [UserInfoManager shareUserInfoManager].currentStarInfo = starInfo;
                }
                
            }
        }
            break;
        case 25:
        {
            //弹幕开关设置消息
            self.roomInfoData.openflag = [[bodyDic objectForKey:@"openflag"] boolValue];
            //不要主动去修改设置
            LiveRoomViewController *liveRoomViewController = (LiveRoomViewController *)self.rootViewController;
            [liveRoomViewController chatToolBarBarageSwitchChange];
        }
            break;
        case 50:
        {
            //提升房管
            RoomManagerModel *model = [[RoomManagerModel alloc] initWithData:bodyDic];
            if (model.userid == [UserInfoManager shareUserInfoManager].currentUserInfo.userId)
            {
                [UserInfoManager shareUserInfoManager].currentUserInfo.managerflag = YES;
            }
        }
            break;
        case 51:
        {
            //解除房管
            RoomManagerModel *model = [[RoomManagerModel alloc] initWithData:bodyDic];
            if (model.userid == [UserInfoManager shareUserInfoManager].currentUserInfo.userId)
            {
                [UserInfoManager shareUserInfoManager].currentUserInfo.managerflag = NO;
            }
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
    
    PublicMessageVC *publicViewController = [self.tabMenuContentViewControllers objectForKey:Public_Chat_Title];
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
    SystemMessageVC *systemViewController = [self.tabMenuContentViewControllers objectForKey:System_Chat_Title];
    if (systemViewController)
    {
        [systemViewController addGiftInfoToChatMessage:model];
        if (self.roomInfoData.showtype == 3)
        {
            //明星直播间
            if (model.bigStargiftList && model.bigStargiftList.count > 0)
            {
                [systemViewController updateBigStarGiftRankMessage:model];
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
            //            [self.view bringSubviewToFront:_singleGiftContainerView];
            //            [self.view bringSubviewToFront:_moreGiftContainerView];
            //            [_singleGiftContainerView showGiftAnimation];
            //            [_moreGiftContainerView showGiftAnimation];
        });
    }
}


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


#pragma mark - 收到抢沙发消息
- (void)receiveSofa:(NSNotification *)notification
{
    NSDictionary *bodyDic = [notification userInfo];
    //    EWPLog(@"bodyDic = %@",bodyDic);
    //
    RobSofaModel *model = [[RobSofaModel alloc] initWithData:bodyDic];
    //    if (self.entireview && model.result == 1)
    //    {
    //        UserInfo *userInfo = [UserInfoManager shareUserInfoManager].currentUserInfo;
    //
    //        if (userInfo && userInfo.userId == model.userid)
    //        {
    //            userInfo.coin = model.usercoin;
    //            [UserInfoManager shareUserInfoManager].currentUserInfo = userInfo;
    //        }
    //        SofaData *sofaData = [[SofaData alloc] init];
    //        sofaData.num = model.num;
    //        sofaData.coin = 100;
    //        sofaData.sofano = model.sofano;
    //        sofaData.userid = model.userid;
    //        sofaData.nick = model.nick;
    //        sofaData.photo = model.photo;
    //        sofaData.hidden = model.hidden;
    //        sofaData.hiddenindex = model.hiddenindex;
    //        sofaData.issupermanager = model.issupermanager;
    //        [self.entireview setSofaData:sofaData];
    //        if (userInfo.userId ==  model.userid)
    //        {
    //            [self showNoticeInWindow:@"抢沙发成功"];
    //        }
    //
    //        PublicViewController *publicViewController = [self.tabMenuContentViewControllers objectForKey:Public_Chat_Title];
    //        if (publicViewController)
    //        {
    //            [publicViewController addSofaInfoToChatMessage:model];
    //        }
    //    }
    
    PublicMessageVC *publicViewController = [self.tabMenuContentViewControllers objectForKey:Public_Chat_Title];
    if (publicViewController)
    {
        [publicViewController addSofaInfoToChatMessage:model];
    }
    
    
}

#pragma mark - 收到错误消息
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
                //                [self showNoticeInWindow:@"未登录或者token超时"];
                //                [self performSelectorOnMainThread:@selector(autoExitRoom) withObject:nil waitUntilDone:NO];
            }
                break;
            case 102:
            {
                //输入非法
                if (msg == nil)
                {
                    msg = @"输入非法";
                }
                //                [self showNoticeInWindow:msg];
                //
            }
                break;
            case 103:
            {
                //货币冻结
                if (msg == nil)
                {
                    msg = @"货币冻结";
                }
                
                //                [self showNoticeInWindow:msg];
                
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
                //                [self showNoticeInWindow:msg];
            }
                break;
            case 4:
            {
                //                //送礼人金币不足
                //                if (self.entireview.bRobbingSofa)
                //                {
                //                    self.entireview.bRobbingSofa = NO;
                //                }
                //                [self showRechargeDialog];
            }
                break;
            case 5:
            {
                //送礼接收人不存在
                if (msg == nil)
                {
                    msg = @"送礼接收人不存在";
                }
                //                [self showNoticeInWindow:msg];
            }
                break;
            case 6:
            {
                //送礼人不存在
                if (msg == nil)
                {
                    msg = @"送礼人不存在";
                }
                //                [self showNoticeInWindow:msg];
            }
                break;
            case 11:
            {
                //被禁言提醒
                if (msg == nil)
                {
                    msg = @"您已被禁言,无法发言!";
                }
                //                [self showNoticeInWindow:msg];
            }
                break;
            case 201:
            {
                //                if (msg == nil)
                //                {
                //                    msg = @"抢沙发失败";
                //                }self.entireview.bRobbingSofa = NO;
                //                [self showNoticeInWindow:msg];
            }
                break;
            case 210:
            {
                if (msg == nil)
                {
                    msg = @"点赞失败";
                }
                //                [self showNoticeInWindow:msg];
            }
                break;
            default:
                break;
        }
    }
}

- (void)receiveApproveResult:(NSNotification *)notification
{
    NSDictionary *bodyDic = [notification userInfo];
    EWPLog(@"receiveApproveResult bodyDic = %@",bodyDic);

}

#pragma mark - 收到进入房间消息
- (void)receiveEnterRoomMessage:(NSNotification *)notification
{
    NSDictionary *bodyDic = [notification userInfo];
    EWPLog(@"bodyDic = %@",bodyDic);
    NSInteger memberCount = [[bodyDic objectForKey:@"memberCount"] longLongValue];
    NSInteger touristCount = [[bodyDic objectForKey:@"touristCount"] longLongValue];
    NSInteger sumCount = memberCount + touristCount;
    
    LiveRoomViewController* lr = (LiveRoomViewController*)self.rootViewController;

    if (sumCount<9950) {
        lr.audienceLabel.text = [NSString stringWithFormat:@"%ld",(long)sumCount];
    }
    else
    {
        lr.audienceLabel.text = [NSString stringWithFormat:@"%.1fM",(float)sumCount/10000];
    }

    UserEnterRoomModel *model = [[UserEnterRoomModel alloc] initWithData:bodyDic];
    if (model.type != 2)
    {
        //机器人用户type == 2,机器人进来不显示欢迎语
        PublicMessageVC *publicViewController = [self.tabMenuContentViewControllers objectForKey:Public_Chat_Title];
        if (publicViewController)
        {
//            公聊区显示进房间消息
            [publicViewController addUserEnterRoomMessage:model];
            [lr lrTaskNumberWithParms:model withMumber:0];
        }
        
    }
}
#pragma mark - 接受退出房间消息通知
- (void)receiveOutRoomMessage:(NSNotification *)notification
{
    NSDictionary *bodyDic = [notification userInfo];
    EWPLog(@"bodyDic = %@",bodyDic);
    NSInteger memberCount = [[bodyDic objectForKey:@"memberCount"] longLongValue];
    NSInteger touristCount = [[bodyDic objectForKey:@"touristCount"] longLongValue];
    NSInteger sumCount = memberCount + touristCount;
    
    LiveRoomViewController* lr = (LiveRoomViewController*)self.rootViewController;

    if (sumCount<9950) {
        lr.audienceLabel.text = [NSString stringWithFormat:@"%ld",(long)sumCount];
    }
    else
    {
        lr.audienceLabel.text = [NSString stringWithFormat:@"%.1fW",(float)sumCount/10000];
    }

    UserEnterRoomModel *model = [[UserEnterRoomModel alloc] initWithData:bodyDic];
    if (model.type != 2)
    {
        [lr lrTaskNumberWithParms:model withMumber:1];
        
    }
    
}

-(void)clearAllMessage{
    PublicMessageVC *publicViewController = [self.tabMenuContentViewControllers objectForKey:Public_Chat_Title];
    if (publicViewController)
    {
        [publicViewController initData:1];
    }
    
    
    PrivateMessageVC *priiewController = [self.tabMenuContentViewControllers objectForKey:Private_Chat_Title];
    if (priiewController)
    {
        [priiewController  initData];
    }
    SystemMessageVC *systemViewController = [self.tabMenuContentViewControllers objectForKey:System_Chat_Title];
    if (systemViewController)
    {
        [systemViewController  initData:1];
    }
}

#pragma mark - 首次收到点赞通知
-(void)receiveSendNotice:(NSNotification *)notification
{
    PublicMessageVC *publicViewController = [self.tabMenuContentViewControllers objectForKey:Public_Chat_Title];
    if (publicViewController)
    {
        [publicViewController receiveSendNotice:notification];
    }
}

#pragma mark - 收到弹幕消息
- (void)receiveBarageMessage:(NSNotification *)notification
{
    //    如果弹幕被屏蔽，直接返回
    //        if (_shieldBarrage == YES)
    //        {
    //            return;
    //        }
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
                barageMessage = [NSString stringWithFormat:@"{%ld}说: %@",(long)model.userid,model.content];
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
                    nick = [NSString stringWithFormat:@"%@ ",nick];
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

#pragma mark - EWPBarrageDataSource
- (NSInteger)numberOfBarrageViewItem
{
    return 5;
}

- (CGFloat)heightOfBarrageViewItem
{
    return 22.0f;
}

- (CGFloat)spaceOfBarrageViewItem
{
    return 0.0f;
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

#pragma mark - 收到切换到点歌界面消息
- (void)receiveMusicChangeMessage:(NSNotification *)notification
{
    //切换到点歌界面
    self.roomInfoData.bigstarstate = 4;
    [self initVoteMusicViewData];
    //    AudienceViewController *audieceViewController = [self.tabMenuContentViewControllers objectForKey:Audience_List_Title];
    //    if (audieceViewController)
    //    {
    //        [self updateTouristCount:audieceViewController.touristCount recordCountshowGift:audieceViewController.recordCount];
    //    }
}

#pragma mark - 收到切换到showTime得消息
- (void)receiveShowTimeChangeMessage:(NSNotification *)notification
{
    //    切换到showTime界面
    self.roomInfoData.bigstarstate = 2;
    [self initShowTimeViewData];
    
    //    AudienceViewController *audieceViewController = [self.tabMenuContentViewControllers objectForKey:Audience_List_Title];
    //    if (audieceViewController)
    //    {
    //        [self updateTouristCount:audieceViewController.touristCount recordCountshowGift:audieceViewController.recordCount];
    //    }
}

#pragma mark - 收到showtime开始的消息
- (void)receiveShowTimeBeginMessage:(NSNotification *)notification
{
    //    NSDictionary *bodyDic = [notification userInfo];
    //    EWPLog(@"bodyDic = %@",bodyDic);
    //    __block NSInteger timeSecond = [[bodyDic objectForKey:@"timeSecond"] integerValue];
    
    //    [self getServerTimeWithBlock:^(long long serverTime) {
    //        if (serverTime > 0)
    //        {
    //            long long endTime = [[bodyDic objectForKey:@"endTime"] longLongValue];
    //            timeSecond = (NSInteger)(endTime - serverTime)/1000;
    //        }
    //
    //        ShowTimeViewController *viewController = [self.tabMenuContentViewControllers objectForKey:ShowTime_Title];
    //        if (viewController)
    //        {
    //            [viewController beginShowTime:timeSecond];
    //        }
    //    }];
}

//    }
//}

#pragma mark - 处理全局礼物消息
- (void)progressGlobalGiftInfo:(NSDictionary *)dictionay
{
    GlobalMessageModel *model = [[GlobalMessageModel alloc] initWithData:dictionay];
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
        headString = [NSString stringWithFormat:@"{%ld} 送给 {%ld}",(long)model.fromuserid,(long)model.touserid];
    }
    if([AppInfo shareInstance].res_server && model.giftimg)
    {
        
        NSString *scrollMessage = [NSString stringWithFormat:@"%@ %@ 共 %ld %@",headString,model.giftname,(long)model.giftnum,model.giftunit];
        OHAttributedLabel *label = [self.scrollNotice addMessage:scrollMessage];
        NSString *yellowString = [NSString stringWithFormat:@" %ld ", (long)model.giftnum];
        NSRange greenRange = [label.attributedText.string rangeOfString:@" 送给 "];
        NSRange yellowRange = [label.attributedText.string rangeOfString:yellowString];
        
        [label addCustomLink:[NSURL URLWithString:@" 送给 "] inRange:greenRange color:[CommonFuction colorFromHexRGB:@"ffffff"]];
        [label addCustomLink:[NSURL URLWithString:yellowString] inRange:yellowRange color:[CommonFuction colorFromHexRGB:@"F7C520"]];
        label.font =[UIFont systemFontOfSize:14];
        //        NSMutableAttributedString* attString = [label.attributedText mutableCopy];
        ////        [attString setTextColor:[CommonFuction colorFromHexRGB:@"00C1B9"] range:greenRange];
        //        label.attributedText = attString;
        [_scrollNotice start];
    }
}

#pragma mark - 处理幸运礼物中奖信息
//幸运礼物中奖通知
- (void)progressGlobalLuckyGiftInfo:(NSDictionary *)dictionay
{
    GlobaMessageLuckyModel *model = [[GlobaMessageLuckyModel alloc] initWithData:dictionay];
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
        if (headString)
        {
            [self.scrollNotice addMessage:headString];
            [_scrollNotice start];
        }
        
    }
}

#pragma mark - 处理全局沙发信息
- (void)progressGlobalSofaInfo:(NSDictionary *)dictionay
{
    GlobalMessageModel *model = [[GlobalMessageModel alloc] initWithData:dictionay];
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



#pragma mark -查询更房间有关的数据
- (void)queryRoomAllData
{
    [[GiftDataManager shareInstance] queryGiftData];
    [[EmotionManager shareInstance] queryAllEmotion];
}


#pragma mark - 更新用户聊天成员信息
- (void)addChatMember:(NSDictionary *)dictionay
{
    ChatMessageModel *model = [[ChatMessageModel alloc] initWithData:dictionay];
    if (model.userid != 0 && [model.nick length] > 0)
    {
        UserInfo *userInfo = [[UserInfo alloc] init];
        userInfo.userId = model.userid;
        userInfo.nick = model.nick;
        userInfo.hidden = model.hidden;
        userInfo.hiddenindex = model.hiddenindex;
        userInfo.issupermanager = model.issupermanager;
        userInfo.staruserid = model.staruserid;
        userInfo.photo = model.photo;
        userInfo.isYellowVip = model.isYellowVip;
        userInfo.isPurpleVip = model.isPurpleVip;
        userInfo.userStarlevelid = model.starlevelid;
        userInfo.consumerlevelweight = model.consumerlevelweight;
        [[UserInfoManager shareUserInfoManager] addMemberInfo:userInfo];
    }
    
    if (model.targetUserid != 0 && [model.targetNick length] > 0)
    {
        UserInfo *userInfo = [[UserInfo alloc] init];
        userInfo.userId = model.targetUserid;
        userInfo.nick = model.targetNick;
        userInfo.hidden = model.thidden;
        userInfo.hiddenindex = model.thiddenindex;
        userInfo.issupermanager = model.tissupermanager;
        userInfo.staruserid = model.staruserid;
        userInfo.photo = model.photo;
        userInfo.isYellowVip = model.isYellowVip;
        userInfo.isPurpleVip = model.isPurpleVip;
        userInfo.userStarlevelid = model.starlevelid;
        userInfo.consumerlevelweight = model.consumerlevelweight;
        [[UserInfoManager shareUserInfoManager] addMemberInfo:userInfo];
    }
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
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
