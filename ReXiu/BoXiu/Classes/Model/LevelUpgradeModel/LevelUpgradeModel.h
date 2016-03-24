//
//  LevelUpgradeModel.h
//  BoXiu
//
//  Created by andy on 14-10-24.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "RoomMessageModel.h"

@interface LevelUpgradeModel : RoomMessageModel
//23
@property (nonatomic,assign) NSInteger upgradeType;//1为财富等级，2为明显等级
@property (nonatomic,assign) NSInteger userid;
@property (nonatomic,strong) NSString *nick;
@property (nonatomic,assign) NSInteger staruserid;
@property (nonatomic,assign) NSInteger oldConsumerlevelweight;
@property (nonatomic,assign) NSInteger nowConsumerlevelweight;
@property (nonatomic,assign) NSInteger oldStarlevelid;
@property (nonatomic,assign) NSInteger nowStarlevelid;
@end
