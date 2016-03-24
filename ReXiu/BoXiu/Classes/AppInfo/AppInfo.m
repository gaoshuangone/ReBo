
//  AppInfo.m
//  BoXiu
//
//  Created by andy on 14-5-4.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//
#import "AFNetworking.h"
#import "AppInfo.h"
#import "GetConfigModel.h"
#import "LoginModel.h"
#import "UserInfoManager.h"
#import "LoginViewController.h"
#import "NSString+DES.h"
#import "HideRechargeMenuModel.h"
#import "UMessage.h"
#import "BThirdLoginModel.h"
#import "ThirdLoginModel.h"
#import "UMSocial.h"
#import "GetUserInfoModel.h"
#import "VerifyAppStoreRechargeModel.h"
#import "DataBaseManager.h"
#import "VerifyAppStoreRechargeModel.h"
#import "SFHFKeychainUtils.h"
#import "GetSystemTimeModel.h"
#import "KeychainItemWrapper.h"
#import "Reachability.h"
#include <sys/sysctl.h>

#import "GetUserInfoModel.h"
#define ServiceName @"cn.ourebo.ReBo.BoXiu" 
#define DeviceToken @"DeviceToken"

#define APPSTORE_RECHARGE_TABLE @"appstore"
#define REPEAT_MAXCOUNT (5)
#define REPEAT_INTERVAL (60)
@interface AppInfo ()

@property (nonatomic,strong) NSMutableArray *appstoreRechargeInfos;
@property (nonatomic,assign) NSInteger repeatCount;//法术失败次数


@end

@implementation AppInfo

+ (AppInfo *)shareInstance
{
    static dispatch_once_t predicate;
    static id instance;
    dispatch_once(&predicate,^{
        instance = [[self alloc] init];
    });
    return instance;
}


//唯一标识别
+(NSString *)deviceUUID
{
    if (  ([AppInfo shareInstance].udid  != nil)) {
        return [AppInfo shareInstance].udid;
    }
 
    KeychainItemWrapper *keychainItem= [[KeychainItemWrapper alloc]initWithIdentifier:@"UUID"accessGroup:nil];
    
    NSString *strUUID = [keychainItem objectForKey:(__bridge id)kSecValueData];
    
    if ([strUUID isEqualToString:@""])
        
    {
        CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
        
        strUUID = (NSString *)CFBridgingRelease(CFUUIDCreateString (kCFAllocatorDefault,uuidRef));
        
        [keychainItem setObject:strUUID forKey:(__bridge id)kSecValueData];
        
    }
    [AppInfo shareInstance].udid = strUUID;
    return strUUID;
//    return  [[UIDevice currentDevice].identifierForVendor UUIDString];
}

