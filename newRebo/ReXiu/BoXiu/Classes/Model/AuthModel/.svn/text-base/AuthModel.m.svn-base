//
//  AuthModel.m
//  BoXiu
//
//  Created by Andy on 14-4-11.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "AuthModel.h"
#import "AppDelegate.h"
#import "AppInfo.h"
#import "NSString+DES.h"
#import "UserInfoManager.h"

static long long auto_add_seq = 1;

@implementation AuthModel

+ (void)sendAuth
{
    NSMutableData *authData = [NSMutableData data];
  
    //body
    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionary];
    [bodyDic setObject:[AppInfo deviceUUID] forKey:@"did"];
    if ([AppInfo shareInstance].token)
    {
        [bodyDic setObject:[AppInfo shareInstance].token forKey:@"token"];
    }

    [bodyDic setObject:[CommonFuction getPlatformString] forKey:@"info"];
    [bodyDic setObject:[NSNumber numberWithInt:3] forKey:@"type"];
    NSString *channelid = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"channelid"];
    if (channelid && [channelid length])
    {
        //渠道号
        [bodyDic setObject:channelid forKey:@"channelid"];
    }
    
    NSString *appversion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    if (appversion && [appversion length])
    {
        //b版本号
        [bodyDic setObject:appversion forKey:@"appversion"];
    }

#ifdef Des_Encode
    NSMutableString *string = [NSMutableString string];
    if ([AppInfo shareInstance].token)
    {
        [string appendString:[AppInfo shareInstance].token];
    }
    
    if ([AppInfo deviceUUID])
    {
        [string appendString:[AppInfo deviceUUID]];
    }
    [string appendString:[CommonFuction getPlatformString]];
    [string appendFormat:@"%lld",auto_add_seq];
    NSString *signString = [[ReXiuLib shareInstance] DESEncryptWithKey:string];
    [bodyDic setObject:signString forKey:@"sign"];
    [bodyDic setObject:[NSNumber numberWithLongLong:auto_add_seq] forKey:@"seq"];
#endif//Des_Encode
    NSData *bodyData = [bodyDic JSONKitData];
    
    //bodylen
    char buffer[4] = {0};
    [SUByteConvert intToByteArray:[bodyData length] bytes:buffer];
    [authData appendBytes:buffer length:sizeof(int)];
    
    //cmd
    memset(buffer, 0, sizeof(char) * 4);
    COMMAND_ID cmd = CM_AUTH;
    [SUByteConvert shortToByteArray:cmd bytes:buffer];
    [authData appendBytes:buffer length:sizeof(COMMAND_ID)];
    
    //保留4个空字节
    memset(buffer, 0, sizeof(char) * 4);
    [authData appendBytes:buffer length:4];
    
    //bodydata
    [authData appendBytes:[bodyData bytes] length:[bodyData length]];
    
    [[CommandManager shareInstance] sendData:authData DataType:eAuth_Type];
    
}

- (void)analyseData:(NSDictionary *)dataDic
{
    
}
@end
