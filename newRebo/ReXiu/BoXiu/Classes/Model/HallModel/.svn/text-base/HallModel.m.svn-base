//
//  HallModel.m
//  BoXiu
//
//  Created by andy on 14-5-5.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "HallModel.h"

@implementation HallModel

- (void)requestDataWithParams:(NSDictionary *)params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:GetHallData_Method params:params success:success fail:fail];
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
            NSArray *largeStarArray = [dataDic objectForKey:@"largestar"];
            if (largeStarArray && [largeStarArray count] == 1)
            {
                NSDictionary *largeStarDic = [largeStarArray objectAtIndex:0];
                StarInfo *largeStar = [[StarInfo alloc] init];
                largeStar.adphoto = [largeStarDic objectForKey:@"adphoto"];
                largeStar.fansnum = [[largeStarDic objectForKey:@"fansnum"] intValue];
                largeStar.fansnumtoplimit = [[largeStarDic objectForKey:@"fansnumtoplimit"] intValue];
                largeStar.idxcode = [[largeStarDic objectForKey:@"idxcode"] intValue];
                largeStar.liveip = [largeStarDic objectForKey:@"liveip"];
                largeStar.livestream = [largeStarDic objectForKey:@"livestream"];
                largeStar.nick = [largeStarDic objectForKey:@"nick"];
                largeStar.recommendflag = [[largeStarDic objectForKey:@"recommendflag"] intValue];
                largeStar.roomid = [[largeStarDic objectForKey:@"roomid"] intValue];
                largeStar.serverip = [largeStarDic objectForKey:@"serverip"];
                largeStar.serverport = [[largeStarDic objectForKey:@"serverport"] integerValue];
                largeStar.showusernum = [[largeStarDic objectForKey:@"showusernum"] intValue];
                largeStar.starid = [[largeStarDic objectForKey:@"starid"] intValue];
                largeStar.status = [[largeStarDic objectForKey:@"status"] intValue];
                largeStar.userId = [[largeStarDic objectForKey:@"userid"] intValue];
                
                self.largeStar = largeStar;
            }
            
            NSArray *smallStarArray = [dataDic objectForKey:@"smallstar"];
            if (smallStarArray && [smallStarArray count] > 0)
            {
                for (int nIndex = 0; nIndex < [smallStarArray count]; nIndex++)
                {
                    NSDictionary *smallStarDic = [smallStarArray objectAtIndex:nIndex];
                    if (smallStarDic && [smallStarDic count] > 0)
                    {
                        StarInfo *smallStar = [[StarInfo alloc] init];
                        smallStar.adphoto = [smallStarDic objectForKey:@"adphoto"];
                        smallStar.fansnum = [[smallStarDic objectForKey:@"fansnum"] intValue];
                        smallStar.fansnumtoplimit = [[smallStarDic objectForKey:@"fansnumtoplimit"] intValue];
                        smallStar.idxcode = [[smallStarDic objectForKey:@"idxcode"] intValue];
                        smallStar.liveip = [smallStarDic objectForKey:@"liveip"];
                        smallStar.livestream = [smallStarDic objectForKey:@"livestream"];
                        smallStar.nick = [smallStarDic objectForKey:@"nick"];
                        smallStar.recommendflag = [[smallStarDic objectForKey:@"recommendflag"] intValue];
                        smallStar.roomid = [[smallStarDic objectForKey:@"roomid"] intValue];
                        smallStar.serverip = [smallStarDic objectForKey:@"serverip"];
                        smallStar.serverport = [[smallStarDic objectForKey:@"serverport"] integerValue];
                        smallStar.showusernum = [[smallStarDic objectForKey:@"showusernum"] intValue];
                        smallStar.starid = [[smallStarDic objectForKey:@"starid"] intValue];
                        smallStar.status = [[smallStarDic objectForKey:@"status"] intValue];
                        smallStar.userId = [[smallStarDic objectForKey:@"userid"] intValue];
                        if (_smallStarMArray == nil)
                        {
                            _smallStarMArray = [NSMutableArray array];
                        }
                        [self.smallStarMArray addObject:smallStar];
                    }
                }
            }
            
            NSArray *posterArray = [dataDic objectForKey:@"poster"];
            if (posterArray && [posterArray count] > 0)
            {
                for (int nIndex = 0; nIndex < [posterArray count]; nIndex++)
                {
                    NSDictionary *posterDic = [posterArray objectAtIndex:nIndex];
                    if (posterDic && [posterDic count] > 0)
                    {
                        PosterData *adData = [[PosterData alloc] init];
                        adData.actiontype = [[posterDic objectForKey:@"actiontype"] integerValue];
                        adData.data = [posterDic objectForKey:@"data"];
                        adData.datetime = [posterDic objectForKey:@"datetime"];
                        adData.devicetype = [[posterDic objectForKey:@"devicetype"] integerValue];
                        adData.posterid = [[posterDic objectForKey:@"id"] integerValue];
                        adData.imgurl = [posterDic objectForKey:@"imgurl"];
                        adData.postertype = [[posterDic objectForKey:@"postertype"] integerValue];
                        adData.seq = [[posterDic objectForKey:@"seq" ] integerValue];
                        adData.status = [[posterDic objectForKey:@"status"] integerValue];
                        
                        if (_posterMArray == nil)
                        {
                            _posterMArray = [NSMutableArray array];
                        }
                        [self.posterMArray addObject:adData];
                    }
                }
            }
            
            NSDictionary *popularStarDic = [dataDic objectForKey:@"popular"];
            if (popularStarDic && [popularStarDic count])
            {
                
                self.recordCount = [[popularStarDic objectForKey:@"recordCount"] integerValue];
                self.pageIndex = [[popularStarDic objectForKey:@"pageIndex"] integerValue];
                self.pageSize = [[popularStarDic objectForKey:@"pageSize"] integerValue];
                
                NSArray *poplarStarArray = [popularStarDic objectForKey:@"data"];
                if (poplarStarArray && [poplarStarArray count] > 0)
                {
                    for (int nIndex = 0; nIndex < [poplarStarArray count]; nIndex++)
                    {
                        NSDictionary *starDic = [poplarStarArray objectAtIndex:nIndex];
                        if (starDic && [starDic count] > 0)
                        {
                            StarInfo *starInfo = [[StarInfo alloc] init];
                            starInfo.adphoto = [starDic objectForKey:@"adphoto"];
                            starInfo.fansnum = [[starDic objectForKey:@"fansnum"] intValue];
                            starInfo.fansnumtoplimit = [[starDic objectForKey:@"fansnumtoplimit"] intValue];
                            starInfo.idxcode = [[starDic objectForKey:@"idxcode"] intValue];
                            starInfo.liveip = [starDic objectForKey:@"liveip"];
                            starInfo.livestream = [starDic objectForKey:@"livestream"];
                            starInfo.nick = [starDic objectForKey:@"nick"];
                            starInfo.recommendflag = [[starDic objectForKey:@"recommendflag"] intValue];
                            starInfo.roomid = [[starDic objectForKey:@"roomid"] intValue];
                            starInfo.serverip = [starDic objectForKey:@"serverip"];
                            starInfo.serverport = [[starDic objectForKey:@"serverport"] integerValue];
                            starInfo.showusernum = [[starDic objectForKey:@"showusernum"] intValue];
                            starInfo.starid = [[starDic objectForKey:@"starid"] intValue];
                            starInfo.status = [[starDic objectForKey:@"status"] intValue];
                            starInfo.userId = [[starDic objectForKey:@"userid"] intValue];
                            if (_popularStarMArray == nil)
                            {
                                _popularStarMArray = [NSMutableArray array];
                            }
                            [self.popularStarMArray addObject:starInfo];
                            
                        }
                    }
                    
                }
            }
        }
        return YES;

    }
    return NO;
}
@end
