//
//  ShowPreViewController.m
//  BoXiu
//
//  Created by tongmingyu on 14-10-28.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "ShowPreViewController.h"
#import "ShowPreViewCell.h"
#import "QueryLiveSchedulesModel.h"
#import "TopProgramModel.h"
#import "DelAttentionModel.h"
#import "AddAttentModel.h"
#import "UMSocial.h"
#import "GetSystemTimeModel.h"
//#import "Reachability.h"
#import "Reachability.h"
@interface ShowPreViewController ()<BaseTableViewDataSoure,BaseTableViewDelegate,ShowPreViewCellDelegate>

@property (nonatomic,strong) NSMutableArray *allDataAry;
@property (nonatomic,strong) NSMutableArray *photoMary;
@property (nonatomic,strong) NSMutableArray *todayMAry;
@property (nonatomic,strong) NSMutableArray *tomorrowMAry;
@property (nonatomic,strong) NSMutableArray *topMary; //节目置顶
@property (nonatomic,assign) NSInteger updateDataNum;//普通节目列表和热播间置顶节目下来刷新

@property (nonatomic,strong) LiveSchedulesData *selectedDate;
@property (nonatomic,strong) UIImageView *headImg;
@property (nonatomic,strong) UILabel *nickLab;
@property (nonatomic,strong) UILabel *infor;
@property (nonatomic,strong) UIButton* attentionBtn;
@property (nonatomic,strong) UIButton *liveBtn;
@property (nonatomic,strong) UIButton* shareBtn;

@property (nonatomic,strong) UILabel *auctionTime;
@property (nonatomic,strong) UILabel *sharelabel;
@property (nonatomic,strong) UIView *bglab;
@property (nonatomic,strong) UIView *share;
@property (nonatomic,strong) EWPSimpleDialog *livelog;
@property (nonatomic,assign) NSInteger Number;

@property (nonatomic, assign) BOOL Star;
@property (nonatomic,assign) NSTimer *timer;
@property (nonatomic,assign) NSDate *serverTimeDate;
@property (nonatomic,assign) NSData *date2;
@property (nonatomic,assign) long datetimer;

@property (nonatomic,assign) NSInteger updateNum;
@property (nonatomic,assign) NSInteger updateAry;

@end

@implementation ShowPreViewController


- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"updateDataNum" context:nil];
}

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
    
    self.title = @"节目预告";
    
    _allDataAry = nil;
    
    self.tableView.frame =  CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 118);
    self.tableView.baseDataSource = self;
    self.tableView.baseDelegate = self;
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    _photoMary = [NSMutableArray array];
    
    [_photoMary removeAllObjects];
    
    _livelog = [[EWPSimpleDialog alloc] initWithFrame:CGRectMake((SCREEN_WIDTH -274)/2, (SCREEN_HEIGHT -382)/2, 274, 310)];
    _livelog.backgroundColor = [UIColor whiteColor];
    _livelog.layer.cornerRadius = 12.0f;
    
    _bglab = [[UIView alloc] initWithFrame: CGRectMake(0, 0, _livelog.frame.size.width, 87)];
    _bglab.backgroundColor = [CommonFuction colorFromHexRGB:@"d14c49"];
    //    _bglab.layer.cornerRadius = 11.0f;
    [_livelog addSubview:_bglab];
    
    _infor= [[UILabel alloc] initWithFrame: CGRectMake(111, 19, 81, 15)];
    _infor.text= @"直播还有";
    _infor.font = [UIFont boldSystemFontOfSize:13.0f];
    _infor.textColor = [CommonFuction colorFromHexRGB:@"ffffff"];
    [_bglab addSubview:_infor];
    CGSize inforSize = [CommonFuction sizeOfString:_infor.text maxWidth:120 maxHeight:15 withFontSize:13.0f];
    _infor.frame = CGRectMake((270 - inforSize.width)/2, 19, inforSize.width, 15);
    
    _auctionTime = [[UILabel alloc] initWithFrame:CGRectMake(52, 42, 190, 15)];
    _auctionTime.textColor = [CommonFuction colorFromHexRGB:@"ffffff"];
    [_bglab addSubview:_auctionTime];
    
    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(231, 0, 40, 40)];
    [closeBtn setImage:[UIImage imageNamed:@"attent_change_close"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
    [_bglab addSubview:closeBtn];
    
    _attentionBtn = [[UIButton alloc] initWithFrame:CGRectMake((270-149)/2 + 3, 434/2, 149, 32)];
    [_attentionBtn addTarget:self action:@selector(attention1:) forControlEvents:UIControlEventTouchUpInside];
    [_attentionBtn setTitle:@"关注我获得直播提醒" forState:UIControlStateNormal];
    _attentionBtn.titleLabel.textColor = [CommonFuction colorFromHexRGB:@"ffffff"];
    [_attentionBtn setBackgroundImage:IMAGE_SUBJECT_NOR(264, 40) forState:UIControlStateNormal];
    [_attentionBtn setBackgroundImage:IMAGE_SUBJECT_SEL(264, 40) forState:UIControlStateHighlighted];
    _attentionBtn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    _attentionBtn.layer.masksToBounds = YES;
    _attentionBtn.layer.cornerRadius = 16.0f;
    [_livelog addSubview:_attentionBtn];
    
    
    // 画确认按钮的左上、右上圆角
    CAShapeLayer *confirmButtonLayer = [CAShapeLayer layer];
    UIBezierPath *radiusPath = [UIBezierPath bezierPathWithRoundedRect:_bglab.bounds
                                                     byRoundingCorners:(UIRectCornerTopLeft|UIRectCornerTopRight)
                                                           cornerRadii:CGSizeMake(11.0f, 11.0f)];
    confirmButtonLayer.path = radiusPath.CGPath;
    _bglab.layer.mask = confirmButtonLayer;
    
    
    _liveBtn = [[UIButton alloc] initWithFrame:CGRectMake((270-149)/2 + 3, 434/2, 149, 32)];
    [_liveBtn addTarget:self action:@selector(liveroom) forControlEvents:UIControlEventTouchUpInside];
    [_liveBtn setTitle:@"进入直播LIVE" forState:UIControlStateNormal];
    _liveBtn.titleLabel.textColor = [CommonFuction colorFromHexRGB:@"ffffff"];
    [_liveBtn setBackgroundImage:IMAGE_SUBJECT_NOR(264, 40) forState:UIControlStateNormal];
    [_liveBtn setBackgroundImage:IMAGE_SUBJECT_SEL(264, 40) forState:UIControlStateHighlighted];
    _liveBtn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    _liveBtn.layer.masksToBounds = YES;
    _liveBtn.layer.cornerRadius = 16.0f;
    [_livelog addSubview:_liveBtn];
    
    _shareBtn = [[UIButton alloc] initWithFrame:CGRectMake(3, 0, 17, 16)];
    [_shareBtn setImage:[UIImage imageNamed:@"share-1"] forState:UIControlStateNormal];
    [_shareBtn addTarget:self action:@selector(shareBoxiu) forControlEvents:UIControlEventTouchUpInside];
    
    _share = [[UIView alloc] initWithFrame:CGRectMake(85, 544/2, 130, 35)];
    _share.backgroundColor = [CommonFuction colorFromHexRGB:@"ffffff"];
    [_livelog addSubview:_share];
    UITapGestureRecognizer *setinfor = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shareBoxiu)];
    [_share addGestureRecognizer:setinfor];
    
    _sharelabel= [[UILabel alloc] initWithFrame: CGRectMake(24,0, 81, 15)];
    _sharelabel.text= @"分享给好友";
    _sharelabel.font = [UIFont boldSystemFontOfSize:13.0f];
    _sharelabel.textColor = [CommonFuction colorFromHexRGB:@"959596"];
    
    CGSize shareSize = [CommonFuction sizeOfString:_sharelabel.text maxWidth:120 maxHeight:15 withFontSize:13.0f];
    _shareBtn.frame = CGRectMake(3, 0, 17, 16);
    _sharelabel.frame = CGRectMake(24, 0, shareSize.width, 15);
    
    _headImg = [[UIImageView alloc]initWithFrame:CGRectMake(100, 95, 75, 75)];
    _headImg.layer.cornerRadius = 75.0f/2;
    [_headImg.layer setMasksToBounds:YES];
    [_livelog addSubview: _headImg];
    
    _nickLab = [[UILabel alloc] initWithFrame:CGRectZero];
    _nickLab.font = [UIFont boldSystemFontOfSize:14.0f];
    [_livelog addSubview:_nickLab];
    
    [self addObserver:self forKeyPath:@"updateDataNum" options:NSKeyValueObservingOptionNew context:nil];
    
    [self requestData:NO];
    
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
-(void)viewWillAppear:(BOOL)animated
{
    if([AppInfo IsEnableConnection])
    {
        //        [self requestData:YES];
        
        if ([AppInfo shareInstance].nowtimesMillis == 0) {
            [[AppDelegate shareAppDelegate] enter:nil];
            return;
        }
    }
    else
    {
        [self stopAnimating];
        [self.tableView reloadData];
        
        if([_allDataAry count] == 0)
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
}
- (void)refreshData
{
    [self requestData:YES];
}

- (void)requestData:(BOOL)refresh
{
    
    if([AppInfo IsEnableConnection])
    {
        if([_allDataAry count] > 0)
        {
            self.tipLabel.hidden = YES;
            self.networkview.hidden = YES;
        }else
        {
            self.tipLabel.hidden = NO;
            self.networkview.hidden = YES;
        }
        [self networking:refresh];
        
    }
    else
    {
        if([_allDataAry count] == 0)
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

-(void)networking:(BOOL)refresh
{
    if (self.allDataAry.count==0) {
        self.isFirstRequestData = YES;
    }else{
        self.isFirstRequestData = NO;
    }
    [self startAnimating];
    if (!refresh)
    {
        //        [self startAnimating];
    }
    
    if (_allDataAry == nil)
    {
        _allDataAry = [NSMutableArray array];
    }
    [self deletecont];
    
    if (_todayMAry == nil)
    {
        _todayMAry = [NSMutableArray array];
    }
    [_todayMAry removeAllObjects];
    
    if (_tomorrowMAry == nil)
    {
        _tomorrowMAry = [NSMutableArray array];
    }
    [_tomorrowMAry removeAllObjects];
    
    if (_topMary == nil)
    {
        _topMary = [NSMutableArray array];
    }
    [_topMary removeAllObjects];
    
    self.updateDataNum = 0;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        QueryLiveSchedulesModel *model = [[QueryLiveSchedulesModel alloc] init];
        [model requestDataWithParams:nil success:^(id object) {
            _Number = 0;
            /*成功返回数据*/
            if (model.result == 0)
            {
                [_allDataAry removeAllObjects];
                [self.allDataAry addObjectsFromArray:model.liveSchedMutable];
                
                [self.photoMary addObjectsFromArray:model.photoMary];
                
                [self.todayMAry addObjectsFromArray:model.todayMary];
                [self.tomorrowMAry addObjectsFromArray:model.tomorrowMary];
                //                _updateNum = 0;
                [self.tableView reloadData];
            }else if (model.code == 403){
                [self showOherTerminalLoggedDialog];
            }
            [self deletecont];
            self.updateDataNum++;
            [self stopAnimating];
        } fail:^(id object) {
            [self stopAnimating];
            _Number = 1;
            if([_allDataAry count] == 0)
            {
                self.tipLabel.hidden = YES;
                self.networkview.hidden = NO;
            }
            self.updateDataNum++;
            /*失败返回数据*/
        }];
    });
    
}

int nowyear ;
int nowmonth;
int nowday ;
int nowhour ;
int nowBranch ;

int dateyear ;
int datemonth ;
int dateday ;
int datehour ;
int datebranch ;

int endhour;
int endbranch;
-(void)deletecont
{
    if ([_allDataAry count] >0) {
        NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]];
        long long nowtime = [timeSp longLongValue];
        for (int t=0; t<[_allDataAry count]; t++) {
            LiveSchedulesData *starInfo =[self.allDataAry objectAtIndex:t];
            double time2 =  starInfo.starTimeInMillis/1000 - nowtime - [AppInfo shareInstance].timerMillis ;
            int time = time2;
            int day = (int)(time / (24 * 60 * 60 ));
            time = time % (24 * 60 * 60 );
            int hour = (int)(time  / (60 * 6));
            time = time  % (60 * 60);
            int minute = (int)(time / 60 );
            time = time % 60;
            int second = (int)time;
            
            if(day<=0 && hour<= 0 && minute<= 0 && second<= 0)
            {
                [self.allDataAry removeObjectAtIndex:t];
                t--;
            }
        }
        [self.tableView reloadData];
    }
    
}

