//
//  GetTwoLevelCategoryModel.m
//  BoXiu
//
//  Created by tongmingyu on 14-8-26.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "GetTwoLevelCategoryModel.h"

@implementation TwoLevelCategoryData

@end


@implementation GetTwoLevelCategoryModel

- (void)requestDataWithParams:(NSDictionary *)params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:Get_TwoLevelCategory_Method params:params success:success fail:fail];
}

- (BOOL)analyseData:(NSDictionary *)data
{
    if (![super analyseData:data])
    {
        return NO;
    }
    if (self.result == 0)
    {
        if(_TwoLevelCategoryMArray == nil)
        {
            _TwoLevelCategoryMArray = [NSMutableArray array];
        }
        [_TwoLevelCategoryMArray removeAllObjects];
        
        NSArray *dataArray = [data objectForKey:@"data"];
        if (dataArray && [dataArray count] > 0)
        {
            for (int nIndex = 0; nIndex < [dataArray count]; nIndex++)
            {
                NSDictionary *categoryDictionary = [dataArray objectAtIndex:nIndex];
                TwoLevelCategoryData *categoryData = [[TwoLevelCategoryData alloc] init];
                categoryData.createtime = [categoryDictionary objectForKey:@"createtime"];
                categoryData.icon = [categoryDictionary objectForKey:@"mstatus"];
                categoryData.categoryId = [[categoryDictionary objectForKey:@"id"] integerValue];
                categoryData.levelno = [[categoryDictionary objectForKey:@"levelno"] integerValue];
                categoryData.name = [categoryDictionary objectForKey:@"name"];
                categoryData.orderno = [[categoryDictionary objectForKey:@"orderno"] integerValue];
                categoryData.ordertype = [[categoryDictionary objectForKey:@"ordertype"] integerValue];
                categoryData.pid = [[categoryDictionary objectForKey:@"pid"] integerValue];
                categoryData.status = [[categoryDictionary objectForKey:@"status"] integerValue];
                [self.TwoLevelCategoryMArray addObject:categoryData];
            }
            
            return YES;
        }

    }
    
    return NO;
}

@end
