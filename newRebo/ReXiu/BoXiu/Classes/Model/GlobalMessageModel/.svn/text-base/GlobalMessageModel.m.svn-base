//
//  GlobalMessageModel.m
//  BoXiu
//
//  Created by andy on 14-7-11.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "GlobalMessageModel.h"

@implementation GlobalMessageModel

- (void)analyseData:(NSDictionary *)dataDic
{
    [super analyseData:dataDic];
    if (dataDic && [dataDic count] > 0)
    {
        self.chatType = [[dataDic objectForKey:@"chatType"] integerValue];
        self.fromnick = [dataDic objectForKey:@"fromnick"];
        self.fromuserid = [[dataDic objectForKey:@"fromuserid"] integerValue];
        self.giftimg = [dataDic objectForKey:@"giftimg"];
        self.giftname = [dataDic objectForKey:@"giftname"];
        self.giftnum = [[dataDic objectForKey:@"giftnum"] intValue];
        self.giftunit = [dataDic objectForKey:@"giftunit"];
        self.hidden = [[dataDic objectForKey:@"hidden"] integerValue];
        self.hiddenindex = [dataDic objectForKey:@"hiddenindex"];
        self.issupermanager = [[dataDic objectForKey:@"issupermanager"] boolValue];
        self.staruserid = [[dataDic objectForKey:@"staruserid"] integerValue];
        self.thidden = [[dataDic objectForKey:@"thidden"] integerValue];
        self.thiddenindex = [dataDic objectForKey:@"thiddenindex"];
        self.tissupermanager = [[dataDic objectForKey:@"tissupermanager"] boolValue];
        self.starnick = [dataDic objectForKey:@"starnick"];
        self.touserid = [[dataDic objectForKey:@"touserid"] integerValue];
        self.tonick = [dataDic objectForKey:@"tonick"];
        self.msg = [dataDic objectForKey:@"msg"];
        self.href =[[dataDic objectForKey:@"href"] toString];
    }
    
}

@end
