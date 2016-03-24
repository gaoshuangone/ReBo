//
/******************************************************************************************/
//  共同方法——时间


#import <Foundation/Foundation.h>
#import "CommonUtils.h"

@interface CommonUtils (Date)

/****************** 关于时间方法 <S> ******************/

/* 
 Date 转换 NSString (默认格式：@"yyyy-MM-dd HH:mm:ss")   
 */
+ (NSString *)getStringForDate:(NSDate *)date;

/* 
 Date 转换 NSString (默认格式：自定义)  
 */
+ (NSString *)getStringForDate:(NSDate *)date format:(NSString *)format;

/* 
 NSString 转换 Date (默认格式：@"yyyy-MM-dd HH:mm:ss") 
 */
+ (NSDate *)getDateForString:(NSString *)string;

/* 
 NSString 转换 Date (默认格式：自定义) 
 */




+ (NSDate *)getDateForString:(NSString *)string format:(NSString *)format;
/*
 时间戳 转换 Date (默认格式：自定义)
 */
+(NSString*)getDateForStringTime:(NSString*)stringTie;
/*
 时间戳 转换 string (默认格式：自定义) format自定义
 */
+(NSString*)getDateForStringIntegerTime:(NSTimeInterval)stringIntegerTie withFormat:(NSString*)format;




/*
 NSString 转换  format自定义格式string(默认格式：@"yyyy-MM-dd HH:mm:ss")
 */
+(NSString*)getDateForStringTime:(NSString*)stringTie withFormat:(NSString*)format;
@end
