//
//  GetShowTimeStateModel.h
//  BoXiu
//
//  Created by andy on 15-1-26.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import "BaseHttpModel.h"
#import "ShowTimeEndModel.h"

@interface GetShowTimeStateModel : BaseHttpModel

@property (nonatomic,assign) NSInteger status;//0:未开始；1：正在进行 2:已结束
@property (nonatomic,assign) long long startTime;
@property (nonatomic,assign) long long serverTime;//当前服务器时间
@property (nonatomic,assign) long long endTime;
@property (nonatomic,assign) NSInteger totalPraiseNum;//主播总赞

@property (nonatomic,strong) ShowTimeEndModel *showTimeEndModel;

@end
