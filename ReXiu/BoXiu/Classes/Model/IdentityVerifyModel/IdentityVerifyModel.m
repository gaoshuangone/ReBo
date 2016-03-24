//
//  IdentityVerifyModel.m
//  BoXiu
//
//  Created by andy on 15/5/15.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import "IdentityVerifyModel.h"

@implementation IdentityVerifyModel

- (void)uploadDataWithFileUrl:(NSString *)fileUrl params:(NSDictionary *)params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self uploadDataWithFileUrl:fileUrl params:params method:IdentityVerify_Method httpHeader:nil success:success fail:fail];
}

- (BOOL)analyseData:(NSDictionary *)data
{
    if (![super analyseData:data])
    {
        return NO;
    }
    
    return NO;
}
@end
