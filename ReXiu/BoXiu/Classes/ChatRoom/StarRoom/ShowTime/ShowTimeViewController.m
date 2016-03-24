//
//  ShowTimeViewController.m
//  BoXiu
//
//  Created by tongmingyu on 15-1-22.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import "ShowTimeViewController.h"
#import "ChatRoomViewController.h"
#import "UserInfoManager.h"
#import "GetShowTimeStateModel.h"
#import "ShowTimeEndModel.h"
#import "ShowTimeDataModel.h"
#import "SendShowTimeApproveModel.h"
#import "ShowtimeItemView.h"

@interface ShowTimeViewController ()

@property (nonatomic,strong) UIImageView *bgImgView;
@property (nonatomic,strong) UILabel *clockTime;  //点赞倒计时
@property (nonatomic,strong) UILabel *mysendPraise;
@property (nonatomic,strong) UILabel *coinCount;
@property (nonatomic,strong) UIView *chargeView;

@property (nonatomic,strong) NSTimer *showTimeTimer;  //showtime 倒计时
@property (nonatomic,assign) NSInteger timeSecond;

@property (nonatomic,strong) ShowtimeItemView *firstItemView;
@property (nonatomic,strong) ShowtimeItemView *secondItemView;
@property (nonatomic,strong) ShowtimeItemView *thirdItemView;
@property (nonatomic,strong) ShowtimeItemView *luckItemView;

@property (nonatomic,strong) ShowTimeDataModel *showTimeDataModel;//保存tcp实时发过来的数据，每次更新

@property (nonatomic,strong) NSMutableArray *luckNickMArray;

@property (nonatomic,assign) NSInteger showtimeStatus;//0:未开始；1：正在进行；2：已结束

@property (nonatomic,assign) NSTimer *luckTimer;

@end

