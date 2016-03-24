//
//  GeneralRankModel.m
//  BoXiu
//
//  Created by andy on 14-5-9.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "GeneralRankModel.h"
#import "UserInfo.h"

@implementation GeneralRankModel

- (void)requestDataWithParams:(NSDictionary *)params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:getRank_Method params:params success:success fail:fail];
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
        NSArray *dataArray = [data objectForKey:@"data"];
        if (dataArray && [dataArray count] > 0)
        {
            self.starUserMArray = [NSMutableArray array];
            for (int nIndex = 0; nIndex < [dataArray count]; nIndex++)
            {
                NSDictionary *popularStarDic = [dataArray objectAtIndex:nIndex];
                StarInfo *poplarStar = [[StarInfo alloc] init];
                if([self analyseStarData:popularStarDic toInfo:poplarStar])
                {
                    poplarStar.userId = [[popularStarDic objectForKey:@"userid"] intValue];
                    [self.starUserMArray addObject:poplarStar];
                }
                
            }
            
        }
        return YES;
    }
    return NO;

}
@end
