//
//  UserLogicModel.m
//  BoXiu
//
//  Created by tongmingyu on 14-5-23.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "UserLogicModel.h"

@implementation UserLogicModel

- (BOOL)analyseUserData:(NSDictionary *)dataDic toInfo:(UserInfo *)userInfo
{
    if (dataDic && [dataDic count] > 0)
    {
        userInfo.userId = [[dataDic objectForKey:@"id"] intValue];
        userInfo.idxcode = [[dataDic objectForKey:@"idxcode"] intValue];
        userInfo.loginname = [dataDic objectForKey:@"loginname"];
        userInfo.nick = [dataDic objectForKey:@"nick"];
        userInfo.phone = [dataDic objectForKey:@"phone"];
        userInfo.photo = [dataDic objectForKey:@"photo"];
        userInfo.sex = [[dataDic objectForKey:@"sex"] intValue];
        userInfo.province = [dataDic objectForKey:@"province"];
        userInfo.provincename = [dataDic objectForKey:@"provincename"];
        userInfo.city = [dataDic objectForKey:@"city"];
        userInfo.cityname = [dataDic objectForKey:@"cityname"];
        userInfo.coin = [[dataDic objectForKey:@"coin"] longLongValue];
        userInfo.bean = [[dataDic objectForKey:@"bean"] longLongValue];
        userInfo.isstar = [[dataDic objectForKey:@"isstar"] intValue];
        userInfo.issupermanager = [[dataDic objectForKey:@"issupermanager"] intValue];
        userInfo.privlevelweight = [[dataDic objectForKey:@"privlevelweight"] intValue];
        userInfo.clevelnextweight = [[dataDic objectForKey:@"clevelnextweight"] intValue];
        userInfo.clevelnextweightcoin = [[dataDic objectForKey:@"clevelnextweightcoin"] longLongValue];
        userInfo.clevelweightcoin = [[dataDic objectForKey:@"clevelweightcoin"] longLongValue];
        userInfo.consumerlevelweight = [UserInfo switchConsumerlevelweight:[[dataDic objectForKey:@"consumerlevelweight"] intValue]];//[[dataDic objectForKey:@"consumerlevelweight"] intValue];
        userInfo.costcoin = [[dataDic objectForKey:@"costcoin"] longLongValue];
        userInfo.cpercent = [[dataDic objectForKey:@"cpercent"] intValue];
        userInfo.isPurpleVip = [[dataDic objectForKey:@"isPurpleVip"] boolValue];
        userInfo.isYellowVip = [[dataDic objectForKey:@"isYellowVip"] boolValue];
        userInfo.token = [dataDic objectForKey:@"token"];
        userInfo.passwordnotset = [[dataDic objectForKey:@"passwordnotset"] boolValue];
        userInfo.password = [dataDic objectForKey:@"password"];
        userInfo.hidden = [[dataDic objectForKey:@"hidden"] integerValue];
        userInfo.authstatus = [[dataDic objectForKey:@"authstatus"] integerValue];
        userInfo.introduction =[[dataDic objectForKey:@"introduction"] toString];
        return YES;
    }
    else
        return NO;

}

- (BOOL)analyseStarData:(NSDictionary *)dataDic toInfo:(StarInfo *)starInfo
{
    [self analyseUserData:dataDic toInfo:starInfo];
    
    if (dataDic && [dataDic count] > 0)
    {
        starInfo.adphoto = [dataDic objectForKey:@"adphoto"];
        starInfo.attentionnum = [[dataDic objectForKey:@"attentionnum"] integerValue];
        starInfo.fansnum = [[dataDic objectForKey:@"fansnum"] intValue];
        starInfo.sex = [[dataDic objectForKey:@"sex"] intValue];
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
        starInfo.stargetcoin = [[dataDic objectForKey:@"stargetcoin"] longLongValue];
        starInfo.starlevelnextid = [[dataDic objectForKey:@"starlevelnextid"] intValue];
        starInfo.starlevelnextcoin = [[dataDic objectForKey:@"starlevelnextcoin"] longLongValue];
        starInfo.starlevelcoin = [[dataDic objectForKey:@"starlevelcoin"] longLongValue];
        starInfo.starlevelpercent = [[dataDic objectForKey:@"starlevelpercent"] intValue];
        starInfo.attentionflag = [[dataDic objectForKey:@"attentionflag"] boolValue];
        starInfo.onlineflag = [[dataDic objectForKey:@"onlineflag"] boolValue];
        starInfo.introduction = [dataDic objectForKey:@"introduction"];
        starInfo.starlevelid = [[dataDic objectForKey:@"starlevelid"] intValue];
        starInfo.consumerlevelweight = [UserInfo switchConsumerlevelweight:[[dataDic objectForKey:@"consumerlevelweight"] intValue]];
        starInfo.starlevelnextcoin = [[dataDic objectForKey:@"starlevelnextcoin"] longLongValue];
        starInfo.costcoin = [[dataDic objectForKey:@"costcoin"] longLongValue];
        starInfo.clevelnextweightcoin = [[dataDic objectForKey:@"clevelnextweightcoin"] longLongValue];
        starInfo.mylink = [dataDic objectForKey:@"mylink"];
         starInfo.isbeantomoneydisplay =[[dataDic objectForKey:@"isbeantomoneydisplay"] toString];
        starInfo.roomfmt =[[dataDic objectForKey:@"roomfmt"] toString];

        return YES;

    }
    else
        return NO;
}

@end
