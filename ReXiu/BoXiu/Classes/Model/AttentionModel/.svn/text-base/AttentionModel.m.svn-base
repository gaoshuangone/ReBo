//
//  AttentionModel.m
//  BoXiu
//
//  Created by tongmingyu on 14-5-7.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "AttentionModel.h"
#import "UserInfo.h"

@implementation AttentionModel

- (void)requestDataWithParams:(NSDictionary *)params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:GetAttention_Method params:params success:success fail:fail];
}

/*返回数据解析接口*/

- (BOOL)analyseData:(NSDictionary *)data
{
    if (![super analyseData:data])
    {
        return NO;
    }
    if (self.result == 0)
    {
        NSDictionary *dataDic = [data objectForKey:@"data"];
        if (dataDic && [dataDic isKindOfClass:[NSDictionary class]] && [dataDic count] > 0)
        {
            self.pageIndex = [[dataDic objectForKey:@"pageIndex"] integerValue];
            self.pageSize = [[dataDic objectForKey:@"pageSize"] integerValue];
            self.pagination = [[dataDic objectForKey:@"pagination"] boolValue];
            self.recordCount = [[dataDic objectForKey:@"recordCount"] integerValue];
            
            NSArray *dataArray = [dataDic objectForKey:@"data"];
            if (dataArray && [dataArray count] > 0)
            {
                if (_starUserMArray == nil)
                {
                    _starUserMArray = [NSMutableArray array];
                }
                for (int nIndex = 0; nIndex < [dataArray count]; nIndex++)
                {
                    NSDictionary *starInfoDic = [dataArray objectAtIndex:nIndex];
                    StarInfo *starInfo = [[StarInfo alloc] init];
                    starInfo.adphoto = [starInfoDic objectForKey:@"adphoto"];
                    starInfo.photo = [starInfoDic objectForKey:@"photo"];
                    starInfo.bean = [[starInfoDic objectForKey:@"bean"] longLongValue];
                    starInfo.coin = [[starInfoDic objectForKey:@"coin"] longLongValue];
                    starInfo.consumerlevelweight = [UserInfo switchConsumerlevelweight:[[starInfoDic objectForKey:@"consumerlevelweight"] integerValue]];//[[starInfoDic objectForKey:@"consumerlevelweight"] integerValue];
                    starInfo.costcoin = [[starInfoDic objectForKey:@"costcoin"] longLongValue];
                    starInfo.getcoin = [[starInfoDic objectForKey:@"getcoin"] longLongValue];
                    starInfo.hidden = [[starInfoDic objectForKey:@"hidden"] integerValue];
                    starInfo.idxcodedefault = [[starInfoDic objectForKey:@"idxcodedefault"] integerValue];
                    starInfo.attentionflag = [[starInfoDic objectForKey:@"attentionflag"] boolValue];
                    starInfo.count = [[starInfoDic objectForKey:@"count"] integerValue];
                    starInfo.fansnum = [[starInfoDic objectForKey:@"fansnum"] integerValue];
                    starInfo.fansnumtoplimit = [[starInfoDic objectForKey:@"fansnumtoplimit"] integerValue];
                    starInfo.userId = [[starInfoDic objectForKey:@"userid"] integerValue];
                    starInfo.idxcode = [[starInfoDic objectForKey:@"idxcode"] integerValue];
                    starInfo.livestream = [starInfoDic objectForKey:@"livestream"];
                    starInfo.nick = [starInfoDic objectForKey:@"nick"];
                    starInfo.onlineflag = [[starInfoDic objectForKey:@"onlineflag"] boolValue];
                    starInfo.recommendflag = [[starInfoDic objectForKey:@"recommendflag"] boolValue];
                    starInfo.roomid = [[starInfoDic objectForKey:@"roomid"] integerValue];
                    starInfo.serverip = [starInfoDic objectForKey:@"serverip"];
                    starInfo.serverport = [[starInfoDic objectForKey:@"serverport"] integerValue];
                    starInfo.rsstatus = [[starInfoDic objectForKey:@"rsstatus"] integerValue];
                    starInfo.showbegintime = [starInfoDic objectForKey:@"showbegintime"];
                    starInfo.showusernum = [[starInfoDic objectForKey:@"showusernum"] integerValue];
                    starInfo.praisecount = [[starInfoDic objectForKey:@"praisecount"] integerValue];
                    starInfo.starid = [[starInfoDic objectForKey:@"starid"] integerValue];
                    starInfo.starlevelid = [[starInfoDic objectForKey:@"starlevelid"] integerValue];
                    starInfo.timeago = [starInfoDic objectForKey:@"timeago"];
                    starInfo.introduction = [starInfoDic objectForKey:@"introduction"];
                    starInfo.isPurpleVip = [[starInfoDic objectForKey:@"isPurpleVip"] boolValue];
                    starInfo.isYellowVip = [[starInfoDic objectForKey:@"isYellowVip"] boolValue];
                    starInfo.isstar = [[starInfoDic objectForKey:@"isstar"] boolValue];
                    starInfo.issupermanager = [[starInfoDic objectForKey:@"issupermanager"] boolValue];
                    starInfo.iswatchmanager = [[starInfoDic objectForKey:@"iswatchmanager"] boolValue];
                    starInfo.loginname = [starInfoDic objectForKey:@"loginname"];
                    starInfo.attentionflag = YES;
                    [self.starUserMArray addObject:starInfo];
                }
                
                return YES;
            }
        }

    }
    return NO;
}

@end

@implementation ChangeAttentionModel

- (void)requestDataWithParams:(NSDictionary *)params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:ChangeAttention_Method params:params success:success fail:fail];
}

@end

