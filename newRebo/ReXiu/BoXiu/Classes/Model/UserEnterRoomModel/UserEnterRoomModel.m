//
//  UserEnterRoomModel.m
//  BoXiu
//
//  Created by andy on 14-8-5.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "UserEnterRoomModel.h"

@implementation CarData

@end

@implementation MemberData

@end

@implementation UserEnterRoomModel

- (void)analyseData:(NSDictionary *)dataDic
{
    if (dataDic == nil)
    {
        return;
    }
    
    NSDictionary *car = [dataDic objectForKey:@"car"];
    if (car && [car count])
    {
        _carData = [[CarData alloc] init];
        _carData.brandimg = [car objectForKey:@"brandimg"];
        _carData.carimgsmall = [car objectForKey:@"carimgsmall"];
        _carData.carunit = [car objectForKey:@"carunit"];
        _carData.carname = [car objectForKey:@"carname"];
        _carData.carId = [[car objectForKey:@"id"] integerValue];
        _carData.flashurl = [car objectForKey:@"flashurl"];
        
    }
    NSString *jsonStr = [dataDic objectForKey:@"member"];//[[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
    if ([jsonStr isKindOfClass:[NSString class]])
    {
        return ;
    }
    NSDictionary *member = [dataDic objectForKey:@"member"];
    if (member && [member count])
    {
        _memberData = [[MemberData alloc] init];
        _memberData.clientId = [member objectForKey:@"clientId"];
        _memberData.consumerlevelweight =[UserInfo switchConsumerlevelweight:[[member objectForKey:@"consumerlevelweight"] integerValue]];
        _memberData.deviceType = [[member objectForKey:@"deviceType"] integerValue];
        _memberData.hidden = [[member objectForKey:@"hidden"] integerValue];
        _memberData.hiddenindex = [member objectForKey:@"hiddenindex"];
        _memberData.idxcode = [[member objectForKey:@"idxcode"] integerValue];
        _memberData.issupermanager = [[member objectForKey:@"issupermanager"] boolValue];
        _memberData.levelWeight = [[member objectForKey:@"levelWeight"] integerValue];
        _memberData.nick = [member objectForKey:@"nick"];
        _memberData.photo = [member objectForKey:@"photo"];
        _memberData.privlevelweight = [[member objectForKey:@"privlevelweight"] integerValue];
        _memberData.starlevelid = [[member objectForKey:@"starlevelid"] integerValue];
        _memberData.staruserid = [[member objectForKey:@"staruserid"] integerValue];
        _memberData.time = [[member objectForKey:@"time"] longLongValue];
        _memberData.type = [[member objectForKey:@"type"] integerValue];
        _memberData.userId = [[member objectForKey:@"userId"] integerValue];
    }
    self.time = [[dataDic objectForKey:@"time"] longLongValue];
    self.touristCount = [[dataDic objectForKey:@"touristCount"] integerValue];
}

@end
