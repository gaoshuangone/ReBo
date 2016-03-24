
//
//  RecommendListStarQueryModel.m
//  BoXiu
//
//  Created by tongmingyu on 14-10-24.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "QueryHotStarsModel.h"

@implementation HotStarsData


@end

@implementation QueryHotStarsModel

- (void)requestDataWithParams:(NSDictionary *)params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:QueryHotStars_Method params:params success:success fail:fail];
}


- (BOOL)analyseData:(NSDictionary *)data
{
    if (![super analyseData:data])
    {
        return NO;
    }
    if (self.result == 0)
    {
        if(_hotStarMutable == nil)
        {
            _hotStarMutable = [NSMutableArray array];
        }
        [_hotStarMutable removeAllObjects];
        
        NSArray *dataArray = [data objectForKey:@"data"];
        if (dataArray && [dataArray count] > 0)
        {
            NSInteger dataCount;
            if (dataArray.count > 2)
            {
                dataCount = 2;
            }
            else
            {
                dataCount = [dataArray count];
            }
            for (int nIndex = 0; nIndex < dataCount; nIndex++)
            {
                NSDictionary *categoryDictionary = [dataArray objectAtIndex:nIndex];
                HotStarsData *hotstarsData = [[HotStarsData alloc] init];
                hotstarsData.adphoto = [categoryDictionary objectForKey:@"adphoto"];
                hotstarsData.photo = [categoryDictionary objectForKey:@"photo"];
                
                hotstarsData.firstnewstarflag = [[categoryDictionary objectForKey:@"firstnewstarflag"] integerValue];
                hotstarsData.count = [[categoryDictionary objectForKey:@"count"] integerValue];
                hotstarsData.fansnum = [[categoryDictionary objectForKey:@"fansnum"] integerValue];
                hotstarsData.fansnumtoplimit = [[categoryDictionary objectForKey:@"fansnumtoplimit"] integerValue];
                hotstarsData.pid = [[categoryDictionary objectForKey:@"id"] integerValue];
                hotstarsData.Idxcode = [[categoryDictionary objectForKey:@"idxcode"] integerValue];
                
                hotstarsData.liveIp = [categoryDictionary objectForKey:@"liveip"];
                hotstarsData.livestream = [categoryDictionary objectForKey:@"livestream"];
                hotstarsData.hnewstarflag = [[categoryDictionary objectForKey:@"newstarflag"] integerValue];
                hotstarsData.nick = [categoryDictionary objectForKey:@"nick"];
                
                hotstarsData.onlineflag = [[categoryDictionary objectForKey:@"onlineflag"] integerValue];
                hotstarsData.recommendflag = [[categoryDictionary objectForKey:@"recommendflag"] integerValue];
                hotstarsData.recommendno = [[categoryDictionary objectForKey:@"recommendno"] integerValue];
                hotstarsData.roomId = [[categoryDictionary objectForKey:@"roomid"] integerValue];
                
                hotstarsData.serverip = [categoryDictionary objectForKey:@"serverip"];
                
                hotstarsData.serverport = [[categoryDictionary objectForKey:@"serverport"] integerValue];
                hotstarsData.showbegintime = [categoryDictionary objectForKey:@"showbegintime"];
                hotstarsData.showusernum = [[categoryDictionary objectForKey:@"showusernum"] integerValue];
                hotstarsData.starId = [[categoryDictionary objectForKey:@"starid"] integerValue];
                hotstarsData.starlevelid = [[categoryDictionary objectForKey:@"starlevelid"] integerValue];
                hotstarsData.timeago = [categoryDictionary objectForKey:@"timeago"];
                hotstarsData.userId = [[categoryDictionary objectForKey:@"userid"] integerValue];
                
                [self.hotStarMutable addObject:hotstarsData];
            }
            
            return YES;
        }

    }
    
    return NO;
}


@end
