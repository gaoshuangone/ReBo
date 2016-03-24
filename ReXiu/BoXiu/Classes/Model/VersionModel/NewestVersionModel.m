//
//  NewestVersionModel.m
//  BoXiu
//
//  Created by tongmingyu on 14-6-4.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "NewestVersionModel.h"

@implementation NewestVersionModel

- (void)requestDataWithParams:(NSDictionary *)params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:CheckUp_Method params:params success:success fail:fail];
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
        if (dataDic && [dataDic count] > 0)
        {
            _compatible = [[dataDic objectForKey:@"compatible"] intValue];
            _mainversion = [[dataDic objectForKey:@"mainversion"] intValue];
            _path = [dataDic objectForKey:@"path"];
            _remark = [dataDic objectForKey:@"remark"];
        }
        return YES;
    }
    return NO;
}

@end
