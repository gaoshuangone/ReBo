//
//  LiangQueryModel.m
//  BoXiu
//
//  Created by tongmingyu on 14-9-2.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "LiangQueryModel.h"

@implementation LiangData

@end

@implementation LiangQueryModel

- (void)requestDataWithParams:(NSDictionary *)params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:LiangQuery_Method params:params success:success fail:fail];
}

- (BOOL)analyseData:(NSDictionary *)data
{
    if (![super analyseData:data])
    {
        return NO;
    }
    if (self.result == 0)
    {
        if(_liangdataMarry == nil)
        {
            _liangdataMarry = [NSMutableArray array];
        }
        [_liangdataMarry removeAllObjects];
        
        NSDictionary *dic = [data objectForKey:@"data"];
        NSArray *dataArray = [dic objectForKey:@"data"];
        if (dataArray && [dataArray count] > 0)
        {
            for (int nIndex = 0; nIndex < [dataArray count]; nIndex++)
            {
                NSDictionary *categoryDictionary = [dataArray objectAtIndex:nIndex];
                LiangData *data = [[LiangData alloc] init];
                
                data.coin = [[categoryDictionary objectForKey:@"coin"] longLongValue];
                data.pid = [[categoryDictionary objectForKey:@"id"] integerValue];
                data.Idxcode = [[categoryDictionary objectForKey:@"idxcode"] integerValue];
                data.status = [[categoryDictionary objectForKey:@"status"] integerValue];
                data.timenum = [[categoryDictionary objectForKey:@"timenum"] integerValue];
                data.timeunit = [[categoryDictionary objectForKey:@"timeunit"] integerValue];
                
                [self.liangdataMarry addObject:data];
            }
            
            return YES;
        }
        
        self.pageIndex = [[dic objectForKey:@"pageIndex"] intValue];
        self.pageSize = [[dic objectForKey:@"pageSize"] integerValue];
        self.pagination = [[dic objectForKey:@"pagination"] intValue];
        self.recordCount = [[dic objectForKey:@"recordCount"] integerValue];
        return YES;
    }
    return NO;
}


@end
