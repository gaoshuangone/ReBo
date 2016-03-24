//
//  SysytemConfig.h
//  BrandShow
//
//  Created by CaiZetong on 14-10-14.
//  Copyright (c) 2014年 cc. All rights reserved.
//

#import <Foundation/Foundation.h>

#define UpdateNotification          @"UpdateNotification"

@interface SystemConfig : NSObject

+ (NSString *)appVersion;

+ (BOOL)isVersion:(NSString *)oldVersion lessthan:(NSString *)newVersion;

+ (void)checkUpdate:(void(^)(BOOL isNew))success failed:(void(^)())failed;

@end
