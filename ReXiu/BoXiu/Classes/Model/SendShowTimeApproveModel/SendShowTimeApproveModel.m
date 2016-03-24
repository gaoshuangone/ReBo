//
//  SendShowTimeApproveModel.m
//  BoXiu
//
//  Created by andy on 15-1-23.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import "SendShowTimeApproveModel.h"

@implementation SendShowTimeApproveModel

+ (void)sendApprove:(NSDictionary *)bodyDic
{
    NSMutableData *packetData = [NSMutableData data];
    //body
    NSData *bodyData = [bodyDic JSONKitData];
    EWPLog(@"bodyDic = %@",bodyDic);
    
    //bodylen
    char buffer[4] = {0};
    [SUByteConvert intToByteArray:[bodyData length] bytes:buffer];
    [packetData appendBytes:buffer length:sizeof(int)];
    
    //cmd
    memset(buffer, 0, sizeof(char) * 4);
    COMMAND_ID cmd = CM_SEND_SHOWTIME_APPROVE;
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
    [super analyseData:dataDic];
    self.success = [[dataDic objectForKey:@"success"] integerValue];
    self.msg = [[dataDic objectForKey:@"msg"] integerValue];
    self.coin = [[dataDic objectForKey:@"coin"] longLongValue];
    self.num = [[dataDic objectForKey:@"num"] integerValue];
}


@end
