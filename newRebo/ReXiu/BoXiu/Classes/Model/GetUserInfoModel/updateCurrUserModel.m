//
//  updateCurrUserModel.m
//  BoXiu
//
//  Created by tongmingyu on 14-5-15.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "updateCurrUserModel.h"
#import "AFNetworking.h"
#import "UserInfoManager.h"

@implementation updateCurrUserModel

- (void)requestDataWithParams:(NSDictionary *)params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:updateCurrUser_Method httpHeader:nil params:params success:success fail:fail];
}

- (void)uploadDataWithFileUrl:(NSString *)fileUrl params:(NSDictionary *)params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self uploadDataWithFileUrl:fileUrl params:params method:Upload_Photo_Method httpHeader:nil success:success fail:fail];
}
@end
