//
//  GetRoomInfoModel.m
//  BoXiu
//
//  Created by andy on 14-5-12.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "GetRoomInfoModel.h"
@implementation RoomInfoData
@end

@implementation GetRoomInfoModel

- (void)requestDataWithParams:(NSDictionary *)params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:GetRoomInfo_Method params:params success:success fail:fail];
}

/*返回数据解析接口*/

- (BOOL)analyseData:(NSDictionary *)data
{
    if (![super analyseData:data])
    {
        return NO;
    }
    if (self.result == 0)
    {
        NSDictionary *dataDic = [data objectForKey:@"data"];
        EWPLog(@"RoomInfoData:%@",dataDic);
        
        if (dataDic && [dataDic isKindOfClass:[NSDictionary class]] && [dataDic count] > 0)
        {
            _roomInfoData = [[RoomInfoData alloc] init];
            _roomInfoData.attentionflag = [[dataDic objectForKey:@"attentionflag"] boolValue];
            _roomInfoData.bigstarstarttime = [dataDic objectForKey:@"bigstarstarttime"];
            _roomInfoData.managerflag = [[dataDic objectForKey:@"managerflag"] boolValue];
            _roomInfoData.liveip = [dataDic objectForKey:@"liveip"];
            _roomInfoData.livestream = [dataDic objectForKey:@"livestream"];
            _roomInfoData.privatechatad = [dataDic objectForKey:@"privatechatad"];
            _roomInfoData.publictalkstatus = [[dataDic objectForKey:@"publictalkstatus"] integerValue];
            _roomInfoData.serverip = [dataDic objectForKey:@"serverip"];
            _roomInfoData.serverport = [dataDic objectForKey:@"serverport"];
            NSString *value = [dataDic objectForKey:@"showbegintime"];
            _roomInfoData.showbegintime = value? value : nil;
            
            value = [dataDic objectForKey:@"roomad"];
            _roomInfoData.showtype = [[dataDic objectForKey:@"showtype"] integerValue];
            _roomInfoData.roomad = value? value : nil;
            
            _roomInfoData.showid = [[dataDic objectForKey:@"showid"] integerValue];
            
            _roomInfoData.openflag = [[dataDic objectForKey:@"openflag"] boolValue];
            _roomInfoData.chatintervalcommon = [[dataDic objectForKey:@"chatintervalcommon"] integerValue];
            _roomInfoData.chatintervalpurplevip = [[dataDic objectForKey:@"chatintervalpurplevip"] integerValue];
            _roomInfoData.chatintervalyellowvip = [[dataDic objectForKey:@"chatintervalyellowvip"] integerValue];
            _roomInfoData.pubpraisenotice = [[dataDic objectForKey:@"pubpraisenotice"] integerValue];
            _roomInfoData.bigstarstate = [[dataDic objectForKey:@"bigstarstate"] integerValue];
            _roomInfoData.showtimestatus = [[dataDic objectForKey:@"showtimestatus"] integerValue];
            _roomInfoData.enteredcount = [[dataDic objectForKey:@"enteredcount"] integerValue];
        }
        return YES;
    }
    return NO;
    
}

@end
