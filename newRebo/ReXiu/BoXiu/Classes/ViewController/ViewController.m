//
//  ViewController.m
//  BoXiu
//
//  Created by andy on 14-9-15.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "ViewController.h"
#import "LoginViewController.h"
#import "GetSystemTimeModel.h"
#import "UserInfoManager.h"
#import "LiveRoomViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UILabel *timeLable;
@property (nonatomic, strong) NSTimer *connectionTimer; //触发定时器
@property (nonatomic, strong) EWPActivityIndicatorView *activityIndicatorView;
@property (nonatomic, strong) UIImageView* imageViewIndictorView;
@property (nonatomic, strong) UILabel *remarkLabel;


@property (nonatomic, strong) UIImageView *bgImageView;  //大图背景

@property (nonatomic,strong) NSMutableArray* arrayImages;
//@property (nonatomic, retain) UILabel *reBoLabel;        //热波，给你最好的视听娱乐
//@property (nonatomic, retain) UIImageView *logoView;     //热波logo


@end

@implementation ViewController

 int timess = 60; //获取验证码60秒后才可以显示

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.isFirstRequestData = YES;
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [CommonFuction colorFromHexRGB:@"f6f6f6"];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    [self setNeedsStatusBarAppearanceUpdate];

    //设置导航栏字体属性和背景
    [[UINavigationBar appearance] setBackgroundImage:[CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"ffffff"] size:CGSizeMake(SCREEN_WIDTH, 66)] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName: [CommonFuction colorFromHexRGB:@"454a4d"],
                                                            NSFontAttributeName: [UIFont systemFontOfSize:18.0f]}];

    
    __weak typeof(self) weakself = self;
    [self setNavigationBarLeftItem:nil itemNormalImg:[UIImage imageNamed:@"navBack_normal"] itemHighlightImg:nil withBlock:^(id sender) {
        __strong typeof(self) strongself = weakself;
        if (strongself)
        {
            NSString *className = NSStringFromClass([strongself class]);
            NSDictionary *param = [NSDictionary dictionaryWithObject:className forKey:@"className"];
            [strongself popCanvasWithArgment:param];
        }
       
    }];
    
    _networkview = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 200)/2, (SCREEN_HEIGHT - 256)/2, 200, 200)];
    _networkview.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_networkview];
    _networkview.hidden = YES;
    
    UITapGestureRecognizer *networkinfor = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnNetwork:)];
    [_networkview addGestureRecognizer:networkinfor];
    
    
    _networkImg = [[UIImageView alloc] initWithFrame:CGRectMake(64, 27, 78, 55)];
    _networkImg.image = [UIImage imageNamed:@"network"];
    [_networkview addSubview:_networkImg];

    _networklabel = [[UILabel alloc] initWithFrame: CGRectMake(20, 315, 100, 14)];
    _networklabel.text = @"网络不给力点击重新加载";
    _networklabel.textColor = [CommonFuction colorFromHexRGB:@"454a4d"];
    _networklabel.font = [UIFont systemFontOfSize:13.0f];
    CGSize networksize = [CommonFuction sizeOfString:_networklabel.text maxWidth:150 maxHeight:14 withFontSize:13.0f];
    _networklabel.frame = CGRectMake((200 - networksize.width)/2, 100, networksize.width, 14);
    [_networkview addSubview:_networklabel];

    
    if (self.baseViewType == kbaseTableViewType)
    {
        _tipLabel = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH -175)/2, (SCREEN_HEIGHT -175)/2-56, 175, 175)];
        _tipLabel.backgroundColor = [UIColor clearColor];
        [self.tableView addSubview:_tipLabel];
        
        _contentImg = [[UIImageView alloc] initWithFrame:CGRectMake(57, 15, 115/2, 62)];
        _contentImg.image= [UIImage imageNamed:@"contentImg"];
        
        _tipLabeltext = [[UILabel alloc] initWithFrame:CGRectMake(10, 29, 100, 20)];
        _tipLabeltext.font = [UIFont systemFontOfSize:13.0f];
        _tipLabeltext.textColor = [CommonFuction colorFromHexRGB:@"959596"];
        _tipLabeltext.textAlignment = NSTextAlignmentCenter;
        _tipLabeltext.text = @"暂无数据";
        CGSize tipsize = [CommonFuction sizeOfString:_tipLabeltext.text maxWidth:80 maxHeight:14 withFontSize:13.0f];
        _tipLabeltext.frame = CGRectMake((175 - tipsize.width)/2, 93, tipsize.width, 14);
        
        _tipContent2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 62, 100, 20)];
        _tipContent2.font = [UIFont systemFontOfSize:15.0f];
        _tipContent2.textColor = [CommonFuction colorFromHexRGB:@"959596"];
        _tipContent2.textAlignment = NSTextAlignmentCenter;
        _tipContent2.text = @"下拉刷新看看～";
        CGSize tip2size = [CommonFuction sizeOfString:_tipContent2.text maxWidth:150 maxHeight:14 withFontSize:15.0f];
        _tipContent2.frame = CGRectMake((175 - tip2size.width)/2, 117, tip2size.width, 14);

        
        _updateView = [[UIImageView alloc] initWithFrame:CGRectMake((175 - 12)/2, 143, 12, 16)];
        _updateView.image = [UIImage imageNamed:@"update"];

        
        [_tipLabel addSubview:_tipLabeltext];
        [_tipLabel addSubview:_contentImg];
        [_tipLabel addSubview:_tipContent2];
        [_tipLabel addSubview:_updateView];

        self.imageViewPoint = self.tableView.center;
    }
    
     NSArray *imageNames = [NSArray arrayWithObjects:@"01JZ.png", @"02JZ.png", @"03JZ.png", @"04JZ.png", @"05JZ.png", @"06JZ.png", @"07JZ.png", @"08JZ.png", @"09JZ.png", @"10JZ.png", @"11JZ.png", @"12JZ.png", @"13JZ.png", @"14JZ.png", @"15JZ.png", @"16JZ.png", @"17JZ.png", @"18JZ.png", @"19JZ.png", @"20JZ.png",nil];
   
   _arrayImages = [NSMutableArray array];
    for (NSString *name in imageNames) {
        [ _arrayImages addObject:[UIImage imageNamed:name]];
    }
    __weak typeof(self) weakSelf = self;
    self.progressViewBlock = ^(BOOL showProgressView)
    {
        __strong typeof(self) strongSelf = weakSelf;
        if (showProgressView)
        {
            [strongSelf startAnimating];
        }
        else
        {
            [strongSelf stopAnimating];
        }
    };
    
    
}

