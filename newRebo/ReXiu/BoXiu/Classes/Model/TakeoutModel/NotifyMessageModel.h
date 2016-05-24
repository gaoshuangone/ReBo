//
//  NotifyMessageModel.h
//  BoXiu
//
//  Created by tongmingyu on 14-6-6.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "RoomMessageModel.h"

@interface NotifyMessageModel : RoomMessageModel
//chatType12
@property (nonatomic,assign) NSInteger fromuserid;
@property (nonatomic,strong) NSString *fromusernick;
@property (nonatomic,assign) NSInteger hidden;
@property (nonatomic,strong) NSString *hiddenindex;
@property (nonatomic,assign) BOOL issupermanager;
@property (nonatomic,assign) NSInteger speaktype;//0;禁言，1恢复
@property (nonatomic,assign) NSInteger thidden;
@property (nonatomic,strong) NSString *thiddenindex;
@property (nonatomic,assign) long long time;
@property (nonatomic,assign) BOOL tissupermanager;
@property (nonatomic,assign) NSInteger touserid;
@property (nonatomic,strong) NSString *tousernick;
@property (nonatomic,assign) NSInteger type;
@property (nonatomic,strong) NSString *msg;
@end