#pragma mark -BaseTableCanvasDataSoure
- (NSInteger)numberOfSectionsInBaseTableView:(BaseTableView *)baseTableView
{
    return 1;
}

- (NSInteger)baseTableView:(BaseTableView *)baseTableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger nCount = [self.allDataAry count];
    return nCount;
}

- (UITableViewCell *)baseTableView:(BaseTableView *)baseTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier =  @"cellIdentifier";
    ShowPreViewCell *cell = [baseTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[ShowPreViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    LiveSchedulesData *liveDate = [self.allDataAry objectAtIndex:indexPath.row];
    cell.liveScheData = liveDate;
    
    cell.vertImgView.frame = CGRectMake(22, 28, 2, 30);
    cell.vertImgView2.frame = CGRectMake(22, 88, 2, 68);
    cell.liveScheData = [self.allDataAry objectAtIndex:indexPath.row];
    
    if (_updateAry != [_allDataAry count]) {
        _updateNum = 0;
    }else{
        
    }
    
    if ([_allDataAry count] == indexPath.row +1 ) {
        if (!_updateNum) {
            [self.tableView reloadData];
            _updateNum = 1;
        }
    }
    _updateAry = [_allDataAry count];
    
    return cell;
}

- (void)reloadSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation
{
    
}

#pragma mark -UITableViewDelegate
- (void)baseTableView:(BaseTableView *)baseTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedDate = [self.allDataAry objectAtIndex:indexPath.row];
    
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]];
    long long nowtime = [timeSp longLongValue];
    double time2 =  _selectedDate.starTimeInMillis/1000 - nowtime - [AppInfo shareInstance].timerMillis;
    
    int time = time2;
    int day = (int)(time / (24 * 60 * 60));
    int hour = (int)(time  / (60 * 60 ));
    int minute = (int)(time / 60 );
    int second = (int)time;
    if (day<= 0 && hour<= 0 && minute<= 0 && second<= 0) {
        [self liveroominfor];
        return;
    }
    _auctionTime.text =@"";
    
    // 如果要检测网络状态的变化,必须用检测管理器的单例的startMonitoring
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    // 检测网络连接的单例,网络变化时的回调方法
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable)
        {
            [[AppInfo shareInstance] showNoticeInWindow:@"网络连接失败，请重试" duration:1.5];
        }
        else
        {
            [_livelog showInWindow];
        }
        [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
        
    }];
    
    NSInteger hideSwitch = [[[AppInfo shareInstance].hideSwitch substringFromIndex:1] integerValue];
    if(hideSwitch != 1)
    {
        [_share addSubview:_shareBtn];
        [_share addSubview:_sharelabel];
        
    }
    
    _datetimer = nowtime + [AppInfo shareInstance].timerMillis;
    [self timerFireMethod:nil];
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInteger:self.selectedDate.userid] forKey:@"userid"];
    GetUserInfoModel *model = [[GetUserInfoModel alloc] init];
    model.isNotUseToken = YES;
    [model requestDataWithParams:dict success:^(id object) {
        /*成功返回数据*/
        GetUserInfoModel *userInfoModel = object;
        if (userInfoModel.result == 0)
        {
            if (self.allDataAry.count > 0)
            {
                if(userInfoModel.userInfo.attentionflag)
                {
                    [_attentionBtn setTitle:@"已关注" forState:UIControlStateNormal];
                    
                    _Star = YES;
                }
                else
                {
                    [_attentionBtn setTitle:@"关注我获得直播提醒" forState:UIControlStateNormal];
                    _Star = NO;
                }
            }
        }
        else
        {
            
        }
        
    } fail:^(id object) {
        /*失败返回数据*/
    }];
    
    _nickLab.text = _selectedDate.nick;
    
    CGSize nickSize = [CommonFuction sizeOfString:self.nickLab.text maxWidth:120 maxHeight:15 withFontSize:14.0f];
    _nickLab.frame = CGRectMake((274 - nickSize.width)/2, 374/2, 120, 14);
    
    NSString *photourl = [NSString stringWithFormat:@"%@%@",[AppInfo shareInstance].res_server,_selectedDate.photo];
    [_headImg sd_setImageWithURL:[NSURL URLWithString:photourl]];
    
    
}


