//
//  GetUserCarModel.m
//  BoXiu
//
//  Created by andy on 14-7-15.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "GetUserCarModel.h"

@implementation UserCarData

@end
@implementation GetUserCarModel

- (void)requestDataWithParams:(NSDictionary *)params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:Get_UserCar_Method params:params success:success fail:fail];
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
        if (dataArray && [dataArray isKindOfClass:[NSArray class]] && [dataArray count] > 0)
        {
            if (_dataMArray == nil)
            {
                _dataMArray = [NSMutableArray array];
            }
            [_dataMArray removeAllObjects];
            for (int nIndex = 0; nIndex < [dataArray count]; nIndex++)
            {
                NSDictionary *dataDic = [dataArray objectAtIndex:nIndex];
                UserCarData *carData = [[UserCarData alloc] init];
                carData.activedays = [[dataDic objectForKey:@"activedays"] integerValue];
                carData.begintime = [dataDic objectForKey:@"begintime"];
                carData.brandimg = [dataDic objectForKey:@"brandimg"];
                carData.carimg = [dataDic objectForKey:@"carimg"];
                carData.carimgbig = [dataDic objectForKey:@"carimgbig"];
                carData.carimgsmall = [dataDic objectForKey:@"carimgsmall"];
                carData.carname = [dataDic objectForKey:@"carname"];
                carData.carunit = [dataDic objectForKey:@"carunit"];
                carData.coin = [[dataDic objectForKey:@"coin"] integerValue];
                carData.edittime = [dataDic objectForKey:@"edittime"];
                carData.endtime = [dataDic objectForKey:@"endtime"];
                carData.carid = [[dataDic objectForKey:@"id"] integerValue];
                carData.propid = [[dataDic objectForKey:@"propid"] integerValue];
                carData.proptype = [[dataDic objectForKey:@"proptype"] integerValue];
                carData.status = [[dataDic objectForKey:@"status"] integerValue];
                carData.useflag = [[dataDic objectForKey:@"useflag"] integerValue];
                [self.dataMArray addObject:carData];
            }
            return YES;
        }
    }
    
    return NO;
}
@end
