//
//  GlobaMessageLuckyModel.m
//  BoXiu
//
//  Created by tongmingyu on 14-11-3.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "GlobaMessageLuckyModel.h"

@implementation GlobaMessageLuckyModel

- (void)analyseData:(NSDictionary *)dataDic
{
    [super analyseData:dataDic];
    if (dataDic && [dataDic count] > 0)
    {
        self.giftId = [[dataDic objectForKey:@"giftid"] integerValue];
        self.rewardCoin = [[dataDic objectForKey:@"rewardcoin"] integerValue];
        self.rewardtype = [[dataDic objectForKey:@"rewardtype"] integerValue];
        if (self.rewardtype == 2)
        {
            self.rewardbs = [[dataDic objectForKey:@"rewardbs"] integerValue];
        }
        
        self.usernick = [dataDic objectForKey:@"usernick"];
        self.userid = [[dataDic objectForKey:@"userid"] integerValue];
        self.loginname = [dataDic objectForKey:@"loginname"];
    }
    
}

@end
