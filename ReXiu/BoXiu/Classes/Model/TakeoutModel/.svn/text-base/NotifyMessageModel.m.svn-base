//
//  NotifyMessageModel.m
//  BoXiu
//
//  Created by tongmingyu on 14-6-6.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "NotifyMessageModel.h"

@implementation NotifyMessageModel

- (void)analyseData:(NSDictionary *)dataDic
{
    [super analyseData:dataDic];
    if (dataDic && [dataDic count] > 0)
    {
        self.fromuserid = [[dataDic objectForKey:@"fromuserid"] integerValue];
        self.fromusernick = [dataDic objectForKey:@"fromusernick"];
        self.hidden = [[dataDic objectForKey:@"hidden"] integerValue];
        self.hiddenindex = [dataDic objectForKey:@"hiddenindex"];
        self.issupermanager = [[dataDic objectForKey:@"issupermanager"] boolValue];
        self.speaktype = [[dataDic objectForKey:@"speaktype"] integerValue];
        self.thidden = [[dataDic objectForKey:@"thidden"] integerValue];
        self.thiddenindex = [dataDic objectForKey:@"thiddenindex"];
        self.tissupermanager = [[dataDic objectForKey:@"tissupermanager"] boolValue];
        self.touserid = [[dataDic objectForKey:@"touserid"] integerValue];
        self.tousernick = [dataDic objectForKey:@"tousernick"];
        self.type = [[dataDic objectForKey:@"type"] integerValue];
        self.time = [[dataDic objectForKey:@"time"] longLongValue];
    }
    
}

@end
