//
//  hotRecommendModel.m
//  BoXiu
//
//  Created by andy on 14-7-7.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "hotRecommendModel.h"
#import "UserInfo.h"

@implementation hotRecommendModel

- (void)requestDataWithParams:(NSDictionary *)params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:Get_HotStars_Method params:params success:success fail:fail];
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
            if (_starMArray == nil)
            {
                _starMArray = [NSMutableArray array];
            }
            for (int nIndex = 0; nIndex < [dataArray count]; nIndex++)
            {
                NSDictionary *starInfoDic = [dataArray objectAtIndex:nIndex];
                StarInfo *starInfo = [[StarInfo alloc] init];
                starInfo.adphoto = [starInfoDic objectForKey:@"adphoto"];
                starInfo.count = [[starInfoDic objectForKey:@"count"] integerValue];
                starInfo.fansnum = [[starInfoDic objectForKey:@"fansnum"] integerValue];
                starInfo.fansnumtoplimit = [[starInfoDic objectForKey:@"fansnumtoplimit"] integerValue];
                starInfo.firstnewstarflag = [[starInfoDic objectForKey:@"firstnewstarflag"] integerValue];
                starInfo.idxcode = [[starInfoDic objectForKey:@"idxcode"] integerValue];
                starInfo.newstarflag = [[starInfoDic objectForKey:@"newstarflag"] integerValue];
                starInfo.liveip = [starInfoDic objectForKey:@"liveip"];
                starInfo.livestream = [starInfoDic objectForKey:@"livestream"];
                starInfo.newstarflag = [[starInfoDic objectForKey:@"newstarflag"] integerValue];
                starInfo.nick = [starInfoDic objectForKey:@"nick"];
                starInfo.onlineflag = [[starInfoDic objectForKey:@"onlineflag"] boolValue];
                starInfo.recommendflag = [[starInfoDic objectForKey:@"recommendflag"] integerValue];
                starInfo.roomid = [[starInfoDic objectForKey:@"roomid"] integerValue];
                starInfo.serverip = [starInfoDic objectForKey:@"serverip"];
                starInfo.serverport = [[starInfoDic objectForKey:@"serverport"] integerValue];
                starInfo.showbegintime = [starInfoDic objectForKey:@"showbegintime"];
                starInfo.showusernum = [[starInfoDic objectForKey:@"showusernum"] integerValue];
                starInfo.starid = [[starInfoDic objectForKey:@"starid"] integerValue];
                starInfo.starlevelid = [[starInfoDic objectForKey:@"starlevelid"] integerValue];
                starInfo.userId = [[starInfoDic objectForKey:@"userid"] integerValue];
                
                [self.starMArray addObject:starInfo];
            }
            
            return YES;
        }

    }
    
    return NO;
}

@end
