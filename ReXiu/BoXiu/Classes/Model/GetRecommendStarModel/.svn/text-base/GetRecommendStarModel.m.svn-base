//
//  GetRecommendStarModel.m
//  BoXiu
//
//  Created by andy on 14-9-19.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "GetRecommendStarModel.h"
#import "UserInfo.h"

@implementation GetRecommendStarModel
- (void)requestDataWithParams:(NSDictionary *) params success:(HttpServerInterfaceBlock) success fail:(HttpServerInterfaceBlock) fail
{
    [self requestDataWithMethod:Get_RecommendStarList_Method params:params success:success fail:fail];
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
        NSArray *starArray = [data objectForKey:@"data"];
        if (starArray && [starArray count] > 0)
        {
            for (int nIndex = 0; nIndex < [starArray count]; nIndex++)
            {
                NSDictionary *starDic = [starArray objectAtIndex:nIndex];
                if (starDic && [starDic count] > 0)
                {
                    StarInfo *starInfo = [[StarInfo alloc] init];
                    starInfo.adphoto = [starDic objectForKey:@"adphoto"];
                    starInfo.photo = [starDic objectForKey:@"photo"];
                    starInfo.attentionflag = [[starDic objectForKey:@"attentionflag"] boolValue];
                    starInfo.count = [[starDic objectForKey:@"count"] integerValue];
                    starInfo.fansnum = [[starDic objectForKey:@"fansnum"] intValue];
                    starInfo.fansnumtoplimit = [[starDic objectForKey:@"fansnumtoplimit"] intValue];
                    starInfo.firstnewstarflag = [[starDic objectForKey:@"firstnewstarflag"] intValue];
                    starInfo.idxcode = [[starDic objectForKey:@"idxcode"] intValue];
                    starInfo.liveip = [starDic objectForKey:@"liveip"];
                    starInfo.livestream = [starDic objectForKey:@"livestream"];
                    starInfo.nick = [starDic objectForKey:@"nick"];
                    starInfo.onlineflag = [[starDic objectForKey:@"onlineflag"] boolValue];
                    starInfo.recommendflag = [[starDic objectForKey:@"recommendflag"] intValue];
                    starInfo.roomid = [[starDic objectForKey:@"roomid"] intValue];
                    starInfo.serverip = [starDic objectForKey:@"serverip"];
                    starInfo.serverport = [[starDic objectForKey:@"serverport"] integerValue];
                    starInfo.showbegintime = [starDic objectForKey:@"showbegintime"];
                    starInfo.showusernum = [[starDic objectForKey:@"showusernum"] intValue];
                    starInfo.starid = [[starDic objectForKey:@"starid"] intValue];
                    starInfo.starlevelid = [[starDic objectForKey:@"starlevelid"] intValue];
                    starInfo.timeago = [starDic objectForKey:@"timeago"];
                    starInfo.userId = [[starDic objectForKey:@"userid"] intValue];
                    starInfo.introduction = [starDic objectForKey:@"introduction"];
                    starInfo.praisecount = [[starDic objectForKey:@"praisecount"] intValue];

                    if (_starMArray == nil)
                    {
                        _starMArray = [NSMutableArray array];
                    }
                    [self.starMArray addObject:starInfo];
                    
                }
            }
        }
        
        return YES;
    }
    return NO;
}

@end