- (id)init
{
    self = [super init];
    if (self)
    {
        //初始化服务器地址
        [self initAppBaseUrl];
        self.bFirstEnterMainView = YES;
        self.bOldLoginState = NO;
        self.bLoginSuccess = NO;
        self.isHaiBaoUp = YES;
        self.res_server = self.resourceBaseUrl;
        self.heart_time = 60;
        self.hideSwitch = @"11";
        char debugDeviceToken[256] = {51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65};
        self.deviceToken = [NSString stringWithUTF8String:debugDeviceToken];
        
        [self addObserver:self forKeyPath:@"bLoginSuccess" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

- (NSString *)deviceToken
{
    if (_deviceToken == nil)
    {
        NSError *erro = nil;
        NSString *deviceToken = [SFHFKeychainUtils getPasswordForUsername:DeviceToken andServiceName:ServiceName error:&erro];
        if (deviceToken && deviceToken.length > 0)
        {
            _deviceToken = deviceToken;
            return _deviceToken;
        }
        else
        {
            deviceToken = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
            BOOL result = [SFHFKeychainUtils storeUsername:DeviceToken andPassword:deviceToken forServiceName:ServiceName updateExisting:YES error:&erro];
            if (result)
            {
                _deviceToken = deviceToken;
            }
            else
            {
                char debugDeviceToken[256] = {51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65};
                _deviceToken = [NSString stringWithUTF8String:debugDeviceToken];
            }
        }
    }
    return _deviceToken;
}
//复制到main
- (void)initConfigInfo
{
    //初始化消息中心，登录成功装在消息
    self.messageCenter =  [MessageCenter shareMessageCenter];

    if(self.initCoinfigState != 0)
    {
        return;
    }
    
    self.initCoinfigState = 1;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        GetConfigModel *getConfigModel = [[GetConfigModel alloc] init];
        [getConfigModel requestDataWithParams:nil success:^(id sender){
            if (getConfigModel.result ==  0)
            {
                self.initCoinfigState = 2;//初始化完成
                self.res_server = getConfigModel.res_server;
                long time = getConfigModel.heart_time/1000;
                self.online_stars_location = getConfigModel.online_stars_location;
                if (time != 0)
                {
                    self.heart_time = time;
                }
            }
            else
            {
                self.initCoinfigState = 0;
            }
        }
        fail:^(id sender)
         {
             self.initCoinfigState = 0;
         }];
    });
    

    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        HideRechargeMenuModel *model = [[HideRechargeMenuModel alloc] init];
        [model requestDataWithParams:nil success:^(id object) {
            if (model.result == 0)
            {
                self.hideSwitch = model.hideSwitch;
            }

        } fail:^(id object) {
    
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

- (void)updateLivingButton
{
    BaseHttpModel *model = [[BaseHttpModel alloc] init];
    [model requestDataWithMethod:ShowLiveBtnOnMobile_Method params:nil success:^(id object)
     {
//         code = 1;
//         data = "";
//         msg = "broadcast:4";
//         result = 0;
//         title = "";
         if (model.result == 0)
         {
             if (model.code == 1)
             {
                 self.bShowLivingButton = YES;
             }
             else
             {
                 self.bShowLivingButton = NO;
              
             }
         
             
             
             [[NSNotificationCenter defaultCenter]postNotificationName:@"ShowLiveBtnOnMobile" object:self userInfo:@{@"bool":[NSNumber numberWithBool:self.bShowLivingButton]}];
         }else{
             if (model.code == 403)
             {
                 [[AppInfo shareInstance] loginOut];
                 [[NSNotificationCenter defaultCenter]postNotificationName:@"showOherTerminalLoggedDialog" object:self userInfo:nil];//多端登录的情况
                 
             }
         }
     } fail:^(id object)
     {
//         [AppInfo shareInstance].bShowLivingButton = NO;
     }];
}

- (void)initAppBaseUrl
{
    BOOL isTestVersion = [[[NSBundle mainBundle] objectForInfoDictionaryKey:@"Test_Version"] boolValue];
    if (isTestVersion)
    {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *serverType = [defaults objectForKey:@"serverType"];
        if (serverType)
        {
            self.serverType = [serverType integerValue];
        }
        else
        {
            self.serverType = 3;
        }
        
        NSString *serverBaseUrl = [defaults objectForKey:@"serverBaseUrl"];
        if (serverBaseUrl)
        {
            self.serverBaseUrl = serverBaseUrl;
        }
        else
        {
            self.serverBaseUrl = Test_ServerBaseUrl;
        }
        
        NSString *requestServerBaseUrl = [defaults objectForKey:@"requestServerBaseUrl"];
        if (requestServerBaseUrl)
        {
            self.requestServerBaseUrl = requestServerBaseUrl;
        }
        else
        {
            self.requestServerBaseUrl = Test_Request_ServerBaseUrl;
        }
        
        NSString *resourceBaseUrl = [defaults objectForKey:@"resourceBaseUrl"];
        if (resourceBaseUrl)
        {
            self.resourceBaseUrl = resourceBaseUrl;
        }
        else
        {
            self.resourceBaseUrl = Test_ResourceBaseUrl;
        }
        
        NSString *protocolUrl = [defaults objectForKey:@"protocolUrl"];
        if (protocolUrl)
        {
            self.protocolUrl = protocolUrl;
        }
        else
        {
            self.protocolUrl = Test_PROTOCOL_URL;
        }
    }
    else
    {
        self.serverType = 5;//测试现网
        self.serverBaseUrl = ServerBaseUrl;
        self.requestServerBaseUrl = Request_ServerBaseUrl;
        self.resourceBaseUrl = ResourceBaseUrl;
        self.protocolUrl = PROTOCOL_URL;
    }

}

- (void)saveServerType:(NSInteger)type
{
    self.serverType = type;
    switch (type)
    {
        case 1:
        {
            self.serverBaseUrl = QXQ_ServerBaseUrl;
            self.requestServerBaseUrl = QXQ_Request_ServerBaseUrl;
            self.resourceBaseUrl = QXQ_ResourceBaseUrl;
            self.protocolUrl = QXQ_PROTOCOL_URL;
        }
            break;
        case 2:
        {
            self.serverBaseUrl = ZhouFeng_ServerBaseUrl;
            self.requestServerBaseUrl = ZhouFeng_Request_ServerBaseUrl;
            self.resourceBaseUrl = ZhouFeng_ResourceBaseUrl;
            self.protocolUrl = ZhouFeng_PROTOCOL_URL;
        }
            break;
        case 3:
        {
            self.serverBaseUrl = Test_ServerBaseUrl;
            self.requestServerBaseUrl = Test_Request_ServerBaseUrl;
            self.resourceBaseUrl = Test_ResourceBaseUrl;
            self.protocolUrl = Test_PROTOCOL_URL;
        }
            break;
        case 4:
        {
            self.serverBaseUrl = Model_ServerBaseUrl;
            self.requestServerBaseUrl = Model_Request_ServerBaseUrl;
            self.resourceBaseUrl = Model_ResourceBaseUrl;
            self.protocolUrl = Model_PROTOCOL_URL;
        }
            break;
        case 5:
        {
            self.serverBaseUrl = ServerBaseUrl;
            self.requestServerBaseUrl = Request_ServerBaseUrl;
            self.resourceBaseUrl = ResourceBaseUrl;
            self.protocolUrl = PROTOCOL_URL;
        }
            break;
        case 6:
        {
            self.serverBaseUrl = TYW_ServerBaseUrl;
            self.requestServerBaseUrl = TYW_Request_ServerBaseUrl;
            self.resourceBaseUrl = TYW_ResourceBaseUrl;
            self.protocolUrl = TYW_PROTOCOL_URL;
        }
            break;
        case 7:
        {
            self.serverBaseUrl = Test1_ServerBaseUrl;
            self.requestServerBaseUrl = Test1_Request_ServerBaseUrl;
            self.resourceBaseUrl = Test_ResourceBaseUrl;
            self.protocolUrl = Test_PROTOCOL_URL;
        }
            break;
        default:
            break;
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[NSNumber numberWithInteger:self.serverType] forKey:@"serverType"];
    [defaults setObject:self.serverBaseUrl forKey:@"serverBaseUrl"];
    [defaults setObject:self.requestServerBaseUrl forKey:@"requestServerBaseUrl"];
    [defaults setObject:self.resourceBaseUrl forKey:@"resourceBaseUrl"];
    [defaults setObject:self.protocolUrl forKey:@"protocolUrl"];
    [defaults synchronize];
}

- (void)saveLogin:(NSString *)loginName password:(NSString *)loginPassword loginType:(NSInteger)loginType autoRegistUser:(BOOL)bAutoUser
{
    
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
    
    
    self.loginType = loginType;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:loginName forKey:@"login_name"];
    [defaults setObject:loginPassword forKey:@"login_password"];
    [defaults setObject:[NSNumber numberWithBool:bAutoUser] forKey:@"auto_user"];
    [defaults setObject:[NSNumber numberWithInteger:loginType] forKey:@"loginType"];
    [defaults synchronize];
    
}

- (void)removeLoginName:(BOOL)remove
{
    if (remove)
    {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults removeObjectForKey:@"login_name"];
        [defaults removeObjectForKey:@"login_password"];
    }
    else
    {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults removeObjectForKey:@"login_password"];
        [defaults synchronize];
    }
}


- (void)saveLogin:(NSString *)loginName password:(NSString *)loginPassword
{
    [self saveLogin:loginName password:loginPassword loginType:3 autoRegistUser:NO];
}

- (NSString *)getSavedLoginName
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *loginName=[defaults objectForKey:@"login_name"];
    return loginName;
}

