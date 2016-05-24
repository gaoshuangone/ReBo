//
//  AutoRegistModel.h
//  BoXiu
//
//  Created by tongmingyu on 14-12-3.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "BaseHttpModel.h"

@interface AutoRegistModel : BaseHttpModel

@property (nonatomic, assign) NSInteger bean;
@property (nonatomic, assign) NSInteger clevelnextweight;
@property (nonatomic, assign) NSInteger clevelnextweightcoin;
@property (nonatomic, assign) NSInteger clevelweightcoin;
@property (nonatomic, assign) NSInteger coin;
@property (nonatomic, assign) NSInteger consumerlevelweight;

@property (nonatomic, assign) NSInteger costcoin;
@property (nonatomic, assign) NSInteger cpercent;
@property (nonatomic, strong) NSString *createtime;

@property (nonatomic, assign) NSInteger freezecoinflag;
@property (nonatomic, assign) NSInteger getcoin;
@property (nonatomic, assign) NSInteger days;
@property (nonatomic, strong) NSString *img;
@property (nonatomic, strong) NSString *name;

@property (nonatomic, assign) NSInteger handsel_coin;
@property (nonatomic, assign) NSInteger hidden;
@property (nonatomic, assign) NSInteger userid;

@property (nonatomic, assign) NSInteger idxcode;
@property (nonatomic, assign) NSInteger idxcodedefault;
@property (nonatomic, assign) BOOL isPurpleVip;
@property (nonatomic, assign) BOOL isYellowVip;
@property (nonatomic, assign) BOOL isproxy;
@property (nonatomic, assign) BOOL isstar;
@property (nonatomic, assign) BOOL issupermanager;
@property (nonatomic, assign) BOOL iswatchmanager;

@property (nonatomic, strong) NSString *loginname;
@property (nonatomic, strong) NSString *nick;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, assign) NSInteger passwordnotset;
@property (nonatomic, strong) NSString *photo;

@property (nonatomic, assign) NSInteger privlevelweight;
@property (nonatomic, assign) NSInteger sex;
@property (nonatomic, assign) NSInteger starlevelcoin;
@property (nonatomic, assign) NSInteger starlevelid;
@property (nonatomic, strong) NSString *starlevelname;

@property (nonatomic, assign) NSInteger starlevelnextcoin;
@property (nonatomic, assign) NSInteger starlevelnextid;
@property (nonatomic, assign) NSInteger starlevelpercent;
@property (nonatomic, assign) NSInteger status;

@property (nonatomic, strong) NSString *token;
@property (nonatomic, assign) NSInteger type;

@end
