//
//  BindMobileModel.m
//  BoXiu
//
//  Created by andy on 14-8-20.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "BindMobileModel.h"

@implementation BindMobileModel

- (void)requestDataWithParams:(NSDictionary *)params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:Bind_Mobile_Method params:params success:success fail:fail];
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
