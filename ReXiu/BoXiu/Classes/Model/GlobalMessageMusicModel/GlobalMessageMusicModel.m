//
//  GlobalMessageMusicModel.m
//  BoXiu
//
//  Created by tongmingyu on 15-1-4.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import "GlobalMessageMusicModel.h"

@implementation GlobalMessageMusicModel

- (void)analyseData:(NSDictionary *)dataDic
{
    [super analyseData:dataDic];
    if (dataDic && [dataDic count] > 0)
    {
        self.chatType = [[dataDic objectForKey:@"chatType"] integerValue];
        self.time = [[dataDic objectForKey:@"time"] longValue];
        self.usernick = [dataDic objectForKey:@"usernick"];
        self.userid = [[dataDic objectForKey:@"userid"] integerValue];
        self.issupermanager = [[dataDic objectForKey:@"issupermanager"] boolValue];
        
        self.hidden = [[dataDic objectForKey:@"hidden"] integerValue];
        self.hiddenindex = [dataDic objectForKey:@"hiddenindex"];
        
        self.staruserid = [[dataDic objectForKey:@"staruserid"] integerValue];
        self.starnick = [dataDic objectForKey:@"starnick"];
        self.livescheduleId = [[dataDic objectForKey:@"livescheduleId"] integerValue];
        
        self.musicId = [[dataDic objectForKey:@"musicId"] integerValue];
        self.musicName = [dataDic objectForKey:@"musicName"];
        self.ticketNum = [[dataDic objectForKey:@"ticketnum"] integerValue];
        self.usercoin = [[dataDic objectForKey:@"usercoin"] integerValue];
    }
    
}

@end
