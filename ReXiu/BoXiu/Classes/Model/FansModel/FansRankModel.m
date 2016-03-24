//
//  FansRankModel.m
//  BoXiu
//
//  Created by tongmingyu on 14-5-12.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "FansRankModel.h"
#import "UserInfo.h"

@implementation FansRankModel

- (void)requestDataWithParams:(NSDictionary *)params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:getFansRank_Method params:params success:success fail:fail];
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
            self.costallCoin = [[dataDic objectForKey:@"costallCoin"] integerValue];
            NSArray *dataArray = [dataDic objectForKey:@"newList"];

            if (_fansUserMArray == nil)
            {
                _fansUserMArray = [NSMutableArray array];
            }
            [_fansUserMArray removeAllObjects];
            
            for (int nIndex = 0; nIndex < [dataArray count]; nIndex++)
            {
                NSDictionary *dataDic = [dataArray objectAtIndex:nIndex];
                UserInfo *userInfo = [[UserInfo alloc] init];
                userInfo.coin = [[dataDic objectForKey:@"coin"] longLongValue];
                userInfo.consumerlevelweight = [UserInfo switchConsumerlevelweight:[[dataDic objectForKey:@"consumerlevelweight"] integerValue]];
                userInfo.sex = [[dataDic objectForKey:@"sex"] integerValue];
                userInfo.hidden = [[dataDic objectForKey:@"hidden"] integerValue];
                userInfo.hiddenindex = [dataDic objectForKey:@"hiddenindex"];
                userInfo.idxcode = [[dataDic objectForKey:@"idxcode"] integerValue];
                userInfo.issupermanager = [[dataDic objectForKey:@"issupermanager"] boolValue];
                userInfo.nick = [dataDic objectForKey:@"nick"];
                userInfo.photo = [dataDic objectForKey:@"photo"];
                userInfo.privlevelweight = [[dataDic objectForKey:@"privlevelweight"] integerValue];
                userInfo.userId = [[dataDic objectForKey:@"userid"] integerValue];
                userInfo.isYellowVip = [[dataDic objectForKey:@"isYellowVip"] integerValue];
                userInfo.isPurpleVip = [[dataDic objectForKey:@"isPurpleVip"] integerValue];
                [_fansUserMArray addObject:userInfo];
            }
            
        }
        return YES;
    }
    return NO;
}

@end


