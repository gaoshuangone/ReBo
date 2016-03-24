//
//  ShowTimeRankModel.m
//  BoXiu
//
//  Created by andy on 15-1-26.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import "ShowTimeRankModel.h"

@implementation ShowTimeRankModel

- (void)analyseData:(NSDictionary *)dataDic
{
    [super analyseData:dataDic];
    
    if (dataDic && [dataDic count])
    {
        NSDictionary *rankVo = [dataDic objectForKey:@"rankVo"];
        if (rankVo && [rankVo isKindOfClass:[NSDictionary class]])
        {
            self.firstId = [[rankVo objectForKey:@"firstId"] integerValue];
            self.firstNum = [[rankVo objectForKey:@"firstNum"] integerValue];
            self.firstNick = [rankVo objectForKey:@"firstNick"];
            self.firstIdxcode = [[rankVo objectForKey:@"firstIdxcode"] integerValue];
            
            self.secondId = [[rankVo objectForKey:@"secondId"] integerValue];
            self.secondNum = [[rankVo objectForKey:@"secondNum"] integerValue];
            self.secondNick = [rankVo objectForKey:@"secondNick"];
            self.secondIdxcode = [[rankVo objectForKey:@"secondIdxcode"] integerValue];
            
            self.thirdId = [[rankVo objectForKey:@"thirdId"] integerValue];
            self.thirdNum = [[rankVo objectForKey:@"thirdNum"] integerValue];
            self.thirdNick = [rankVo objectForKey:@"thirdNick"];
            self.thirdIdxcode = [[rankVo objectForKey:@"thirdIdxcode"] integerValue];
            
            self.systemTime = [[rankVo objectForKey:@"systemTime"] longValue];
        }
    }
  }

@end