-(void)OnNetwork:(id)sender
{
    if (self.netViewTouchEd)
    {
        self.netViewTouchEd();
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}

//比如按下按钮 60秒后 才能继续点击。
- (void) buttonPressed:(CGRect)LabelFrame;
{
    UIButton *btn = (UIButton *)[self.view viewWithTag:2];;
    btn.hidden = YES;
    
    if (_timeLable != nil)
    {
        [_timeLable removeFromSuperview];
        _timeLable = nil;
    }
    _timeLable = [[UILabel alloc] initWithFrame:LabelFrame];
    _timeLable.font = [UIFont systemFontOfSize:12];
    //_timeLable.layer.cornerRadius = 3.0;
    _timeLable.backgroundColor = RGB(204, 204, 204, 1.0);
    _timeLable.text = @"60秒后重新获取";
    _timeLable.textColor = [UIColor whiteColor];
    _timeLable.textAlignment = NSTextAlignmentCenter;
   // _timeLable.layer.masksToBounds = YES;
    
    [self.scrollView addSubview:_timeLable];
    
    _connectionTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(buttonPress:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:_connectionTimer forMode:NSDefaultRunLoopMode];
}

- (void) buttonPress:(id)sender
{
    UIButton *btn = (UIButton *)[self.view viewWithTag:2];;
    
    _timeLable.text = [NSString stringWithFormat:@"%d秒后重新获取",timess];
    
    if (timess == 0)
    {
        timess = 60;
        [_connectionTimer invalidate];
        _connectionTimer = nil;
        btn.hidden = NO;
        [_timeLable removeFromSuperview];
        _timeLable = nil;
        
        [btn setTitle:@"重新获取" forState:UIControlStateNormal];
    }
    else
    {
        timess--;
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 请求数据时候动画

- (void)startAnimating
{
    self.tipLabel.hidden = YES;
    self.networkview.hidden = YES;
    
    
    if (self.isFirstRequestData) {
        
        
        if (_imageViewIndictorView==nil) {
            _imageViewIndictorView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 110, 38+50)];
            _imageViewIndictorView.contentMode = UIViewContentModeTop;
            
           
            _imageViewIndictorView.center =  self.imageViewPoint;
            _imageViewIndictorView.animationImages =self.arrayImages;
            _imageViewIndictorView.animationDuration = 1;
            _imageViewIndictorView.animationRepeatCount = 100;
            
            [_imageViewIndictorView startAnimating];
            
            self.remarkLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 38+5, 110, 20)];
            self.remarkLabel.textColor = [CommonFuction colorFromHexRGB:@"959596"];
            self.remarkLabel.font = [UIFont systemFontOfSize:15];
            self.remarkLabel.text = @"loading...";
            self.remarkLabel.textAlignment = NSTextAlignmentCenter;
            [_imageViewIndictorView addSubview:self.remarkLabel];
            
        }
        [self.tableView addSubview:_imageViewIndictorView];
    }else{
        
        if (_activityIndicatorView == nil)
        {
            _activityIndicatorView = [[EWPActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            _activityIndicatorView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
            
            
        }
        
        
        [self.view addSubview:_activityIndicatorView];
        
        [_activityIndicatorView startAnimating];
    }
}

- (void)stopAnimating
{
    if (self.isFirstRequestData) {
        if (_imageViewIndictorView) {
            [_imageViewIndictorView removeFromSuperview];
            _imageViewIndictorView = nil;
        }
    }
        if (_activityIndicatorView)
        {
            [_activityIndicatorView stopAnimating];
            _activityIndicatorView = nil;
        }
    
}

- (void)startLoadProgram
{
    _bgImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"getProgram"]];
    _bgImageView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    _bgImageView.userInteractionEnabled = YES;
    
    EWPButton *closeBtn = [EWPButton buttonWithType:UIButtonTypeCustom];
    closeBtn.frame = CGRectMake(SCREEN_WIDTH - 40, 0, 40, 40);
    [closeBtn setImage:[UIImage imageNamed:@"exitroom"] forState:UIControlStateNormal];
   
    closeBtn.buttonBlock = ^(id sender)
    {
        [UserInfoManager shareUserInfoManager].currentStarInfo = nil;
        [self autoExitRoom];
        
    };
    
    UIImageView *logoView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"u27"]];
    logoView.frame = CGRectMake(0, 0, 50, 50);
    logoView.center = CGPointMake(SCREEN_WIDTH / 2.0, SCREEN_HEIGHT / 4.0);
    
    
    UILabel *reBoLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 300, 20)];
    reBoLabel.center = CGPointMake(SCREEN_WIDTH / 2.0 , SCREEN_HEIGHT / 3 + 20);
    reBoLabel.text   = @"热波，给你最好的视听娱乐";
    reBoLabel.textAlignment = NSTextAlignmentCenter;
    reBoLabel.textColor     = [UIColor yellowColor];
    reBoLabel.font          = [UIFont italicSystemFontOfSize:20];
    
    UILabel *loadLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 300, 20)];
    loadLabel.center = CGPointMake(SCREEN_WIDTH / 2.0 , SCREEN_HEIGHT / 2.0);
    loadLabel.text   = @"正在加载中，请稍候";
    loadLabel.textAlignment = NSTextAlignmentCenter;
    loadLabel.textColor     = [UIColor whiteColor];
    loadLabel.font          = [UIFont systemFontOfSize:20];
    
    
    NSMutableArray *imageArray = [[NSMutableArray alloc]init];
    for (int i = 0; i <= 11; i ++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"loadVideo%d",i]];
        [imageArray addObject:image];
    }
    UIImageView *animationImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 3)];
    animationImageView.center = CGPointMake(SCREEN_WIDTH / 2.0, (SCREEN_HEIGHT - 40) / 2.0);
    animationImageView.animationImages = imageArray;
    animationImageView.animationDuration = 1.5f;
    [animationImageView startAnimating];
    
    
    
    
