//
//  FreeTicketModel.m
//  BoXiu
//
//  Created by tongmingyu on 14-12-25.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "FreeTicketModel.h"

@implementation FreeTicketModel


- (void)requestDataWithParams:(NSDictionary *)params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:HaveFreeTicket_Method params:params success:success fail:fail];
}


- (BOOL)analyseData:(NSDictionary *)data
{
    if (![super analyseData:data])
    {
        return NO;
    }
    if (self.result == 0)
    {
         self.haveFreeTicket = [[data objectForKey:@"data"] boolValue];
        return YES;
    }
    return NO;
}

@end
