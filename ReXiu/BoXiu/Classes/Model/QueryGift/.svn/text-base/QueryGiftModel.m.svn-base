//
//  QueryGiftModel.m
//  BoXiu
//
//  Created by andy on 14-5-6.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "QueryGiftModel.h"

@implementation GiftData


@end

@implementation QueryGiftModel

- (void)requestDataWithParams:(NSDictionary *)params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:GetGift_Method params:params success:success fail:fail];
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
        NSArray *giftArray = [data objectForKey:@"data"];
        if (giftArray && [giftArray count] > 0)
        {
            for (int nIndex = 0; nIndex < [giftArray count]; nIndex++)
            {
                NSDictionary *giftDic = [giftArray objectAtIndex:nIndex];
                GiftData *giftData = [[GiftData alloc] init];
                giftData.coin = [[giftDic objectForKey:@"coin"] integerValue];
                giftData.flashurl = [giftDic objectForKey:@"flashurl"];
                giftData.giftimg = [NSString stringWithFormat:@"%@m",[giftDic objectForKey:@"giftimg"]];
                giftData.giftimgbig = [NSString stringWithFormat:@"%@m",[giftDic objectForKey:@"giftimgbig"]];
                giftData.giftimgsmall = [NSString stringWithFormat:@"%@m",[giftDic objectForKey:@"giftimgsmall"]];
                giftData.giftname = [giftDic objectForKey:@"giftname"];
                giftData.giftid = [[giftDic objectForKey:@"id"] integerValue];
                giftData.luckyflag = [[giftDic objectForKey:@"luckyflag"] integerValue];
                giftData.usergetcoin = [[giftDic objectForKey:@"usergetcoin"] integerValue];
                if (_giftMArray == nil)
                {
                    _giftMArray = [NSMutableArray array];
                }
                [self.giftMArray addObject:giftData];
            }
        }
        return YES;
    }
    return NO;

}
@end
