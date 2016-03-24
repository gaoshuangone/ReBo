//
//  RechargeModel.m
//  BoXiu
//
//  Created by andy on 14-7-12.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "RechargeModel.h"

@implementation RechargeModel

- (void)requestDataWithParams:(NSDictionary *)params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:AliPay_Recharge_Method params:params success:success fail:fail];
}


- (BOOL)analyseData:(NSDictionary *)data
{
    if (![super analyseData:data])
    {
        return NO;
    }
    if (self.result == 0)
    {
        NSString *dataSign = [data objectForKey:@"data"];
        if (dataSign && [dataSign length])
        {
            self.dataSign = dataSign;
            return YES;
        }
    }
    
    return NO;
}
@end
