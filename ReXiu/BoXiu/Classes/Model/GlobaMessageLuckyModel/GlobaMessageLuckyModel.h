//
//  GlobaMessageLuckyModel.h
//  BoXiu
//
//  Created by tongmingyu on 14-11-3.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "GlobalMessageModel.h"

@interface GlobaMessageLuckyModel : GlobalMessageModel

@property (nonatomic,assign) NSInteger giftId;
@property (nonatomic,strong) NSString  *usernick;
@property (nonatomic,strong) NSString  *loginname;
@property (nonatomic,assign) NSInteger userid;

@property (nonatomic,assign) NSInteger rewardCoin;
@property (nonatomic,assign) NSInteger rewardtype;
@property (nonatomic,assign) NSInteger rewardbs;

@end
