//
//  FirstRechargeModel.m
//  BoXiu
//
//  Created by andy on 14-6-10.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "FirstRechargeModel.h"

@implementation FirstRechargeModel

- (void)requestDataWithParams:(NSDictionary *)params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:First_Recharge_Method params:params success:success fail:fail];
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
            self.bFirstRecharge = [[dataDic objectForKey:@"hasData"] boolValue];
        }
        return YES;
    }
    return NO;
}

@end
