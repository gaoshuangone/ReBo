//
//  SofaListModel.m
//  BoXiu
//
//  Created by andy on 14-6-4.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "SofaListModel.h"

@implementation SofaCellData


@end

@implementation SofaListModel

- (void)requestDataWithParams:(NSDictionary *)params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:SofaList_Method params:params success:success fail:fail];
}
/*返回数据解析接口*/

- (BOOL)analyseData:(NSDictionary *)data
{
    if (![super analyseData:data])
    {
        return NO;
    }
    if (self.result == 0)
    {
        NSArray *sofaArray = [data objectForKey:@"data"];
        if (sofaArray && [sofaArray count] > 0)
        {
            if (_sofaMArray == nil)
            {
                _sofaMArray = [NSMutableArray array];
            }
            for (int nIndex = 0; nIndex < [sofaArray count]; nIndex++)
            {
                SofaCellData *sofaData = [[SofaCellData alloc] init];
                NSDictionary *sofaDic = [sofaArray objectAtIndex:nIndex];
                sofaData.coin = [[sofaDic objectForKey:@"coin"] integerValue];
                sofaData.datetime = [sofaDic objectForKey:@"datetime"];
                sofaData.sofaid = [[sofaDic objectForKey:@"id"] integerValue];
                sofaData.nick = [sofaDic objectForKey:@"nick"];
                sofaData.num = [[sofaDic objectForKey:@"num"] integerValue];
                sofaData.photo = [sofaDic objectForKey:@"photo"];
                sofaData.roomid = [[sofaDic objectForKey:@"roomid"] integerValue];
                sofaData.showid = [[sofaDic objectForKey:@"showid"] integerValue];
                sofaData.sofano = [[sofaDic objectForKey:@"sofano"] integerValue];
                sofaData.userid = [[sofaDic objectForKey:@"userid"] integerValue];
                sofaData.hidden = [[sofaDic objectForKey:@"hidden"] integerValue];
                sofaData.hiddenindex = [sofaDic objectForKey:@"hiddenindex"];
                sofaData.issupermanager = [[sofaDic objectForKey:@"issupermanager"] boolValue];
                
                [self.sofaMArray addObject:sofaData];
            }
        }
        return YES;

    }
    return NO;
}


@end