- (NSString *)getSavedPassword
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *password=[defaults objectForKey:@"login_password"];
    return password;
}

- (BOOL) isAutoUser
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber *autoUser=[defaults objectForKey:@"auto_user"];
    return [autoUser boolValue];
}

- (void)loginOut
{
    [UMessage unregisterForRemoteNotifications];//关闭消息通知
    
    self.bFirstExitFromSetting = YES;
    self.bOldLoginState = self.bLoginSuccess;
    NSString *strUserId = [NSString stringWithFormat:@"%ld",(long)[UserInfoManager shareUserInfoManager].currentUserInfo.userId];
    [UMessage removeAlias:strUserId type:@"userid" response:^(id responseObject, NSError *error) {
    }];
    
    self.bLoginSuccess = NO;
//    if (self.loginType == 3)
//    {
//        [self removeLoginName:NO];
//    }
//    else
//    {
//        [self removeLoginName:YES];
//    }
    NSUserDefaults* defaultt = [NSUserDefaults standardUserDefaults];
    if ([[defaultt valueForKey:@"loginType"] integerValue ]== 3) {
        [self removeLoginName:NO];
    }else{
             [self removeLoginName:YES];
    }
    
    [UserInfoManager shareUserInfoManager].tempHederImage = nil;
    [UserInfoManager shareUserInfoManager].currentUserInfo = nil;
//    [MessageCenter shareMessageCenter].unReadCount = 0;
    [AppInfo shareInstance].bLoginSuccess = NO;
    self.bShowLivingButton = NO;
}

