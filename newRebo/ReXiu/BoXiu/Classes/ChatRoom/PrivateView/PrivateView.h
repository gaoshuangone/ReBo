//
//  PrivateView.h
//  BoXiu
//
//  Created by Andy on 14-3-28.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "BaseView.h"
#import "UserInfo.h"
#import "ChatMessageModel.h"
#import "NSAttributedString+Attributes.h"
#import "MarkupParser.h"
#import "OHAttributedLabel.h"
#import "CustomMethod.h"
#import "PopupMenuDelegate.h"

@protocol PrivateViewDelegate <NSObject>

- (void)toLogin;

@end
@interface PrivateView : BaseView<UITableViewDataSource,UITableViewDelegate,OHAttributedLabelDelegate>

@property (nonatomic,assign) id<PopupMenuDelegate> popupMenudelegate;
@property (nonatomic,assign) id<PrivateViewDelegate> delegate;

- (void)addChatMessage:(ChatMessageModel *)chatMessageModel;
- (void)addDefaultMessage;
- (void)clearAllMessage;

@end
