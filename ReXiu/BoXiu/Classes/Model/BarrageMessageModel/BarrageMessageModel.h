//
//  BarrageMessageModel.h
//  BoXiu
//
//  Created by andy on 14-12-22.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "RoomMessageModel.h"

@interface BarrageMessageModel : RoomMessageModel
@property (nonatomic,strong) NSString *content;
@property (nonatomic,assign) NSInteger hidden;
@property (nonatomic,strong) NSString *hiddenindex;
@property (nonatomic,assign) BOOL issupermanager;
@property (nonatomic,strong) NSString *nick;
@property (nonatomic,assign) long long stargetcoin;
@property (nonatomic,assign) NSInteger starlevelid;
@property (nonatomic,strong) NSString *starlevelname;
@property (nonatomic,assign) long long starlevelnextcoin;
@property (nonatomic,strong) NSString *starlevelpercent;
@property (nonatomic,assign) NSInteger staruserid;
@property (nonatomic,assign) long time;
@property (nonatomic,assign) long long touserbean;
@property (nonatomic,assign) long long tousercoin;
@property (nonatomic,assign) long long userbean;
@property (nonatomic,assign) long long usercoin;
@property (nonatomic,assign) NSInteger userid;

+ (void)sendBarrageMessage:(NSDictionary *)params;

@end