@implementation ShowTimeViewController

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
    // Do any additional setup after loading the view.
    
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.bounces = NO;
    self.scrollView.delaysContentTouches = NO;
    
    _bgImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _bgImgView.image = [UIImage imageNamed:@"musicBg"];
    [self.scrollView addSubview:_bgImgView];
    
    UIImageView *clockImgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 16, 16)];
    clockImgView.image = [UIImage imageNamed:@"clocktime"];
    [self.scrollView addSubview:clockImgView];
    
    _clockTime = [[UILabel alloc] initWithFrame:CGRectMake(40, 9, 90, 20)];
    _clockTime.text = @"00:00";
    _clockTime.textColor = [CommonFuction colorFromHexRGB:@"575757"];
    _clockTime.font = [UIFont boldSystemFontOfSize:13.0f];
    [self.scrollView addSubview:_clockTime];
    
    _mysendPraise = [[UILabel alloc] initWithFrame:CGRectMake(100, 11, 200, 20)];
    _mysendPraise.text = @"我的送赞个数 0";
    _mysendPraise.textColor = [CommonFuction colorFromHexRGB:@"939393"];
    _mysendPraise.textAlignment = NSTextAlignmentRight;
    _mysendPraise.font = [UIFont systemFontOfSize:11.0f];
    [self.scrollView addSubview:_mysendPraise];
    
    _firstItemView = [[ShowtimeItemView alloc] initShowTimeWithFrame:CGRectMake(15, 10 + clockImgView.frame.origin.y + 20, 291, 28) title:@"点赞圣手：" praiseImgName:@"sage"];
    _firstItemView.needBold = YES;
    [self.scrollView addSubview:_firstItemView];
    
    _secondItemView = [[ShowtimeItemView alloc] initShowTimeWithFrame:CGRectMake(15, 10 + _firstItemView.frame.origin.y + 33, 291, 28) title:@"点赞高手：" praiseImgName:@"hightHander"];
    [self.scrollView addSubview:_secondItemView];
    
    _thirdItemView = [[ShowtimeItemView alloc] initShowTimeWithFrame:CGRectMake(15, 10 + _secondItemView.frame.origin.y + 33, 291, 28) title:@"点赞达人：" praiseImgName:@"master"];
    [self.scrollView addSubview:_thirdItemView];
    
    _luckItemView = [[ShowtimeItemView alloc] initShowTimeWithFrame:CGRectMake(15, 10 + _thirdItemView.frame.origin.y + 33, 291, 28) title:@"点赞幸运儿：" praiseImgName:@"luckys"];
    _luckItemView.animateWithDuration = 0.05;
    [self.scrollView addSubview:_luckItemView];
    
    UILabel *speedParise = [[UILabel alloc] initWithFrame:CGRectMake(18, 10 + _luckItemView.frame.origin.y + 38, 90, 20)];
    speedParise.text = @"加速点赞:";
    speedParise.textColor = [CommonFuction colorFromHexRGB:@"ffffff"];
    speedParise.font = [UIFont systemFontOfSize:12.0f];
    [self.scrollView addSubview:speedParise];
    
    UIImage *pariseNormalImg = [CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"ffffff" alpha:0.5] size:CGSizeMake(95, 34)];
    UIImage *pariseHightImg = [CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"000000" alpha:0.5] size:CGSizeMake(95, 34)];
    
    UIButton *starBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    starBtn.frame  = CGRectMake(107, 10 + _luckItemView.frame.origin.y + 30, 95, 34);
    starBtn.tag = 2;//加10个赞
    [starBtn.layer setMasksToBounds:YES];
    [starBtn.layer setCornerRadius:2.0f];
    [starBtn setImage:pariseNormalImg forState:UIControlStateNormal];
    [starBtn setImage:pariseHightImg forState:UIControlStateHighlighted];
    [starBtn addTarget:self action:@selector(clickPraise:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:starBtn];
    
    UIImageView *starImg = [[UIImageView alloc] initWithFrame:CGRectMake(8, 5, 24, 24)];
    starImg.image = [UIImage imageNamed:@"starParise"];
    [starBtn addSubview:starImg];
    
    speedParise = [[UILabel alloc] initWithFrame:CGRectMake(38, 2, 50, 30)];
    speedParise.text = @"100热币 + 10赞";
    speedParise.textColor = [CommonFuction colorFromHexRGB:@"ffffff"];
    speedParise.font = [UIFont systemFontOfSize:11.0f];
    speedParise.numberOfLines = 0;
    speedParise.lineBreakMode = NSLineBreakByWordWrapping;
    [starBtn addSubview:speedParise];
    
    
    UIButton *sunBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sunBtn.frame  = CGRectMake(208, 10 + _luckItemView.frame.origin.y + 30, 95, 34);
    sunBtn.tag = 3;//加100个赞
    [sunBtn.layer setMasksToBounds:YES];
    [sunBtn.layer setCornerRadius:2.0f];
    [sunBtn setImage:pariseNormalImg forState:UIControlStateNormal];
    [sunBtn setImage:pariseHightImg forState:UIControlStateHighlighted];
    [sunBtn addTarget:self action:@selector(clickPraise:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:sunBtn];
    
    UIImageView *sunImg = [[UIImageView alloc] initWithFrame:CGRectMake(8, 5, 24, 24)];
    sunImg.image = [UIImage imageNamed:@"sun"];
    [sunBtn addSubview:sunImg];
    
    speedParise = [[UILabel alloc] initWithFrame:CGRectMake(38, 2, 50, 30)];
    speedParise.text = @"1000热币 + 100赞";
    speedParise.textColor = [CommonFuction colorFromHexRGB:@"ffffff"];
    speedParise.font = [UIFont systemFontOfSize:11.0f];
    speedParise.numberOfLines = 0;
    speedParise.lineBreakMode = NSLineBreakByWordWrapping;
    [sunBtn addSubview:speedParise];
    
    
    _chargeView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.scrollView addSubview:_chargeView];
    
    UIImageView *coinImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, 14, 15, 15)];
    coinImg.image = [UIImage imageNamed:@"rebi"];
    [_chargeView addSubview:coinImg];
    
    _coinCount = [[UILabel alloc] initWithFrame:CGRectMake(36, 15, 150, 15)];
    _coinCount.textColor = [CommonFuction colorFromHexRGB:@"f7c250"];
    _coinCount.textAlignment = NSTextAlignmentLeft;
    _coinCount.font = [UIFont systemFontOfSize:12.0f];
    _coinCount.text = @"0";
    [_chargeView addSubview:_coinCount];
    
    UIButton *rechargeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rechargeBtn.frame = CGRectMake(230, 10.5, 68, 25);
    [rechargeBtn setTitleColor:[CommonFuction colorFromHexRGB:@"f7c250"] forState:UIControlStateNormal];
    [rechargeBtn setTitle:@"充值" forState:UIControlStateNormal];
    rechargeBtn.layer.cornerRadius = 4;
    rechargeBtn.layer.cornerRadius = 12.5;
    rechargeBtn.layer.masksToBounds = YES;
    rechargeBtn.layer.borderWidth = 0.5;
    rechargeBtn.layer.borderColor = [CommonFuction colorFromHexRGB:@"f7c250"].CGColor;
    rechargeBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    [rechargeBtn addTarget:self action:@selector(goToRecharge) forControlEvents:UIControlEventTouchUpInside];
    [_chargeView addSubview:rechargeBtn];
}

