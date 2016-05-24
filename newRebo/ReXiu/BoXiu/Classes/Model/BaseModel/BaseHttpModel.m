//
//  BaseHttpModel.m
//  BoXiu
//
//  Created by andy on 14-9-15.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "BaseHttpModel.h"
#import "NSString+DES.h"
#import "CommonFuction.h"
#import "UserInfoManager.h"
#import "MainViewController.h"
static long long auto_add_Number = 1;

@implementation BaseHttpModel

- (id)init
{
    self = [super init];
    if (self)
    {
        self.result = -1;
    }
    return self;
}
/*
 BaseHttpModel本类调用类目
 */
- (void)requestDataWithType:(NSString *)requestType method:(NSString *)method httpHeader:(NSDictionary *)httpHeader params:(NSDictionary *)params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{

        if([AppInfo shareInstance].initCoinfigState == 0)
        {
            [MainViewController initConfigInfo];
            
//            [[AppInfo shareInstance] initConfigInfo];
        }
        
        NSMutableDictionary *header = [NSMutableDictionary dictionaryWithDictionary:[self httpHeaderWithMethod:method]];
        if (httpHeader && [httpHeader count])
        {
            [header addEntriesFromDictionary:httpHeader];
        }
        
        NSMutableDictionary *paramDic = [NSMutableDictionary dictionaryWithDictionary:[self signParamWithMethod:method]];
        if (params && [params count])
        {
            [paramDic addEntriesFromDictionary:params];
        }
        
#ifdef DEBUG
        NSMutableDictionary *requestDic = [NSMutableDictionary dictionary];
        [requestDic setObject:[AppInfo shareInstance].requestServerBaseUrl forKey:@"requestBaseUrl"];
        [requestDic setObject:method forKey:@"method"];
        [requestDic setObject:paramDic forKey:@"param"];
//        EWPLog(@"requestInfo:%@",requestDic);
#endif//DEBUG
    [self requestDataWithBaseUrl:[AppInfo shareInstance].requestServerBaseUrl requestType:requestType method:method httpHeader:header params:paramDic success:^(id object) {
        if (self.code==403 && [self.msg isEqualToString:@"2"]) {//token过期
            [[AppInfo shareInstance]autoLogin:^{
                
                [self requestDataWithBaseUrl:[AppInfo shareInstance].requestServerBaseUrl requestType:requestType method:method httpHeader:header params:paramDic success:^(id object) {
                    if (success)
                    {
                        NSLog(@"model方法");
                        NSLog(@"method=%@ \nparams = %@",method,params);
                        DDLogInfo(@"data=%@\n\n",object);
                        success(object);
                    }
                } fail:^(id object) {
                    if (fail)
                    {
                        fail(object);
                    }
                  
                }];
                
                
            } fail:^(NSString *erroMessage) {
                if (fail)
                {
                    fail(object);
                }

            }];
            
                   [self autAddNumber];
            return ;
        }
        
        //            if (self.data && [self.data isKindOfClass:[NSString class]])
        //            {
        //                if ([self.data isEqualToString:@"403"] || [self.data rangeOfString:@"用户没有登陆"].length > 0)
        //                {
        //                    [[AppInfo shareInstance] showNoticeInWindow:@"请检查是否登录" duration:3];
        //                    [UserInfoManager shareUserInfoManager].currentUserInfo = nil;
        //                }
        //
        //                if ([self.data isEqualToString:@"101"])
        //                {
        //                    [[AppInfo shareInstance] showNoticeInWindow:@"您没有权限访问" duration:3];
        //                }
        //
        //            }
        if (success)
        {
            success(object);
        }
    } fail:^(id object) {
        if (fail)
        {
            fail(object);
        }
    }];
        [self autAddNumber];
   
}
/*
子类model正常调用的方法
*/
- (void)requestDataWithMethod:(NSString *)method params:(NSDictionary *)params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail{
//    if ([AppInfo shareInstance].network ==0 || ![AppInfo IsEnableConnection])
//    {
//        [[AppInfo shareInstance] showNoticeInWindow:@"您的网络有问题,请检查网络" duration:1.5];
//        return;
//    }
    [self requestDataWithType:nil method:method httpHeader:nil params:params success:success fail:fail];
}

