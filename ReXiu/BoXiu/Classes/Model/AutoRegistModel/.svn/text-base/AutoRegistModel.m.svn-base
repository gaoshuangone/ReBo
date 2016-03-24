//
//  AutoRegistModel.m
//  BoXiu
//
//  Created by tongmingyu on 14-12-3.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "AutoRegistModel.h"

@implementation AutoRegistModel

- (void)requestDataWithParams:(NSDictionary *)params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:AutoRegist_Method params:params success:success fail:fail];
}


- (BOOL)analyseData:(NSDictionary *)data
{
    if (![super analyseData:data])
    {
        return NO;
    }
    
    if (self.result == 0)
    {
        NSDictionary *dic = [data objectForKey:@"data"];
        if (data && data.count > 0)
        {
            self.bean = [[dic objectForKey:@"bean"] integerValue];
            self.clevelnextweight = [[dic objectForKey:@"clevelnextweight"] integerValue];
            self.clevelnextweightcoin = [[dic objectForKey:@"clevelnextweightcoin"] integerValue];
            self.clevelweightcoin = [[dic objectForKey:@"clevelweightcoin"] integerValue];
            
            self.coin = [[dic objectForKey:@"coin"] integerValue];
            self.consumerlevelweight = [[dic objectForKey:@"consumerlevelweight"] integerValue];
            self.costcoin = [[dic objectForKey:@"costcoin"] integerValue];
            self.cpercent = [[dic objectForKey:@"cpercent"] integerValue];
            
            self.createtime = [dic objectForKey:@"createtime"];
            self.freezecoinflag = [[dic objectForKey:@"freezecoinflag"] integerValue];
            self.getcoin = [[dic objectForKey:@"getcoin"] integerValue];
            
            NSDictionary *carDic = [dic objectForKey:@"handsel_car"];
            if (carDic && carDic.count != 0)
            {
                self.days = [[carDic objectForKey:@"days"] integerValue];
                self.img = [carDic objectForKey:@"img"];
                self.name = [carDic objectForKey:@"name"];
            }
            
            
            self.handsel_coin = [[dic objectForKey:@"handsel_coin"] integerValue];
            self.hidden = [[dic objectForKey:@"hidden"] integerValue];
            self.userid = [[dic objectForKey:@"id"] integerValue];
            self.idxcode = [[dic objectForKey:@"idxcode"] integerValue];
            self.idxcodedefault = [[dic objectForKey:@"idxcodedefault"] integerValue];
            
            self.isPurpleVip = [[dic objectForKey:@"isPurpleVip"] boolValue];
            self.isYellowVip = [[dic objectForKey:@"isYellowVip"] boolValue];
            self.isproxy = [[dic objectForKey:@"isproxy"] boolValue];
            self.isstar = [[dic objectForKey:@"isstar"] boolValue];
            self.issupermanager = [[dic objectForKey:@"issupermanager"] boolValue];
            self.iswatchmanager = [[dic objectForKey:@"iswatchmanager"] boolValue];
            
            self.loginname = [dic objectForKey:@"loginname"];
            self.nick = [dic objectForKey:@"nick"];
            self.password = [dic objectForKey:@"password"];
            
            self.passwordnotset = [[dic objectForKey:@"passwordnotset"] integerValue];
            self.photo = [dic objectForKey:@"photo"];
            self.privlevelweight = [[dic objectForKey:@"privlevelweight"] integerValue];
            self.sex = [[dic objectForKey:@"sex"] integerValue];
            self.starlevelcoin = [[dic objectForKey:@"starlevelcoin"] integerValue];
            self.starlevelid = [[dic objectForKey:@"starlevelid"] integerValue];
            self.starlevelname = [dic objectForKey:@"starlevelname"];
            self.starlevelnextcoin = [[dic objectForKey:@"starlevelnextcoin"] integerValue];
            self.starlevelnextid = [[dic objectForKey:@"starlevelnextid"] integerValue];
            
            self.starlevelpercent = [[dic objectForKey:@"starlevelpercent"] integerValue];
            self.status = [[dic objectForKey:@"status"] integerValue];
            self.token = [dic objectForKey:@"token"];
            self.type = [[dic objectForKey:@"type"] integerValue];
            [AppInfo shareInstance].bLoginSuccess = YES;
            
       

        }
        return YES;
    }
    
    return NO;
}

@end
