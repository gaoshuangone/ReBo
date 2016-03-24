//
//  BeanTocoinModel.m
//  BoXiu
//
//  Created by tongmingyu on 14-10-9.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "BeanTocoinModel.h"

@implementation BeanTocoinModel

- (void)requestDataWithParams:(NSDictionary *)params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:beanTocoin_Method params:params success:success fail:fail];
}

- (BOOL)analyseData:(NSDictionary *)data
{
    if (![super analyseData:data])
    {
        return NO;
    }
    
    if (self.result == 0)
    {
        NSObject *obj = [data objectForKey:@"data"];
        if (obj && [obj isKindOfClass:[NSDictionary class]])
        {
            NSDictionary *dic = (NSDictionary *)obj;
            if (dic)
            {
                self.bean = [[dic objectForKey:@"bean"] longLongValue];
                self.coin = [[dic objectForKey:@"coin"] longLongValue];
            }
            return YES;
        }
        else
        {
            return NO;
        }
    }

    
    return YES;
}

@end 
