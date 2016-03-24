//
//  PosterModel.m
//  BoXiu
//
//  Created by andy on 14-7-7.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "PosterModel.h"

@implementation PosterData

@end

@implementation PosterModel

- (void)requestDataWithParams:(NSDictionary *)params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:Get_Poster_Method params:params success:success fail:fail];
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
            if (_posterMArray == nil)
            {
                _posterMArray = [NSMutableArray array];
            }
            for (int nIndex = 0; nIndex < [dataArray count]; nIndex++)
            {
                NSDictionary *posterDic = [dataArray objectAtIndex:nIndex];
                PosterData *posterData = [[PosterData alloc] init];
                posterData.actiontype = [[posterDic objectForKey:@"actiontype"] integerValue];
                posterData.data = [posterDic objectForKey:@"data"];
                posterData.datetime = [posterDic objectForKey:@"datetime"];
                posterData.devicetype = [[posterDic objectForKey:@"devicetype"] integerValue];
                posterData.posterid = [[posterDic objectForKey:@"id"] integerValue];
                posterData.imgurl = [posterDic objectForKey:@"imgurl"];
                posterData.postertype = [[posterDic objectForKey:@"postertype"] integerValue];
                posterData.seq = [[posterDic objectForKey:@"seq" ] integerValue];
                posterData.status = [[posterDic objectForKey:@"status"] integerValue];
                
                [self.posterMArray addObject:posterData];
            }
            
            return YES;
        }

    }
    
    return NO;
}

@end
