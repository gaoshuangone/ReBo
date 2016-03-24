//
//  TopProgramModel.m
//  BoXiu
//
//  Created by tongmingyu on 14-12-25.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "TopProgramModel.h"
#import "QueryLiveSchedulesModel.h"

@implementation TopProgramModel

-(void)requestDataWithParams:(NSDictionary *)params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:SelectTopLiveSchedule_Method params:params success:success fail:fail];
}

- (BOOL)analyseData:(NSDictionary *)data
{
    if (![super analyseData:data])
    {
        return NO;
    }
    
    if (self.result == 0)
    {
        if (_topArray == nil)
        {
            _topArray = [NSMutableArray array];
        }
        [_topArray removeAllObjects];
        
        NSArray *array = [data objectForKey:@"data"];
        if (array.count > 0)
        {
            NSTimeInterval currentDate = [[NSDate date] timeIntervalSince1970] * 1000;
            long long currentDateTime = [[NSNumber numberWithDouble:currentDate] longLongValue];
            
            for (int nIndex = 0; nIndex < array.count; nIndex++)
            {
                NSDictionary *dic = [array objectAtIndex:nIndex];
                LiveSchedulesData *liveData = [[LiveSchedulesData alloc] init];
                
                liveData.createTime = [dic objectForKey:@"createtime"];
                liveData.date = [dic objectForKey:@"date"];
                liveData.endTimeInMillis = [[dic objectForKey:@"endTimeInMillis"] longLongValue];
                
                liveData.endTime = [dic objectForKey:@"endtime"];
                liveData.pid = [[dic objectForKey:@"id"] integerValue];
                liveData.lintype = [[dic objectForKey:@"lintype"] integerValue];
                liveData.liveName = [dic objectForKey:@"livename"];
                
                liveData.liveprogramid = [[dic objectForKey:@"liveprogramid"] integerValue];
                
                liveData.mobileImg = [dic objectForKey:@"mobileimg"];
                liveData.mobileUrl = [dic objectForKey:@"mobileurl"];
                liveData.nick = [dic objectForKey:@"nick"];
                liveData.onlineflag = [[dic objectForKey:@"onlineflag"] integerValue];
                liveData.pcImg = [dic objectForKey:@"pcimg"];
                liveData.pcUrl = [dic objectForKey:@"pcurl"];
                
                liveData.roomposter = [dic objectForKey:@"roomposter"];
                liveData.showDate = [dic objectForKey:@"showDate"];
                liveData.showDateTitle = [dic objectForKey:@"showDateTitle"];
                liveData.showTime = [dic objectForKey:@"showTime"];
                liveData.showusernum = [[dic objectForKey:@"showusernum"] integerValue];
                liveData.starlevelid = [[dic objectForKey:@"starlevelid"] integerValue];
                liveData.starbigimg = [dic objectForKey:@"starbigimg"];
                liveData.topflag = [[dic objectForKey:@"topflag"] integerValue];
                
                liveData.starIdxcode = [dic objectForKey:@"starIdxcode"];
                liveData.starTimeInMillis = [[dic objectForKey:@"startTimeInMillis"] longLongValue];
                liveData.startTime = [dic objectForKey:@"starttime"];
                liveData.userid = [[dic objectForKey:@"userid"] integerValue];
                
                liveData.photo = [dic objectForKey:@"photo"];
                liveData.adphoto = [dic objectForKey:@"adphoto"];
                
                NSDate *starDate = [NSDate dateWithTimeIntervalSince1970:liveData.starTimeInMillis/1000];
                NSTimeInterval currentDateZero = [[CommonFuction zeroOfDate:starDate] timeIntervalSince1970] * 1000;
                long long currentDateZeroTime = [[NSNumber numberWithDouble:currentDateZero] longLongValue];
                
                if (liveData.endTimeInMillis > currentDateTime)
                {
                    if (currentDateTime > currentDateZeroTime)
                    {
                        liveData.startInCurrentDate = YES;
                    }
                    else
                    {
                        liveData.startInCurrentDate = NO;
                    }
                    [_topArray addObject:liveData];
                }
                
            }
            
            return YES;
        }
 
    }
    return NO;
}

@end
