//
//  TcpModel.m
//  BoXiu
//
//  Created by Andy on 14-4-10.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "TcpModel.h"
#import "TcpServerInterface.h"

@implementation TcpModel

- (id)initWithBodyData:(NSDictionary *)bodyDic
{
    self = [super init];
    if (self)
    {
        [self analyseData:bodyDic];
    }
    return self;
}

- (void)analyseData:(NSDictionary *)dataDic
{
    
}
@end
