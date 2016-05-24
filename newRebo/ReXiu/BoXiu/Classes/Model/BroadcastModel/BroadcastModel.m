//
//  BroadcastModel.m
//  BoXiu
//
//  Created by andy on 14-6-5.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "BroadcastModel.h"

@implementation BroadcastModel

- (void)analyseData:(NSDictionary *)dataDic
{
    [super analyseData:dataDic];
    if (dataDic && [dataDic count] > 0)
    {
        NSDictionary *dic = [dataDic objectForKey:@"data"];
        if (dic && [dic isKindOfClass:[NSDictionary class]] && [dic count])
        {
            self.downmobileliveip = [dic objectForKey:@"downmobileliveip"];
            self.downliveip = [dic objectForKey:@"downliveip"];
            self.showid = [[dic objectForKey:@"id"] integerValue];
            self.liveip = [dic objectForKey:@"liveip"];
            self.livestream = [dic objectForKey:@"livestream"];
            self.roomid = [[dic objectForKey:@"roomid"] integerValue];
            self.serverip = [dic objectForKey:@"serverip"];
            self.serverport = [[dic objectForKey:@"serverport"] integerValue];
            self.showbegintime = [dic objectForKey:@"showbegintime"];
            self.showtype = [[dic objectForKey:@"showtype"] integerValue];
            self.showusernum = [[dic objectForKey:@"showusernum"] integerValue];
            self.starid = [[dic objectForKey:@"starid"] integerValue];
            self.statcoinflag = [[dic objectForKey:@"statcoinflag"] integerValue];
            self.status = [[dic objectForKey:@"status"] integerValue];
            self.userid = [[dic objectForKey:@"userid"] integerValue];
        }
        self.hidden = [[dataDic objectForKey:@"hidden"] integerValue];
        self.issupermanager = [[dataDic objectForKey:@"issupermanager"] boolValue];
        self.nick = [dataDic objectForKey:@"nick"];
        self.staruserid = [[dataDic objectForKey:@"staruserid"] integerValue];
        self.time = [[dataDic objectForKey:@"time"] longLongValue];
        self.useridfrom = [[dataDic objectForKey:@"useridfrom"] integerValue];
    }
    
}

@end
