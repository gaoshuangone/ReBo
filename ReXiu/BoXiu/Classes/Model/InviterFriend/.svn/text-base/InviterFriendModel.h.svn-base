//
//  InviterFriendModel.h
//  BoXiu
//
//  Created by tongmingyu on 15-5-15.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import "BaseHttpModel.h"


@interface InviterReward : NSObject

@property (nonatomic,assign) NSInteger count;
@property (nonatomic,strong) NSMutableArray *rewards;
@property (nonatomic,assign) NSInteger type;
@end

@interface Reward : NSObject

@property (nonatomic,assign) NSInteger count;
@property (nonatomic,assign) NSInteger rewardId;
@property (nonatomic,strong) NSString *imgsrc;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *type;
@property (nonatomic,assign) NSInteger unit;
@end

@interface InviterFriendModel : BaseHttpModel
@property (nonatomic,assign) NSInteger successCount;
@property (nonatomic, strong) NSMutableArray *inviterRewards;

@end
