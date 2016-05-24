//
//  LoginModel.h
//  XiuBo
//
//  Created by Andy on 14-3-20.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "BaseHttpModel.h"

@interface LoginModel : BaseHttpModel
@property (nonatomic,assign) NSInteger province;
@property (nonatomic,strong) NSString *provincename;
@property (nonatomic,assign) NSInteger area;//  省id
@property (nonatomic,assign) NSInteger city;//city id
@property (nonatomic,assign) NSString *cityname;
@property (nonatomic,assign) long long coin;
@property (nonatomic,assign) NSInteger consumerlevelweight;
@property (nonatomic,assign) NSInteger privlevelweight;
@property (nonatomic,strong) NSString *phone;
@property (nonatomic,assign) long long costcoin;
@property (nonatomic,assign) NSInteger canaltype;
@property (nonatomic,assign) int userid;//userid
@property (nonatomic,assign) int idxcode;//靓号
@property (nonatomic,strong) NSString *loginname;//登录名
@property (nonatomic,strong) NSString *nick;//昵称
@property (nonatomic,assign) NSInteger hidden;  //隐身
@property (nonatomic,assign) int sex;//0:未知；1：男；2：女
@property (nonatomic,assign) BOOL isproxy;//
@property (nonatomic,assign) BOOL isstar;//
@property (nonatomic,assign) BOOL issupermanager;//
@property (nonatomic,strong) NSString *photo;//photo
@property (nonatomic,assign) NSInteger status;
@property (nonatomic,strong) NSString *token;
@property (nonatomic,strong) NSString *ip;
@property (nonatomic,strong) NSString *createtime;
@property (nonatomic,assign) NSInteger fansnum;
@property (nonatomic,assign) NSInteger roomid;//只有主播登录才返回

@property (nonatomic,assign) BOOL isPurpleVip;  //紫p
@property (nonatomic,assign) BOOL isYellowVip; //黄p

@property (nonatomic,strong) NSString *password;  //服务器返回加密过的密码
@property (nonatomic,assign) NSInteger passwordnotset;

@property (nonatomic,assign) NSInteger authstatus;//实名认证

@property (nonatomic,strong) NSMutableArray *rewards;//受邀人获得邀请奖励。
@end
