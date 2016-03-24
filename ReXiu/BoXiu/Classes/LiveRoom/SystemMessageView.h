//
//  SystemMessageView.h
//  BoXiu
//
//  Created by andy on 15/6/17.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import "BaseView.h"
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
#import "PopupMenuDelegate.h"
#import "NSAttributedString+Attributes.h"
#import "MarkupParser.h"
#import "OHAttributedLabel.h"
#import "CustomMethod.h"

@interface SystemMessageView : BaseView<UITableViewDataSource,UITableViewDelegate,OHAttributedLabelDelegate>

@property (nonatomic,assign) id<PopupMenuDelegate> popupMenudelegate;

- (void)addChatMessage:(ChatMessageModel *)chatMessageModel;
- (void)addGiftInfoToChatMessage:(GiveGiftModel *)giveGiftModel;
- (void)addSofaInfoToChatMessage:(RobSofaModel *)sofaModel;
- (void)addRoomMessage:(NotifyMessageModel *)notifyMessageModel;
- (void)addGlobalMessage:(GlobalMessageModel *)globalMessageModel;
- (void)addApproveMessage:(SendApproveModel *)sendApproveModel;
- (void)addUserEnterRoomMessage:(UserEnterRoomModel *)userEnterModel;
- (void)addCrownMessage:(CrownModel *)crownModel;

- (void)addGlobalLuckyGiftMessage:(NSDictionary *)dictionay;

- (void)addAttionNotifyMessage:(AttentionNotifyModel *)attentionNotifyModel;
- (void)addMessage:(NSString *)message;

- (void)clearAllMessage;

- (void)queryGiftRankData;

- (void)showGiftRankBtn;

- (void)updateStarGiftRank:(NSArray *)starGiftRankDatas;


@end
