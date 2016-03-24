//
//  ThirdLoginModel.m
//  BoXiu
//
//  Created by andy on 14-8-15.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "ThirdLoginModel.h"

@implementation ThirdLoginModel

- (void)requestDataWithParams:(NSDictionary *)params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:Third_Login_Method params:params success:success fail:fail];
}

- (BOOL)analyseData:(NSDictionary *)data
{
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
            self.consumerlevelweight = [[dataDic objectForKey:@"consumerlevelweight"] integerValue];
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
            self.password = [dataDic objectForKey:@"password"];
            self.sex = [[dataDic objectForKey:@"sex"] intValue];
            self.status = [[dataDic objectForKey:@"status"] intValue];
            self.token = [dataDic objectForKey:@"token"];
            self.phone = [dataDic objectForKey:@"phone"];
            self.authstatus = [[dataDic objectForKey:@"authstatus"] integerValue];
            return YES;
        }
    }
    
    return NO;
}
@end
