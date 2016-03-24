//
//  NSMutableDictionary+GTMBase64.m
//  MemberMarket
//
//  Created by jiangbin on 13-11-27.
//  Copyright (c) 2013年 yiwopai. All rights reserved.
//

#import "NSMutableDictionary+GTMBase64.h"
#import "NSString+GTMBase64.h"

#define Base64_Encode

@implementation NSMutableDictionary (GTMBase64)

- (void)setBase64Object:(id)value forKey:(NSString *)key
{
    NSString *valueString = nil;
    if ([value isKindOfClass:[NSNumber class]])
    {
        valueString = [value stringValue];
    }
    else
    {
        valueString = (NSString *)[value copy];
    }
   
#ifdef Base64_Encode

     [self setObject:[valueString encodeBase64String] forKey:key];
#else
    [self setObject:object forKey:key];
#endif//Base64_Encode
    
    
}

- (id)ObjectFromBase64ForKey:(NSString *)key
{
    id value = [self valueForKey:key];
    NSString *decodeStr = [value copy];
#ifdef Base64_Encode
    return [decodeStr decodeBase64String];
#else
    return value;
#endif//Base64_Encode

}

@end
