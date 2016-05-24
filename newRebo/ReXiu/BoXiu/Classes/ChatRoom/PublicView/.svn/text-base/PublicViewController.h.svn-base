//
//  PublicViewController.h
//  BoXiu
//
//  Created by andy on 15-1-9.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import "ViewController.h"
#import "PublicView.h"
#import "UserInfoManager.h"
#import "ChatToolBar.h"
#import "ChatMessageModel.h"
#import "UserEnterRoomModel.h"
#import "SendApproveModel.h"
#import "RobSofaModel.h"
#import "NotifyMessageModel.h"
#import "CrownModel.h"
#import "GlobalMessageModel.h"
#import "GlobaMessageLuckyModel.h"
#import "GiveGiftModel.h"
#import "AttentionNotifyModel.h"

@interface PublicViewController : ViewController<PopupMenuDelegate>
@property (nonatomic,strong) ChatToolBar *chatToolBar;
@property (nonatomic,assign) id<PopupMenuDelegate> popupMenuDelegate;

//初始化,showtype =3时，界面不一样
- (void)initData:(NSInteger)showType;

//增加进入房间消息
- (void)addUserEnterRoomMessage:(UserEnterRoomModel *)userEnterModel;

//增加点赞消息
- (void)addApproveMessage:(SendApproveModel *)sendApproveModel;

//增加抢沙发消息
- (void)addSofaInfoToChatMessage:(RobSofaModel *)sofaModel;

//增加房间消息，以后看是否可以整理
- (void)addRoomMessage:(NotifyMessageModel *)notifyMessageModel;

//成为皇冠粉丝提醒
- (void)addCrownMessage:(CrownModel *)crownModel;

//增加全局消息,所有房间都能收到的消息
- (void)addGlobalMessage:(GlobalMessageModel *)globalMessageModel;

//增加幸运消息
-(void)addGlobalLuckyGiftMessage:(GlobaMessageLuckyModel *)globaLuckyModel;

//收到礼物消息
- (void)addGiftInfoToChatMessage:(GiveGiftModel *)giveGiftModel;

//增加聊天信息
- (void)addChatMessage:(ChatMessageModel *)chatMessageModel;

//增加关注消息提示信息
- (void)addAttionNotifyMessage:(AttentionNotifyModel *)attentionNotifyModel;

//如果是明星直播间，更新明星直播间礼物排行榜
- (void)updateBigStarGiftRankMessage:(GiveGiftModel *)giveGiftModel;

- (void)addMessage:(NSString *)message;

@end
