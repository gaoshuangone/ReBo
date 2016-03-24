//
//  GetApproveModel.m
//  BoXiu
//
//  Created by andy on 14-7-14.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "GetApproveModel.h"

@implementation GetApproveModel

+ (void)getApprove:(NSDictionary *)bodyDic
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
    COMMAND_ID cmd = CM_GET_APPROVE;
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
    if (dataDic && [dataDic count])
    {
        self.userid = [[dataDic objectForKey:@"userid"] integerValue];
        self.staruserid = [[dataDic objectForKey:@"staruserid"] integerValue];
        self.leavecount = [[dataDic objectForKey:@"leavecount"] integerValue];
        self.getcount = [[dataDic objectForKey:@"getcount"] integerValue];
        self.sendcount = [[dataDic objectForKey:@"sendcount"] integerValue];
        self.maxcount = [[dataDic objectForKey:@"maxcount"] integerValue];
    }
}
@end
