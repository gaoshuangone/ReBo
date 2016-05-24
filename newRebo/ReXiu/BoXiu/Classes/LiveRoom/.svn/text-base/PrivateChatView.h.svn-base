//
//  PrivateChatView.h
//  BoXiu
//
//  Created by andy on 15/12/9.
//  Copyright © 2015年 rexiu. All rights reserved.
//

#import "BaseView.h"
#import "LiveRoomViewController.h"
#import "ChatMessageModel.h"
#import "NSAttributedString+Attributes.h"
#import "MarkupParser.h"
#import "OHAttributedLabel.h"
#import "CustomMethod.h"
#import "PopupMenuDelegate.h"
#import "EmotionManager.h"

@interface PrivateChatView : BaseView<UITableViewDataSource,UITableViewDelegate,OHAttributedLabelDelegate>
@property (strong, nonatomic)LiveRoomViewController* rootLiveRoomViewController;
@property (nonatomic,assign) id<PopupMenuDelegate> popupMenudelegate;
-(void)initAudienceHeaderViewData;
-(void)hidPrivateChatViewWithisHid:(BOOL)isHid;
- (void)addChatMessage:(ChatMessageModel *)chatMessageModel;
- (void)addChatMember:(UserInfo *)userInfo;
- (void)addDefaultMessage;
- (void)clearAllMessage;
- (void)setTargetUserInfo:(UserInfo *)targetUserInfo;
- (void)changeFieldText;
@end
