//
//  StarGiftRankModel.m
//  BoXiu
//
//  Created by andy on 14-12-29.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "StarGiftRankModel.h"

@implementation StarGiftRankItemData

@end

@implementation StarGiftRankModel
- (void)requestDataWithParams:(NSDictionary *)params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:Query_StarGiftRank_Method params:params success:success fail:fail];
}


- (BOOL)analyseData:(NSDictionary *)data
{
    if (![super analyseData:data])
    {
        return NO;
    }
    
    if (self.result == 0)
    {
        if (data && [data count])
        {
            NSArray *dataArray = [data objectForKey:@"data"];
            if (dataArray && [dataArray isKindOfClass:[NSArray class]])
            {
                if (_dataMArray == nil)
                {
                    _dataMArray = [NSMutableArray array];
                }
                [_dataMArray removeAllObjects];
                
                for (NSDictionary *dataDic in dataArray)
                {
                    if (dataDic && [dataDic count])
                    {
                        StarGiftRankItemData *starGiftRankItemData = [[StarGiftRankItemData alloc] init];
                        starGiftRankItemData.giftname = [dataDic objectForKey:@"giftname"];
                        starGiftRankItemData.nick = [dataDic objectForKey:@"nick"];
                        starGiftRankItemData.giftid = [[dataDic objectForKey:@"giftid"] integerValue];
                        starGiftRankItemData.giftimg = [dataDic objectForKey:@"giftimg"];
                        starGiftRankItemData.idxcode = [[dataDic objectForKey:@"idxcode"] integerValue];
                        starGiftRankItemData.count = [[dataDic objectForKey:@"count"] integerValue];
                        starGiftRankItemData.giftimgbig = [dataDic objectForKey:@"giftimgbig"];
                        starGiftRankItemData.userid = [[dataDic objectForKey:@"userid"] integerValue];
                        
                        [_dataMArray addObject:starGiftRankItemData];
                    }
                }
            }
            return YES;
        }

    }
    return NO;
}

@end
