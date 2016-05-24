//
//  ChatMessageModel.h
//  BoXiu
//
//  Created by Andy on 14-4-11.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RoomMessageModel.h"

@interface ChatMessageModel : RoomMessageModel
@property (nonatomic,assign) NSInteger hidden;//2表示隐身用户进入
@property (nonatomic,strong) NSString *hiddenindex;
@property (nonatomic,assign) BOOL issupermanager;//是否为超管
@property (nonatomic,strong) NSString *msg;
@property (nonatomic,assign) NSInteger userid;
@property (nonatomic,strong) NSString *nick;
@property (nonatomic,assign) int contentType;
@property (nonatomic,assign) NSInteger thidden;
@property (nonatomic,strong) NSString *thiddenindex;
@property (nonatomic,assign) NSInteger tissupermanager;
@property (nonatomic,assign) NSInteger targetUserid;
@property (nonatomic,strong) NSString *targetNick;
@property (nonatomic,assign) NSInteger staruserid;
@property (nonatomic,strong) NSString *time;
@property (nonatomic,assign) NSInteger unspeak;
@property (nonatomic,assign) NSInteger result;
@property (nonatomic,copy) NSString *photo;
@property (nonatomic,assign) BOOL isPurpleVip;  //紫色会员
@property (nonatomic,assign) BOOL isYellowVip;  //黄色会员
@property (nonatomic,assign) NSInteger starlevelid;//明星等级
@property (nonatomic,assign) NSInteger consumerlevelweight;//当前财富最高等级


+ (void)sendMessage:(NSDictionary *)bodyDic;

@end