//    [self.view addSubview:_bgImageView];
//    [self.view addSubview:_reBoLabel];
//    [self.view addSubview:_logoView];
//    
//    
//    [self.view addSubview:closeBtn];
//    [self.view addSubview:animationImageView];
    
    
    [_bgImageView addSubview:reBoLabel];
    [_bgImageView addSubview:loadLabel];
    [_bgImageView addSubview:logoView];
    [_bgImageView addSubview:closeBtn];
    [_bgImageView addSubview:animationImageView];
    [self.view addSubview:_bgImageView];
}
- (void)stopLoadProgram
{
    [_bgImageView removeFromSuperview];
}

- (void)autoExitRoom
{
    LiveRoomViewController *temp = [[LiveRoomViewController alloc]init];
    [temp exitRoom:YES];
    
    NSString *className = NSStringFromClass([self class]);
    NSDictionary *param = [NSDictionary dictionaryWithObject:className forKey:@"className"];

    [self popCanvasWithArgment:param];
}

#pragma mark 未登录提示
- (BOOL)showLoginDialog
{
    if (![AppInfo shareInstance].bLoginSuccess)
    {
        if (!self.showingLoginAlertView)
        {
            EWPAlertView *alertView = [[EWPAlertView alloc] initWithTitle:@"提示" message:@"还未登录，登录后更多精彩" leftBtnTitle:@"稍后再说" rightBtnTitle:@"马上登录" clickBtnBlock:^(NSInteger nIndex) {
                if (nIndex == 0)
                {
                    
                }
                else if(nIndex == 1)
                {
                    LoginViewController *viewController = [[LoginViewController alloc] init];
                    [[AppDelegate shareAppDelegate].lrSliderMenuViewController closeSliderMenu];
                    [[AppDelegate shareAppDelegate].navigationController pushViewController:viewController animated:YES];
                }
                self.showingLoginAlertView = NO;
            }];
            [alertView show];
            self.showingLoginAlertView = YES;
        }
        return YES;
    }
    return NO;
}

