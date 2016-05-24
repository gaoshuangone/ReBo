//
//  QueryOnLineStarModel.m
//  BoXiu
//
//  Created by andy on 14-8-25.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "QueryOnLineStarModel.h"
#import "UserInfo.h"

@implementation QueryOnLineStarModel

- (void)requestDataWithParams:(NSDictionary *)params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    _number = [[params objectForKey:@"pageIndex"] integerValue];
    
    [self requestDataWithMethod:Query_OnLineStar_Method params:params success:success fail:fail];
}

- (BOOL)analyseData:(NSDictionary *)data
{
    if (![super analyseData:data])
    {
        return NO;
    }
    if (self.result ==0 )
    {
        NSArray *onLineStarArray = [data objectForKey:@"data"];
        if (onLineStarArray && [onLineStarArray count])
        {
            if (_onLineStarMArray == nil)
            {
                _onLineStarMArray = [NSMutableArray array];
            }
            [_onLineStarMArray removeAllObjects];
            
            if (_starIdArry == nil)
            {
                _starIdArry = [NSMutableArray array];
            }
            [_starIdArry removeAllObjects];
            
            if (_starIdArry2 == nil)
            {
                _starIdArry2 = [NSMutableArray array];
            }
            [_starIdArry2 removeAllObjects];

            for (int nIndex = 0; nIndex < [onLineStarArray count]; nIndex++)
            {

                NSDictionary *starInfoDic = [onLineStarArray objectAtIndex:nIndex];
                StarInfo *starInfo = [[StarInfo alloc] init];
                starInfo.adphoto = [[starInfoDic objectForKey:@"adphoto"] toString];
                starInfo.count = [[starInfoDic objectForKey:@"count"] integerValue];
                starInfo.fansnum = [[starInfoDic objectForKey:@"fansnum"] intValue];
                starInfo.fansnumtoplimit = [[starInfoDic objectForKey:@"fansnumtoplimit"] intValue];
                starInfo.idxcode = [[starInfoDic objectForKey:@"idxcode"] intValue];
                starInfo.liveip = [starInfoDic objectForKey:@"liveip"];
                starInfo.livestream = [starInfoDic objectForKey:@"livestream"];
                starInfo.nick = [starInfoDic objectForKey:@"nick"];
                starInfo.recommendflag = [[starInfoDic objectForKey:@"recommendflag"] intValue];
                starInfo.roomid = [[starInfoDic objectForKey:@"roomid"] intValue];
                starInfo.serverip = [starInfoDic objectForKey:@"serverip"];
                starInfo.serverport = [[starInfoDic objectForKey:@"serverport"] integerValue];
                starInfo.showbegintime = [starInfoDic objectForKey:@"showbegintime"];
                starInfo.showusernum = [[starInfoDic objectForKey:@"showusernum"] intValue];
                starInfo.starid = [[starInfoDic objectForKey:@"starid"] intValue];
                starInfo.starlevelid = [[starInfoDic objectForKey:@"starlevelid"] intValue];
                starInfo.userId = [[starInfoDic objectForKey:@"userid"] intValue];
                starInfo.onlineflag = [[starInfoDic objectForKey:@"onlineflag"] boolValue];                
                starInfo.introduction = [starInfoDic objectForKey:@"introduction"];
                
                NSNumber *numObj = [NSNumber numberWithInt: (int)starInfo.starid];
                
                if (_number == 1) {
                    [_starIdArry addObject:numObj];
                }else
                {
                    [_starIdArry2 addObject:numObj];
                }
                
                [self.onLineStarMArray addObject:starInfo];
                
                
                
                
                
//                StarInfo *starInfo = [[StarInfo alloc] init];
//                starInfo.adphoto = [starDic objectForKey:@"adphoto"];
//                starInfo.photo = [starDic objectForKey:@"photo"];
//                starInfo.attentionflag = [[starDic objectForKey:@"attentionflag"] boolValue];
//                starInfo.count = [[starDic objectForKey:@"count"] integerValue];
//                starInfo.fansnum = [[starDic objectForKey:@"fansnum"] intValue];
//                starInfo.fansnumtoplimit = [[starDic objectForKey:@"fansnumtoplimit"] intValue];
//                starInfo.firstnewstarflag = [[starDic objectForKey:@"firstnewstarflag"] intValue];
//                starInfo.idxcode = [[starDic objectForKey:@"idxcode"] intValue];
//                starInfo.liveip = [starDic objectForKey:@"liveip"];
//                starInfo.livestream = [starDic objectForKey:@"livestream"];
//                starInfo.nick = [starDic objectForKey:@"nick"];
//                starInfo.onlineflag = [[starDic objectForKey:@"onlineflag"] boolValue];
//                starInfo.recommendflag = [[starDic objectForKey:@"recommendflag"] intValue];
//                starInfo.roomid = [[starDic objectForKey:@"roomid"] intValue];
//                starInfo.serverip = [starDic objectForKey:@"serverip"];
//                starInfo.serverport = [[starDic objectForKey:@"serverport"] integerValue];
//                starInfo.showbegintime = [starDic objectForKey:@"showbegintime"];
//                starInfo.showusernum = [[starDic objectForKey:@"showusernum"] intValue];
//                starInfo.starid = [[starDic objectForKey:@"starid"] intValue];
//                starInfo.starlevelid = [[starDic objectForKey:@"starlevelid"] intValue];
//                starInfo.timeago = [starDic objectForKey:@"timeago"];
//                starInfo.userId = [[starDic objectForKey:@"userid"] intValue];
//                starInfo.introduction = [starDic objectForKey:@"introduction"];
//                starInfo.praisecount = [[starDic objectForKey:@"praisecount"] intValue];

                
                
                
                
            }
        }
        
        return YES;
    }
    return NO;
}
@end
