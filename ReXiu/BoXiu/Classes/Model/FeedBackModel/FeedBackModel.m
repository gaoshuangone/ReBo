//
//  FeedBackModel.m
//  BoXiu
//
//  Created by andy on 14-5-15.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "FeedBackModel.h"

@implementation FeedBackModel

- (void)requestDataWithParams:(NSDictionary *)params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:Feedback_Method params:params success:success fail:fail];
}

@end
