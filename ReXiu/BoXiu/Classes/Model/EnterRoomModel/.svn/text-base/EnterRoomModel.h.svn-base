//
//  EnterRoomModel.h
//  BoXiu
//
//  Created by Andy on 14-4-11.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseTcpModel.h"

@interface EnterRoomModel : BaseTcpModel
@property (nonatomic,assign) NSInteger userId;
@property (nonatomic,assign) int result;
@property (nonatomic,assign) int status;//1 正在演出;2没有演出
@property (nonatomic,strong) NSString *liveurl;//视频地址
@property (nonatomic,strong) NSString *remark;//如果result为0（失败），该字段表示失败的原因。

+ (void)enterRoomWithUserId:(NSInteger )userId starUserId:(NSInteger )starUserid  reconnect:(BOOL)reconnect;

@end
