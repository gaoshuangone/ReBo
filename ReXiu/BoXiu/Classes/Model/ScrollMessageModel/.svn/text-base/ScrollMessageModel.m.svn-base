//
//  ScrollMessageModel.m
//  BoXiu
//
//  Created by andy on 14-5-21.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "ScrollMessageModel.h"

@implementation ScrollMessageModel

- (void)analyseData:(NSDictionary *)dataDic
{
    [super analyseData:dataDic];
    if (dataDic && [dataDic count] > 0)
    {
        self.fromuserid = [[dataDic objectForKey:@"fromuserid"] integerValue];
        self.fromnick = [dataDic objectForKey:@"fromnick"];
        self.touserid = [[dataDic objectForKey:@"touserid"] integerValue];
        self.tonick = [dataDic objectForKey:@"tonick"];
        
        self.giftname = [dataDic objectForKey:@"giftname"];
        self.giftimg = [dataDic objectForKey:@"giftimg"];
        self.giftnum = [[dataDic objectForKey:@"giftnum"] intValue];
        self.giftunit = [dataDic objectForKey:@"giftunit"];
    }

}

@end
