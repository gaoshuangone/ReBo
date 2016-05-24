//
//  SpecialRankModel.m
//  BoXiu
//
//  Created by andy on 14-5-9.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "SpecialRankModel.h"

@implementation StarGift
@end

@implementation SpecialRankModel

- (void)requestDataWithParams:(NSDictionary *)params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:GiftList_Method params:params success:success fail:fail];
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
        NSDictionary *dataDic = [data objectForKey:@"data"];
        if (dataDic && [dataDic count] > 0)
        {
            NSArray *popularStarArray = [dataDic objectForKey:@"thisweek"];
            self.starUserMArray = [NSMutableArray array];
            if (popularStarArray && [popularStarArray count])
            {
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
                        starGift.value = [[popularStarDic objectForKey:@"value"] integerValue];
                        [self.starUserMArray addObject:starGift];
                    }
                    
                }
            }
            
            popularStarArray = [dataDic objectForKey:@"lastweek"];
            self.lastStarUserMArray = [NSMutableArray array];
            if (popularStarArray && [popularStarArray count])
            {
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
                        starGift.value = [[popularStarDic objectForKey:@"value"] integerValue];
                        [self.lastStarUserMArray addObject:starGift];
                    }
                    
                }
            }
        }
        return YES;

    }
    return NO;
}
@end
