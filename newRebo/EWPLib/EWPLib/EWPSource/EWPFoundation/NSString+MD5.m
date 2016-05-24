//
//  NSString+MD5.m
//  MemberMarket
//
//  Created by andy on 13-12-3.
//  Copyright (c) 2013年 yiwopai. All rights reserved.
//

#import "NSString+MD5.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (MD5)

- (NSString *)md5
{
    const char *original_str = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH] = {0};
    CC_MD5(original_str, (unsigned int)strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int nIndex = 0; nIndex < CC_MD5_DIGEST_LENGTH; nIndex++)
    {
        [hash appendFormat:@"%02X",result[nIndex]];
    }
    return [hash lowercaseString];
}

@end
