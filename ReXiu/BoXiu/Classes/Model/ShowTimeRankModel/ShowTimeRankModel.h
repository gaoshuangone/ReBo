//
//  ShowTimeRankModel.h
//  BoXiu
//
//  Created by andy on 15-1-26.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import "BaseTcpModel.h"

@interface ShowTimeRankModel : BaseTcpModel
@property (nonatomic,assign) NSInteger firstNum;
@property (nonatomic,assign) NSInteger firstId;
@property (nonatomic,strong) NSString *firstNick;
@property (nonatomic,assign) NSInteger firstIdxcode;

@property (nonatomic,assign) NSInteger secondNum;
@property (nonatomic,assign) NSInteger secondId;
@property (nonatomic,strong) NSString *secondNick;
@property (nonatomic,assign) NSInteger secondIdxcode;

@property (nonatomic,assign) NSInteger thirdNum;
@property (nonatomic,assign) NSInteger thirdId;
@property (nonatomic,strong) NSString *thirdNick;
@property (nonatomic,assign) NSInteger thirdIdxcode;

@property (nonatomic,assign) long systemTime;

@end
