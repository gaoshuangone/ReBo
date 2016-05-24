//
//  QueryMusicListModel.m
//  BoXiu
//
//  Created by tongmingyu on 14-12-26.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "QueryMusicListModel.h"

@implementation MusicData


@end


@implementation QueryMusicListModel

-(void)requestDataWithParams:(NSDictionary *)params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:QueryRoommusicList_Method params:params success:success fail:fail];
}

-(BOOL)analyseData:(NSDictionary *)data
{
    if (![super analyseData:data])
    {
        return NO;
    }
    
    if (self.result == 0)
    {
        if (_musicDataArray == nil)
        {
            _musicDataArray = [NSMutableArray array];
        }
        [_musicDataArray removeAllObjects];
        
        NSDictionary *diction = [NSDictionary dictionaryWithDictionary:[data objectForKey:@"data"]];
        self.canOperate = [[diction objectForKey:@"canOperate"] integerValue];
        
        NSArray *array = [diction objectForKey:@"musicList"];
        if (array.count > 0)
        {
            for (int nIndex = 0; nIndex < array.count; nIndex++)
            {
                NSDictionary *dic = [array objectAtIndex:nIndex];
                MusicData *musicListData = [[MusicData alloc] init];
                
                musicListData.musiceId = [[dic objectForKey:@"id"] integerValue];
                musicListData.livescheduleid = [[dic objectForKey:@"livescheduleid"] integerValue];
                musicListData.musicname = [dic objectForKey:@"musicname"];
                
                musicListData.roomid = [[dic objectForKey:@"roomid"] integerValue];
                musicListData.staruserid = [[dic objectForKey:@"staruserid"] integerValue];
                musicListData.status = [[dic objectForKey:@"status"] integerValue];
                musicListData.ticket = [[dic objectForKey:@"ticket"] integerValue];
                
                [_musicDataArray addObject:musicListData];
            }
            
            return YES;
        }
    }
    return NO;
}

@end