-(void)timerFireMethod:(NSTimer *)timer
{
    
    _datetimer +=1;
    long date3 = (self.selectedDate.starTimeInMillis/1000) - _datetimer;

    static int day;
    static int hour;
    static int minute;
    static int second;
    
    day = (int)date3/(60*60*24);
    hour = (int)(date3 - (day*60*60*24))/(60*60);
    minute = (int)(date3 - (day*60*60*24) - (hour *60 *60))/60;
    second = (int)(date3 - (day*60*60*24) - (hour *60 *60) - minute *60);

    
    _infor.text= @"直播还有";
    _attentionBtn.hidden = NO;
    _liveBtn.hidden =YES;
    
    
    if ( day >0) {
        
        _auctionTime.text = [NSString stringWithFormat:@"%d天%d小时%d分%d秒", day, hour, minute,second];//倒计时显示 天 小时 分钟 秒
        CGSize TimeSize = [CommonFuction sizeOfString:_auctionTime.text maxWidth:258 maxHeight:15 withFontSize:13.0f];
        _auctionTime.frame = CGRectMake((270 - TimeSize.width -45)/2, 42, TimeSize.width + 45, 15);
        
        
    }
    else
    {
        if ( hour >0) {
            _auctionTime.text = [NSString stringWithFormat:@"%d小时%d分%d秒",hour,  minute, second];//倒计时显示 时 分 秒
            CGSize TimeSize = [CommonFuction sizeOfString:_auctionTime.text maxWidth:225 maxHeight:15 withFontSize:13.0f];
            _auctionTime.frame = CGRectMake((270 - TimeSize.width -38)/2, 42, TimeSize.width + 38, 15);
            
        }
        else
        {
            if( minute >0)
            {
                _auctionTime.text = [NSString stringWithFormat:@"%d分%d秒",  minute, second];//倒计时显示 分 秒
                CGSize TimeSize = [CommonFuction sizeOfString:_auctionTime.text maxWidth:225 maxHeight:15 withFontSize:13.0f];
                _auctionTime.frame = CGRectMake((270 - TimeSize.width -16)/2, 42, TimeSize.width + 28, 15);
                
            }
            else
            {
                if (second >0) {
                    _auctionTime.text = [NSString stringWithFormat:@"%d秒",  second];//倒计时显示 秒
                    CGSize TimeSize = [CommonFuction sizeOfString:_auctionTime.text maxWidth:220 maxHeight:15 withFontSize:13.0f];
                    _auctionTime.frame = CGRectMake((270 - TimeSize.width - 10)/2, 42, TimeSize.width + 10, 15);
                }
                else
                {
                    _auctionTime.text = @"现场直播中";
                    _infor.text = @"精彩节目";
                    _attentionBtn.hidden = YES;
                    _liveBtn.hidden =NO;
                    
                    CGSize TimeSize = [CommonFuction sizeOfString:_auctionTime.text maxWidth:220 maxHeight:15 withFontSize:13.0f];
                    
                    _auctionTime.frame = CGRectMake((270 - TimeSize.width -20)/2, 42, TimeSize.width + 20, 15);
                }
                
            }
            
        }
        
    }
   
    
}
#pragma mark- 分享
-(void) shareBoxiu
{
    if (_livelog)
    {
        [_timer invalidate];
        [_livelog hide];
    }
    datemonth = [[_selectedDate.date substringWithRange:NSMakeRange(5, 2)] intValue];
    dateday = [[_selectedDate.date substringWithRange:NSMakeRange(8, 2)] intValue];
    datehour = [[_selectedDate.showTime substringWithRange:NSMakeRange(0, 2)] intValue];
    datebranch = [[_selectedDate.showTime substringWithRange:NSMakeRange(3, 2)] intValue];
    NSString *shareSt = @"";
    if(datebranch == 0)
    {
        shareSt = [NSString stringWithFormat:@"%d月%d日 %d点00分,“%@”会在#热波间#和大家进行精彩的直播互动哦，喜欢我记得来捧场哦！/%ld",datemonth,dateday,datehour,_selectedDate.nick,(long)self.selectedDate.starIdxcode];
    }
    else
    {
        shareSt = [NSString stringWithFormat:@"%d月%d日 %d点%d分,“%@”会在#热波间#和大家进行精彩的直播互动哦，喜欢我记得来捧场哦！/%ld",datemonth,dateday,datehour,datebranch,_selectedDate.nick,(long)self.selectedDate.starIdxcode];
    }
    
    
    UIImage* image = nil;
    if (_headImg) {
        image = _headImg.image;
    }else{
        image =[UIImage imageNamed:@"reboLogo"];
    }
    NSString *sharelink = [NSString stringWithFormat:@"http://www.51rebo.cn/%ld",(long)self.selectedDate.starIdxcode];
    NSString *shareContent = [NSString stringWithFormat:@"%@",shareSt];
    [UMSocialData defaultData].extConfig.wechatSessionData.url = sharelink;
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = sharelink;
    [UMSocialData defaultData].extConfig.qqData.url = sharelink;
    [UMSocialData defaultData].extConfig.qzoneData.url = sharelink;
    [UMSocialData defaultData].extConfig.wechatSessionData.url = sharelink;
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = sharelink;
    [UMSocialData defaultData].extConfig.title = @"#热波间#最火的全民娱乐直播在线平台，潮人聚集地";
    
    [UMSocialConfig setFinishToastIsHidden:NO position:UMSocialiToastPositionBottom];

    [UMSocialSnsService presentSnsIconSheetView:[AppDelegate shareAppDelegate].lrSliderMenuViewController
                                         appKey:nil
                                      shareText:[shareContent stringByAppendingString:sharelink]
                                     shareImage:image
                                shareToSnsNames:@[UMShareToSina,UMShareToTencent,UMShareToQQ,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSms]
                                       delegate:nil];
}

