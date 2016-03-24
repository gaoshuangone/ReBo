//
//  BThirdLoginModel.m
//  BoXiu
//
//  Created by andy on 14-8-15.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "BThirdLoginModel.h"

@implementation BThirdLoginModel

- (void)requestDataWithParams:(NSDictionary *)params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:BThird_Login_Method params:params success:success fail:fail];
}


@end
