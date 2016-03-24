//
//  GetOneLevelCategoryModel.m
//  BoXiu
//
//  Created by andy on 14-8-8.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "GetOneLevelCategoryModel.h"

@implementation OneLevelCategoryData

@end

@implementation GetOneLevelCategoryModel

- (void)requestDataWithParams:(NSDictionary *)params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:Get_OneLevelCategory_Method params:params success:success fail:fail];
}


- (BOOL)analyseData:(NSDictionary *)data
{
    if (![super analyseData:data])
    {
        return NO;
    }
    if (self.result == 0)
    {
        if(_OneLevelCategoryMArray == nil)
        {
            _OneLevelCategoryMArray = [NSMutableArray array];
        }
        [_OneLevelCategoryMArray removeAllObjects];
        
        NSArray *dataArray = [data objectForKey:@"data"];
        if (dataArray && [dataArray count] > 0)
        {
            for (int nIndex = 0; nIndex < [dataArray count]; nIndex++)
            {
                NSDictionary *categoryDictionary = [dataArray objectAtIndex:nIndex];
                OneLevelCategoryData *categoryData = [[OneLevelCategoryData alloc] init];
                categoryData.createtime = [categoryDictionary objectForKey:@"createtime"];
                categoryData.icon = [categoryDictionary objectForKey:@"icon"];
                categoryData.categoryId = [[categoryDictionary objectForKey:@"id"] integerValue];
                categoryData.levelno = [[categoryDictionary objectForKey:@"levelno"] integerValue];
                categoryData.name = [categoryDictionary objectForKey:@"name"];
                categoryData.orderno = [[categoryDictionary objectForKey:@"orderno"] integerValue];
                categoryData.ordertype = [[categoryDictionary objectForKey:@"ordertype"] integerValue];
                categoryData.pid = [[categoryDictionary objectForKey:@"pid"] integerValue];
                categoryData.status = [[categoryDictionary objectForKey:@"status"] integerValue];
                [self.OneLevelCategoryMArray addObject:categoryData];
            }
            return YES;
        }
    }
    
    return NO;
}
@end