- (void)autoLogin:(LoginResultSuccess)success fail:(LoginResultFail)fail
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *loginType = [defaults objectForKey:@"loginType"];
    if (loginType)
    {
        NSString *loginName = [defaults objectForKey:@"login_name"];
        NSString *loginPassword = [defaults objectForKey:@"login_password"];
        
        if (!loginName || !loginPassword)
        {
            return;
        }
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        
        [dict setObject:loginName forKey:@"username"];
        [dict setObject:loginPassword forKey:@"password"];
        [dict setObject:[NSNumber numberWithBool:YES] forKey:@"autoLogin"];
        [dict setObject:[NSNumber numberWithBool:YES] forKey:@"passwordEncoded"];
        LoginModel *loginModel = [[LoginModel alloc] init];
        [loginModel requestDataWithParams:dict success:^(id sender)
         {
             if (loginModel.result == 0)
             {
                 UserInfo *currentUserInfo = [[UserInfo alloc] init];
                 currentUserInfo.userId = loginModel.userid;
                 currentUserInfo.loginname = loginModel.loginname;
                 currentUserInfo.nick = loginModel.nick;
                 currentUserInfo.password = loginModel.password;
                 currentUserInfo.passwordnotset = loginModel.passwordnotset;
                 currentUserInfo.idxcode = loginModel.idxcode;
                 currentUserInfo.isstar = loginModel.isstar;
                 currentUserInfo.issupermanager = loginModel.issupermanager;
                 currentUserInfo.sex = loginModel.sex;
                 currentUserInfo.photo = loginModel.photo;
                 currentUserInfo.coin = loginModel.coin;
                 currentUserInfo.phone = loginModel.phone;
                 currentUserInfo.isPurpleVip = loginModel.isPurpleVip;
                 currentUserInfo.isYellowVip = loginModel.isYellowVip;
                 currentUserInfo.consumerlevelweight = [UserInfo switchConsumerlevelweight:loginModel.consumerlevelweight];//loginModel.consumerlevelweight;
                 currentUserInfo.token = loginModel.token;
                 currentUserInfo.authstatus = loginModel.authstatus;
                 currentUserInfo.hidden = loginModel.hidden;
                 
                 
                 self.userInfoSingle = currentUserInfo;
                 self.loginType = [loginType integerValue];
                 //根据umeng 后台需要绑定设备别名
                 NSString *strUserId = [NSString stringWithFormat:@"%d",loginModel.userid];
                 [UMessage addAlias:strUserId type:@"userid" response:^(id responseObject, NSError *error) {
                }];
                 [UserInfoManager shareUserInfoManager].currentUserInfo = currentUserInfo;
                 if (success)
                 {
                     success();
                 }
             }
             else
             {
                 [UserInfoManager shareUserInfoManager].currentUserInfo = nil;
                 if (fail)
                 {
                     if (loginModel.code == LOGIN_REPEAT)
                     {
                         NSString *erro = @"已经在其他设备上登录，请重新登录";
                         if (loginModel.msg && [loginModel.msg length] > 0)
                         {
                             erro = loginModel.msg;
                         }
                         fail(loginModel.msg);
                     }
                     
                 }
             }
             [[NSNotificationCenter defaultCenter]postNotificationName:@"getUserInfo" object:nil];
               [[NSNotificationCenter defaultCenter]postNotificationName:@"ShowLiveBtnOnMain" object:self userInfo:nil];
             [self updateLivingButton];
           
         }
        fail:^(id sender)
         {
             
             if (fail)
             {
                 fail(nil);
             }
         }];
    }
}

- (void)loginWithUserName:(NSString *)username password:(NSString *)password success:(LoginResultSuccess)success fail:(LoginResultFail)fail
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:username forKey:@"username"];
    [dict setObject:[[ReXiuLib shareInstance] DESEncryptWithKey:password] forKey:@"password"];
    __weak typeof(self) weakSelf = self;
    LoginModel *model = [[LoginModel alloc] init];
    [model requestDataWithParams:dict success:^(id object) {
        /*成功返回数据*/
        __strong typeof(self) strongSelf = weakSelf;
        if (model.result == 0)
        {
            strongSelf.bOldLoginState = [AppInfo shareInstance].bLoginSuccess;
            strongSelf.bLoginSuccess = YES;

            UserInfo *currentUserInfo = [[UserInfo alloc] init];
            currentUserInfo.userId = model.userid;
            currentUserInfo.loginname = model.loginname;
            currentUserInfo.nick = model.nick;
            currentUserInfo.password = model.password;
            currentUserInfo.passwordnotset = model.passwordnotset;
            currentUserInfo.idxcode = model.idxcode;
            currentUserInfo.isstar = model.isstar;
            currentUserInfo.issupermanager = model.issupermanager;
            currentUserInfo.sex = model.sex;
            currentUserInfo.photo = model.photo;
            currentUserInfo.coin = model.coin;
            currentUserInfo.phone = model.phone;
            currentUserInfo.isPurpleVip = model.isPurpleVip;
            currentUserInfo.isYellowVip = model.isYellowVip;
            currentUserInfo.consumerlevelweight = [UserInfo switchConsumerlevelweight:model.consumerlevelweight];//model.consumerlevelweight;
            currentUserInfo.token = model.token;
            currentUserInfo.authstatus = model.authstatus;
            currentUserInfo.rewards = model.rewards;
            
            [UserInfoManager shareUserInfoManager].currentUserInfo = currentUserInfo;
            
            self.userInfoSingle = currentUserInfo;
            
            [strongSelf saveLogin:[dict objectForKey:@"username"] password:model.password];
            
            //根据umeng 后台需要绑定设备别名
            NSString *strUserId = [NSString stringWithFormat:@"%d",model.userid];
            [UMessage addAlias:strUserId type:@"userid" response:^(id responseObject, NSError *error) {
            }];
            
            
            if (success)
            {
                success();
            }
            
            [self updateLivingButton];
            
                        [[NSNotificationCenter defaultCenter]postNotificationName:@"getUserInfo" object:nil];
        }
        else
        {
            [UserInfoManager shareUserInfoManager].currentUserInfo = nil;
            if (fail)
            {
                fail(model.msg);
            }
        }

        
        
    } fail:^(id object) {
        /*失败返回数据*/
    }];
}

