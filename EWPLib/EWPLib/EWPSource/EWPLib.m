//
//  EWPLib.m
//  EWPLib
//
//  Created by andy on 14-7-21.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//


#import "EWPLib.h"
#import "NSString+DES.h"
#import "NSString+Date.h"

const NSString *publicKey = @"1234567890";

@interface EWPLib ()
@property (nonatomic,strong) NSString *signData;
@end

@implementation EWPLib

+ (instancetype)shareInstance
{
    static dispatch_once_t predicate;
    static EWPLib* instance;
    dispatch_once(&predicate,^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (void)initWithSignData:(NSString *)signData
{
    self.signData = signData;
}

- (void)initEWPLib
{
    self.signData = @"PaRi+XnZO+M5YX+7BCHl1zjLznRIuExq4ZgEErY5owHxb4rRcJWMRxkROm3olCFxz33ebzD0Pd76jY/sB98/Hhy9Wqk3n1BR";
}

- (NSString *)libInfo
{
    NSString *company = @"杭州热秀网络技术技术有限公司";
    NSString *starTime = @"20140301000000";
    NSString *endTime = @"20190301000000";
    NSString *auth = @"1a2b3c4d5e6f7g8h9i";
    NSString *identifier = [[NSBundle mainBundle] bundleIdentifier];
    
    NSTimeInterval currentDate = [[NSDate date] timeIntervalSince1970];
    NSTimeInterval endDate = [[endTime stringToDate] timeIntervalSince1970];
    if (currentDate - endDate > 0)
    {
        //第一个时间大
        return nil;
    }
    
    NSMutableString *info = [NSMutableString string];
    //公司名称
    [info appendString:company];
    //开始时间
    [info appendString:starTime];
    //结束时间
    [info appendString:endTime];
    //授权码
    [info appendString:auth];
    //identifier
    [info appendString:identifier];
    return info;
}

- (BOOL)isSuccessOfInit
{
    NSString *sourceData = [self libInfo];
    if (sourceData == nil)
    {
        return NO;
    }
    
    NSString *encodeData = [sourceData DESEncryptWithKey:publicKey];//用公钥加密
    if ([encodeData isEqualToString:self.signData])
    {
        return YES;
    }
    return NO;
}

@end
