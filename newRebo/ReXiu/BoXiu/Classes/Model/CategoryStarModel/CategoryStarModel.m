//
//  CategoryStarModel.m
//  BoXiu
//
//  Created by andy on 14-7-11.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "CategoryStarModel.h"
#import "StarCategoryModel.h"
#import "UserInfo.h"

@implementation CategoryStarModel

- (void)requestDataWithParams:(NSDictionary *)params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:Get_CategoryStarList_Method params:params success:success fail:fail];
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
                starInfo.starid = [[starInfoDic objectForKey:@"starid"] integerValue];
                starInfo.starlevelid = [[starInfoDic objectForKey:@"starlevelid"] integerValue];
                starInfo.timeago = [starInfoDic objectForKey:@"timeago"];
                starInfo.introduction = [starInfoDic objectForKey:@"introduction"];
                starInfo.photo =[starInfoDic objectForKey:@"photo"];
                starInfo.praisecount = [[starInfoDic objectForKey:@"praisecount"] integerValue];
                [self.starMArray addObject:starInfo];
            }
            
            return YES;
        }
    }
    
    return NO;
}


@end
