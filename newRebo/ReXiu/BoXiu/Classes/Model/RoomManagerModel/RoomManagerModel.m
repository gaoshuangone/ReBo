//
//  RoomManagerModel.m
//  BoXiu
//
//  Created by andy on 14-7-23.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "RoomManagerModel.h"

@implementation RoomManagerModel

- (void)analyseData:(NSDictionary *)dataDic
{
    if (dataDic && [dataDic count])
    {
        self.chatType = [[dataDic objectForKey:@"chatType"] integerValue];
        self.userid = [[dataDic objectForKey:@"userid"] integerValue];
        self.nick = [dataDic objectForKey:@"nick"];
        self.staruserid = [[dataDic objectForKey:@"staruserid"] integerValue];
    }
    
}
@end
