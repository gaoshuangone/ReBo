//
//  CommonUtils+Date.m
//  Nightclub
//
//  Created by 赵 伟 on 13-11-27.
//  Copyright (c) 2013年 赵伟. All rights reserved.
//

#import "CommonUtils+Date.h"

@implementation CommonUtils (Date)

/****************** 关于时间方法 ******************/

/* Date 转换 NSString (默认格式：@"yyyy-MM-dd HH:mm:ss")   */
+ (NSString *)getStringForDate:(NSDate *)date {
	return [self getStringForDate:date format:@"yyyy-MM-dd HH:mm:ss"];
}

/* Date 转换 NSString (默认格式：自定义)  */
+ (NSString *)getStringForDate:(NSDate *)date format:(NSString *)format {
    if (format == nil) format = @"yyyy-MM-dd HH:mm:ss";
    
	//实例化一个NSDateFormatter对象
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	//设定时间格式,这里可以设置成自己需要的格式
	[dateFormatter setDateFormat:format];
	//用[NSDate date]可以获取系统当前时间
	NSString *currentDateStr = [dateFormatter stringFromDate:date];
	return currentDateStr;
}

/* NSString 转换 Date (默认格式：@"yyyy-MM-dd HH:mm:ss") */
+ (NSDate *)getDateForString:(NSString *)string {
    return [self getDateForString:string format:@"yyyy-MM-dd HH:mm:ss"];
}

/* NSString 转换 Date (默认格式：自定义)  */
+ (NSDate *)getDateForString:(NSString *)string format:(NSString *)format; {
    if (format == nil) format = @"yyyy-MM-dd HH:mm:ss";

    //实例化一个NSDateFormatter对象
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	//设定时间格式,这里可以设置成自己需要的格式
	[dateFormatter setDateFormat:format];
    return [dateFormatter dateFromString:string];
}
+(NSString*)getDateForStringTime:(NSString*)stringTie
{
    NSDate* timeSp = [NSDate dateWithTimeIntervalSince1970:[stringTie intValue]];
    return  [self getStringForDate:timeSp];
    
    
}
+(NSString*)getDateForStringTime:(NSString*)stringTie withFormat:(NSString*)format
{
    NSDate* timeSp = [self getDateForString:stringTie];
    
    if (format == nil) {
        format = @"yyyy-MM-dd HH:mm:ss";
    }
   
    
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:format];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:timeSp];
    return currentDateStr;
    
}
+(NSString*)getDateForStringIntegerTime:(NSTimeInterval)stringIntegerTie withFormat:(NSString*)format{
    NSDate* timeSp = [NSDate dateWithTimeIntervalSince1970:stringIntegerTie ];
    
    if (format == nil) {
        format = @"yyyy-MM-dd HH:mm:ss";
    }
    

    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:format];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:timeSp];
    return currentDateStr;

}


@end
