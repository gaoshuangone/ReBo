//
//  BuyLiangModel.m
//  BoXiu
//
//  Created by tongmingyu on 14-9-5.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "BuyLiangModel.h"

@implementation BuyLiangModel

- (void)requestDataWithParams:(NSDictionary *)params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:BuyIdxcode_Method params:params success:success fail:fail];
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
