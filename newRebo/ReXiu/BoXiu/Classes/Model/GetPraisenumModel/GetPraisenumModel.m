//
//  GetPraisenumModel.m
//  BoXiu
//
//  Created by andy on 14-8-20.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "GetPraisenumModel.h"

@implementation GetPraisenumModel

- (void)requestDataWithParams:(NSDictionary *)params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:Get_PraiseNum_Method params:params success:success fail:fail];
}

- (BOOL)analyseData:(NSDictionary *)data
{
    if (![super analyseData:data])
    {
        return NO;
    }
    
    if (self.result == 0 )
    {
         NSDictionary *dic = [data objectForKey:@"data"];
        if ([dic count])
        {
            self.getcount = [[dic objectForKey:@"getcount"] integerValue];
            self.leavecount = [[dic objectForKey:@"leavecount"] integerValue];
            self.sendcount = [[dic objectForKey:@"sendcount"] integerValue];
            self.maxcount = [[dic objectForKey:@"maxcount"] integerValue];
        }
        return YES;
    }
    return NO;
}
@end
