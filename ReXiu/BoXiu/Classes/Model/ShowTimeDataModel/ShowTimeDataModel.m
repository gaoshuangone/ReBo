//
//  ShowTimeDataModel.m
//  BoXiu
//
//  Created by andy on 15-1-26.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import "ShowTimeDataModel.h"

@implementation ShowTimeDataModel

- (void)analyseData:(NSDictionary *)dataDic
{
    NSDictionary *dic = [NSDictionary dictionaryWithDictionary:[dataDic objectForKey:@"data"]];
    
    [super analyseData:dic];
    
    if (dic && [dic count] > 0)
    {
        self.totalPraiseNum = [[dic objectForKey:@"totalPraiseNum"] integerValue];
        self.status = [[dic objectForKey:@"status"] integerValue];
    }
}

@end
