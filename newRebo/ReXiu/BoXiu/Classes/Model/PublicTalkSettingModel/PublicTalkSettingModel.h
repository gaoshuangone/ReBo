//
//  PublicTalkSettingModel.h
//  BoXiu
//
//  Created by andy on 15-1-22.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import "RoomMessageModel.h"
//chatTpe = 13;
@interface PublicTalkSettingModel : RoomMessageModel

@property (nonatomic,assign) NSInteger hidden;
@property (nonatomic,assign) BOOL issupermanager;
@property (nonatomic,strong) NSString *nick;
@property (nonatomic,assign) NSInteger publictalkstatus;//1.开启公聊；2：关闭公聊；3：房管公聊
@property (nonatomic,assign) NSInteger staruserid;
@property (nonatomic,assign) long long time;
@property (nonatomic,assign) NSInteger userid;
@property (nonatomic,assign) NSInteger useridfrom;

@end
