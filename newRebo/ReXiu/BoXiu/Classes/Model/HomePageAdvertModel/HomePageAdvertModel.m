//
//  HomePageAdvertModel.m
//  BoXiu
//
//  Created by tongmingyu on 14-12-30.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "HomePageAdvertModel.h"

@implementation HomePageAdData


@end

@implementation HomePageAdvertModel

-(void)requestDataWithParams:(NSDictionary *)params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:HomePagePoster_Method params:params success:success fail:fail];
}

-(BOOL)analyseData:(NSDictionary *)data
{
    if (![super analyseData:data])
    {
        return NO;
    }
    if (self.result == 0)
    {
        if (_adMarray == nil)
        {
            _adMarray = [NSMutableArray array];
        }
        [_adMarray removeAllObjects];
        
        NSArray *array = [data objectForKey:@"data"];
        if (array.count > 0)
        {
            NSDate *currentDate = [NSDate date];
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            
            for (int nIndex = 0; nIndex < array.count; nIndex++)
            {
                NSDictionary *dic = [array objectAtIndex:nIndex];
                HomePageAdData *AdData = [[HomePageAdData alloc] init];
                AdData.actiontype = [[dic objectForKey:@"actiontype"] integerValue];
                AdData.createtime = [dic objectForKey:@"createtime"];
                AdData.data = [dic objectForKey:@"data"];
                AdData.datetime = [dic objectForKey:@"datetime"];
                
                AdData.devicetype = [[dic objectForKey:@"devicetype"] integerValue];
                AdData.endtime = [dic objectForKey:@"endtime"];
                AdData.adId = [[dic objectForKey:@"id"] integerValue];
                AdData.imgurl = [dic objectForKey:@"imgurl"];
                AdData.postertype = [[dic objectForKey:@"postertype"] integerValue];
                
                AdData.seq = [[dic objectForKey:@"seq"] integerValue];
                AdData.starttime = [dic objectForKey:@"starttime"];
                AdData.status = [[dic objectForKey:@"status"] integerValue];
                AdData.title = [dic objectForKey:@"title"];
                
                NSDate *startDate = [dateFormat dateFromString:AdData.starttime];
                NSDate *endDate = [dateFormat dateFromString:AdData.endtime];
                
                if ([currentDate timeIntervalSinceDate:startDate] > 0 && [currentDate timeIntervalSinceDate:endDate] < 0)
                {
                    [_adMarray addObject:AdData];
                }
            }
            
            return YES;
        }

    }
    
    return NO;
}

@end
