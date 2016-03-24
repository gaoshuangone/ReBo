//
//  BaseTcpModel.m
//  BoXiu
//
//  Created by andy on 14-9-15.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "BaseTcpModel.h"

@implementation BaseTcpModel


- (id)initWithData:(NSDictionary *)dataDic
{
    self = [super init];
    if (self)
    {
        [self analyseData:dataDic];
    }
    return self;
}


- (void)analyseData:(NSDictionary *)dataDic
{
    
}

@end
