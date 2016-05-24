//
//  ChatToolBar.h
//  BoXiu
//
//  Created by Andy on 14-3-28.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "BaseView.h"
#import "UserInfo.h"
#import "GiftView.h"
#import "EmotionView.h"

#import "CommonTextField.h"

typedef NS_ENUM(NSUInteger,TypeKey) {
    TypeKey_GONGLIAO,//对所有人说
    TypeKey_SILIAO,//私聊
    TypeKey_ToOther//对谁说
};

@class ChatToolBar;
@class ChatRoomViewController;
@protocol ChatToolBarDelegate <NSObject>

- (void)sendMessage:(NSDictionary *)param;

- (void)giveGift:(NSDictionary *)giftInfo;

@end

@interface ChatToolBar : BaseView<UITextFieldDelegate,GiftViewDelegate,EmotionViewDelegate>

@property (nonatomic,strong) UserInfo *targetUserInfo;
@property (nonatomic,assign) id<ChatToolBarDelegate> delegate;
@property (nonatomic,strong) CommonTextField *messageCotent;
@property (nonatomic,strong) EmotionView *emotionView;//表情view

@property (nonatomic,assign) TypeKey typeKey;

@property (assign, nonatomic) BOOL isPrivateChat;

- (void)hideKeyBoard;

//进来跟当前主播聊天
- (void)chatWithUserInfo:(UserInfo *)userInfo;
- (void)chatWithUserInfo:(UserInfo *)userInfo showToolBar:(BOOL)show;

- (void)addChatMember:(UserInfo *)userInfo;
- (void)giveGiftWithUserInfo:(UserInfo *)userInfo;

- (void)updateBarageSwitch;


-(void)setBarageSwitchIsOn:(BOOL)isOn;//切换弹幕公聊

-(void)changeChatTypeIsPrivate:(BOOL)isPrivate;//切换私聊

-(void)initSlefUser;


@end
