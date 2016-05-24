//
//  LogicModel.m
//  MemberMarket
//
//  Created by jiangbin on 13-11-13.
//  Copyright (c) 2013年 yiwopai. All rights reserved.
//

#import "HttpModel.h"


@implementation HttpModel

#pragma mark - ModelProtocol
/*模块向网络层请求数据*/
- (void)requestDataWithBaseUrl:(NSString *)baseUrl requestType:(NSString *)requestType method:(NSString *)method httpHeader:(NSDictionary *)httpHeader params:(NSDictionary *)params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [[HttpSerVerInterface shareServerInterface] requestDataWithBaseUrl:baseUrl requestType:requestType method:method httpHeader:httpHeader params:params success:^(id object) {
        if (success)
        {
            
            if ([self respondsToSelector:@selector(analyseData:)])
            {
                [self analyseData:object];
            }
            success(self);
        }
    } fail:^(id object) {
        /*解析完传回去数据*/
        if (fail)
        {
            fail(object);
        }
    }];
}

- (void)requestDataWithType:(NSString *)requestType method:(NSString *)method httpHeader:(NSDictionary *)httpHeader params:(NSDictionary *)params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    
}

- (void)requestDataWithMethod:(NSString *)method httpHeader:(NSDictionary *)httpHeader params:(NSDictionary *)params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    
}

- (void)requestDataWithParams:(NSDictionary *)params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    
}

- (void)requestDataWithMethod:(NSString *)method params:(NSDictionary *)params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    
}

//上传文件
- (void)uploadDataWithBaseUrl:(NSString *)baseUrl fileUrl:(NSString *)fileUrl params:(NSDictionary *)params httpHeader:(NSDictionary *)httpHeader success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail;
{
    [[HttpSerVerInterface shareServerInterface] uploadDataWithBaseUrl:baseUrl fileUrl:fileUrl params:params httpHeader:httpHeader success:^(id object) {
        if (success)
        {
            if ([self respondsToSelector:@selector(analyseData:)])
            {
                [self analyseData:object];
            }
            success(self);
        }

    } fail:^(id object) {
        /*解析完传回去数据*/
        if (fail)
        {
            fail(object);
        }
    }];
}

- (void)uploadDataWithFileUrl:(NSString *)fileUrl params:(NSDictionary *)params method:(NSString *)method httpHeader:(NSDictionary *)httpHeader success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{

}

- (void)uploadDataWithFileUrl:(NSString *)fileUrl params:(NSDictionary *)params method:(NSString *)method  success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    
}

- (void)uploadDataWithFileUrl:(NSString *)fileUrl params:(NSDictionary *)params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    
}

- (BOOL)analyseData:(NSDictionary *)data
{
    if (data && [data count] > 0)
    {
        return YES;
    }
    return NO;
}

#pragma mark - 功能
- (void)uploadFileWithurl:(NSString *)url fileUrl:(NSString *)fileUrl fileName:(NSString *)fileName httpHeader:(NSDictionary *)httpHeader success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail;
{
    NSString *name = fileName;
    if (name == nil)
    {
        name = @"file";
    }
    [[HttpSerVerInterface shareServerInterface] uploadFileWithurl:url fileUrl:fileUrl fileName:name httpHeader:httpHeader success:success fail:fail];
}

@end