- (void)loginWithAccount:(NSString *)account  nick:(NSString *)nick withHeadUrl:(NSString*)headUrl token:(NSString *)token type:(NSInteger)type success:(LoginResultSuccess)success fail:(LoginResultFail)fail
{
    BThirdLoginModel *model = [[BThirdLoginModel alloc] init];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:account forKey:@"account"];
    [params setObject:token forKey:@"token"];
    [params setObject:[NSNumber numberWithInteger:type] forKey:@"type"];
    NSString *sign = [NSString stringWithFormat:@"%@%@%ld",account,token,(long)type];
    [params setObject:[[ReXiuLib shareInstance] DESEncryptWithKey:sign] forKey:@"sign"];
    __weak typeof(self) weaSelf = self;
    [model requestDataWithParams:params success:^(id object) {
        __strong typeof(self) strongSelf = weaSelf;
        if (model.result == 0)
        {
            [strongSelf login2WithAccount:account nick:nick withHeadUrl:headUrl token:token type:type success:success fail:fail];
        
        }
        else
        {
            if ([AppInfo shareInstance].loginType == 1)
            {
                [[UMSocialDataService defaultDataService] requestUnOauthWithType:UMShareToQQ  completion:^(UMSocialResponseEntity *response){
                    EWPLog(@"response is %@",response);
                }];
            }
            else if ([AppInfo shareInstance].loginType == 2)
            {
                [[UMSocialDataService defaultDataService] requestUnOauthWithType:UMShareToSina  completion:^(UMSocialResponseEntity *response){
                    EWPLog(@"response is %@",response);
                }];
            }
            else if ([AppInfo shareInstance].loginType == 4)
            {
                [[UMSocialDataService defaultDataService] requestUnOauthWithType:UMShareToWechatSession  completion:^(UMSocialResponseEntity *response){
                    EWPLog(@"response is %@",response);
                }];

            }
            
            if (fail)
            {
                fail(model.msg);
            }
        }
        
        [self updateLivingButton];
          [[NSNotificationCenter defaultCenter]postNotificationName:@"getUserInfo" object:nil];
        
    } fail:^(id object) {
        
    }];
}


- (void)login2WithAccount:(NSString *)account nick:(NSString *)nick  withHeadUrl:(NSString*)headUrl token:(NSString *)token type:(NSInteger)type  success:(LoginResultSuccess)success fail:(LoginResultFail)fail
{
    ThirdLoginModel *model = [[ThirdLoginModel alloc] init];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:account forKey:@"account"];
    [params setObject:nick forKey:@"nick"];
    [params setObject:token forKey:@"token"];
      [params setObject:headUrl forKey:@"photo"];
    [params setObject:[NSNumber numberWithInteger:type] forKey:@"type"];
    
    __weak typeof(self) weaSelf = self;
    [model requestDataWithParams:params success:^(id object) {
        __strong typeof(self) strongSelf = weaSelf;
        if (model.result == 0)
        {
            UserInfo *currentUserInfo = [[UserInfo alloc] init];
            currentUserInfo.userId = model.userid;
            currentUserInfo.loginname = model.loginname;
            currentUserInfo.nick = model.nick;
            currentUserInfo.password = model.password;
            currentUserInfo.idxcode = model.idxcode;
            currentUserInfo.isstar = model.isstar;
            currentUserInfo.issupermanager = model.issupermanager;
            currentUserInfo.sex = model.sex;
            currentUserInfo.photo = model.photo;
            currentUserInfo.coin = model.coin;
            currentUserInfo.phone = model.phone;
            currentUserInfo.consumerlevelweight = [UserInfo switchConsumerlevelweight:model.consumerlevelweight];//model.consumerlevelweight;
            currentUserInfo.token = model.token;
            currentUserInfo.authstatus = model.authstatus;
            [UserInfoManager shareUserInfoManager].currentUserInfo = currentUserInfo;
            [strongSelf saveLogin:currentUserInfo.loginname password:currentUserInfo.password loginType:type autoRegistUser:NO];
             self.userInfoSingle = currentUserInfo;
            //根据umeng 后台需要绑定设备别名
            NSString *strUserId = [NSString stringWithFormat:@"%d",model.userid];
            [UMessage addAlias:strUserId type:@"userid" response:^(id responseObject, NSError *error) {

            }];
            if (success)
            {
                success();
            }
        }
        else
        {
            [UserInfoManager shareUserInfoManager].currentUserInfo = nil;
            if (fail)
            {
                fail(model.msg);
            }
        }
        [self updateLivingButton];
        
          [[NSNotificationCenter defaultCenter]postNotificationName:@"getUserInfo" object:nil];
        
    } fail:^(id object) {
        
    }];
}


