//
//  AppDelegate.m
//  BoXiu
//
//  Created by Andy on 14-3-27.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "LeftMenuViewController.h"
#import "SUByteConvert.h"
#import "UserInfoManager.h"
#import "AppInfo.h"
#import "EWPDialog.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "NewestVersionModel.h"
#import "RechargeViewController.h"
#import <AlipaySDK/AlipaySDK.h>
#import "DataVerifier.h"
#import "Recharge.h"
#import "UMSocial.h"
#import "UMSocialQQHandler.h"
#import "UMSocialSinaHandler.h"
#import "MobClick.h"
#import "EWPLib.h"
#import "AFNetworkReachabilityManager.h"
#import "UMSocialWechatHandler.h"
#import "EWPGuideViewController.h"
#import "SignInModel.h"
#import "UMessage.h"
#import "MessageCenter.h"
#import "WXApi.h"
#import "StartPageManager.h"
#import "StartupPageModel.h"
#import "ActivityUrlViewController.h"
#import "ChatRoomViewController.h"
#import "LiveRoomViewController.h"
#import "MallViewController.h"
#import "RechargeViewController.h"
#import "AppStoreRechargeViewController.h"
//#import "Reachability.h"
#import "Reachability.h"
#import "NdUncaughtExceptionHandler.h"
#import "InviterFriendViewController.h"
#import "SelectModePaymentViewController.h"
#import "XZMCoreNewFeatureVC.h"
@interface AppDelegate ()<EWPGuideViewDelegate,UIAlertViewDelegate>
@property (nonatomic) Reachability *hostReachability;
@property (nonatomic,strong) NSArray *startupPages;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    
    
    [AppInfo shareInstance].network = 1;
    
    NSString *remoteHostName = @"www.apple.com";
    self.hostReachability = [Reachability reachabilityWithHostName:remoteHostName];
    [self.hostReachability startNotifier];
    /**
     *  启动引导页，暂时关闭
     */
 /*
    //判断是否需要显示：（内部已经考虑版本及本地版本缓存）
    BOOL canShow = [XZMCoreNewFeatureVC canShowNewFeature];
    
    //测试代码，正式版本应该删除
    //    canShow = YES;
    
    if(canShow){ // 初始化新特性界面
        
        UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        window.backgroundColor = [UIColor clearColor];
        self.window = window;
        
        window.rootViewController = [XZMCoreNewFeatureVC newFeatureVCWithImageNames:@[@"new1",@"new2",@"new3",@"new4",@""] enterBlock:^{
            
            NSLog(@"进入主页面");
            [self enter:launchOptions];
            
        } configuration:^(UIButton *enterButton) { // 配置进入按钮
//            [enterButton setBackgroundImage:[UIImage imageNamed:@"btn_nor"] forState:UIControlStateNormal];
//            [enterButton setBackgroundImage:[UIImage imageNamed:@"btn_pressed"] forState:UIControlStateHighlighted];
        
            enterButton.bounds = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
            enterButton.center = CGPointMake(KScreenW * 0.5, KScreenH* 0.85);
        }];
        [window makeKeyAndVisible];
        
    }else{
        
        [self enter:launchOptions];
    }
    
    */
    
    [self enter:launchOptions];

// 加彩色日志
    [self addDDLog];
    
    return YES;
}