- (void)viewWillLayoutSubviews
{
    self.scrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.bgImgView.frame = CGRectMake(0, 0, self.view.frame.size.width, 253);
    self.chargeView.frame = CGRectMake(0, self.bgImgView.frame.size.height, self.view.frame.size.width,43);
    
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.bgImgView.frame.size.height + self.chargeView.frame.size.height);
}

- (void)viewWillAppear:(BOOL)animated
{
    //监听是否触发home键挂起程序.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationWillResignActive:)
                                                 name:UIApplicationWillResignActiveNotification
                                               object:[UIApplication sharedApplication]];
}

- (void)viewWillDisappear:(BOOL)animated
{
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillResignActiveNotification object:[UIApplication sharedApplication]];
}

//第一次进来要判断showtime的状态，以及处理响应的数据
- (void)getShowTimeStateAndData
{
    GetShowTimeStateModel *model = [[GetShowTimeStateModel alloc] init];
    ChatRoomViewController *chatRoomViewController = (ChatRoomViewController*)self.rootViewController;
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObject:[NSNumber numberWithInteger:chatRoomViewController.roomInfoData.showid] forKey:@"showId"];
    StarInfo *starInfo = [UserInfoManager shareUserInfoManager].currentStarInfo;
    NSString *serverIp= [NSString stringWithFormat:@"http://%@:%ld/mobile/dispatch.mobile",starInfo.serverip,(long)starInfo.serverport];
    if (starInfo.serverip == nil)
    {
        serverIp = [AppInfo shareInstance].requestServerBaseUrl;
    }
    [param addEntriesFromDictionary:[model signParamWithMethod:Get_ShowTimeState_Method]];
    [model requestDataWithBaseUrl:serverIp requestType:nil method:Get_ShowTimeState_Method httpHeader:[model httpHeaderWithMethod:Get_ShowTimeState_Method] params:param success:^(id object)
     {
         if (model.result == 0)
         {
             if (model.status == 0)
             {
                 self.showtimeStatus = 0;
             }
             else if (model.status == 1)
             {
                 self.showtimeStatus = 1;
                 chatRoomViewController.showTimeInProgress = YES;
                 
                 long long leftoverTime = model.endTime - model.serverTime;
                 _timeSecond = (NSInteger)leftoverTime/1000;
                 
                 NSInteger minute = _timeSecond / 60;
                 NSInteger second = _timeSecond % 60;
                
                 _clockTime.text = [NSString stringWithFormat:@"%.2ld:%.2ld",(long)minute,(long)second];
                 
                 if (_showTimeTimer == nil)
                 {
                     _showTimeTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(OnShowTimeTimer) userInfo:nil repeats:YES];
                 }
             }
             else if (model.status == 2)
             {
                 self.showtimeStatus = 2;
                 
                 if (_luckTimer)
                 {
                     [_luckTimer invalidate];
                     _luckTimer = nil;
                 }
                 
                 //把定时器强制失效
                 if (_showTimeTimer)
                 {
                     [_showTimeTimer invalidate];
                     _showTimeTimer = nil;
                     
                     _clockTime.text = [NSString stringWithFormat:@"%.2d:%.2d",0,0];
                 }
                 
                 
                 ChatRoomViewController *chatRoomViewController = (ChatRoomViewController*)self.rootViewController;
                 if (chatRoomViewController)
                 {
                     chatRoomViewController.showTimeInProgress = NO;
                 }

                 [_firstItemView setNick:model.showTimeEndModel.firstNick praiseNum:model.showTimeEndModel.firstNum];
                 [_secondItemView setNick:model.showTimeEndModel.secondNick praiseNum:model.showTimeEndModel.secondNum];
                 [_thirdItemView setNick:model.showTimeEndModel.thirdNick praiseNum:model.showTimeEndModel.thirdNum];
                 [_luckItemView setNick:model.showTimeEndModel.luckNick praiseNum:model.showTimeEndModel.luckNum];
             }
         }
     } fail:^(id object) {
         [chatRoomViewController showNoticeInWindow:model.msg];
     }];

}