- (void)refreshCurrentUserInfo:(void (^)(void))complete
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        UserInfo *userInfo = [UserInfoManager shareUserInfoManager].currentUserInfo;
        if (userInfo)
        {
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            [dict setObject:[NSNumber numberWithInteger:userInfo.userId] forKey:@"userid"];//新本用token请求，不用参数，暂时不做修改
            GetUserInfoModel *model = [[GetUserInfoModel alloc] init];
            [model requestDataWithParams:dict success:^(id object) {
                /*成功返回数据*/
                if (model.result == 0)
                {
                    if (model.userInfo)
                    {
                        //更新信息
                        userInfo.bean = model.userInfo.bean;
                        userInfo.coin = model.userInfo.coin;
                        userInfo.consumerlevelweight = model.userInfo.consumerlevelweight;
                        userInfo.hidden = model.userInfo.hidden;
                        userInfo.isPurpleVip = model.userInfo.isPurpleVip;
                        userInfo.isYellowVip = model.userInfo.isYellowVip;
                        userInfo.isstar = model.userInfo.isstar;
                        userInfo.issupermanager = model.userInfo.issupermanager;
                        userInfo.nick = model.userInfo.nick;
                        userInfo.photo = model.userInfo.photo;
                        userInfo.privlevelweight = model.userInfo.privlevelweight;
                        userInfo.sex = model.userInfo.sex;
                        
                  
                        [UserInfoManager shareUserInfoManager].currentUserInfo.introduction = model.userInfo.introduction;
                        [UserInfoManager shareUserInfoManager].hidden = model.userInfo.hidden;
                        NSLog(@"%ld", (long)[UserInfoManager shareUserInfoManager].hidden);
                        [UserInfoManager shareUserInfoManager].currentUserInfo = userInfo;
                        
                         self.userInfoSingle = userInfo;
                        if (complete)
                        {
                            complete();
                        }
                    }
                    
                }
                
            } fail:^(id object) {
                /*失败返回数据*/
                
            }];
        };
    });
}

//装载存在本地的appstore信息
- (void)loadAppStoreRechargeInfo
{
    BOOL exsit = [[DataBaseManager shareDataBaseManager] isExistOfTable:APPSTORE_RECHARGE_TABLE];
    if (!exsit)
    {
        //如果第一次创建,直接返回
        NSArray *keyArray = @[@"userId",@"tradeno",@"costmoney",@"receiptdata"];
        [[DataBaseManager shareDataBaseManager] createTableWithName:APPSTORE_RECHARGE_TABLE keys:keyArray];
        return;
    }
    else
    {
        NSArray *dataArray = [[DataBaseManager shareDataBaseManager] queryTableWithName:APPSTORE_RECHARGE_TABLE sortByTime:YES];

        if (dataArray && dataArray.count)
        {
            if (_appstoreRechargeInfos == nil)
            {
                _appstoreRechargeInfos = [NSMutableArray array];
            }
            [_appstoreRechargeInfos removeAllObjects];
            
            UserInfo *userInfo = [UserInfoManager shareUserInfoManager].currentUserInfo;
            for (NSDictionary *dictionary in dataArray)
            {
                if (dictionary)
                {
                    NSInteger userId = [[dictionary objectForKey:@"userId"] integerValue];
                    if (userId == userInfo.userId)
                    {
                        AppStoreRechargeInfo *appstoreRechargeInfo = [[AppStoreRechargeInfo alloc] init];
                        appstoreRechargeInfo.userId = [[dictionary objectForKey:@"userId"] integerValue];
                        appstoreRechargeInfo.tradeno = [dictionary objectForKey:@"tradeno"];
                        appstoreRechargeInfo.costmoney = [dictionary objectForKey:@"costmoney"];
                        appstoreRechargeInfo.receiptdata = [dictionary objectForKey:@"receiptdata"];
                        [_appstoreRechargeInfos addObject:appstoreRechargeInfo];
                    }
                  
                }
            }
            [self sendAppStoreRechargeInfoToServer];
        }
        

    }
}

//如果本地有appsote信息的话想服务器发送
- (void)sendAppStoreRechargeInfoToServer
{
    if (_appstoreRechargeInfos.count)
    {
        AppStoreRechargeInfo *appstoreRechargeInfo = [_appstoreRechargeInfos firstObject];
        if (appstoreRechargeInfo)
        {
            NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
            [dictionary setObject:appstoreRechargeInfo.receiptdata forKey:@"receiptdata"];
            [dictionary setObject:appstoreRechargeInfo.costmoney forKey:@"costmoney"];
            [dictionary setObject:appstoreRechargeInfo.tradeno forKey:@"tradeno"];
            
            VerifyAppStoreRechargeModel *model = [[VerifyAppStoreRechargeModel alloc] init];
            [model requestDataWithParams:dictionary success:^(id object) {
                if (model.result == 0)
                {
                    self.repeatCount = 0;
                    [self deleteLocalAppstoreRechargeInfo:appstoreRechargeInfo];
                    [UserInfoManager shareUserInfoManager].currentUserInfo.coin = model.coin;
                    
                    //发送下一条
                    [self performSelector:@selector(sendAppStoreRechargeInfoToServer) withObject:nil];
                }
                else
                {
                    if (self.repeatCount > 5)
                    {
                        return ;
                    }
                    self.repeatCount++;
                    [self performSelector:@selector(sendAppStoreRechargeInfoToServer) withObject:nil afterDelay:REPEAT_INTERVAL];
                }
            } fail:^(id object) {
                if (self.repeatCount > 5)
                {
                    return ;
                }
                self.repeatCount++;
                [self performSelector:@selector(sendAppStoreRechargeInfoToServer) withObject:nil afterDelay:REPEAT_INTERVAL];
            }];
            
        }
    }
   
}

