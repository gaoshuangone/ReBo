//
//  PrivateMessageView.h
//  BoXiu
//
//  Created by andy on 15/6/17.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import "BaseView.h"
#import "ChatMessageModel.h"
#import "PopupMenuDelegate.h"
#import "NSAttributedString+Attributes.h"
#import "MarkupParser.h"
#import "OHAttributedLabel.h"
#import "CustomMethod.h"

@protocol PrivateMessageViewDelegate <NSObject>

- (void)toLogin;

@end

@interface PrivateMessageView : BaseView<UITableViewDataSource,UITableViewDelegate,OHAttributedLabelDelegate>

@property (nonatomic,assign) id<PopupMenuDelegate> popupMenudelegate;
@property (nonatomic,assign) id<PrivateMessageViewDelegate> delegate;

- (void)addChatMessage:(ChatMessageModel *)chatMessageModel;
- (void)addDefaultMessage;
- (void)clearAllMessage;
@end