- (void)setApproveCount:(NSInteger)approveCount
{
    _approveCount = approveCount;
    if (_mysendPraise)
    {
        _mysendPraise.text = [NSString stringWithFormat:@"我的送赞个数 %ld",(long)approveCount];
    }
}

- (void)initData
{
    UserInfo *userInfo = [UserInfoManager shareUserInfoManager].currentUserInfo;
    if (userInfo)
    {
        _coinCount.text = [NSString stringWithFormat:@"%lld",userInfo.coin];
    }
    
    if (_luckNickMArray == nil)
    {
        _luckNickMArray = [NSMutableArray array];
        NSDictionary *allMemberInfo = [[UserInfoManager shareUserInfoManager] allMemberInfo];
        for (UserInfo *userInfo in [allMemberInfo allValues])
        {
            [_luckNickMArray addObject:userInfo.nick];
        }
    }

    [self getShowTimeStateAndData];
}

- (void)beginShowTime:(NSInteger)timeSecond
{
    ChatRoomViewController *chatRoomViewController = (ChatRoomViewController*)self.rootViewController;
    if (chatRoomViewController)
    {
        chatRoomViewController.showTimeInProgress = YES;
    }
    
    self.showtimeStatus = 1;
    _timeSecond = timeSecond;
    if (_showTimeTimer == nil)
    {
        _showTimeTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(OnShowTimeTimer) userInfo:nil repeats:YES];
    }
    
    NSInteger minute = timeSecond / 60;
    NSInteger second = timeSecond % 60;
    
    _clockTime.text = [NSString stringWithFormat:@"%.2ld:%.2ld",(long)minute,(long)second];
}

