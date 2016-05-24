//
//  SeenHistoryModel.m
//  BoXiu
//
//  Created by tongmingyu on 14-5-27.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "SeenHistoryModel.h"

@implementation SeenHistoryModel

- (void)requestDataWithParams:(NSDictionary *)params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:SeenHistory_Method params:params success:success fail:fail];
}


- (BOOL)analyseData:(NSDictionary *)data
{
    if (![super analyseData:data])
    {
        return NO;
    }
    NSDictionary *dataDic = [data objectForKey:@"data"];
    if (dataDic && [dataDic count] > 0)
    {
        NSArray *popularStarArray = [dataDic objectForKey:@"data"];
        self.userMArray = [NSMutableArray array];
        if (popularStarArray && [popularStarArray count])
        {
            for (int nIndex = 0; nIndex < [popularStarArray count]; nIndex++)
            {
                NSDictionary *popularStarDic = [popularStarArray objectAtIndex:nIndex];
                StarInfo *poplarStar = [[StarInfo alloc] init];
                if([self analyseStarData:popularStarDic toInfo:poplarStar])
                    [self.userMArray addObject:poplarStar];
                
                
            }
        }
    }
    return YES;
}

@end
