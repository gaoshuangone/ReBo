//
//  PublicTalkSettingModel.m
//  BoXiu
//
//  Created by andy on 15-1-22.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import "PublicTalkSettingModel.h"

@implementation PublicTalkSettingModel
- (void)analyseData:(NSDictionary *)dataDic
{
    [super analyseData:dataDic];
    
    if (dataDic && [dataDic count] > 0)
    {
        self.hidden = [[dataDic objectForKey:@"hidden"] integerValue];
        self.issupermanager = [[dataDic objectForKey:@"issupermanager"] boolValue];
        self.nick = [dataDic objectForKey:@"nick"];
        self.publictalkstatus = [[dataDic objectForKey:@"publictalkstatus"] integerValue];
        self.staruserid = [[dataDic objectForKey:@"staruserid"] integerValue];
        self.time = [[dataDic objectForKey:@"time"] longLongValue];
        self.userid = [[dataDic objectForKey:@"userid"] integerValue];
        self.useridfrom = [[dataDic objectForKey:@"usernick"] integerValue];
    }
}
@end
