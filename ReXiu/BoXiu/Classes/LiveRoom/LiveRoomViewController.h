//
//  LiveRoomViewController.h
//  BoXiu
//
//  Created by andy on 15/6/11.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import "ViewController.h"
#import "GetRoomInfoModel.h"
#import "RobSofaModel.h"
#import "SofaCell.h"
#import "UIPopoverListView.h"
#import "LiveRoomMiddleView.h"
#import "LiveRoomIamgeView.h"
@class HotStarsData;
@class UserInfo;
typedef enum{
    LiveRoomType_EnterRoom,//进入房间
    LiveRoomType_BeforLive,//自己直播开始直播前
    LiveRoomType_Living,//直播过程中
    LiveRoomType_OutLiveRoom,//响应点击退出，或者异常退出程序，（未执行到直播结束）
    LiveRoomType_Stop//直播已经结束，收到停播消息
    
}LiveRoomType;

typedef enum{
   LiveRoomOtherThing_Normol,
    LiveRoomOtherThing_SelfLiveIpError,//个人直播时获取服务器失败
    
    LiveRoomOtherThing_receiveWillLive,//收到开播消息
    LiveRoomOtherThing_receiveWillStop//收到停播消息
    
}LiveRoomOtherThings;//其它单个情况



typedef enum{
    LiveRoomVC_LiveRoomViewController,
    LiveRoomVC_LiveRankViewController,
    LiveRoomVC_PersonInfoViewController,
    LiveRoomVC_LoginViewController
  
    
}LiveRoomVC;

typedef enum{
    liveRoomUserType_NormalUser,//普通用户
    liveRoomUserType_StarUser//主播
}liveRoomUserType;
@interface RoomSettingData : NSObject
@property (nonatomic,assign) BOOL shieldBarrage;  //屏蔽弹幕消息
@property (nonatomic,assign) BOOL isPlayVideo;
@property (nonatomic,assign) BOOL hideChat;

@end

@interface LiveRoomViewController : ViewController

@property (nonatomic,strong) RoomInfoData *roomInfoData;
@property (nonatomic,strong) LiveRoomMiddleView *middleView;
@property (nonatomic,strong) RoomSettingData *roomSettingData;
@property (nonatomic,assign) LiveRoomType liveRoomType;//直播时间类型
@property (nonatomic,assign) liveRoomUserType liveRoomUserType;//直播使用者类型
@property (nonatomic,assign) LiveRoomVC liveRoomVC;//直播需要跳转类型
@property (nonatomic,assign) LiveRoomOtherThings liveRoomOtherThings;//直播其它情况
@property (nonatomic,assign) BOOL hideChat;           //设置使用
@property (nonatomic,assign) BOOL hideBarrage;
@property (nonatomic,assign) BOOL audioMode;

@property (nonatomic,strong) UILabel      *audienceLabel;     //在线数量

@property (nonatomic,assign, readonly) BOOL phoneLiving;
@property (nonatomic,strong) UIPopoverListView *poplistview;

//为开播转开播，暂时保存起来，信息不一致，后台问题
@property (nonatomic,assign) NSInteger showid;              //主播id
@property (nonatomic,strong) NSString *serverip;
@property (nonatomic,strong) NSString *livestream;//主播id
@property (nonatomic,assign) NSInteger staruserid;          //主播id
@property (nonatomic,assign) BOOL isZhiBoIng;//是否是直播中，与直播过程中被推掉了，停播的时候，判断是否退出直播时候用
@property (strong, nonatomic)LiveRoomIamgeView* liveRoomIamgeView;//直播画布
-(void)pressedShowOherTerminalLoggedDialog;

- (void)exitRoom:(BOOL)stopVideo;

- (void)autoExitRoom;
- (BOOL)phoneLiving;
//切换音视频模式
- (void)changePlayMode:(BOOL)isPlayVideo;

- (void)startVideoPlay:(BOOL )isPlayVideo;

//设置主播赞个数
- (void)setStarPraiseCount:(NSInteger)count;

//设置房间人数
- (void)setRoomAudienceCount:(NSInteger)count;

- (void)didHotStarUserIdData:(HotStarsData *)hotData;

- (void)showPopupMenu:(UserInfo *)userInfo;

- (void)selecteSofaData:(SofaData *)sofaData;

//- (void)changePlayMode:(BOOL)isPlayVideo;

- (void)stopPlay;
- (void)reEnterRoom:(BOOL)reconnect;

- (void)showMarketDialogWithTitle:(NSString *)title message:(NSString *)message buyVipBlock:(void (^)())buyVipBlock cancelBlock:(void (^)())cancelBlock;    //判断非VIP用户点击VIP表情
-(void)stopPlayingautoExitRoom;
//-(void)refreshAudience;//leftView刷新时候异步刷新liveRoom观众人数

//-(void)showError;
-(void)chatToolBarBarageSwitchChange;
-(void)setHaiBaoUp;

//parms 参数   number 任务编号
-(void)lrTaskNumberWithParms:(id)parms withMumber:(NSInteger)number;//其它类不初始化互相调用的总开关
-(void)showNetworkErroDialog;

@end
