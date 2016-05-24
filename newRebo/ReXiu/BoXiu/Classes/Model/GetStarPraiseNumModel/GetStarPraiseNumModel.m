//
//  GetStarPraiseNumModel.m
//  BoXiu
//
//  Created by tongmingyu on 14-10-17.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "GetStarPraiseNumModel.h"

@implementation GetStarPraiseNumModel

- (void)requestDataWithParams:(NSDictionary *)params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:Get_StarPraiseNum_Method params:params success:success fail:fail];
}

- (BOOL)analyseData:(NSDictionary *)data
{
    if (![super analyseData:data])
    {
        return NO;
    }
    if (self.result == 0)
    {
        if ([data count])
        {
            NSDictionary *dic = [data objectForKey:@"data"];
            
            self.starmonthpraisecount = [[dic objectForKey:@"starmonthpraisecount"] integerValue];
        }
        return YES;
    }

    return YES;
}

@end
