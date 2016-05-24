//
//  GetUserInfoModel.m
//  BoXiu
//
//  Created by tongmingyu on 14-5-6.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "GetUserInfoModel.h"

@implementation GetUserInfoModel
// 获取个人信息
- (void)requestDataWithParams:(NSDictionary *)params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    if (self.isNotUseToken) {
            [self requestDataWithMethod:GetUserInfo_Method params:params success:success fail:fail];
    }else{
        [self requestDataWithMethod:GetUserInfo_Method_UseToken params:params success:success fail:fail];

    }

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
        
        StarInfo *userInfo = [[StarInfo alloc] init];
        if([self analyseStarData:dataDic toInfo:userInfo])
        {
            self.userInfo = userInfo;
        }
        
        return YES;
    }
    return NO;
}

@end
