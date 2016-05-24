//
//  SetAutoRegistPwdModel.m
//  BoXiu
//
//  Created by tongmingyu on 14-12-4.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "SetAutoRegistPwdModel.h"

@implementation SetAutoRegistPwdModel

- (void)requestDataWithParams:(NSDictionary *)params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:SetAutoRegistPwd_Method params:params success:success fail:fail];
}


- (BOOL)analyseData:(NSDictionary *)data
{
    if (![super analyseData:data])
    {
        return NO;
    }
    if (self.result == 0)
    {
        return YES;
    }
    return NO;
}

@end
