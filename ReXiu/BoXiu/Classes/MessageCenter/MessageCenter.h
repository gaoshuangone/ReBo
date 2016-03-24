//
//  MessageCenter.h
//  BoXiu
//
//  Created by andy on 14-11-20.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "BaseObject.h"

#define Message_Table @"message"

@interface MessageData : NSObject

@property (nonatomic,assign) NSInteger messageId;
@property (nonatomic,strong) NSString *uuid;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *content;
@property (nonatomic,strong) NSString *time;
@property (nonatomic,assign) BOOL     readed;

@property (nonatomic,strong) NSString *icon;         //头像地址
@property (nonatomic,assign) NSInteger messageType; //通知类型1活动通知 2 财富等级升级通知 3 主播开播通知
@property (nonatomic,assign) NSInteger notifyShowType; //1在APP显示 2系统通知栏 3 APP和系统通知栏

@property (nonatomic,assign) NSInteger actionLink;  //1进入WAP页面地址  2进入房间页面  3进入商城页面 4  进入充值页面 5 进入邀请界面
@property (nonatomic,strong) NSString *data;    //当actionLink=1时，该值是staruserid 当actionLink=2时，该值是WAP页面的url地址其他情况下，该值为空

@property (nonatomic,assign) NSInteger staruserId;   //主播ID
@property (nonatomic,strong) NSString *level;       //升级后的财富等级名称
@property (nonatomic,strong) NSString *levelName;   //升级后的等级icon
@property (nonatomic,assign) NSInteger userId;     //保存登录后用户userID

@end

@interface MessageCenter : BaseObject

@property (nonatomic,assign) NSInteger unReadCount;
@property (nonatomic,assign) BOOL isHaveUnReadCount;
@property (nonatomic,strong) MessageData *currentNotifyData;//点击消息栏进入程序保存的消息

+ (instancetype)shareMessageCenter;

//获取加载消息后的数据
- (NSArray *)getMessageData;

//首次加载消息
- (void)loadMessageData;

//保存消息
- (BOOL)saveMessge:(MessageData *)messageData;

//删除消息
- (BOOL)deleteMessage:(NSInteger)messgeId;

//删除所有消息
- (BOOL)deleteAllMessage;

//标记已读消息
- (BOOL)markMessageReadFlag:(NSInteger)messageId;

//标记多个消息已读
- (BOOL)markMoreMessageReadFlag:(NSArray *)messageIds;


@end
