//
//  ChatMessageModel.m
//  BoXiu
//
//  Created by Andy on 14-4-11.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "ChatMessageModel.h"
#import "CommandManager.h"

@implementation ChatMessageModel

+ (void)sendMessage:(NSDictionary *)bodyDic
{
    NSLog(@"TCP------------------发送-------%@--%@",[bodyDic objectForKey:@"msg"],[bodyDic objectForKey:@"nick"]);
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
    COMMAND_ID cmd = CM_SEND_MESSAGE;
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
    if (dataDic && [dataDic count] > 0)
    {
        self.hidden = [[dataDic objectForKey:@"hidden"] integerValue];
        self.thidden = [[dataDic objectForKey:@"thidden"] integerValue];
        
        self.hiddenindex = [dataDic objectForKey:@"hiddenindex"];
        self.thiddenindex = [dataDic objectForKey:@"thiddenindex"];
        
        self.issupermanager = [[dataDic objectForKey:@"issupermanager"] boolValue];
        self.tissupermanager = [[dataDic objectForKey:@"tissupermanager"] boolValue];
        
        self.userid = [[dataDic objectForKey:@"userid"] integerValue];
        self.nick = [dataDic objectForKey:@"nick"];
        self.staruserid = [[dataDic objectForKey:@"staruserid"] integerValue];
        self.targetUserid = [[dataDic objectForKey:@"targetUserid"] integerValue];
        self.targetNick = [dataDic objectForKey:@"targetNick"];
        self.msg = [dataDic objectForKey:@"msg"];
        self.unspeak = [[dataDic objectForKey:@"unspeak"] integerValue];
        self.result = [[dataDic objectForKey:@"result"] integerValue];
        self.photo = [dataDic objectForKey:@"photo"];
        
        self.isPurpleVip = [[dataDic objectForKey:@"isPurpleVip"] integerValue];
        self.isYellowVip = [[dataDic objectForKey:@"isYellowVip"] integerValue];
        self.starlevelid = [[dataDic objectForKey:@"starlevelid"] integerValue];
        self.consumerlevelweight = [[dataDic objectForKey:@"consumerlevelweight"] integerValue];
    }

}

@end
