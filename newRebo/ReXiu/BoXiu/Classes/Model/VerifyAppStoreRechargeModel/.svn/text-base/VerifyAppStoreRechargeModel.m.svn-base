//
//  VerifyAppStoreRechargeModel.m
//  BoXiu
//
//  Created by andy on 14-11-14.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "VerifyAppStoreRechargeModel.h"

@implementation VerifyAppStoreRechargeModel

- (void)requestDataWithParams:(NSDictionary *)params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:Verify_Recharge_Appstore params:params success:success fail:fail];
}


- (BOOL)analyseData:(NSDictionary *)data
{
    if (![super analyseData:data])
    {
        return NO;
    }
    if (self.result == 0)
    {
        self.coin = [[data objectForKey:@"data"] longValue];
        return YES;
    }
    return NO;
}

@end
