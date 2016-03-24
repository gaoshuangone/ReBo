//
//  SendApproveModel.m
//  BoXiu
//
//  Created by andy on 14-7-14.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "SendApproveModel.h"

@implementation SendApproveModel


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
    COMMAND_ID cmd = CM_SEND_APPROVE;
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
        self.chatType = [[dataDic objectForKey:@"chatType"] integerValue];
        self.clienttype = [[dataDic objectForKey:@"clienttype"] integerValue];
        self.getcount = [[dataDic objectForKey:@"getcount"] integerValue];
        self.hidden = [[dataDic objectForKey:@"hidden"] integerValue];
        self.hiddenindex = [dataDic objectForKey:@"hiddenindex"];
        self.issupermanager = [[dataDic objectForKey:@"issupermanager"] boolValue];
        self.leavecount = [[dataDic objectForKey:@"leavecount"] integerValue];
        self.num = [[dataDic objectForKey:@"num"] integerValue];
        self.roomid = [[dataDic objectForKey:@"roomid"] integerValue];
        self.sendcount = [[dataDic objectForKey:@"sendcount"] integerValue];
        self.starmonthpraisecount = [[dataDic objectForKey:@"starmonthpraisecount"] integerValue];
        self.userid = [[dataDic objectForKey:@"userid"] integerValue];
        self.nick = [dataDic objectForKey:@"nick"];
        self.staruserid = [[dataDic objectForKey:@"staruserid"] integerValue];
        self.starnick = [dataDic objectForKey:@"starnick"];
        self.useridfrom = [[dataDic objectForKey:@"useridfrom"] integerValue];
        self.starid = [[dataDic objectForKey:@"starid"] integerValue];
        self.showid = [[dataDic objectForKey:@"showid"] integerValue];
        self.time = [[dataDic objectForKey:@"time"] longLongValue];
        self.maxcount = [[dataDic objectForKey:@"maxcount"] integerValue];
    }
}

@end
