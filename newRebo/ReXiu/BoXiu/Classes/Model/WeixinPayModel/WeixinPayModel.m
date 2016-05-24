//
//  WeixinPayModel.m
//  BoXiu
//
//  Created by tongmingyu on 15-1-20.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import "WeixinPayModel.h"

@implementation WeixinPayModel

- (void)requestDataWithParams:(NSDictionary *)params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:WeixinPay_Method params:params success:success fail:fail];
}

- (BOOL)analyseData:(NSDictionary *)data
{
    if (![super analyseData:data])
    {
        return NO;
    }
    if (self.result == 0)
    {
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:[data objectForKey:@"data"]];
        
        if (dic && dic.count > 0)
        {
            self.appid = [dic objectForKey:@"appid"];
            self.noncestr = [dic objectForKey:@"noncestr"];
            self.package = [dic objectForKey:@"packagevalue"];
            self.outtradeno = [dic objectForKey:@"outtradeno"];
            self.partnerid = [dic objectForKey:@"partnerid"];
            self.prepayid = [dic objectForKey:@"prepayid"];
            self.retcode = [dic objectForKey:@"retcode"];
            self.retmsg = [dic objectForKey:@"retmsg"];
            self.sign = [dic objectForKey:@"sign"];
            self.timestamp = [dic objectForKey:@"timestamp"];
            
            return YES;
        }
    }
    
    return NO;
}

@end
