//
//  SetInvisibleModel.m
//  BoXiu
//
//  Created by tongmingyu on 15/8/31.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import "SetInvisibleModel.h"

@implementation SetInvisibleModel

- (void)requestDataWithParams:(NSDictionary *)params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:InvisibleState_Method params:params success:success fail:fail];

}
- (BOOL)analyseData:(NSDictionary *)data
{
    if (![super analyseData:data])
    {
        return NO;
    }
    if (self.result == 0)
    {
        self.results = [[data objectForKey:@"result"] integerValue];
        return YES;
    }
    return NO;
}
@end