- (void)endShowTimeWithData:(NSDictionary *)data
{
    self.showtimeStatus = 2;
    //把定时器强制失效
    if (_showTimeTimer)
    {
        [_showTimeTimer invalidate];
        _showTimeTimer = nil;
        
        _clockTime.text = [NSString stringWithFormat:@"%.2d:%.2d",0,0];
    }
    
    if (_luckTimer)
    {
        [_luckTimer invalidate];
        _luckTimer = nil;
    }
    
    ChatRoomViewController *chatRoomViewController = (ChatRoomViewController*)self.rootViewController;
    if (chatRoomViewController)
    {
        chatRoomViewController.showTimeInProgress = NO;
    }
    
    NSDictionary *dataDic = [data objectForKey:@"data"];
    if (dataDic && [dataDic isKindOfClass:[NSDictionary class]])
    {
        //用此model解析数据
        ShowTimeEndModel *model = [[ShowTimeEndModel alloc] initWithData:dataDic];
        [_firstItemView setNick:model.firstNick praiseNum:model.firstNum];
        [_secondItemView setNick:model.secondNick praiseNum:model.secondNum];
        [_thirdItemView setNick:model.thirdNick praiseNum:model.thirdNum];
        [_luckItemView setNick:model.luckNick praiseNum:model.luckNum];
    }
 }

- (void)setShowTimeData:(NSDictionary *)data
{
    //用此model解析tcp下发的过来得数据
    ShowTimeDataModel *showTimeDataModel = [[ShowTimeDataModel alloc] initWithData:data];
    [self progressShowTimeData:showTimeDataModel];
}

- (void)receiveSendApproveResult:(NSDictionary *)data
{
    //发送赞返回结果
    SendShowTimeApproveModel *model = [[SendShowTimeApproveModel alloc] initWithData:data];
    if (model.success == 1)
    {
        [UserInfoManager shareUserInfoManager].currentUserInfo.coin = model.coin;
        _coinCount.text = [NSString stringWithFormat:@"%lld",model.coin];
        
        ChatRoomViewController *chatRoomViewController = (ChatRoomViewController*)self.rootViewController;
        if (chatRoomViewController)
        {
            chatRoomViewController.showTimeTotalApproveCount = model.num;
        }
    }
    
}

//tcp发过来的数据处理
- (void)progressShowTimeData:(ShowTimeDataModel *)showTimeDataModel
{
    ShowTimeDataModel *oldShowTimeData = _showTimeDataModel;
    self.showTimeDataModel = showTimeDataModel;
    
    ChatRoomViewController *chatRoomViewController = (ChatRoomViewController*)self.rootViewController;
    if (chatRoomViewController)
    {
        [chatRoomViewController setStarApproveCount:showTimeDataModel.totalPraiseNum];
    }
    
    if (oldShowTimeData == nil)
    {
        [_firstItemView updateNick:showTimeDataModel.firstNick praiseNum:showTimeDataModel.firstNum];
    }
    //判断点赞圣手数据是否一致，否则更新动画
    if (oldShowTimeData.firstId == showTimeDataModel.firstId)
    {
        if (oldShowTimeData.firstNum != showTimeDataModel.firstNum)
        {
            [_firstItemView updateNick:showTimeDataModel.firstNick praiseNum:showTimeDataModel.firstNum];
        }
    }
    else
    {
        [_firstItemView updateNick:showTimeDataModel.firstNick praiseNum:showTimeDataModel.firstNum];
    }
    
    //判断点赞高手数据是否一致，否则更新动画
    if (oldShowTimeData.secondId == showTimeDataModel.secondId)
    {
        if (oldShowTimeData.secondNum != showTimeDataModel.secondNum)
        {
            [_secondItemView updateNick:showTimeDataModel.secondNick praiseNum:showTimeDataModel.secondNum];
        }
    }
    else
    {
        [_secondItemView updateNick:showTimeDataModel.secondNick praiseNum:showTimeDataModel.secondNum];
    }
    
    //判断点赞达人数据是否一致，否则更新动画
    if (oldShowTimeData.thirdId == showTimeDataModel.thirdId)
    {
        if (oldShowTimeData.thirdNum != showTimeDataModel.thirdNum)
        {
            [_thirdItemView updateNick:showTimeDataModel.thirdNick praiseNum:showTimeDataModel.thirdNum];
        }
    }
    else
    {
        [_thirdItemView updateNick:showTimeDataModel.thirdNick praiseNum:showTimeDataModel.thirdNum];
        
    }
    if (showTimeDataModel.firstNick && showTimeDataModel.secondNick && showTimeDataModel.thirdNick)
    {
        [self startLuckTimer];
    }
}