-(void)enter:(NSDictionary *)launchOptions
{
    
    [NdUncaughtExceptionHandler setDefaultHandler];
    
    
    if([AppInfo IsEnableConnection])
    {
        EWPLog(@"有网络连接--%d",[AppInfo IsEnableConnection]);
        [AppInfo shareInstance].nowtimesMillis = 1;
    }
    else
    {
        EWPLog(@"网络连接失败--%d",[AppInfo IsEnableConnection]);
        
        [AppInfo shareInstance].nowtimesMillis = 0;
        
    }
    
    [[EWPLib shareInstance] initEWPLib];
    
    [MainViewController initConfigInfo];
    
    //初始化友盟
    [self initUMengSetting];
    
    //向微信注册
    [WXApi registerApp:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"WXAppId"]];
    
    
    //在程序中注册推送通知
    [UMessage startWithAppkey:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"UMengAppkey"] launchOptions:launchOptions];
    
    NSDictionary *pushMsg = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (pushMsg && [pushMsg count] > 0)
    {
        MessageData *messageData = [self savePushMsg:pushMsg];
        [MessageCenter shareMessageCenter].currentNotifyData = messageData;
    }
    
    if (ISBIGSYSTEM8)
    {
        UIUserNotificationSettings *userSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIRemoteNotificationTypeNone
                                                                                     categories:nil];
        [UMessage registerRemoteNotificationAndUserNotificationSettings:userSettings];
    }
    else
    {
        [UMessage registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge
         |UIRemoteNotificationTypeSound
         |UIRemoteNotificationTypeNone];
    }
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    _startupPages = [NSArray arrayWithArray:[[StartPageManager shareInstance] startPages]] ;
    if ([_startupPages count])
    {
        NSMutableArray *imgDataMArray = [NSMutableArray array];
        for (StartupPageData *startupPageData in _startupPages)
        {
            [imgDataMArray addObject:startupPageData.imgData];
        }
        EWPGuideViewController *guideViewController = [[EWPGuideViewController alloc] initWithImgDataArray:imgDataMArray];
        guideViewController.delegate = self;
        guideViewController.autoScroll = YES;
        self.window.rootViewController = guideViewController;
    }
    else
    {
        [self showHomeView];
    }
    
    [self.window makeKeyAndVisible];
    
    
    [[AppInfo shareInstance] autoLogin:^(){
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
        });
    }fail:^(NSString *erroMessage){
        
        
    }];
    
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"ColoseSelfStar" object:self];//关闭直播
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    
    
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"notiRefarch" object:self];//提现关注公众号后进入应用需要自动跳转
    
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UMOnlineConfigDidFinishedNotification object:nil];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSString *devicetokenStr = [NSString stringWithFormat:@"%@",deviceToken];
    devicetokenStr = [devicetokenStr stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    devicetokenStr = [devicetokenStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    [AppInfo shareInstance].deviceToken = devicetokenStr;
    NSLog(@"  = %@",devicetokenStr);
    [self openClient];
    
    [UMessage registerDeviceToken:deviceToken];
    
    //如果用户卸载掉再安装添加一个无效的userid
    //    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //    NSString *loginType = [defaults objectForKey:@"loginType"];
    //    if (!loginType)
    //    {
    //
    NSString *strUserId = [NSString stringWithFormat:@"%ld",(long)[UserInfoManager shareUserInfoManager].currentUserInfo.userId];
    [UMessage addAlias:strUserId type:@"userid" response:^(id responseObject, NSError *error) {
        
    }];
    //    }
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"%@",error);
}


#pragma mark _Umeng推送消息
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    //关闭友盟自带的弹出框
    [UMessage setAutoAlert:NO];
    
    
    [UMessage didReceiveRemoteNotification:userInfo];
    if (userInfo && userInfo.count > 0)
    {
        MessageData *messageData = [self savePushMsg:userInfo];
        if (application.applicationState == UIApplicationStateInactive)
        {
            [UMessage setBadgeClear:YES];
            
            
            
            [MessageCenter shareMessageCenter].currentNotifyData = messageData;
            [[AppDelegate shareAppDelegate] showHomeView];
            
            
            
            //            [[NSNotificationCenter defaultCenter]postNotificationName:@"UMessagePush" object:nil];//返回到当前页面，后面修改
        }
    }
    
    
}



