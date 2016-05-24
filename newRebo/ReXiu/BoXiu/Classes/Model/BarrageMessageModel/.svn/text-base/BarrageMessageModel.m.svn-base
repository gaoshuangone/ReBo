//
//  BarrageMessageModel.m
//  BoXiu
//
//  Created by andy on 14-12-22.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "BarrageMessageModel.h"

@implementation BarrageMessageModel

- (void)analyseData:(NSDictionary *)dataDic
{
    [super analyseData:dataDic];
    if (dataDic && [dataDic count] > 0)
    {
        self.content = [dataDic objectForKey:@"content"];
        self.hidden = [[dataDic objectForKey:@"hidden"] integerValue];
        self.hiddenindex = [dataDic objectForKey:@"hiddenindex"];
        self.issupermanager = [[dataDic objectForKey:@"issupermanager"] boolValue];
        self.nick = [dataDic objectForKey:@"nick"];
        self.stargetcoin = [[dataDic objectForKey:@"stargetcoin"] longLongValue];
        self.starlevelid = [[dataDic objectForKey:@"starlevelid"] integerValue];
        self.starlevelname = [dataDic objectForKey:@"starlevelname"];
        self.starlevelnextcoin = [[dataDic objectForKey:@"starlevelnextcoin"] longValue];
        self.starlevelpercent = [dataDic objectForKey:@"starlevelpercent"];
        self.staruserid = [[dataDic objectForKey:@"staruserid"] integerValue];
        self.time = [[dataDic objectForKey:@"time"] longValue];
        self.touserbean = [[dataDic objectForKey:@"touserbean"] longLongValue];
        self.tousercoin = [[dataDic objectForKey:@"tousercoin"] longLongValue];
        self.userbean = [[dataDic objectForKey:@"userbean"] longLongValue];
        self.usercoin = [[dataDic objectForKey:@"usercoin"] longLongValue];
        self.userid = [[dataDic objectForKey:@"userid"] integerValue];
    }
}

+ (void)sendBarrageMessage:(NSDictionary *)params
{
    
    NSMutableData *packetData = [NSMutableData data];
    //body
    NSData *bodyData = [params JSONKitData];
    EWPLog(@"bodyDic = %@",params);
    
    //bodylen
    char buffer[4] = {0};
    [SUByteConvert intToByteArray:[bodyData length] bytes:buffer];
    [packetData appendBytes:buffer length:sizeof(int)];
    
    //cmd
    memset(buffer, 0, sizeof(char) * 4);
    COMMAND_ID cmd = CM_SEND_BARAGEMESSAGE;
    [SUByteConvert shortToByteArray:cmd bytes:buffer];
    [packetData appendBytes:buffer length:sizeof(COMMAND_ID)];
    
    //保留4个空字节
    memset(buffer, 0, sizeof(char) * 4);
    [packetData appendBytes:buffer length:4];
    
    
    //bodydata
    [packetData appendBytes:[bodyData bytes] length:[bodyData length]];
    
    [[CommandManager shareInstance] sendData:packetData];
}

@end
