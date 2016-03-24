//
//  AppInfo.h
//  BoXiu
//
//  Created by andy on 14-5-4.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MessageCenter.h"
#import "AppStoreRechargeViewController.h"
#import "UserInfo.h"
#import "EWPIconLable.h"
typedef void(^LoginResultSuccess)();
typedef void(^LoginResultFail)(NSString *erroMessage);

@interface AppInfo : NSObject

@property (nonatomic,assign) BOOL isNeedReturnMain;//是否需要返回到主页，配合使用，判断从其他页面返回到其它页面的情况（一般是主页）的情况
/*  if ([AppInfo shareInstance].pushType==0) {
    self.isShouldReturnMain = YES;
}*///这种情况是判断本页面弹出提示框的返回情况，如果点击返回，会重置isNeedReturnMain=NO
@property (nonatomic,strong) NSString* lastFromeClass;//从上层类进入，配合使用
@property (nonatomic,strong) NSString* shouldPushToClass;//从上层类进入，配合使用

@property (nonatomic,assign) NSInteger pushType;// 0需要跳转到首页  1 需要跳转到搜索页面  3 需要返回到排行榜页面

@property (nonatomic,assign) NSInteger serverType;//标志是那个服务器
@property (nonatomic,strong) NSString *serverBaseUrl;//用于切换环境用
@property (nonatomic,strong) NSString *requestServerBaseUrl;//普通post请求基址
@property (nonatomic,strong) NSString *resourceBaseUrl;//静态资源url
@property (nonatomic,strong) NSString *protocolUrl;//使用协议url

@property (nonatomic,assign) BOOL first;

@property (nonatomic,assign) BOOL bLoginSuccess;
@property (nonatomic,strong) NSString *res_server; //头像URL前缀
@property (nonatomic,assign) NSInteger online_stars_location;

@property (nonatomic,assign) long heart_time;
@property (nonatomic,strong) NSString *deviceToken;
@property (nonatomic,strong) NSString *token;//登录返回的token，
@property (nonatomic,strong) NSString *serverIp;
@property (nonatomic,strong) UserInfo* userInfoSingle;//个人信息，不会变

@property (nonatomic,assign) NSInteger loginType;//1.qq;2.sina;3.官网账号
@property (nonatomic,strong) NSString *hideSwitch;//采用两位数字控制充值和商城。第一位数字1代表隐藏，2代表显示，同理商城也是这样。
@property (nonatomic,assign) NSInteger initCoinfigState;//0:初始化失败或未初始化。1:正在初始化，2：初始化完成
@property (nonatomic,assign) BOOL bOldLoginState;
@property (nonatomic,assign) BOOL bFirstExitFromSetting;
@property (nonatomic,assign) BOOL bFirstEnterMainView;//第一次进入软件是否检测完版本是否升级.
@property (nonatomic,strong) MessageCenter *messageCenter;
//升级相关


@property (nonatomic,strong) NSString *upgradeVersion;
@property (nonatomic,strong) NSString *upgradePath;
@property (nonatomic,strong) NSString *upgradeLog;

@property (nonatomic,assign) BOOL isGuanZhu;//判断是否关注主播，同意leftVIew与主播详细关注按钮状态

@property (nonatomic,assign) BOOL bShowLivingButton;    //是否显示我要开播按钮

@property (nonatomic,strong) NSString *neName;      //保存修改中的昵称
@property (nonatomic,assign) NSInteger unReadMsgCount;//保存未读消息数量

@property (nonatomic, assign) long long nowtimesMillis;
@property (nonatomic, assign) long long timerMillis;

@property (nonatomic,strong) NSDate* nowtimes;
@property (nonatomic,strong) NSString* udid;

@property (nonatomic,assign) BOOL isHaiBaoUp;
@property (nonatomic,assign) BOOL isHaiBaoNew;
@property (nonatomic,assign) NSInteger network;
@property (nonatomic,strong) UIPageControl *pageControl;    //引导页控制器
@property (nonatomic,assign) NSInteger send;

@property (nonatomic,strong) UILabel *audienceNumber;   //主播面板的粉丝数量 （要求实时变化，所以暂时放在这里）
@property (nonatomic,assign) NSInteger fansNumber;   //粉丝数量
@property (nonatomic,assign) NSInteger state;   //关注状态 0关注 1未关注 2其他
@property (nonatomic,assign) NSInteger history; //历史聊天信息
@property (nonatomic,assign) NSInteger historynumber; //历史状态

@property (nonatomic,strong) UIView *coinbackview;  //热豆
@property (nonatomic,strong) UIImageView *coinImg;  //热币icon
@property (nonatomic,strong) UILabel *coin;   //主播热豆

@property (nonatomic,assign) NSInteger  personcont ;
@property (nonatomic,assign) UserInfo *user;   //点击用户列表临时保存用户的信息

+ (AppInfo *)shareInstance;
- (void)initConfigInfo;
- (void)saveLogin:(NSString *)loginName password:(NSString *)loginPassword loginType:(NSInteger)loginType autoRegistUser:(BOOL)bAutoUser;
- (void)saveLogin:(NSString *)loginName password:(NSString *)loginPassword;
- (NSString *)getSavedLoginName;
- (NSString *)getSavedPassword;
- (BOOL) isAutoUser;

- (void)autoLogin:(LoginResultSuccess)success fail:(LoginResultFail)fail;
- (void)loginOut;

//登录
- (void)loginWithUserName:(NSString *)username password:(NSString *)password success:(LoginResultSuccess)success fail:(LoginResultFail)fail;

//第三方登录
- (void)loginWithAccount:(NSString *)account nick:(NSString *)nick  withHeadUrl:(NSString*)headUrl token:(NSString *)token type:(NSInteger)type success:(LoginResultSuccess)success fail:(LoginResultFail)fail;

/**
 *  重新请求当前用户信息
 */

- (void)refreshCurrentUserInfo:(void (^)(void))complete;

//测试环境下设置服务器地址
- (void)saveServerType:(NSInteger)type;

//保存appsotre相关信息
- (BOOL)saveAppStoreRecharegeInfo:(AppStoreRechargeInfo *)appStoreRechargeInfo;

//删除验证过的appsotre信息
- (BOOL)deleteLocalAppstoreRechargeInfo:(AppStoreRechargeInfo *)appStoreRechargeInfo;

- (void)showNoticeInWindow:(NSString *)message duration:(CGFloat)duration;
//label 行间距
+(void)setLabel:(UILabel *)label string:(NSString *)str withLineSpacing:(CGFloat)space;

+ (NSString*)getMachineName;

+(NSString *)deviceUUID;

+(NSString*)getMachineplatform;

+ (NSString *)formatTimeStamp:(NSString *)timestamp nowTimerStamp:(NSDate *)nowtimes;

+ (BOOL) IsEnableConnection;

- (void)updateLivingButton;

- (void)loadAppStoreRechargeInfo;
+(BOOL)ip4;
+(BOOL)ip5;
+(BOOL)ip6;
+(BOOL)ip6P;
@end
