//
//  StartupPageModel.m
//  BoXiu
//
//  Created by andy on 15-1-19.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import "StartupPageModel.h"

@implementation StartupPageData


@end

@implementation StartupPageModel

- (void)requestDataWithParams:(NSDictionary *)params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:Get_StartupPage_Method params:params success:success fail:fail];
}


- (BOOL)analyseData:(NSDictionary *)data
{
    if (![super analyseData:data])
    {
        return NO;
    }
    if (self.result == 0)
    {
        if (_startupPages == nil)
        {
            _startupPages = [NSMutableArray array];
        }
        [_startupPages removeAllObjects];
        
        
        NSDictionary *dataDic = [data objectForKey:@"data"];
        if (dataDic && [dataDic isKindOfClass:[NSDictionary class]])
        {
            NSString *res_server = [dataDic objectForKey:@"res_server"];
            NSArray *startupPageArray = [dataDic objectForKey:@"data"];
            if (startupPageArray && [startupPageArray isKindOfClass:[NSArray class]])
            {
                for (NSDictionary *startupPageDic in startupPageArray)
                {
                    StartupPageData *starupPageData = [[StartupPageData alloc] init];
                    starupPageData.actiontype = [[startupPageDic objectForKey:@"actiontype"] integerValue];
                    starupPageData.data = [startupPageDic objectForKey:@"data"];
                    starupPageData.datetime = [startupPageDic objectForKey:@"datetime"];
                    starupPageData.devicetype = [[startupPageDic objectForKey:@"devicetype"] integerValue];
                    starupPageData.endtime = [startupPageDic objectForKey:@"endtime"];
                    starupPageData.staruppageid = [[startupPageDic objectForKey:@"id"] integerValue];
                    NSString *imgurl = [startupPageDic objectForKey:@"imgurl"];
                    starupPageData.imgurl = [NSString stringWithFormat:@"%@%@",res_server,imgurl];
                    starupPageData.postertype = [[startupPageDic objectForKey:@"postertype"] integerValue];
                    starupPageData.seq = [[startupPageDic objectForKey:@"seq"] integerValue];
                    starupPageData.starttime = [startupPageDic objectForKey:@"starttime"];
                    starupPageData.status = [[startupPageDic objectForKey:@"status"] integerValue];
                    starupPageData.title = [startupPageDic objectForKey:@"title"];
                    [_startupPages addObject:starupPageData];
                }
            }
        }
        return YES;
    }
    return NO;
}

@end
