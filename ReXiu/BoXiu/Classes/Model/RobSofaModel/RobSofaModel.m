//
//  RobSofaModel.m
//  BoXiu
//
//  Created by andy on 14-5-28.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "RobSofaModel.h"

@implementation RobSofaModel

+ (void)robSofa:(NSDictionary *)bodyDic
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
    COMMAND_ID cmd = CM_ROB_SOFA;
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
    if (dataDic && [dataDic count] > 0)
    {
        self.hidden = [[dataDic objectForKey:@"hidden"] integerValue];
        self.hiddenindex = [dataDic objectForKey:@"hiddenindex"];
        self.issupermanager = [[dataDic objectForKey:@"issupermanager"] boolValue];
        self.nick = [dataDic objectForKey:@"nick"];
        self.num = [[dataDic objectForKey:@"num"] integerValue];
        self.photo = [dataDic objectForKey:@"photo"];
        self.result = [[dataDic objectForKey:@"result"] integerValue];
        self.sofano = [[dataDic objectForKey:@"sofano"] integerValue];
        self.starbean = [[dataDic objectForKey:@"starbean"] longLongValue];
        self.starcoin = [[dataDic objectForKey:@"starcoin"] longLongValue];
        self.starlevelid = [[dataDic objectForKey:@"starlevelid"] integerValue];
        self.starnick = [dataDic objectForKey:@"starnick"];
        self.staruserid = [[dataDic objectForKey:@"staruserid"] integerValue];
        self.time = [[dataDic objectForKey:@"time"] longLongValue];
        self.userbean = [[dataDic objectForKey:@"userbean"] longLongValue];
        self.usercoin = [[dataDic objectForKey:@"usercoin"] longLongValue];
        self.userid = [[dataDic objectForKey:@"userid"] integerValue];
    }
    
}

@end
