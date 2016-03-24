//
//  HideRechargeMenuModel.m
//  BoXiu
//
//  Created by andy on 14-9-3.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "HideRechargeMenuModel.h"

@implementation HideRechargeMenuModel

- (void)requestDataWithParams:(NSDictionary *)params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:Is_HideRecharge_Method params:params success:success fail:fail];
}

- (BOOL)analyseData:(NSDictionary *)data
{
    if (![super analyseData:data])
    {
        return NO;
    }
    if (self.result == 0)
    {
        id hideSwitch = [data objectForKey:@"data"];
        if (hideSwitch && [hideSwitch isKindOfClass:[NSString class]])
        {
            self.hideSwitch = hideSwitch;
        }
        return YES;
    }
    return NO;
}

@end
