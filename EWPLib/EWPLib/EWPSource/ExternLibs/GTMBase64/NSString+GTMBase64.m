//
//  NSString+GTMBase64.m
//  MemberMarket
//
//  Created by jiangbin on 13-12-3.
//  Copyright (c) 2013年 yiwopai. All rights reserved.
//

#import "NSString+GTMBase64.h"
#import "GTMBase64.h"

@implementation NSString (GTMBase64)

- (NSString *)encodeBase64String
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    data = [GTMBase64 encodeData:data];
    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return base64String;
}

- (NSString *)decodeBase64String
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    data = [GTMBase64 decodeData:data];
    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return base64String;
}
@end
