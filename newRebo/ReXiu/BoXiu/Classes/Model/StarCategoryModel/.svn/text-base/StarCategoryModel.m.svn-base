//
//  StarCategoryModel.m
//  BoXiu
//
//  Created by andy on 14-7-7.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "StarCategoryModel.h"
#import "UserInfo.h"

@implementation StarCategoryData

@end


@implementation StarCategoryModel

- (void)requestDataWithParams:(NSDictionary *)params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:Get_StarCategory_Method params:params success:success fail:fail];
}


- (BOOL)analyseData:(NSDictionary *)data
{
    if (![super analyseData:data])
    {
        return NO;
    }
    
    if (self.result == 0)
    {
        NSArray *dataArray = [data objectForKey:@"data"];
        if (dataArray && [dataArray count] > 0)
        {
            if (_starCategoryMArray == nil)
            {
                _starCategoryMArray = [NSMutableArray array];
            }
            for (int nIndex = 0; nIndex < [dataArray count]; nIndex++)
            {
                NSDictionary *starCategoryDic = [dataArray objectAtIndex:nIndex];
                StarCategoryData *starCategoryData = [[StarCategoryData alloc] init];
                starCategoryData.count = [[starCategoryDic objectForKey:@"count"] integerValue];
                starCategoryData.createtime = [starCategoryDic objectForKey:@"createtime"];
                starCategoryData.categoryId = [[starCategoryDic objectForKey:@"id"] integerValue];
                starCategoryData.levelno = [starCategoryDic objectForKey:@"levelno"];
                starCategoryData.name = [starCategoryDic objectForKey:@"name"];
                starCategoryData.orderno = [[starCategoryDic objectForKey:@"orderno"] integerValue];
                starCategoryData.pid = [[starCategoryDic objectForKey:@"pid"] integerValue];
                
                NSArray *starArray = [starCategoryDic objectForKey:@"starlist"];
                if (starArray && [starArray count])
                {
                    if (starCategoryData.starInfoMArray == nil)
                    {
                        starCategoryData.starInfoMArray = [NSMutableArray array];
                    }
                    for (int nSubIndex = 0; nSubIndex < [starArray count]; nSubIndex++)
                    {
                        NSDictionary *starInfoDic = [starArray objectAtIndex:nSubIndex];
                        StarInfo *starInfo = [[StarInfo alloc] init];
                        starInfo.adphoto = [starInfoDic objectForKey:@"adphoto"];
                        starInfo.count = [[starInfoDic objectForKey:@"count"] integerValue];
                        starInfo.fansnum = [[starInfoDic objectForKey:@"fansnum"] integerValue];
                        starInfo.fansnumtoplimit = [[starInfoDic objectForKey:@"fansnumtoplimit"] integerValue];
                        starInfo.userId = [[starInfoDic objectForKey:@"userid"] integerValue];
                        starInfo.idxcode = [[starInfoDic objectForKey:@"idxcode"] integerValue];
                        starInfo.nick = [starInfoDic objectForKey:@"nick"];
                        starInfo.onlineflag = [[starInfoDic objectForKey:@"onlineflag"] boolValue];
                        starInfo.roomid = [[starInfoDic objectForKey:@"roomid"] integerValue];
                        starInfo.rsstatus = [[starInfoDic objectForKey:@"rsstatus"] integerValue];
                        starInfo.showbegintime = [starInfoDic objectForKey:@"showbegintime"];
                        starInfo.showusernum = [[starInfoDic objectForKey:@"showusernum"] integerValue];
                        
                        [starCategoryData.starInfoMArray addObject:starInfo];
                    }
                }
                [self.starCategoryMArray addObject:starCategoryData];
            }
            
            return YES;
        }
    }
    
    return NO;
}

@end
