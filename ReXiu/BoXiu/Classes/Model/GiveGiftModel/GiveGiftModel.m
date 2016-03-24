//
//  GiveGiftModel.m
//  BoXiu
//
//  Created by andy on 14-5-22.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "GiveGiftModel.h"

@implementation GiveGiftModel

+ (void)giveGift:(NSDictionary *)giftInfo
{
    NSMutableData *packetData = [NSMutableData data];
    //body
    NSDictionary *bodyDic = [NSDictionary dictionaryWithDictionary:giftInfo];

    NSData *bodyData = [bodyDic JSONKitData];
    EWPLog(@"bodyDic = %@",bodyDic);
    //bodylen
    char buffer[4] = {0};
    [SUByteConvert intToByteArray:[bodyData length] bytes:buffer];
    [packetData appendBytes:buffer length:sizeof(int)];
    
    //cmd
    memset(buffer, 0, sizeof(char) * 4);
    COMMAND_ID cmd = CM_GIVE_GIFT;
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
    self.actiontype = [[dataDic objectForKey:@"actiontype"] integerValue];
    self.chatType = [[dataDic objectForKey:@"chatType"] integerValue];
    self.clienttype = [[dataDic objectForKey:@"clienttype"] integerValue];
    self.clienttypeinfo = [dataDic objectForKey:@"clienttypeinfo"];
    self.coin = [[dataDic objectForKey:@"coin"] longLongValue];
    self.giftcost = [[dataDic objectForKey:@"giftcost"] longLongValue];
    self.giftflashurl = [dataDic objectForKey:@"giftflashurl"];
    self.giftimg = [dataDic objectForKey:@"giftimg"];
    self.giftimgbig = [dataDic objectForKey:@"giftimgbig"];
    self.giftname = [dataDic objectForKey:@"giftname"];
    self.giftsource = [[dataDic objectForKey:@"giftsource"] integerValue];
    self.giftcategory = [[dataDic objectForKey:@"giftcategory"] integerValue];
    self.giftunit = [dataDic objectForKey:@"giftunit"];
    self.hidden = [[dataDic objectForKey:@"hidden"] integerValue];
    self.hiddenindex = [dataDic objectForKey:@"hiddenindex"];
    self.issupermanager = [[dataDic objectForKey:@"issupermanager"] boolValue];
    self.objectid = [[dataDic objectForKey:@"objectid"] integerValue];
    self.objectnum = [[dataDic objectForKey:@"objectnum"] intValue];
    self.result = [[dataDic objectForKey:@"result"] integerValue];
    self.roomid = [[dataDic objectForKey:@"roomid"] integerValue];
    self.showid = [[dataDic objectForKey:@"showid"]  integerValue];
    self.starbean = [[dataDic objectForKey:@"starbean"] longLongValue];
    self.starcoin = [[dataDic objectForKey:@"starcoin"] longLongValue];
    self.stargetcoin = [[dataDic objectForKey:@"stargetcoin"] longLongValue];
    self.starid = [[dataDic objectForKey:@"starid"] integerValue];
    self.starlevelid = [[dataDic objectForKey:@"starlevelid"] integerValue];
    self.staruserid = [[dataDic objectForKey:@"staruserid"] integerValue];
    self.thidden = [[dataDic objectForKey:@"thidden"] integerValue];
    self.thiddenindex = [dataDic objectForKey:@"thiddenindex"];
    self.time = [[dataDic objectForKey:@"time"] longValue];
    self.tissupermanager = [[dataDic objectForKey:@"tissupermanager"] boolValue];
    self.touserbean = [[dataDic objectForKey:@"touserbean"] longLongValue];
    self.tousercoin = [[dataDic objectForKey:@"tousercoin"] longLongValue];
    self.userbean = [[dataDic objectForKey:@"userbean"] longLongValue];
    self.usercoin = [[dataDic objectForKey:@"usercoin"] longLongValue];
    self.useridfrom = [[dataDic objectForKey:@"useridfrom"] intValue];
    self.useridto = [[dataDic objectForKey:@"useridto"] intValue];
    self.usernickfrom = [dataDic objectForKey:@"usernickfrom"];
    self.usernickto = [dataDic objectForKey:@"usernickto"];
    
    NSArray *bigstargiftlist = [dataDic objectForKey:@"bigstargiftlist"];
    if (bigstargiftlist && [bigstargiftlist isKindOfClass:[NSArray class]])
    {
        if (_bigStargiftList == nil)
        {
            _bigStargiftList = [NSMutableArray array];
        }
        [_bigStargiftList removeAllObjects];
        
        for (NSDictionary *bigStarGiftDic in bigstargiftlist)
        {
            StarGiftRankItemData *bigStarGiftData = [[StarGiftRankItemData alloc] init];
            bigStarGiftData.count = [[bigStarGiftDic objectForKey:@"count"] integerValue];
            bigStarGiftData.giftid = [[bigStarGiftDic objectForKey:@"giftid"] integerValue];
            bigStarGiftData.giftimg = [bigStarGiftDic objectForKey:@"giftimg"];
            bigStarGiftData.giftimgbig = [bigStarGiftDic objectForKey:@"giftimgbig"];
            bigStarGiftData.giftname = [bigStarGiftDic objectForKey:@"giftname"];
            bigStarGiftData.idxcode = [[bigStarGiftDic objectForKey:@"idxcode"] integerValue];
            bigStarGiftData.nick = [bigStarGiftDic objectForKey:@"nick"];
            bigStarGiftData.userid = [[bigStarGiftDic objectForKey:@"userid"] integerValue];
            [_bigStargiftList addObject:bigStarGiftData];
        }
    }
    
}

@end
