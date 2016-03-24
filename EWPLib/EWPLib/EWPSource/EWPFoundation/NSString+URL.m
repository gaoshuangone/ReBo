//
//  NSString+URL.m
//  MemberMarket
//
//  Created by andy on 13-12-2.
//  Copyright (c) 2013年 yiwopai. All rights reserved.
//

#import "NSString+URL.h"

@implementation NSString (URL)

- (NSURL *)URLString
{
    return [NSURL URLWithString:self];
}

@end
