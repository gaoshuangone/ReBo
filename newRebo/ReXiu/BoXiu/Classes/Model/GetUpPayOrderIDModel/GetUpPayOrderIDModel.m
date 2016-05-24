//
//  GetUpPayOrderIDModel.m
//  BoXiu
//
//  Created by andy on 14-8-19.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "GetUpPayOrderIDModel.h"

@implementation GetUpPayOrderIDModel

- (void)requestDataWithParams:(NSDictionary *)params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:Get_UPPayOrderID_Method params:params success:success fail:fail];
}

- (BOOL)analyseData:(NSDictionary *)data
{
    if (![super analyseData:data])
    {
        return NO;
    }
    if (self.result == 0)
    {
        NSString *orderId = [data objectForKey:@"data"];
        if (orderId && [orderId length])
        {
            self.orderId = orderId;
            return YES;
        }
    }
    return NO;
}
@end
