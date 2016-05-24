//
//  TheCarModel.m
//  BoXiu
//
//  Created by tongmingyu on 14-8-29.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "TheCarModel.h"

@implementation MallCarData

@end


@implementation TheCarModel

- (void)requestDataWithParams:(NSDictionary *)params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:CarGoodsQuery_Method params:params success:success fail:fail];
}


- (BOOL)analyseData:(NSDictionary *)data
{
    if (![super analyseData:data])
    {
        return NO;
    }
    if (self.result == 0)
    {
        if(_CarMarray == nil)
        {
            _CarMarray = [NSMutableArray array];
        }
        [_CarMarray removeAllObjects];
        
        NSDictionary *dic = [data objectForKey:@"data"];
        NSArray *dataArray = [dic objectForKey:@"data"];
        if (dataArray && [dataArray count] > 0)
        {
            for (int nIndex = 0; nIndex < [dataArray count]; nIndex++)
            {
                NSDictionary *categoryDictionary = [dataArray objectAtIndex:nIndex];
                MallCarData *caryData = [[MallCarData alloc] init];
                caryData.brandimg = [categoryDictionary objectForKey:@"brandimg"];
                caryData.carimg = [categoryDictionary objectForKey:@"carimg"];
                caryData.carimgbig = [categoryDictionary objectForKey:@"carimgbig"];
                caryData.carName = [categoryDictionary objectForKey:@"carname"];
                caryData.carunit = [categoryDictionary objectForKey:@"carunit"];
                
                caryData.coin = [[categoryDictionary objectForKey:@"coin"] longLongValue];
                caryData.pid = [[categoryDictionary objectForKey:@"id"] integerValue];
                
                caryData.mark = [categoryDictionary objectForKey:@"mark"];
                
                caryData.propsno = [[categoryDictionary objectForKey:@"propsno"] integerValue];
                caryData.propstype = [[categoryDictionary objectForKey:@"propstype"] integerValue];
                caryData.timenum = [[categoryDictionary objectForKey:@"timenum"] integerValue];
                caryData.timeunit = [[categoryDictionary objectForKey:@"timeunit"] integerValue];
                
                [self.CarMarray addObject:caryData];
            }
            
            return YES;
        }

    }
    return NO;
}

@end
