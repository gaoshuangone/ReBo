//
//  BindVerifyCodeModel.m
//  BoXiu
//
//  Created by andy on 14-8-20.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "BindVerifyCodeModel.h"

@implementation BindVerifyCodeModel

- (void)requestDataWithParams:(NSDictionary *)params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:Get_BindVerifyCode_Methode params:params success:success fail:fail];
}


@end
