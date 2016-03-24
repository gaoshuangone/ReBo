//
//  PublicView.h
//  BoXiu
//
//  Created by Andy on 14-3-28.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "BaseView.h"
#import "NSAttributedString+Attributes.h"
#import "MarkupParser.h"
#import "OHAttributedLabel.h"
#import "CustomMethod.h"
#import "UserInfo.h"
#import "ChatMessageModel.h"
#import "GiveGiftModel.h"
#import "NotifyMessageModel.h"
#import "PopupMenuDelegate.h"
#import "GlobalMessageModel.h"
#import "SendApproveModel.h"
#import "RobSofaModel.h"
#import "UserEnterRoomModel.h"
#import "CrownModel.h"
#import "GlobaMessageLuckyModel.h"
#import "AttentionNotifyModel.h"

@interface PublicView : BaseView<UITableViewDataSource,UITableViewDelegate,OHAttributedLabelDelegate>

@property (nonatomic,assign) id<PopupMenuDelegate> popupMenudelegate;

- (void)addChatMessage:(ChatMessageModel *)chatMessageModel;
- (void)addGiftInfoToChatMessage:(GiveGiftModel *)giveGiftModel;
- (void)addSofaInfoToChatMessage:(RobSofaModel *)sofaModel;
- (void)addRoomMessage:(NotifyMessageModel *)notifyMessageModel;
- (void)addGlobalMessage:(GlobalMessageModel *)globalMessageModel;
- (void)addApproveMessage:(SendApproveModel *)sendApproveModel;
- (void)addUserEnterRoomMessage:(UserEnterRoomModel *)userEnterModel;
- (void)addCrownMessage:(CrownModel *)crownModel;
- (void)addGlobalLuckyGiftMessage:(GlobaMessageLuckyModel *)globaLuckyModel;
- (void)addAttionNotifyMessage:(AttentionNotifyModel *)attentionNotifyModel;
- (void)addMessage:(NSString *)message;

- (void)clearAllMessage;

- (void)queryGiftRankData;

- (void)showGiftRankBtn;

- (void)updateStarGiftRank:(NSArray *)starGiftRankDatas;

@end
