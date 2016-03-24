//
//  GetApproveModel.h
//  BoXiu
//
//  Created by andy on 14-7-14.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "BaseTcpModel.h"

@interface GetApproveModel : BaseTcpModel
@property (nonatomic,assign) NSInteger userid;
@property (nonatomic,assign) NSInteger staruserid;
@property (nonatomic,assign) NSInteger leavecount;
@property (nonatomic,assign) NSInteger getcount;
@property (nonatomic,assign) NSInteger sendcount;
@property (nonatomic,assign) NSInteger maxcount;

+ (void)getApprove:(NSDictionary *)bodyDic;
@end
