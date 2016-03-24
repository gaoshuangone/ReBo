//
//  GetConfigModel.m
//  BoXiu
//
//  Created by andy on 14-5-5.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "GetConfigModel.h"

@implementation GetConfigModel

- (void)requestDataWithParams:(NSDictionary *)params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:GetConfig_Method params:params success:success fail:fail];
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
        NSDictionary *dataDic = [data objectForKey:@"data"];
        if (dataDic && [dataDic count] > 0)
        {
            self.res_server = [dataDic objectForKey:@"res_server"];
            self.heart_time = [[dataDic objectForKey:@"heart_time"] longValue];
            self.online_stars_location = [[dataDic objectForKey:@"online_stars_location"] integerValue];

        }
        return YES;
    }
    return NO;
}


@end
