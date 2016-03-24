//
//  LiveRoomMiddleView.h
//  BoXiu
//
//  Created by andy on 15/6/11.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import "BaseView.h"
#import "EWPTabMenuControl.h"
#import "PraiseView.h"

@class LiveRoomMiddleView;

@protocol LiveRoomMiddleViewDeleagte <NSObject>

@optional
- (void)giftAction:(LiveRoomMiddleView *)liveRoomMiddleView;
- (void)chatAction:(LiveRoomMiddleView *)liveRoomMiddleView;
- (BOOL)praiseAction:(LiveRoomMiddleView *)liveRoomMiddleView;

@end

@interface LiveRoomMiddleView : BaseView

@property (nonatomic, assign) id<LiveRoomMiddleViewDeleagte> delegate;
@property (nonatomic,strong) EWPTabMenuControl *tabMenu;
@property (nonatomic,strong) NSMutableDictionary *tabMenuContentViewControllers;

@property (nonatomic,strong) PraiseView *praiseView;
@property (nonatomic,strong) UIView *bottomView;


- (void)initData;//liveroom得到数据后加载数据，  //查询表情数据。礼物数据,如果有数据就不会再查询了//显示点赞相关,以及获取主播赞

- (void)showRecommendView;//显示推荐主播
- (void)showStartTime;//显示热播开播时间
- (void)showApproveView;

- (void)initVoteMusicViewData;

- (void)initShowTimeViewData;

- (void)addPraiseView;

- (void)removePraiseView;

- (void)setPrasieCount:(NSInteger)count;

- (void)showTableBarMenu;

- (void)showChatView;

- (void)praiseAnimation;

- (void)sendApprove;

//首次触发点赞通知
-(void)receiveSendNotice:(NSNotification *)notification;

//全局消息
- (void)receiveGlobalMessage:(NSNotification *)notification;

//房间消息
- (void)receiveRoomMessage:(NSNotification *)notification;

//收到礼物
- (void)receiveGift:(NSNotification *)notification;

//收到抢沙发
- (void)receiveSofa:(NSNotification *)notification;

//收到错误消息
- (void)receiverErro:(NSNotification *)notification;

//收到点赞消息
- (void)receiveApproveResult:(NSNotification *)notification;

//收到进入房间消息
- (void)receiveEnterRoomMessage:(NSNotification *)notification;

//接受退出房间消息
- (void)receiveOutRoomMessage:(NSNotification *)notification;

//收到弹幕消息
- (void)receiveBarageMessage:(NSNotification *)notification;

//收到切换到点歌界面消息
- (void)receiveMusicChangeMessage:(NSNotification *)notification;

//收到切换到showtime界面的消息
- (void)receiveShowTimeChangeMessage:(NSNotification *)notification;

//收到showtime开始的消息
- (void)receiveShowTimeBeginMessage:(NSNotification *)notification;

//收到showtime结束的消息
- (void)receiveShowTimeEndMessage:(NSNotification *)notification;

//收到showtime时候的实时数据消息
- (void)receiveShowTimeDataMessage:(NSNotification *)notification;

//收到showtime时候的电灶消息
- (void)receiveShowTimeApproveResult:(NSNotification *)notification;

-(void)clearAllMessage;
@end
