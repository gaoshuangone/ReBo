//
//  NSString+Date.m
//  EWPLib
//
//  Created by andy on 14-8-29.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "NSString+Date.h"

@implementation NSString (Date)

- (NSDate *)stringToDate
{
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [inputFormatter setDateFormat:@"yyyyMMddHHmmss"];
    NSDate* date = [inputFormatter dateFromString:self];
    return date;
}


@end
