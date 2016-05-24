//
//  GlobalMessageModel.h
//  BoXiu
//
//  Created by andy on 14-7-11.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "BaseTcpModel.h"

@interface GlobalMessageModel : BaseTcpModel
@property (nonatomic,assign) NSInteger chatType;
@property (nonatomic,assign) NSInteger fromuserid;
@property (nonatomic,strong) NSString *fromnick;
@property (nonatomic,assign) NSInteger touserid;
@property (nonatomic,strong) NSString *tonick;
@property (nonatomic,strong) NSString *giftname;
@property (nonatomic,strong) NSString *giftimg;
@property (nonatomic,assign) NSInteger giftnum;
@property (nonatomic,strong) NSString *giftunit;
@property (nonatomic,assign) NSInteger hidden;
@property (nonatomic,strong) NSString *hiddenindex;
@property (nonatomic,assign) BOOL issupermanager;
@property (nonatomic,strong) NSString *msg;
@property (nonatomic,assign) NSInteger staruserid;
@property (nonatomic,strong) NSString *starnick;
@property (nonatomic,assign) NSInteger thidden;
@property (nonatomic,strong) NSString *thiddenindex;
@property (nonatomic,assign) BOOL tissupermanager;
@property (nonatomic,strong) NSString * href;
@end
