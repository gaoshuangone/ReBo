//
//  LoginPosterModel.m
//  BoXiu
//
//  Created by tongmingyu on 14-9-22.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "LoginPosterModel.h"

@implementation PostData


@end

@implementation LoginPosterModel

- (void)requestDataWithParams:(NSDictionary *) params success:(HttpServerInterfaceBlock) success fail:(HttpServerInterfaceBlock) fail
{
    [self requestDataWithMethod:queryMobileLoginPoster params:params success:success fail:fail];
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
                    PostData *postData = [[PostData alloc] init];
                    postData.actionType = [[starDic objectForKey:@"actiontype"] integerValue];
                    postData.dateTime = [starDic objectForKey:@"datetime"];
                    postData.devicetype = [[starDic objectForKey:@"devicetype"] intValue];
                    
                    postData.pid = [[starDic objectForKey:@"id"] intValue];
                    postData.ImgUrl = [starDic objectForKey:@"imgurl"];
                    postData.posterType = [[starDic objectForKey:@"postertype"] intValue];
                    postData.seq = [[starDic objectForKey:@"seq"] intValue];
                    postData.staus = [[starDic objectForKey:@"status"] intValue];
                    
                    if (_posterMary == nil)
                    {
                        _posterMary = [NSMutableArray array];
                    }
                    [self.posterMary addObject:postData];
                    
                }
            }
        }
        
        return YES;
    }
    return NO;
}


@end
