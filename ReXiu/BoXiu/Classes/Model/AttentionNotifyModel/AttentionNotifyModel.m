//
//  AttentionNotifyModel.m
//  BoXiu
//
//  Created by andy on 15-1-15.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import "AttentionNotifyModel.h"

@implementation AttentionNotifyModel
- (void)analyseData:(NSDictionary *)dataDic
{
    [super analyseData:dataDic];
    
    if (dataDic && [dataDic count] > 0)
    {
        self.hidden = [[dataDic objectForKey:@"hidden"] integerValue];
        self.issupermanager = [[dataDic objectForKey:@"issupermanager"] boolValue];
        self.starnick = [dataDic objectForKey:@"starnick"];
        self.staruserid = [[dataDic objectForKey:@"staruserid"] integerValue];
        self.time = [[dataDic objectForKey:@"time"] longLongValue];
        self.type = [[dataDic objectForKey:@"type"] integerValue];
        self.userid = [[dataDic objectForKey:@"userid"] integerValue];
        self.usernick = [dataDic objectForKey:@"usernick"];
    }
    
}
@end
