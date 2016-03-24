//
//  enterRoomModel.m
//  BoXiu
//
//  Created by Andy on 14-4-11.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "EnterRoomModel.h"


@implementation EnterRoomModel

+ (void)enterRoomWithUserId:(NSInteger)userId starUserId:(NSInteger)starUserid reconnect:(BOOL)reconnect
{
    NSMutableData *packetData = [NSMutableData data];
    //body
    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionary];
    if (userId != 0)
    {
        [bodyDic setObject:[NSNumber numberWithInteger:userId] forKey:@"userid"];
    }
    if (starUserid != 0)
    {
        [bodyDic setObject:[NSNumber numberWithInteger:starUserid] forKey:@"staruserid"];
    }
//    needhistorymsg 历史聊天消息
    if (reconnect)
    {
        [bodyDic setObject:[NSNumber numberWithBool:NO] forKey:@"sendJoinMsg"];
        [bodyDic setObject:[NSNumber numberWithBool:NO] forKey:@"needhistorymsg"];
        [bodyDic setObject:[NSNumber numberWithBool:NO] forKey:@"sendJoinMsg"];
    }
    else
    {
        [AppInfo shareInstance].history = 0;
        [bodyDic setObject:[NSNumber numberWithBool:YES] forKey:@"sendJoinMsg"];
        [bodyDic setObject:[NSNumber numberWithBool:YES] forKey:@"needhistorymsg"];
        [bodyDic setObject:[NSNumber numberWithBool:YES] forKey:@"sendJoinMsg"];
    }
    
    NSData *bodyData = [bodyDic JSONKitData];
    EWPLog(@"bodyDic = %@",bodyDic);
    //bodylen
    char buffer[4] = {0};
    [SUByteConvert intToByteArray:[bodyData length] bytes:buffer];
    [packetData appendBytes:buffer length:sizeof(int)];
    
    //cmd
    memset(buffer, 0, sizeof(char) * 4);
    COMMAND_ID cmd = CM_ENTERROOM;
    [SUByteConvert shortToByteArray:cmd bytes:buffer];
    [packetData appendBytes:buffer length:sizeof(COMMAND_ID)];
    
    //保留4个空字节
    memset(buffer, 0, sizeof(char) * 4);
    [packetData appendBytes:buffer length:4];
    
    
    //bodydata
    [packetData appendBytes:[bodyData bytes] length:[bodyData length]];
    
    [[CommandManager shareInstance] sendData:packetData];
}

- (void)analyseData:(NSDictionary *)dataDic
{
    
}

@end
