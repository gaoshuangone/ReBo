//
//  RobSofaModel.h
//  BoXiu
//
//  Created by andy on 14-5-28.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "BaseTcpModel.h"

@interface RobSofaModel : BaseTcpModel
@property (nonatomic,assign) NSInteger hidden;
@property (nonatomic,strong) NSString *hiddenindex;
@property (nonatomic,assign) BOOL issupermanager;
@property (nonatomic,strong) NSString *nick;
@property (nonatomic,assign) NSInteger num;
@property (nonatomic,strong) NSString *photo;
@property (nonatomic,assign) NSInteger result;
@property (nonatomic,assign) NSInteger sofano;
@property (nonatomic,assign) long long starbean;
@property (nonatomic,assign) long long starcoin;
@property (nonatomic,assign) NSInteger starlevelid;
@property (nonatomic,strong) NSString *starnick;
@property (nonatomic,assign) NSInteger staruserid;
@property (nonatomic,assign) long long time;
@property (nonatomic,assign) long long userbean;
@property (nonatomic,assign) long long usercoin;
@property (nonatomic,assign) NSInteger userid;

+ (void)robSofa:(NSDictionary *)bodyDic;
@end
