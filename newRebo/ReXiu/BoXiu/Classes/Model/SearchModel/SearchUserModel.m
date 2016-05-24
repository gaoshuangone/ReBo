//
//  SearchUserModel.m
//  BoXiu
//
//  Created by tongmingyu on 14-5-21.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "SearchUserModel.h"
#import "UserInfo.h"

@implementation SearchUserModel

- (void)requestDataWithParams:(NSDictionary *) params success:(HttpServerInterfaceBlock) success fail:(HttpServerInterfaceBlock) fail
{
    [self requestDataWithMethod:SearchUser_Method params:params success:success fail:fail];
}

- (BOOL)analyseData:(NSDictionary *)data
{
    if (![super analyseData:data])
    {
        return NO;
    }
    if (self.result == 0)
    {
        NSArray *dataArray = [data objectForKey:@"data"];
        if (dataArray && [dataArray count] > 0)
        {
            self.userMArray = [NSMutableArray array];
            for (int nIndex = 0; nIndex < [dataArray count]; nIndex++)
            {
                NSDictionary *dataDic = [dataArray objectAtIndex:nIndex];
                StarInfo *starInfo = [[StarInfo alloc] init];
                
                starInfo.userId = [[dataDic objectForKey:@"userid"] intValue];
                starInfo.idxcode = [[dataDic objectForKey:@"idxcode"] intValue];
                starInfo.loginname = [dataDic objectForKey:@"loginname"];
                starInfo.nick = [dataDic objectForKey:@"nick"];
                starInfo.photo = [dataDic objectForKey:@"photo"];
                starInfo.introduction = [dataDic objectForKey:@"introduction"];
                starInfo.count = [[dataDic objectForKey:@"count"] integerValue];
                starInfo.sex = [[dataDic objectForKey:@"sex"] intValue];
                starInfo.province = [dataDic objectForKey:@"province"];
                starInfo.provincename = [dataDic objectForKey:@"provincename"];
                starInfo.city = [dataDic objectForKey:@"city"];
                starInfo.cityname = [dataDic objectForKey:@"cityname"];
                starInfo.coin = [[dataDic objectForKey:@"coin"] longLongValue];
                starInfo.bean = [[dataDic objectForKey:@"bean"] longLongValue];
                starInfo.isstar = [[dataDic objectForKey:@"isstar"] intValue];
                starInfo.issupermanager = [[dataDic objectForKey:@"issupermanager"] intValue];
                starInfo.privlevelweight = [[dataDic objectForKey:@"privlevelweight"] intValue];
                starInfo.clevelnextweight = [[dataDic objectForKey:@"clevelnextweight"] intValue];
                starInfo.clevelnextweightcoin = [[dataDic objectForKey:@"clevelnextweightcoin"] longLongValue];
                starInfo.clevelweightcoin = [[dataDic objectForKey:@"clevelweightcoin"] longLongValue];
                starInfo.consumerlevelweight = [UserInfo switchConsumerlevelweight:[[dataDic objectForKey:@"consumerlevelweight"] intValue]];//[[dataDic objectForKey:@"consumerlevelweight"] intValue];
                starInfo.costcoin = [[dataDic objectForKey:@"costcoin"] longLongValue];
                starInfo.cpercent = [[dataDic objectForKey:@"cpercent"] intValue];
                starInfo.privlevelweight = [[dataDic objectForKey:@"privlevelweight"] intValue];
                
                starInfo.adphoto = [dataDic objectForKey:@"adphoto"];
                starInfo.attentionnum = [[dataDic objectForKey:@"attentionnum"] integerValue];
                starInfo.fansnum = [[dataDic objectForKey:@"fansnum"] intValue];
                starInfo.fansnumtoplimit = [[dataDic objectForKey:@"fansnumtoplimit"] intValue];
                starInfo.liveip = [dataDic objectForKey:@"liveip"];
                starInfo.livestream = [dataDic objectForKey:@"livestream"];
                starInfo.roomid = [[dataDic objectForKey:@"roomid"] intValue];
                starInfo.serverip = [dataDic objectForKey:@"serverip"];
                starInfo.serverport = [[dataDic objectForKey:@"serverport"] integerValue];
                starInfo.starid = [[dataDic objectForKey:@"starid"] intValue];
                starInfo.starlevelid = [[dataDic objectForKey:@"starlevelid"] intValue];
                starInfo.status = [[dataDic objectForKey:@"status"] intValue];
                starInfo.getcoin = [[dataDic objectForKey:@"getcoin"] longLongValue];
                starInfo.starlevelnextid = [[dataDic objectForKey:@"starlevelnextid"] intValue];
                starInfo.starlevelnextcoin = [[dataDic objectForKey:@"starlevelnextcoin"] longLongValue];
                starInfo.starlevelcoin = [[dataDic objectForKey:@"starlevelcoin"] longLongValue];
                starInfo.starlevelpercent = [[dataDic objectForKey:@"starlevelpercent"] intValue];
                starInfo.attentionflag = [[dataDic objectForKey:@"attentionflag"] boolValue];
                starInfo.onlineflag = [[dataDic objectForKey:@"onlineflag"] boolValue];
                starInfo.praisecount = [[dataDic objectForKey:@"praisecount"] integerValue];
                [self.userMArray addObject:starInfo];
                
            }
            
        }
        return YES;

    }
    return NO;
}

@end