- (void)requestDataWithMethod:(NSString *)method httpHeader:(NSDictionary *)httpHeader params:(NSDictionary *)params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithType:nil method:method httpHeader:httpHeader params:params success:success fail:fail];
}

//表单提交
- (void)uploadDataWithFileUrl:(NSString *)fileUrl params:(NSDictionary *)params method:(NSString *)method httpHeader:(NSDictionary *)httpHeader success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    NSString *baseUrl = [NSString stringWithFormat:@"%@/%@",[AppInfo shareInstance].serverBaseUrl,method];
    
    NSMutableDictionary *header = [NSMutableDictionary dictionary];
    if (httpHeader && [httpHeader count])
    {
        [header addEntriesFromDictionary:httpHeader];
    }
    
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    if (params && [params count])
    {
        [paramDic addEntriesFromDictionary:params];
    }
    
    if ([AppInfo shareInstance].token)
    {
        [header setObject:[AppInfo shareInstance].token forKey:@"token"];
    }
    [header setObject:SystemId forKey:@"systemid"];
    
    [self uploadDataWithBaseUrl:baseUrl fileUrl:fileUrl params:params httpHeader:header success:success fail:fail];
}


#pragma mark - ModelProtocol
- (BOOL)analyseData:(NSDictionary *)data
{
    if (data && [data count] > 0)
    {
        self.data = [data objectForKey:@"data"];
        self.result = [[data objectForKey:@"result"] intValue];
        self.title = [data objectForKey:@"title"];
        self.msg = [data objectForKey:@"msg"];
        self.code = [[data objectForKey:@"code"] integerValue];
        return YES;
    }
    return NO;
}

- (NSDictionary *)httpHeaderWithMethod:(NSString *)method
{
    NSMutableDictionary *header = [NSMutableDictionary dictionary];
    
    [header setObject:method forKey:@"msgname"];
    [header setObject:SystemId forKey:@"systemid"];
    [header setObject:@"3" forKey:@"clienttype"];  //ios设3，安卓设2
    [header setObject:[CommonFuction getPlatformString] forKey:@"mobiletype"];
    
    NSString *channelid = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"channelid"];
    if (channelid && [channelid length])
    {
        //渠道号
        [header setObject:channelid forKey:@"channelid"];
        
        
    }
    NSString *appversion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    if (appversion && [appversion length])
    {
        //b版本号
        [header setObject:appversion forKey:@"appversion"];
    }
    
    //    用广告标识符来当设备唯一Id
    [header setObject:[AppInfo deviceUUID] forKey:@"imei"];
//    EWPLog(@"deviceToken:%@",[AppInfo shareInstance].deviceToken);
//    [header setObject:[AppInfo shareInstance].deviceToken forKey:@"imei"];
    
    if ([AppInfo shareInstance].token)
    {
        [header setObject:[AppInfo shareInstance].token forKey:@"token"];
    }
    
    [header setObject:[NSString stringWithFormat:@"%lld",auto_add_Number] forKey:@"_time"];
    [header setObject:[NSString stringWithFormat:@"%lld",auto_add_Number] forKey:@"ttime"];
    return header;
}

- (NSDictionary *)signParamWithMethod:(NSString *)method
{
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    if (paramDic)
    {
        NSMutableString *string = [NSMutableString string];
        [string appendString:method];
        [string appendString:SystemId];
        if ([AppInfo shareInstance].token)
        {
            [string appendString:[AppInfo shareInstance].token];
        }
        [string appendFormat:@"%lld",auto_add_Number];
        NSString *signString = [[ReXiuLib shareInstance] DESEncryptWithKey:string];
        [paramDic setObject:signString forKey:@"tt_sign"];
    }
    return paramDic;
}

- (void)autAddNumber
{
    auto_add_Number++;
}
@end
