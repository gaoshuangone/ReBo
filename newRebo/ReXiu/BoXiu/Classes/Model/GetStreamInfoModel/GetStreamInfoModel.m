//
//  GetStreamInfoModel.m
//  BoXiu
//
//  Created by lidongbo on 4/1/16.
//  Copyright © 2016 rexiu. All rights reserved.
//

#import "GetStreamInfoModel.h"

@implementation GetStreamInfoModel

- (void)requestDataWithParams:(NSDictionary *)params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:GetStreamInfo_Method params:params success:success fail:fail];
}

//- (BOOL)analyseData:(NSDictionary *)data {
//    if (![super analyseData:data]) {
//        return NO;
//    }
//        
//    return YES;
//}


@end
