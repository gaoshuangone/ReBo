//
//  PhoneCardPayModel.m
//  BoXiu
//
//  Created by tongmingyu on 15-3-23.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import "PhoneCardPayModel.h"

@implementation PhoneCardPayModel

- (void)requestDataWithParams:(NSDictionary *)params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:Pay19PhoneRecharge_Method params:params success:success fail:fail];
}

- (BOOL)analyseData:(NSDictionary *)data
{
    if (![super analyseData:data])
    {
        return NO;
    }
    
    return NO;
}

@end