-(void)close:(id)sender
{
    if (_livelog)
    {
        [_timer invalidate];
        [_livelog hide];
    }
}

- (CGFloat)baseTableView:(BaseTableView *)baseTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [ShowPreViewCell height];
}

#pragma mark _ShowPreDelegate

- (void)didRoom:(LiveSchedulesData *)liveSchedData
{
    if (liveSchedData.lintype == 2)
    {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:liveSchedData.mobileUrl forKey:@"mobileurl"];
        [dict setObject:liveSchedData.liveName forKey:@"title"];
        [self pushCanvas:PreViewUrl_Canvas withArgument:dict];
    }
    else if(liveSchedData.lintype == 1)
    {
        NSDictionary *param = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:liveSchedData.userid] forKey:@"staruserid"];
        [self pushCanvas:LiveRoom_CanVas withArgument:param];
    }
}

#pragma mark 通过倒计时 进入房间
-(void)liveroom
{
    if (_livelog)
    {
        [_timer invalidate];
        [_livelog hide];
    }
    NSDictionary *param = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:self.selectedDate.userid] forKey:@"staruserid"];
    [self.rootViewController pushCanvas:LiveRoom_CanVas withArgument:param];
}
#pragma mark 通过列表进入房间
-(void)liveroominfor
{
    NSDictionary *param = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:self.selectedDate.userid] forKey:@"staruserid"];
    [self.rootViewController pushCanvas:LiveRoom_CanVas withArgument:param];
    
}

