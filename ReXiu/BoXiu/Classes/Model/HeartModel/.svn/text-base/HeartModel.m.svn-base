//
//  HeartModel.m
//  BoXiu
//
//  Created by andy on 14-7-3.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "HeartModel.h"

@implementation HeartModel

+ (void)sendHeart
{
    NSMutableData *HeartData = [NSMutableData data];
    
    //body为空
    
    //bodylen
    char buffer[4] = {0};
    [SUByteConvert intToByteArray:0 bytes:buffer];
    [HeartData appendBytes:buffer length:sizeof(int)];
    
    //cmd
    memset(buffer, 0, sizeof(char) * 4);
    COMMAND_ID cmd = CM_HEART;
    [SUByteConvert shortToByteArray:cmd bytes:buffer];
    [HeartData appendBytes:buffer length:sizeof(COMMAND_ID)];
    
    //保留4个空字节
    memset(buffer, 0, sizeof(char) * 4);
    [HeartData appendBytes:buffer length:4];
    
    //bodydata
    [[CommandManager shareInstance] sendData:HeartData DataType:eHeart_Type];
    
}

- (void)analyseData:(NSDictionary *)dataDic
{
    
}

@end