#pragma mark  -其他终端已登录提示框
- (void)showOherTerminalLoggedDialog
{
    if (!self.showingLoginMoreAlertView)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"refashHead" object:nil];
    EWPAlertView *alertView = [[EWPAlertView alloc] initWithTitle:@"警告" message:@"您的账号已在其他移动设备登录，如非本人操作，则账号可能存在安全风险！" leftBtnTitle:@"确定" rightBtnTitle:@"取消" clickBtnBlock:^(NSInteger nIndex) {
        if (nIndex == 0)
        {
           
            LoginViewController *viewController = [[LoginViewController alloc] init];
            [[AppDelegate shareAppDelegate].lrSliderMenuViewController closeSliderMenu];
            [[AppDelegate shareAppDelegate].navigationController pushViewController:viewController animated:YES];
        }
        else
        {
              [AppInfo shareInstance].isNeedReturnMain = NO;
            if (self.isShouldReturnMain ) {
                self.isShouldReturnMain = NO;
                [self popToRootCanvasWithArgment:nil];
            }else if ([AppInfo shareInstance].pushType==2) {//返回搜索
//                [AppInfo shareInstance].pushType=0;
                 [self popCanvasWithArgment:nil];
            }else if([AppInfo shareInstance].pushType==3) {//返回搜索
//                [AppInfo shareInstance].pushType=0;
                [self popCanvasWithArgment:nil];
            }else if([AppInfo shareInstance].pushType==-1) {//返回上一页
//                [AppInfo shareInstance].pushType=0;
                [self popCanvasWithArgment:nil];
            }
                [AppInfo shareInstance].pushType=0;
            [[NSNotificationCenter defaultCenter]postNotificationName:@"ShowLiveBtnOnMain" object:self userInfo:nil];

        }
           self.showingLoginMoreAlertView = NO;
    }];
    [alertView show];
           self.showingLoginMoreAlertView = YES;
    }

}

- (void)getServerTimeWithBlock:(void (^)(long long))serverTimeBlock
{
    GetSystemTimeModel *model = [[GetSystemTimeModel alloc] init];
    long long beginTime = [[NSDate date] timeIntervalSince1970] * 1000;;
    [model requestDataWithParams:nil success:^(id object) {
        long long endTime = [[NSDate date] timeIntervalSince1970] * 1000;
        long long needTime = endTime - beginTime;
        long long serverTime = model.systemTime + (needTime >> 1);
        if (serverTimeBlock)
        {
            serverTimeBlock(serverTime);
        }
    } fail:^(id object) {
        if (serverTimeBlock)
        {
            serverTimeBlock(0);
        }
    }];
    
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
//    if (_tipLabel)
//    {
////        _tipLabel.frame = CGRectMake((self.view.frame.size.width - 100)/2, (self.view.frame.size.height - 20)/ 2 - 50, 100, 20);
//        
//             _tipLabel.frame = CGRectMake((self.view.frame.size.width - 100)/2, self.tableView.frameHeight/2-20, 100, 20);
//    }
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
