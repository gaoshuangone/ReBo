//
//  ResetVerifyCodeModel.m
//  BoXiu
//
//  Created by andy on 14-8-20.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "ResetVerifyCodeModel.h"

@implementation ResetVerifyCodeModel

- (void)requestDataWithParams:(NSDictionary *)params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:Get_ResetVerifyCode_Method params:params success:success fail:fail];
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