- (MessageData *)savePushMsg:(NSDictionary *)userInfo
{
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString *todayTime = [dateformatter stringFromDate:[NSDate date]];
    NSString *jsonStr = [userInfo objectForKey:@"data"];//[[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
    if (![jsonStr isKindOfClass:[NSString class]])
    {
        return nil;
    }
    NSDictionary *dic = [jsonStr objectFromJSONString];
    
    
    //    if (![[userInfo allKeys]containsObject:@"data"]) {//友盟推过来消息是字典类型的
    //        return nil ;
    //    }
    //    NSDictionary* dic = [userInfo objectForKey:@"data"];
    if (dic && dic.count > 0)
    {
        MessageData *msgData = [[MessageData alloc] init];
        msgData.time = todayTime;
        //        msgData.userId = [[dic objectForKey:@"userid"] integerValue];
        msgData.userId = [UserInfoManager shareUserInfoManager].currentUserInfo.userId;
        msgData.content = [dic objectForKey:@"content"];
        
        NSString *strIcon = [dic objectForKey:@"icon"];
        msgData.icon = [NSString stringWithFormat:@"%@%@",[AppInfo shareInstance].res_server,strIcon];
        
        msgData.messageType = [[dic objectForKey:@"messageType"] integerValue];
        msgData.notifyShowType = [[dic objectForKey:@"notifyShowType"] integerValue];
        msgData.title = [dic objectForKey:@"title"];
        msgData.uuid = [dic objectForKey:@"uuid"];
        NSDictionary *paramsDic = [dic objectForKey:@"params"];
        if (paramsDic && [paramsDic count] > 0)
        {
            if (msgData.messageType == 1)
            {
                msgData.actionLink = [[paramsDic objectForKey:@"actionLink"] integerValue];
                msgData.data = [paramsDic objectForKey:@"data"];
                
                msgData.staruserId = 2;
                msgData.level = @"10";
                msgData.levelName = @"1财富级";
            }
            else if (msgData.messageType == 2)
            {
                msgData.level = [paramsDic objectForKey:@"level"];
                msgData.levelName = [paramsDic objectForKey:@"levelName"];
                
                msgData.staruserId = 2;
                msgData.actionLink = 0;
                msgData.data = @"a";
            }
            else if (msgData.messageType == 3)
            {
                msgData.staruserId = [[paramsDic objectForKey:@"staruserId"] integerValue];
                
                msgData.level = @"10";
                msgData.levelName = @"1财富级";
                msgData.actionLink = 0;
                msgData.data = @"a";
            }
        }
        
        if ([UIApplication sharedApplication].applicationState ==  UIApplicationStateInactive)
        {
            msgData.readed = YES;
        }
        else
        {
            msgData.readed = NO;
        }
        
        NSArray *messageDatas = [NSArray arrayWithArray:[[MessageCenter shareMessageCenter] getMessageData]];
        if (messageDatas && [messageDatas count] > 0)
        {
            for (MessageData *messageId in messageDatas)
            {
                if ([messageId.uuid isEqualToString:msgData.uuid])
                {
                    EWPLog(@"相等");
                    break;
                }
                else
                {
                    EWPLog(@"不相等");
                    [[MessageCenter shareMessageCenter] saveMessge:msgData];
                    break;
                }
            }
        }
        else
        {
            [[MessageCenter shareMessageCenter] saveMessge:msgData];
        }
        return msgData;
    }
    return nil;
}



+ (AppDelegate *)shareAppDelegate
{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

#pragma mark - Alipay
//独立客户端回调函数
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    NSString *appScheme = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"AppScheme"];
    
    NSRange range = [[url scheme] rangeOfString:appScheme];
    if (range.length > 0)
    {
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            EWPLog(@"resultDic = %@",resultDic);
        }];
        return YES;
    }
    else
    {
        return  [UMSocialSnsService handleOpenURL:url wxApiDelegate:nil];
    }
    
    return NO;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    if ([url.host isEqualToString:@"safepay"]) {
        
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            EWPLog(@"resultDic = %@",resultDic);
        }];    }
    else if ([sourceApplication isEqualToString:@"com.tencent.xin"])
    {
        [[Recharge shareRechargeInstance] wxpay:url application:application];
        //        return YES;
        return  [UMSocialSnsService handleOpenURL:url wxApiDelegate:nil];
    }
    else
    {
        return  [UMSocialSnsService handleOpenURL:url wxApiDelegate:nil];
    }
    
    return  [UMSocialSnsService handleOpenURL:url wxApiDelegate:nil];
    
}

#pragma mark -SetUMeng
- (void)initUMengSetting
{
    NSString *appkey = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"UMengAppkey"];
    //设置友盟社会化组件appkey
    [UMSocialData setAppKey:appkey];
    
    BOOL isTestVersion = [[[NSBundle mainBundle] objectForInfoDictionaryKey:@"Test_Version"] boolValue];
    if (isTestVersion)
    {
        [MobClick setCrashReportEnabled:NO];//测试的时候关闭友盟log
    }
    
#ifdef DEBUG
    
    //    打开调试log的开关
    //    [UMSocialData openLog:YES];
    //    [UMessage setLogEnabled:YES];
    
#endif//DEBUG
    
    //打开新浪微博的SSO开关
    [UMSocialSinaHandler openSSOWithRedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    
    //设置分享到QQ空间的应用Id，和分享url 链接
    [UMSocialQQHandler setQQWithAppId:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"QQAppId"]
                               appKey:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"QQAppSecret"]
                                  url:@"http://www.51rebo.cn"];
    
    
    //设置微信AppId，设置分享url，默认使用友盟的网址
    [UMSocialWechatHandler setWXAppId:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"WXAppId"] appSecret:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"WXAppSecret"] url:@"http://www.51rebo.cn"];
    
    
    //打开腾讯微博SSO开关，设置回调地址,需要 #import "UMSocialTencentWeiboHandler.h"
    //    [UMSocialTencentWeiboHandler openSSOWithRedirectUrl:@"http://sns.whalecloud.com/tencent2/callback"];
    
    //设置支持没有客户端情况下使用SSO授权
    [UMSocialQQHandler setSupportWebView:YES];
    
    [self initMobClick:appkey];
    
}

