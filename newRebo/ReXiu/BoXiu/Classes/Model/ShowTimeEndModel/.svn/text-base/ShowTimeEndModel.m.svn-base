//
//  ShowTimeEndModel.m
//  BoXiu
//
//  Created by andy on 15-1-26.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import "ShowTimeEndModel.h"

@implementation ShowTimeEndModel

- (void)analyseData:(NSDictionary *)dataDic
{
    [super analyseData:dataDic];
    if (dataDic && [dataDic count])
    {
        self.totalPraiseNum = [[dataDic objectForKey:@"totalPraiseNum"] integerValue];
        NSDictionary *rankVo = [dataDic objectForKey:@"rankVo"];
        if (rankVo && [rankVo isKindOfClass:[NSDictionary class]])
        {
            if (rankVo && [rankVo count] > 0)
            {
                self.luckId = [[rankVo objectForKey:@"luckId"] integerValue];
                self.luckNum = [[rankVo objectForKey:@"luckNum"] integerValue];
                self.luckNick = [rankVo objectForKey:@"luckNick"];
                self.luckIdxcode = [[rankVo objectForKey:@"luckIdxcode"] integerValue];
            }
        }

    }
}
@end
