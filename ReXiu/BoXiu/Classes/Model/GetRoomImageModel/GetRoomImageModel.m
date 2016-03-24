//
//  GetRoomImageModel.m
//  BoXiu
//
//  Created by andy on 14-7-25.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "GetRoomImageModel.h"

@implementation GetRoomImageModel

- (void)requestDataWithParams:(NSDictionary *)params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:Get_RoomImages_Method params:params success:success fail:fail];
}


- (BOOL)analyseData:(NSDictionary *)data
{
    if (![super analyseData:data])
    {
        return NO;
    }
    if (self.result == 0)
    {
        NSArray *dataArray = [data objectForKey:@"data"];
        if (dataArray && [dataArray count] > 0)
        {
            if (_dataMArray == nil)
            {
                _dataMArray = [NSMutableArray array];
            }
            [_dataMArray removeAllObjects];
            [self.dataMArray addObjectsFromArray:dataArray];
            return YES;
        }
    }
    
    return NO;
}

@end