- (void)didLinkType:(LiveSchedulesData *)liveSchedData
{
    NSDictionary *param = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:liveSchedData.userid] forKey:@"staruserid"];
    [self pushCanvas:LiveRoom_CanVas withArgument:param];
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"updateDataNum"])
    {
        NSInteger updateDataNum = [[change objectForKey:NSKeyValueChangeNewKey] integerValue];
        if (updateDataNum == 1)
        {
            [self.tableView reloadData];
            NSInteger nCount = [self.allDataAry count];
            
            if (_Number) {
                self.tipLabel.hidden = YES;
                self.networkview.hidden = NO;
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
            
            [self stopAnimating];
        }
        
    }
}

- (void)attention1:(id)sender
{
    if (![AppInfo shareInstance].bLoginSuccess)
    {
        [self showNotice:@"需要先登录哦"];
        return;
    }
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInteger:_selectedDate.userid]forKey:@"staruserid"];
    
    __weak ShowPreViewController *weakSelf = self;
    
    if (_Star)
    {
        //取消关注
        DelAttentionModel *delAttentionModel = [[DelAttentionModel alloc] init];
        [delAttentionModel requestDataWithParams:dict success:^(id object) {
            __strong ShowPreViewController *strongSelf = weakSelf;
            _Star = NO;
            /*成功返回数据*/
            if (delAttentionModel.result == 0)
            {
                strongSelf.selectedDate.attentionflag = NO;
                strongSelf.attentionBtn.selected = NO;
                [_attentionBtn setTitle:@"关注我获得直播提醒" forState:UIControlStateNormal];
                [strongSelf showNotice:@"已取消对TA的关注"];
            }
            else
            {
                //                EWPAlertView *alerView = [[EWPAlertView alloc] initWithTitle:delAttentionModel.title message:delAttentionModel.msg confirmBlock:^(id sender) {
                //
                //                } cancelBlock:nil];
                //                [alerView show];
            }
        } fail:^(id object) {
            
        }];
    }
    else
    {
        //添加关注
        StarInfo *starInfo = [UserInfoManager shareUserInfoManager].currentStarInfo;
        NSString *serverIp= [NSString stringWithFormat:@"http://%@:%ld/mobile/dispatch.mobile",starInfo.serverip,(long)starInfo.serverport];
        if (starInfo.serverip == nil)
        {
            serverIp = [AppInfo shareInstance].requestServerBaseUrl;
        }
        
        AddAttentModel *addAttentionModel = [[AddAttentModel alloc] init];
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict addEntriesFromDictionary:[addAttentionModel signParamWithMethod:AddAttention_Method]];
        [dict setObject:[NSNumber numberWithInteger:self.selectedDate.userid]forKey:@"staruserid"];
        __weak typeof(self) weakSelf = self;
        [addAttentionModel requestDataWithBaseUrl:serverIp requestType:nil method:AddAttention_Method httpHeader:[addAttentionModel httpHeaderWithMethod:AddAttention_Method] params:dict success:^(id object) {
            __strong typeof(self) strongSelf = weakSelf;
            _Star = YES;
            
            /*成功返回数据*/
            if (addAttentionModel.result == 0)
            {
                strongSelf.selectedDate.attentionflag = YES;
                strongSelf.attentionBtn.selected = YES;
                [_attentionBtn setTitle:@"已关注" forState:UIControlStateNormal];
                
                [strongSelf showNotice:@"已成功关注TA"];
            }
            else
            {
                [strongSelf showNotice:@"需要先登录哦"];
            }
            
        } fail:^(id object) {
            
        }];
        
    }
    
    
}

- (void)didReceiveMemoryWarning {
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

@end
