//
//  LevelUpgradeModel.m
//  BoXiu
//
//  Created by andy on 14-10-24.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "LevelUpgradeModel.h"

@implementation LevelUpgradeModel

- (void)analyseData:(NSDictionary *)dataDic
{
    [super analyseData:dataDic];
    if (dataDic && [dataDic count])
    {
        self.chatType = [[dataDic objectForKey:@"chatType"] integerValue];
        self.upgradeType = [[dataDic objectForKey:@"upgradeType"] integerValue];
        self.userid = [[dataDic objectForKey:@"userid"] integerValue];
        self.nick = [dataDic objectForKey:@"nick"];
        self.staruserid = [[dataDic objectForKey:@"staruserid"] integerValue];
        self.oldConsumerlevelweight = [[dataDic objectForKey:@"oldConsumerlevelweight"] integerValue];
        self.nowConsumerlevelweight = [[dataDic objectForKey:@"nowConsumerlevelweight"] integerValue];
        self.oldStarlevelid = [[dataDic objectForKey:@"oldStarlevelid"] integerValue];
        self.nowStarlevelid = [[dataDic objectForKey:@"nowStarlevelid"] integerValue];
    }
}
@end
