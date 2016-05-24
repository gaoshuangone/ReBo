//
//  AppManager.m
//  FHL
//
//  Created by panume on 14-9-26.
//  Copyright (c) 2014年 JUEWEI. All rights reserved.
//

#import "AppManager.h"
#import <CommonCrypto/CommonDigest.h>


@implementation AppManager


+ (NSString *)md5:(NSString *)str
{
    
    if((nil == str) || ([str isEqualToString:@""]))
    {
        return nil;
    }
    const char *cStr = [str UTF8String];
    
    unsigned char result[16];
    
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result );
//    FLDDLogDebug("result:%s,lenght:%lu", result, strlen((char *)result));
    
    
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0],result[1],result[2],result[3],
            
            result[4],result[5],result[6],result[7],
            
            result[8],result[9],result[10],result[11],
            
            result[12],result[13],result[14],result[15]];
}

+ (void)setUserDefaultsValue:(id)value key:(NSString *)key
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

+ (NSString *)valueForKey:(NSString *)key
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}
+ (void)setUserBoolValue:(BOOL)value key:(NSString *)key
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setBool:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
