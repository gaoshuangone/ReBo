//
//  CrownModel.m
//  BoXiu
//
//  Created by andy on 14-8-14.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "CrownModel.h"

@implementation CrownModel

- (void)analyseData:(NSDictionary *)dataDic
{
    if (dataDic && [dataDic count])
    {
        self.chatType = [[dataDic objectForKey:@"chatType"] integerValue];
        self.nick = [dataDic objectForKey:@"nick"];
        self.staruserid = [[dataDic objectForKey:@"staruserid"] integerValue];
        self.time = [[dataDic objectForKey:@"time"] integerValue];
        self.unspeak = [[dataDic objectForKey:@"unspeak"] integerValue];
        self.userid = [[dataDic objectForKey:@"userid"] integerValue];
        self.hidden = [[dataDic objectForKey:@"hidden"] integerValue];
        self.hiddenindex = [dataDic objectForKey:@"hiddenindex"];
        self.issupermanager = [[dataDic objectForKey:@"issupermanager"] boolValue];
    }
    
}
@end