//保存appstore交易信息到本地
- (BOOL)saveAppStoreRecharegeInfo:(AppStoreRechargeInfo *)appStoreRechargeInfo;
{
    BOOL result = NO;
    if (appStoreRechargeInfo)
    {
        if (_appstoreRechargeInfos == nil)
        {
            _appstoreRechargeInfos = [NSMutableArray array];
        }
        [_appstoreRechargeInfos addObject:appStoreRechargeInfo];
    }
    
    //2分钟之后检查一下
    [self performSelector:@selector(sendAppStoreRechargeInfoToServer) withObject:nil afterDelay:REPEAT_INTERVAL];
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    [dictionary setObject:appStoreRechargeInfo.tradeno forKey:@"tradeno"];
    [dictionary setObject:appStoreRechargeInfo.costmoney forKey:@"costmoney"];
    [dictionary setObject:appStoreRechargeInfo.receiptdata forKey:@"receiptdata"];
    [dictionary setObject:[NSNumber numberWithInteger:appStoreRechargeInfo.userId] forKey:@"userId"];
    result = [[DataBaseManager shareDataBaseManager] insertDataToTable:APPSTORE_RECHARGE_TABLE keyAndValue:dictionary];
    return result;
}

//删除本地保存的appstore信息
- (BOOL)deleteLocalAppstoreRechargeInfo:(AppStoreRechargeInfo *)appStoreRechargeInfo
{
    BOOL result = NO;
    if (appStoreRechargeInfo)
    {
        if (_appstoreRechargeInfos && _appstoreRechargeInfos.count)
        {
            [_appstoreRechargeInfos removeObject:appStoreRechargeInfo];
            NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
            [dictionary setObject:appStoreRechargeInfo.tradeno forKey:@"tradeno"];
            result = [[DataBaseManager shareDataBaseManager] deleteDataFromTable:APPSTORE_RECHARGE_TABLE conditionKeyAndValue:dictionary];
        }
    }
    return result;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
//    if ( [keyPath isEqualToString:@"bLoginSuccess"])
//    {
//        BOOL bLoginSuccess = [[change objectForKey:NSKeyValueChangeNewKey] boolValue];
//        if (bLoginSuccess)
//        {
//            [self performSelector:@selector(loadAppStoreRechargeInfo) withObject:nil];
//        }
//        
//    }
}

#pragma mark -如果不是viewcontroller的话，调用
- (void)showNoticeInWindow:(NSString *)message duration:(CGFloat)duration
{
    if (message != nil && [message length])
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
            MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithWindow:keyWindow];
            HUD.yOffset = 200;
            HUD.margin = 5;
            HUD.labelFont = [UIFont systemFontOfSize:14.0f];
            HUD.removeFromSuperViewOnHide=YES;
            HUD.mode = MBProgressHUDModeCustomView;
            CGSize size = [CommonFuction sizeOfString:message maxWidth:300 maxHeight:100 withFontSize:14.0f];
            UILabel *messageLable = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, size.width + 10, size.height + 10)];
            messageLable.font = [UIFont systemFontOfSize:14.0f];
            messageLable.numberOfLines = 0;
            messageLable.lineBreakMode = NSLineBreakByWordWrapping;
            messageLable.textAlignment = NSTextAlignmentCenter;
            messageLable.alpha = 0.8;
            messageLable.layer.cornerRadius = 12.0f;
            messageLable.backgroundColor = [UIColor clearColor];
            messageLable.textColor = [UIColor whiteColor];
            messageLable.text = message;
            HUD.customView = messageLable;
            [keyWindow addSubview:HUD];
            [HUD show:YES];
            [HUD hide:YES afterDelay:duration];
        });
    }
    
}

+(NSString*)getMachineplatform{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *name = malloc(size);
    sysctlbyname("hw.machine", name, &size, NULL, 0);
    
    NSString *platform = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
    
    free(name);
    return platform;
}


+(BOOL)ip4{

 NSString* platform = [AppInfo getMachineplatform];
    if ([platform isEqualToString:@"iPhone3,1"]||[platform isEqualToString:@"iPhone3,2"]||[platform isEqualToString:@"iPhone3,3"]||[platform isEqualToString:@"iPhone4,1"])
    {
       return YES;
    }else{
        return NO;
    }
    
    
    
}

+(BOOL)ip5{//5 && 5c & 5s
    NSString* platform = [AppInfo getMachineplatform];
    
    if ([platform isEqualToString:@"iPhone5,1"]||[platform isEqualToString:@"iPhone5,2"]||[platform isEqualToString:@"iPhone5,3"]||[platform isEqualToString:@"iPhone5,4"]||[platform isEqualToString:@"iPhone6,1"]||[platform isEqualToString:@"iPhone6,2"])
    {
        return YES;
    }else{
        return NO;
    }
    
}
+(BOOL)ip6{// 6 & 6s
    NSString* platform = [AppInfo getMachineplatform];
    
    if ([platform isEqualToString:@"iPhone7,2"]||[platform isEqualToString:@"iPhone8,1"])
    {
        return YES;
    }else{
        return NO;
    }

}
+(BOOL)ip6P{// 6P & 6ps
    NSString* platform = [AppInfo getMachineplatform];
    
    if ([platform isEqualToString:@"iPhone7,1"]||[platform isEqualToString:@"iPhone8,2"])   {
        return YES;
    }else{
        return NO;
    }
    
}

