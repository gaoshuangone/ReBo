//
//  ChatBar.h
//  BoXiu
//
//  Created by andy on 15/6/13.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import "BaseView.h"

@class ChatBar;
@protocol ChatTbarDelegate <NSObject>

- (void)tapOutViewOfChatBar:(ChatBar *)chatBar;
- (void)chatTbarSendAction:(ChatBar *)charBar;

@end

@interface ChatBar : BaseView

@property (nonatomic,assign) id<ChatTbarDelegate> delegate;
@property (nonatomic, copy) NSString *text;

@end
