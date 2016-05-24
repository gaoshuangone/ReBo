//
//  ShowTimeEndModel.h
//  BoXiu
//
//  Created by andy on 15-1-26.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import "ShowTimeRankModel.h"

@interface ShowTimeEndModel : ShowTimeRankModel

@property (nonatomic,assign) NSInteger luckId;//幸运用户Id
@property (nonatomic,assign) NSInteger luckNum;//幸运用户点赞数量
@property (nonatomic,strong) NSString *luckNick;//幸运用户昵称
@property (nonatomic,assign) NSInteger luckIdxcode;//幸运用户靓号

@property (nonatomic,assign) NSInteger totalPraiseNum;//主播获取的所有得赞
@end
