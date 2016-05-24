//
//  GetSystemTimeModel.m
//  BoXiu
//
//  Created by andy on 15-1-15.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import "GetSystemTimeModel.h"

@implementation GetSystemTimeModel
-(void)requestDataWithParams:(NSDictionary *)params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:Get_SystemTime_Method params:params success:success fail:fail];
}

-(BOOL)analyseData:(NSDictionary *)data
{
    if (![super analyseData:data])
    {
        return NO;
    }
    if (self.result == 0)
    {
         self.systemTime = [[data objectForKey:@"data"] longLongValue];
        return YES;
    }
    return NO;
}

@end