- (void)startLuckTimer
{
    if (_luckTimer == nil)
    {
        _luckTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateLuckItemView) userInfo:nil repeats:YES];
    }
}

- (void)updateLuckItemView
{
    if (_luckNickMArray && _luckNickMArray.count)
    {
        //生成幸运昵称和赞数
        NSInteger randIndex = rand()%_luckNickMArray.count;
        
        NSString *luckNick = [_luckNickMArray objectAtIndex:randIndex];
        if (luckNick && _luckItemView)
        {
            [_luckItemView updateNick:luckNick praiseNum:0];
        }

    }
}

- (void)clickPraise:(id)sender
{
    UIButton *button = (UIButton *)sender;
    
    ChatRoomViewController *chatRoomViewController = (ChatRoomViewController *)self.rootViewController;
    if (chatRoomViewController == nil)
    {
        return;
    }
    
    if ([chatRoomViewController showLoginDialog])
    {
        return;
    }
    
    NSInteger costCoin = 0;
    long long coin = [UserInfoManager shareUserInfoManager].currentUserInfo.coin;
    
    if (button.tag == 2)
    {
        costCoin = 100;
    }
    else
    {
        costCoin = 1000;
    }
    
    if (coin < costCoin)
    {
        [chatRoomViewController showRechargeDialog];
        return;
    }
    else
    {
        [self sendStarApproveWithPraiseType:button.tag];
    }
}

- (void)sendStarApproveWithPraiseType:(NSInteger )praiseType
{
    if (_delegate && [_delegate respondsToSelector:@selector(sendStarApproveWithPraiseType:)])
    {
         ChatRoomViewController *chatRoomViewController = (ChatRoomViewController*)self.rootViewController;
        if (chatRoomViewController.showTimeInProgress)
        {
            [_delegate sendStarApproveWithPraiseType:praiseType];
        }
        else
        {
            if (self.showtimeStatus == 0)
            {
                [chatRoomViewController showNoticeInWindow:@"showtime暂未开始"];
            }
            else if (self.showtimeStatus == 2)
            {
                [chatRoomViewController showNoticeInWindow:@"showtime已结束"];
            }
            
        }
    }
}

//跳转到充值
- (void)goToRecharge
{
    ChatRoomViewController *chatRoomViewController = (ChatRoomViewController *)self.rootViewController;
    if (chatRoomViewController)
    {
        [chatRoomViewController goToRechargeView];
    }
}

- (void)OnShowTimeTimer
{
    if (_timeSecond == 0)
    {
        [_showTimeTimer invalidate];
        _showTimeTimer = nil;
        
        //结束发送积累赞，不能在完全结束后发，因为服务器就接收不到了。
        ChatRoomViewController *chatRoomViewController = (ChatRoomViewController*)self.rootViewController;
        if (chatRoomViewController)
        {
            chatRoomViewController.showTimeInProgress = NO;
            [chatRoomViewController sendStarApproveWithPraiseType:1];
        }

    }
    else
    {
        _timeSecond--;
        
        NSInteger minute = _timeSecond / 60;
        NSInteger second = _timeSecond % 60;
        
        _clockTime.text = [NSString stringWithFormat:@"%.2ld:%.2ld",(long)minute,(long)second];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void) applicationWillResignActive: (NSNotification *)notification
{
    //把定时器强制失效
    if (_showTimeTimer)
    {
        [_showTimeTimer invalidate];
        _showTimeTimer = nil;
        
        _clockTime.text = [NSString stringWithFormat:@"%.2d:%.2d",0,0];
    }
    
    if (_luckTimer)
    {
        [_luckTimer invalidate];
        _luckTimer = nil;
    }
}

@end
