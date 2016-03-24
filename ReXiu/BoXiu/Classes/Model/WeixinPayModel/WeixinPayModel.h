//
//  WeixinPayModel.h
//  BoXiu
//
//  Created by tongmingyu on 15-1-20.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import "BaseHttpModel.h"

@interface WeixinPayModel : BaseHttpModel

@property (nonatomic,strong) NSString *appid;
@property (nonatomic,strong) NSString *noncestr;
@property (nonatomic,strong) NSString *package;
@property (nonatomic,strong) NSString *partnerid;
@property (nonatomic,strong) NSString *prepayid;
@property (nonatomic,strong) NSString *retcode;
@property (nonatomic,strong) NSString *retmsg;
@property (nonatomic,strong) NSString *sign;
@property (nonatomic,strong) NSString *timestamp;
@property (nonatomic,strong) NSString *outtradeno;

@end
