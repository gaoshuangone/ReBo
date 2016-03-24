//
//  RegisterModel.m
//  BoXiu
//
//  Created by andy on 14-5-4.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "RegisterModel.h"

@implementation RegisterModel

- (void)requestDataWithParams:(NSDictionary *)params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:Regsiter_Method params:params success:success fail:fail];
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
            _userInfo = [[UserInfo alloc] init];
            if ([self analyseUserData:dataDic toInfo:_userInfo])
            {
                return YES;
            }
        }
    }

    return NO;
}

@end
