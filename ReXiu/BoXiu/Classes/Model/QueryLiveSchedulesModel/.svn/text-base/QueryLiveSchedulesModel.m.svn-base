//
//  QueryLiveSchedulesModel.m
//  BoXiu
//
//  Created by tongmingyu on 14-10-27.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "QueryLiveSchedulesModel.h"

@implementation LiveSchedulesData


@end

@implementation QueryLiveSchedulesModel


- (void)requestDataWithParams:(NSDictionary *)params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:QueryLiveSchedules_Method params:params success:success fail:fail];
}


- (BOOL)analyseData:(NSDictionary *)data
{
    if (![super analyseData:data])
    {
        return NO;
    }
    if (self.result == 0)
    {
        if(_liveSchedMutable == nil)
        {
            _liveSchedMutable = [NSMutableArray array];
        }
        if (_photoMary == nil)
        {
            _photoMary = [NSMutableArray array];
        }
        if(_todayMary == nil)
        {
            _todayMary = [NSMutableArray array];
        }
        
        if(_tomorrowMary == nil)
        {
            _tomorrowMary = [NSMutableArray array];
        }
        
        [_liveSchedMutable removeAllObjects];
        [_todayMary removeAllObjects];
        [_tomorrowMary removeAllObjects];
        [_photoMary removeAllObjects];
        
        NSArray *dic = [data objectForKey:@"data"];
        if (dic && [dic count] > 0)
        {
//            NSArray *todayArray = [dic objectForKey:@"todayLives"];
//            NSArray *tomorrowArray = [dic objectForKey:@"tomorrowLives"];
            
            NSTimeInterval currentDate = [[NSDate date] timeIntervalSince1970] * 1000;
            long long dTime = [[NSNumber numberWithDouble:currentDate] longLongValue];
            
            if (dic && [dic count])
            {
                for (int Index = 0; Index < [dic count]; Index++)
                {

                    NSDictionary *categoryDictionary = [dic objectAtIndex:Index];
                    
                    LiveSchedulesData *liveData = [[LiveSchedulesData alloc] init];
                    liveData.createTime = [categoryDictionary objectForKey:@"createtime"];
                    liveData.date = [categoryDictionary objectForKey:@"date"];
                    liveData.endTimeInMillis = [[categoryDictionary objectForKey:@"endTimeInMillis"] longLongValue];
                    
                    liveData.endTime = [categoryDictionary objectForKey:@"endtime"];
                    liveData.pid = [[categoryDictionary objectForKey:@"id"] integerValue];
                    liveData.lintype = [[categoryDictionary objectForKey:@"lintype"] integerValue];
                    liveData.liveName = [categoryDictionary objectForKey:@"livename"];
                    
                    liveData.liveprogramid = [[categoryDictionary objectForKey:@"liveprogramid"] integerValue];
                    
                    liveData.mobileImg = [categoryDictionary objectForKey:@"mobileimg"];
                    liveData.mobileUrl = [categoryDictionary objectForKey:@"mobileurl"];
                    liveData.pcImg = [categoryDictionary objectForKey:@"pcimg"];
                    liveData.pcUrl = [categoryDictionary objectForKey:@"pcurl"];
                    
                    liveData.starIdxcode = [categoryDictionary objectForKey:@"idxcode"];
                    liveData.starTimeInMillis = [[categoryDictionary objectForKey:@"startTimeInMillis"] longLongValue];
                    liveData.startTime = [categoryDictionary objectForKey:@"starttime"];
                    liveData.userid = [[categoryDictionary objectForKey:@"userid"] integerValue];
                    liveData.nick = [categoryDictionary objectForKey:@"nick"];
                    liveData.showTime = [categoryDictionary objectForKey:@"starttime"];
                    
                    liveData.photo = [[categoryDictionary objectForKey:@"photo"] toString];
                    liveData.adphoto = [categoryDictionary objectForKey:@"adphoto"];
                    liveData.attentionflag = [[categoryDictionary objectForKey:@"attentionflag"] integerValue];
                    liveData.recommendno = [[categoryDictionary objectForKey:@"recommendno"] integerValue];
                    
                    [self.photoMary addObject:liveData.photo];
                    if (dTime < liveData.endTimeInMillis)
                    {
                        [self.liveSchedMutable addObject:liveData];
                        [self.todayMary addObject:liveData];
                    }
                }
            }
            
          
            return YES;
        }

    }
    
    return NO;
}

@end