- (void)initMobClick:(NSString *)appkey
{
    //使用友盟统计
    [MobClick startWithAppkey:appkey];
    
#ifdef DEBUG
    [MobClick setLogEnabled:YES];
#endif//DEBUG
    
}

#pragma mark - 跳转到主页
- (void)showHomeView
{
    //
    MainViewController *mainViewController = [[MainViewController alloc] init];
    _navigationController = [[UINavigationController alloc] initWithRootViewController:mainViewController];
    
    _lrSliderMenuViewController = [[EWPSliderMenuViewController alloc] initWithRootViewController:_navigationController leftViewController:nil rightViewController:nil];
    _lrSliderMenuViewController.canShowRight = NO;
    
    _lrSliderMenuViewController.view.backgroundColor = [UIColor whiteColor];
    
    //    _lrSliderMenuViewController = [[EWPSliderMenuViewController alloc] initWithRootViewController:_navigationController leftViewController:[[LeftMenuViewController alloc] init] rightViewController:nil];
    //    _lrSliderMenuViewController.canShowRight = NO;
    //    if (SCREEN_HEIGHT == 480)
    //    {
    //        _lrSliderMenuViewController.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"sliderMenuBK960"]];
    //    }
    //    else if (SCREEN_HEIGHT == 568)
    //    {
    //        _lrSliderMenuViewController.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"sliderMenuBK1136"]];
    //    }
    
    self.window.rootViewController = _lrSliderMenuViewController;
    
    
}


#pragma mark - NewGuideViewDelegate
- (void)guideViewController:(EWPGuideViewController *)guideViewController clickAtIndex:(NSInteger)index
{
    [self showHomeView];
    
    if ([_startupPages count])
    {
        StartupPageData *startupPageData = [_startupPages objectAtIndex:index];
        if (startupPageData.actiontype == 1)
        {
            ActivityUrlViewController *viewController = [[ActivityUrlViewController alloc] init];
            viewController.activityUrl = startupPageData.data;
            viewController.title = startupPageData.title;
            [self.navigationController pushViewController:viewController animated:YES];
        }
        else if (startupPageData.actiontype == 2)
        {
            LiveRoomViewController *viewController = [[LiveRoomViewController alloc] init];
            viewController.staruserid = [startupPageData.data integerValue];
            [self.navigationController pushViewController:viewController animated:YES];
        }
        else if (startupPageData.actiontype == 3)
        {
            MallViewController *viewController = [[MallViewController alloc] init];
            [self.navigationController pushViewController:viewController animated:YES];
        }
        
        else if (startupPageData.actiontype == 4)
        {
            //跳转到充值
            
            SelectModePaymentViewController *viewController = [[SelectModePaymentViewController alloc] init];
            [self.navigationController pushViewController:viewController animated:YES];
            
        }else if (startupPageData.actiontype == 5)
        {
            InviterFriendViewController *viewCpmtroller = [[InviterFriendViewController alloc] init];
            [self.navigationController pushViewController:viewCpmtroller animated:YES];
        }
        
    }
}

- (void)guideViewScrollFinsh
{
    [self showHomeView];
}


#pragma mark __客户端打开签到请求
-(void)openClient
{
    SignInModel *signInModel = [[SignInModel alloc] init];
    [signInModel requestDataWithParams:nil success:^(id object)
     {
         if (signInModel.result == 0)
         {
             
         }
     }
                                  fail:^(id object)
     {
         
     }];
    
}
-(void)addDDLog{
    
    //配置参数
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    [[DDTTYLogger sharedInstance] setColorsEnabled:YES];
    DDFileLogger *fileLogger = [[DDFileLogger alloc] init];
    fileLogger.rollingFrequency = 60 * 60 * 24; // 24 hour rolling
    fileLogger.logFileManager.maximumNumberOfLogFiles = 7;
    [DDLog addLogger:fileLogger];
    
    
      //自定义颜色
#if TARGET_OS_IPHONE
    UIColor *pink = [UIColor colorWithRed:(255/255.0) green:(58/255.0) blue:(159/255.0) alpha:1.0];
#else
    NSColor *pink = [NSColor colorWithCalibratedRed:(255/255.0) green:(58/255.0) blue:(159/255.0) alpha:1.0];
#endif
    [[DDTTYLogger sharedInstance] setForegroundColor:pink backgroundColor:nil forFlag:DDLogFlagInfo];
    
    
#if TARGET_OS_IPHONE
    UIColor *gray = [UIColor grayColor];
#else
    NSColor *gray = [NSColor grayColor];
#endif
    [[DDTTYLogger sharedInstance] setForegroundColor:gray backgroundColor:nil forFlag:DDLogFlagVerbose];
    
}

@end
