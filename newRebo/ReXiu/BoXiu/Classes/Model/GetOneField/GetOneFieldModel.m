//
//  GetOneFieldModel.m
//  BoXiu
//
//  Created by CaiZetong on 15/7/17.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import "GetOneFieldModel.h"

@implementation GetOneFieldModel


- (void)requestDataWithParams:(NSDictionary *)params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:GetInfoUser_Method params:params success:success fail:fail];
    
}

- (BOOL)analyseData:(NSDictionary *)data
{
    if (![super analyseData:data])
    {
        return NO;
    }
    
    self.imageUrl = [data objectForKeyedSubscript:@"data"];
    return YES;
}

@end
