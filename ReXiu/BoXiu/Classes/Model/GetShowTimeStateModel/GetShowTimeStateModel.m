//
//  GetShowTimeStateModel.m
//  BoXiu
//
//  Created by andy on 15-1-26.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import "GetShowTimeStateModel.h"

@implementation GetShowTimeStateModel

- (void)requestDataWithParams:(NSDictionary *)params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:Get_ShowTimeState_Method params:params success:success fail:fail];
}


- (BOOL)analyseData:(NSDictionary *)data
{
    if (![super analyseData:data])
    {
        return NO;
    }
    if (self.result == 0)
    {
        NSDictionary *dataDic = [data objectForKey:@"data"];
        self.showTimeEndModel = [[ShowTimeEndModel alloc] initWithData:dataDic];
        self.serverTime = [[dataDic objectForKey:@"serverTime"] longLongValue];
        self.status = [[dataDic objectForKey:@"status"] integerValue];
        self.startTime = [[dataDic objectForKey:@"startTime"] longLongValue];
        self.endTime = [[dataDic objectForKey:@"endTime"] longLongValue];
        self.totalPraiseNum = [[dataDic objectForKey:@"totalPraiseNum"] integerValue];
        return YES;
    }

    return NO;
}


@end
