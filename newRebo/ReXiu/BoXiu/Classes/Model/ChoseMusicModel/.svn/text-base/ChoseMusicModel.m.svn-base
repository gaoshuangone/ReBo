//
//  ChoseMusicModel.m
//  BoXiu
//
//  Created by tongmingyu on 14-12-29.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "ChoseMusicModel.h"

@implementation ChoseMusicModel

-(void)requestDataWithParams:(NSDictionary *)params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:ChoseMusic_Method params:params success:success fail:fail];
}

-(BOOL)analyseData:(NSDictionary *)data
{
    if (![super analyseData:data])
    {
        return NO;
    }
    if (self.result == 0)
    {
        NSDictionary *dic = [data objectForKey:@"data"];
        if (dic && [dic isKindOfClass:[NSDictionary class]])
        {
            self.musicId = [[dic objectForKey:@"musicId"] integerValue];
            self.ticketNum = [[dic objectForKey:@"ticketNum"] integerValue];
            self.coin = [[dic objectForKey:@"coin"] longLongValue];
        }
        return YES;
    }
    return NO;
}


@end
