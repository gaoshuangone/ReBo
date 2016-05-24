//
//  GetRoomServerForMobileStar.m
//  BoXiu
//
//  Created by CaiZetong on 15/8/13.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import "GetRoomServerForMobileStar.h"

@implementation GetRoomServerForMobileStar

- (void)requestDataWithParams:(NSDictionary *)params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:GetRoomServerForMobileStar_Method params:params success:success fail:fail];
    
}

- (BOOL)analyseData:(NSDictionary *)data
{
    if ([super analyseData:data])
    {
        NSDictionary *dic = [data objectForKey:@"data"];
        if (dic && [dic isKindOfClass:[NSDictionary class]] && [dic count])
        {
            self.downmobileliveip = [dic objectForKey:@"downmobileliveip"];
            self.downliveip = [dic objectForKey:@"downliveip"];
//            self.showid = [[dic objectForKey:@"id"] integerValue];
            self.liveip = [dic objectForKey:@"liveip"];
            self.livestream = [dic objectForKey:@"livestream"];
//            self.roomid = [[dic objectForKey:@"roomid"] integerValue];
            self.serverip = [dic objectForKey:@"serverip"];
            self.serverport = [[dic objectForKey:@"serverport"] integerValue];
                  self.cdnp = [[dic objectForKey:@"cdnp"] toString];
//            self.showbegintime = [dic objectForKey:@"showbegintime"];
//            self.showtype = [[dic objectForKey:@"showtype"] integerValue];
//            self.showusernum = [[dic objectForKey:@"showusernum"] integerValue];
//            self.starid = [[dic objectForKey:@"starid"] integerValue];
//            self.statcoinflag = [[dic objectForKey:@"statcoinflag"] integerValue];
//            self.status = [[dic objectForKey:@"status"] integerValue];
//            self.userid = [[dic objectForKey:@"userid"] integerValue];
        }
        return YES;
    }
    
    
    
    return NO;
}

@end
