//
//  GiftRankModel.m
//  BoXiu
//
//  Created by tongmingyu on 14-7-4.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "GiftRankModel.h"
#import "SpecialRankModel.h"

@implementation GiftRankModel

- (void)requestDataWithParams:(NSDictionary *)params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:StarGiftRank_Method params:params success:success fail:fail];
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
        NSArray *popularStarArray = [data objectForKey:@"data"];
        if (popularStarArray && [popularStarArray count] > 0)
        {
            self.starUserMArray = [NSMutableArray array];
            for (int nIndex = 0; nIndex < [popularStarArray count]; nIndex++)
            {
                NSDictionary *popularStarDic = [popularStarArray objectAtIndex:nIndex];
                if (popularStarDic)
                {
                    StarGift *starGift = [[StarGift alloc] init];
                    StarInfo *poplarStar = [[StarInfo alloc] init];
                    if([self analyseStarData:popularStarDic toInfo:poplarStar])
                        starGift.starInfo = poplarStar;
                    
                    starGift.starInfo.userId = [[popularStarDic objectForKey:@"userid"] intValue];
                    starGift.giftId = [[popularStarDic objectForKey:@"giftid"] intValue];
                    starGift.getCoin = [[popularStarDic objectForKey:@"getcoin"] intValue];
                    starGift.giftImg = [popularStarDic objectForKey:@"giftimg"];
                    starGift.giftName = [popularStarDic objectForKey:@"giftname"];
                    starGift.giftUnit = [popularStarDic objectForKey:@"giftunit"];
                    starGift.rankPos = [[popularStarDic objectForKey:@"ranknum"] intValue];
                    starGift.value = [[popularStarDic objectForKey:@"value"] integerValue];
                    [self.starUserMArray addObject:starGift];
                }
                
                
            }
            
        }
        return YES;
    }
    return NO;
}
@end
