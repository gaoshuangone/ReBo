//
//  QueryAllEmotionModel.m
//  BoXiu
//
//  Created by andy on 14-12-3.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "QueryAllEmotionModel.h"

@implementation EmotionData


@end

@implementation EmotionGroupData


@end


@implementation QueryAllEmotionModel

- (void)requestDataWithParams:(NSDictionary *)params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:Query_AllEmotion_Method params:params success:success fail:fail];
}


- (BOOL)analyseData:(NSDictionary *)data
{
    if (![super analyseData:data])
    {
        return NO;
    }
    
    if (self.result == 0)
    {
        NSArray *emotionGroups = [data objectForKey:@"data"];
        if (emotionGroups && [emotionGroups isKindOfClass:[NSArray class]])
        {
            if (_emotionGroupMArray == nil)
            {
                _emotionGroupMArray = [NSMutableArray array];
            }
            
            if (_allEmotionMDic == nil)
            {
                _allEmotionMDic = [NSMutableDictionary dictionary];
            }
            
            for (NSDictionary *emotionGroup in emotionGroups)
            {
                EmotionGroupData *emotionGroupData = [[EmotionGroupData alloc] init];
                if (emotionGroupData.emotionDataMArray == nil)
                {
                    emotionGroupData.emotionDataMArray = [NSMutableArray array];
                }
                emotionGroupData.mheight = [[emotionGroup objectForKey:@"mheight"] floatValue];
                emotionGroupData.mwidth = [[emotionGroup objectForKey:@"mwidth"] floatValue];
                emotionGroupData.height = [[emotionGroup objectForKey:@"height"] floatValue];
                emotionGroupData.width = [[emotionGroup objectForKey:@"width"] floatValue];
                emotionGroupData.title = [emotionGroup objectForKey:@"title"];
                emotionGroupData.link = [emotionGroup objectForKey:@"link"];
                emotionGroupData.mlink = [emotionGroup objectForKey:@"mlink"];
                emotionGroupData.emotionType = [[emotionGroup objectForKey:@"type"] integerValue];
                
                NSArray *emotionDatas = [emotionGroup objectForKey:@"basis"];
                if (emotionDatas && [emotionDatas isKindOfClass:[NSArray class]])
                {
                    for (NSDictionary *emotionDataDic in emotionDatas)
                    {
                        EmotionData *emotionData = [[EmotionData alloc] init];
                        emotionData.title = [emotionDataDic objectForKey:@"title"];
                        emotionData.link = [emotionDataDic objectForKey:@"link"];
                        emotionData.mlink = [emotionDataDic objectForKey:@"mlink"];
                        emotionData.width = emotionGroupData.width;
                        emotionData.height = emotionGroupData.height;
                        emotionData.emotionType = emotionGroupData.emotionType;
                        [emotionGroupData.emotionDataMArray addObject:emotionData];
                        [self.allEmotionMDic setObject:emotionData forKey:emotionData.title];
                    }
                }
                [self.emotionGroupMArray addObject:emotionGroupData];
            }
            return YES;
        }

    }
       return NO;
}
@end
