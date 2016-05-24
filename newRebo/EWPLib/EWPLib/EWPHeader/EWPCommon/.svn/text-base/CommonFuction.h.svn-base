//
//  CommonFuction.h
//  MemberMarket
//
//  Created by jiangbin on 13-11-12.
//  Copyright (c) 2013年 yiwopai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^MethodBlock)();

@interface CommonFuction : NSObject

/*加了两个参数最大宽度和最大高度*/
+ (CGSize)sizeOfString:(NSString *)string maxWidth:(CGFloat)maxWidth maxHeight:(CGFloat)maxHeight withFontSize:(CGFloat)fontSize;

/*返回document目录路径*/
+ (NSString *)documentPath;

//cache路径
+ (NSString *)cachePath;

+ (NSString *)dataToString:(NSData *)data;

+ (BOOL)isFileExistInDocunmentPath:(NSString *)fileName;

+ (BOOL)isFileExistInMainBundle:(NSString *)fileName;

+ (NSString *)uuid;

+ (UIColor *)colorFromHexRGB:(NSString *)inColorString;

+ (UIColor *)colorFromHexRGB:(NSString *)inColorString alpha:(CGFloat)alpha;

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

+ (NSString *)getPlatformString;

+ (BOOL)hasUnicodeString:(NSString *)string;

+ (BOOL)isNumText:(NSString *)str;

//判断输入内容为空或只有空格
+ (BOOL)isEmpty:(NSString *)string;

//多线程执行方法
+ (void)performMethodInMainThread:(BOOL)isMainThread afterDelay:(NSTimeInterval)delay methodBlock:(MethodBlock)methodBlock;

//当天日期零点
+ (NSDate *)zeroOfDate:(NSDate *)date;

//时间字符串转换为时间NSDate,格式：yyyy-MM-dd HH:mm:ss
+ (NSDate *)dateFromString:(NSString *)dateString;

//将时间类型转换为字符串
+ (NSString *)stringFromDate:(NSDate *)date;


@end
