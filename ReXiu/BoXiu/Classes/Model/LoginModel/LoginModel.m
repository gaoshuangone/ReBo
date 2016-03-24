//
//  LoginModel.m
//  XiuBo
//
//  Created by Andy on 14-3-20.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//
 #import "LoginModel.h"
#import "InviterFriendModel.h"

@implementation LoginModel
//登录接口
- (void)requestDataWithParams:(NSDictionary *)params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:Login_Method params:params success:success fail:fail];
}
/*返回数据解析接口*/

- (BOOL)analyseData:(NSDictionary *)data
{
    UserInfo *currentUserInfo = [[UserInfo alloc] init];

    if (![super analyseData:data])
    {
        return NO;
    }
    if (self.result == 0)
    {
        NSDictionary *dataDic = [data objectForKey:@"data"];
        if (dataDic && [dataDic count] > 0)
        {
            self.area = [[dataDic objectForKey:@"area"] integerValue];
            self.city = [[dataDic objectForKey:@"city"] integerValue];
            self.cityname = [dataDic objectForKey:@"cityname"];
            self.coin = [[dataDic objectForKey:@"coin"] longLongValue];
            self.consumerlevelweight = [UserInfo switchConsumerlevelweight:[[dataDic objectForKey:@"consumerlevelweight"] intValue]];
            self.costcoin = [[dataDic objectForKey:@"costcoin"] longLongValue];
            self.fansnum = [[dataDic objectForKey:@"fansnum"] integerValue];
            self.privlevelweight = [[dataDic objectForKey:@"privlevelweight"] integerValue];
            self.province = [[dataDic objectForKey:@"province"] integerValue];
            self.provincename = [dataDic objectForKey:@"provincename"];
            self.roomid = [[dataDic objectForKey:@"roomid"] integerValue];
            self.canaltype = [[dataDic objectForKey:@"canaltype"] intValue];
            self.createtime = [dataDic objectForKey:@"createtime"];
            self.userid = [[dataDic objectForKey:@"id"] intValue];
            self.idxcode = [[dataDic objectForKey:@"idxcode"] intValue];
            self.ip = [dataDic objectForKey:@"ip"];
            self.isproxy = [[dataDic objectForKey:@"isProxy"] boolValue];
            self.isstar = [[dataDic objectForKey:@"isstar"] boolValue];
            self.issupermanager = [[dataDic objectForKey:@"issupermanager"] boolValue];
            self.loginname = [dataDic objectForKey:@"loginname"];
            self.nick = [dataDic objectForKey:@"nick"];
            self.photo = [dataDic objectForKey:@"photo"];
            self.sex = [[dataDic objectForKey:@"sex"] intValue];
            self.status = [[dataDic objectForKey:@"status"] intValue];
            self.token = [dataDic objectForKey:@"token"];
            self.phone = [dataDic objectForKey:@"phone"];
            self.isPurpleVip = [[dataDic objectForKey:@"isPurpleVip"] boolValue];
            self.isYellowVip = [[dataDic objectForKey:@"isYellowVip"] boolValue];
            self.password = [dataDic objectForKey:@"password"];
            self.passwordnotset = [[dataDic objectForKey:@"passwordnotset"] integerValue];
            self.authstatus = [[dataDic objectForKey:@"authstatus"] integerValue];
            self.hidden = [[dataDic objectForKey:@"hidden"] integerValue];
            NSArray *rewards = [dataDic objectForKey:@"rewards"];
          
            [UserInfoManager shareUserInfoManager].hidden = self.hidden;
            
            if (rewards && [rewards isKindOfClass:[NSArray class]])
            {
                //如果rewards有值，说明本次登录的用户(受邀人)获得了邀请奖励
                if (_rewards == nil)
                {
                    _rewards = [NSMutableArray array];
                }
                for (int nIndex = 0; nIndex < rewards.count; nIndex++)
                {
                    NSDictionary *rewardDic = [rewards objectAtIndex:nIndex];
                    Reward *reward = [[Reward alloc] init];
                    reward.type = [rewardDic objectForKey:@"type"];
                    reward.rewardId = [[rewardDic objectForKey:@"id"] integerValue];
                    reward.unit = [[rewardDic objectForKey:@"unit"] integerValue];
                    reward.count = [[rewardDic objectForKey:@"count"] integerValue];
                    reward.name = [rewardDic objectForKey:@"name"];
                    reward.imgsrc = [rewardDic objectForKey:@"imgsrc"];
                    [_rewards addObject:reward];
                }
                
            }
            
        }
        return YES;
    }
    return NO;
}

@end
