//
//  SendApproveModel.h
//  BoXiu
//
//  Created by andy on 14-7-14.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "BaseTcpModel.h"

@interface SendApproveModel : BaseTcpModel


@property (nonatomic,assign) NSInteger chatType;
@property (nonatomic,assign) NSInteger clienttype;
@property (nonatomic,assign) NSInteger getcount;
@property (nonatomic,assign) NSInteger hidden;
@property (nonatomic,strong) NSString *hiddenindex;
@property (nonatomic,assign) BOOL issupermanager;
@property (nonatomic,assign) NSInteger leavecount;
@property (nonatomic,strong) NSString *nick;
@property (nonatomic,assign) NSInteger num;
@property (nonatomic,assign) NSInteger roomid;
@property (nonatomic,assign) NSInteger sendcount;
@property (nonatomic,assign) NSInteger starmonthpraisecount;
@property (nonatomic,strong) NSString *starnick;
@property (nonatomic,assign) NSInteger staruserid;
@property (nonatomic,assign) long long time;
@property (nonatomic,assign) NSInteger userid;
@property (nonatomic,assign) NSInteger useridfrom;
@property (nonatomic,assign) NSInteger starid;
@property (nonatomic,assign) NSInteger showid;
@property (nonatomic,assign) NSInteger maxcount;

+ (void)sendApprove:(NSDictionary *)bodyDic;
@end
