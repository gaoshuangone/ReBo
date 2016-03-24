//
//  SendShowTimeApproveModel.h
//  BoXiu
//
//  Created by andy on 15-1-23.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import "BaseTcpModel.h"

@interface SendShowTimeApproveModel : BaseTcpModel
@property (nonatomic,assign) NSInteger success;//0:失败
@property (nonatomic,assign) NSInteger msg;//如果失败，会返回失败原因
@property (nonatomic,assign) long long coin;//本次点赞后，剩余热币
@property (nonatomic,assign) NSInteger num;//该用户累计点赞数量

+ (void)sendApprove:(NSDictionary *)bodyDic;

@end
