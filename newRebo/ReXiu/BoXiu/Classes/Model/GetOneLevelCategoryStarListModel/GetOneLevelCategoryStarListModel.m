//
//  GetOneLevelCategoryStarListModel.m
//  BoXiu
//
//  Created by andy on 14-8-11.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "GetOneLevelCategoryStarListModel.h"
#import "UserInfo.h"

@implementation GetOneLevelCategoryStarListModel

- (void)requestDataWithParams:(NSDictionary *)params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:Get_OneLevelCategoryStarList_Method params:params success:success fail:fail];
}

- (BOOL)analyseData:(NSDictionary *)data
{
    if (![super analyseData:data])
    {
        return NO;
    }
    if (self.result == 0)
    {
        if(_dataMArray == nil)
        {
            _dataMArray = [NSMutableArray array];
        }
        [_dataMArray removeAllObjects];
        
        NSArray *starArray = [data objectForKey:@"data"];
        if (starArray && [starArray count] > 0)
        {
            for (int nIndex = 0; nIndex < [starArray count]; nIndex++)
            {
                NSDictionary *starInfoDic = [starArray objectAtIndex:nIndex];
                StarInfo *starInfo = [[StarInfo alloc] init];
                starInfo.adphoto = [starInfoDic objectForKey:@"adphoto"];
                starInfo.count = [[starInfoDic objectForKey:@"count"] integerValue];
                starInfo.fansnum = [[starInfoDic objectForKey:@"fansnum"] integerValue];
                starInfo.fansnumtoplimit = [[starInfoDic objectForKey:@"fansnumtoplimit"] integerValue];
                starInfo.userId = [[starInfoDic objectForKey:@"userid"] integerValue];
                starInfo.idxcode = [[starInfoDic objectForKey:@"idxcode"] integerValue];
                starInfo.nick = [starInfoDic objectForKey:@"nick"];
                starInfo.onlineflag = [[starInfoDic objectForKey:@"onlineflag"] boolValue];
                starInfo.roomid = [[starInfoDic objectForKey:@"roomid"] integerValue];
                starInfo.rsstatus = [[starInfoDic objectForKey:@"rsstatus"] integerValue];
                starInfo.showbegintime = [starInfoDic objectForKey:@"showbegintime"];
                starInfo.showusernum = [[starInfoDic objectForKey:@"showusernum"] integerValue];
                
                [self.dataMArray addObject:starInfo];
            }
            return YES;
        }

    }
    
    return NO;
}
@end
