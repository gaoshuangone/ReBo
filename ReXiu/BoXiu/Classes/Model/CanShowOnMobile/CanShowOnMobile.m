//
//  CanShowOnMobile.m
//  BoXiu
//
//  Created by CaiZetong on 15/7/22.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import "CanShowOnMobile.h"

@implementation CanShowOnMobile

- (void)requestDataWithParams:(NSDictionary *)params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:CanShowOnMobile_Method params:params success:success fail:fail];
    
}

- (BOOL)analyseData:(NSDictionary *)data
{
    if (![super analyseData:data])
    {
        return NO;
    }
    
    
    
    return YES;
}

@end