+(void)setLabel:(UILabel *)label string:(NSString *)str withLineSpacing:(CGFloat)space{
    
    NSMutableAttributedString * mas=[[NSMutableAttributedString alloc]init];
    
    NSMutableParagraphStyle * style=[NSMutableParagraphStyle new];
    
    style.alignment=NSTextAlignmentLeft;
    
    style.lineSpacing=space;
    
    style.lineBreakMode = UILineBreakModeTailTruncation;
    
    style.paragraphSpacing=space;
    
    NSDictionary * attributesDict=@{
                                    NSFontAttributeName:[UIFont systemFontOfSize:13],//<span style="white-space:pre">     </span>//label.text字体大小
                                    NSForegroundColorAttributeName:[UIColor blackColor],//<span style="white-space:pre">  </span>//label.textColor 字体颜色
                                    NSParagraphStyleAttributeName:style
                                    };
    
    NSAttributedString *as=[[NSAttributedString alloc]initWithString:str attributes:attributesDict];
    
    [mas appendAttributedString:as];
    
    [label setAttributedText:mas];
}
//检测是否有网
+ (BOOL) IsEnableConnection {
    
    return ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] != NotReachable);
    
}
//iPhone 机型
+ (NSString*)getMachineName{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *name = malloc(size);
    sysctlbyname("hw.machine", name, &size, NULL, 0);
    
    NSString *platform = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
    
    free(name);
    
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G (A1203)";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G (A1241/A1324)";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS (A1303/A1325)";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4 (A1332)";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4 (A1332)";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4 (A1349)";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S (A1387/A1431)";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5 (A1428)";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5 (A1429/A1442)";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c (A1456/A1532)";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c (A1507/A1516/A1526/A1529)";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s (A1453/A1533)";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s (A1457/A1518/A1528/A1530)";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus (A1522/A1524)";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6 (A1549/A1586)";
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6s (A1700)";
     if ([platform isEqualToString:@"iPhone8,2"])   return @"iPhone 6S Plus";

    
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPod Touch 1G (A1213)";
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPod Touch 2G (A1288)";
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPod Touch 3G (A1318)";
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPod Touch 4G (A1367)";
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPod Touch 5G (A1421/A1509)";
    
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad 1G (A1219/A1337)";
    
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad 2 (A1395)";
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad 2 (A1396)";
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad 2 (A1397)";
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad 2 (A1395+New Chip)";
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPad Mini 1G (A1432)";
    if ([platform isEqualToString:@"iPad2,6"])   return @"iPad Mini 1G (A1454)";
    if ([platform isEqualToString:@"iPad2,7"])   return @"iPad Mini 1G (A1455)";
    
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad 3 (A1416)";
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad 3 (A1403)";
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad 3 (A1430)";
    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad 4 (A1458)";
    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad 4 (A1459)";
    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad 4 (A1460)";
    
    if ([platform isEqualToString:@"iPad4,1"])   return @"iPad Air (A1474)";
    if ([platform isEqualToString:@"iPad4,2"])   return @"iPad Air (A1475)";
    if ([platform isEqualToString:@"iPad4,3"])   return @"iPad Air (A1476)";
    if ([platform isEqualToString:@"iPad4,4"])   return @"iPad Mini 2G (A1489)";
    if ([platform isEqualToString:@"iPad4,5"])   return @"iPad Mini 2G (A1490)";
    if ([platform isEqualToString:@"iPad4,6"])   return @"iPad Mini 2G (A1491)";
    
    if ([platform isEqualToString:@"i386"])      return @"iPhone Simulator";
    if ([platform isEqualToString:@"x86_64"])    return @"iPhone Simulator";
    
    return platform;
}
    NSTimeInterval now ;

+ (NSString *)formatTimeStamp:(NSString *)timestamp nowTimerStamp:(NSDate *)nowtimes {

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];

    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];

    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"CN"]];//设置时区
    
    NSDate *dates = [NSDate dateWithTimeIntervalSince1970:[timestamp floatValue]];
    
    NSTimeInterval late = [dates timeIntervalSince1970];
    
    if (nowtimes<=0 || nowtimes == nil) {
        NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
        now = [dat timeIntervalSince1970];
    }
    else
    {
        now = [nowtimes timeIntervalSince1970];
    }

    
    NSString *timeString = @"";
    NSTimeInterval timeInterval = now - late;
    
    if (timeInterval/3600 < 1) {
        //一个小时内
        timeString = [NSString stringWithFormat:@"%f", timeInterval/60];
        
        NSInteger min = [timeString integerValue];
        if(min <= 0) {
            timeString = @"刚刚";
        } else {
            timeString = [NSString stringWithFormat:@"%ld分钟前", (long)min];
        }
    } else if (timeInterval/3600>=1 ) {
        //超过一小时（24 小时内）
        NSTimeInterval cha = now - late;
        int hours = ((int)cha) % (3600 * 24) / 3600;
        timeString = [NSString stringWithFormat:@"%d小时前",hours];
    }
//    暂时不考虑超过二十四小时的情况
//    else if (timeInterval/86400>1) {
//        //超过 24 小时
//        NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
//        [dateformatter setDateFormat:@"YY-MM-dd"];
//        timeString = [NSString stringWithFormat:@"%@",[dateformatter stringFromDate:dates]];
//    }
    
    return timeString;
}
@end
