//
//  CommonFuction.m
//  MemberMarket
//
//  Created by jiangbin on 13-11-12.
//  Copyright (c) 2013年 yiwopai. All rights reserved.
//

#import "CommonFuction.h"
#include <sys/types.h>
#include <sys/sysctl.h>
#import "MacroMethod.h"

@implementation CommonFuction


+ (CGSize)sizeOfString:(NSString *)string maxWidth:(CGFloat)maxWidth maxHeight:(CGFloat)maxHeight withFontSize:(CGFloat)fontSize
{
    CGSize size = CGSizeZero;
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]};
    CGRect rect = [string boundingRectWithSize:CGSizeMake(maxWidth, maxHeight)
                                       options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                    attributes:attribute context:nil];//ios9 字体偏大，计算不太准确
    size = rect.size;
    return size;
}


+ (NSString *)documentPath
{
    NSArray *filePaths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
    
    return [filePaths objectAtIndex: 0];
}

+ (NSString *)cachePath
{
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cacheDirectory = [paths objectAtIndex:0];
    return cacheDirectory;
}

+ (BOOL)isFileExistInDocunmentPath:(NSString *)fileName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    NSString *filePath = [path stringByAppendingString:fileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL result = [fileManager fileExistsAtPath:filePath];
    return result;
}

+ (BOOL)isFileExistInMainBundle:(NSString *)fileName
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL result = [fileManager fileExistsAtPath:filePath];
    return result;
}

+ (NSString *)dataToString:(NSData *)data
{
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

+ (NSString *)uuid
{
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    CFRelease(puuid);
    CFRelease(uuidString);
    return result;
}

+ (UIColor *)colorFromHexRGB:(NSString *)inColorString
{
    UIColor *result = nil;
    unsigned int colorCode = 0;
    unsigned char redByte, greenByte, blueByte;
    
    if (nil != inColorString)
    {
        NSScanner *scanner = [NSScanner scannerWithString:inColorString];
        (void) [scanner scanHexInt:&colorCode]; // ignore error
    }
    redByte = (unsigned char) (colorCode >> 16);
    greenByte = (unsigned char) (colorCode >> 8);
    blueByte = (unsigned char) (colorCode); // masks off high bits
    result = [UIColor
              colorWithRed: (float)redByte / 0xff
              green: (float)greenByte/ 0xff
              blue: (float)blueByte / 0xff
              alpha:1.0];
    return result;
}

+ (UIColor*)colorFromHexRGB:(NSString *)inColorString alpha:(CGFloat)alpha
{
    UIColor *result = nil;
    unsigned int colorCode = 0;
    unsigned char redByte, greenByte, blueByte;
    
    if (nil != inColorString)
    {
        NSScanner *scanner = [NSScanner scannerWithString:inColorString];
        (void) [scanner scanHexInt:&colorCode]; // ignore error
    }
    redByte = (unsigned char) (colorCode >> 16);
    greenByte = (unsigned char) (colorCode >> 8);
    blueByte = (unsigned char) (colorCode); // masks off high bits
    result = [UIColor
              colorWithRed: (float)redByte / 0xff
              green: (float)greenByte/ 0xff
              blue: (float)blueByte / 0xff
              alpha:alpha];
    return result;
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (NSString *) getPlatformString
{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithUTF8String:machine];
    free(machine);
    
    NSDictionary *dictHwMachine = @{
                                    
                                    //iPad.
                                    @"iPad1,1" : @[ @"iPad 1G", @"Wi-Fi / GSM", @"A1219 / A1337" ],
                                    @"iPad2,1" : @[ @"iPad 2", @"Wi-Fi", @"A1395" ],
                                    @"iPad2,2" : @[ @"iPad 2", @"GSM", @"A1396" ],
                                    @"iPad2,3" : @[ @"iPad 2", @"CDMA", @"A1397" ],
                                    @"iPad2,4" : @[ @"iPad 2", @"Wi-Fi Rev A", @"A1395" ],
                                    @"iPad2,5" : @[ @"iPad mini 1G", @"Wi-Fi", @"A1432" ],
                                    @"iPad2,6" : @[ @"iPad mini 1G", @"GSM", @"A1454" ],
                                    @"iPad2,7" : @[ @"iPad mini 1G", @"GSM+CDMA", @"A1455" ],
                                    @"iPad3,1" : @[ @"iPad 3", @"Wi-Fi", @"A1416" ],
                                    @"iPad3,2" : @[ @"iPad 3", @"GSM+CDMA", @"A1403" ],
                                    @"iPad3,3" : @[ @"iPad 3", @"GSM", @"A1430" ],
                                    @"iPad3,4" : @[ @"iPad 4", @"Wi-Fi", @"A1458" ],
                                    @"iPad3,5" : @[ @"iPad 4", @"GSM", @"A1459" ],
                                    @"iPad3,6" : @[ @"iPad 4", @"GSM+CDMA", @"A1460" ],
                                    @"iPad4,1" : @[ @"iPad Air", @"Wi‑Fi", @"A1474" ],
                                    @"iPad4,2" : @[ @"iPad Air", @"Cellular", @"A1475" ],
                                    @"iPad4,4" : @[ @"iPad mini 2G", @"Wi‑Fi", @"A1489" ],
                                    @"iPad4,5" : @[ @"iPad mini 2G", @"Cellular", @"A1517" ],
                                    
                                    //iPhone.
                                    @"iPhone1,1" : @[ @"iPhone 2G", @"GSM", @"A1203" ],
                                    @"iPhone1,2" : @[ @"iPhone 3G", @"GSM", @"A1241 / A13241" ],
                                    @"iPhone2,1" : @[ @"iPhone 3GS", @"GSM", @"A1303 / A13251" ],
                                    @"iPhone3,1" : @[ @"iPhone 4", @"GSM", @"A1332" ],
                                    @"iPhone3,2" : @[ @"iPhone 4", @"GSM Rev A", @"-" ],
                                    @"iPhone3,3" : @[ @"iPhone 4", @"CDMA", @"A1349" ],
                                    @"iPhone4,1" : @[ @"iPhone 4S", @"GSM+CDMA", @"A1387 / A14311" ],
                                    @"iPhone5,1" : @[ @"iPhone 5", @"GSM", @"A1428" ],
                                    @"iPhone5,2" : @[ @"iPhone 5", @"GSM+CDMA", @"A1429 / A14421" ],
                                    @"iPhone5,3" : @[ @"iPhone 5C", @"GSM", @"A1456 / A1532" ],
                                    @"iPhone5,4" : @[ @"iPhone 5C", @"Global", @"A1507 / A1516 / A1526 / A1529" ],
                                    @"iPhone6,1" : @[ @"iPhone 5S", @"GSM", @"A1433 / A1533" ],
                                    @"iPhone6,2" : @[ @"iPhone 5S", @"Global", @"A1457 / A1518 / A1528 / A1530" ],
                                    @"iPhone7,1" : @[ @"iPhone 6 Plus (A1522/A1524)"],
                                    @"iPhone7,2" : @[ @"iPhone 6 (A1549/A1586)" ],
                                    @"iPhone8,1" : @[ @"iPhone 6s " ],
                                    //iPod.
                                    @"iPod1,1" : @[ @"iPod touch 1G", @"-", @"A1213" ],
                                    @"iPod2,1" : @[ @"iPod touch 2G", @"-", @"A1288" ],
                                    @"iPod3,1" : @[ @"iPod touch 3G", @"-", @"A1318" ],
                                    @"iPod4,1" : @[ @"iPod touch 4G", @"-", @"A1367" ],
                                    @"iPod5,1" : @[ @"iPod touch 5G", @"-", @"A1421 / A1509" ],
                                    
                                    //
                                    @"i386"    : @[ @"iPhone Simulator" ],
                                    @"x86_64"  : @[@"iPhone Simulator" ]
                                    };
    
    NSArray *arrayHw = [dictHwMachine objectForKey:platform];
    if(arrayHw !=nil)
    {
        return [arrayHw objectAtIndex:0];
    }
    else
    {
        if ([platform hasSuffix:@"86"] || [platform isEqual:@"x86_64"])
        {
            return @"Simulator";
        }else
            return @"Unknown iOS device";
    }
}

+ (BOOL)hasUnicodeString:(NSString *)string
{
    NSString *text =string;
    
    int length = [text length];
    for (int i=0; i<length; ++i)
    {
        NSRange range = NSMakeRange(i, 1);
        NSString *subString = [text substringWithRange:range];
        const char *cString = [subString UTF8String];
        if (strlen(cString) == 3)
        {
            return YES;
        }
    }
    return NO;
}

+ (BOOL)isNumText:(NSString *)str
{
    NSString * regex= @"^[0-9]*$";
    NSPredicate * pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:str];
    if (isMatch)
    {
        return YES;
    }
    else
    {
        return NO;
    }
    
}

+ (BOOL)isEmpty:(NSString *)string
{
    if (!string)
    {
        return YES;
    }
    else
    {
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        NSString *trimedString = [string stringByTrimmingCharactersInSet:set];
        if ([trimedString length] == 0)
        {
            return YES;
        }
        else
        {
            return NO;
        }
    }
    return YES;
}

+ (void)performMethodInMainThread:(BOOL)isMainThread afterDelay:(NSTimeInterval)delay methodBlock:(MethodBlock)methodBlock
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    if (isMainThread)
    {
        queue = dispatch_get_main_queue();
    }
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, delay * NSEC_PER_SEC);
    dispatch_after(delayTime, queue, ^{
        if (methodBlock)
        {
            methodBlock();
        }
    });
}

+ (NSDate *)zeroOfDate:(NSDate *)date
{
    if (date == nil)
    {
        date = [NSDate date];
    }
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSUIntegerMax fromDate:date];
    components.hour = 0;
    components.minute = 0;
    components.second = 0;
    NSTimeInterval ts = (double)(int)[[calendar dateFromComponents:components] timeIntervalSince1970];
    return [NSDate dateWithTimeIntervalSince1970:ts];
}

+ (NSDate *)dateFromString:(NSString *)dateString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    return destDate;
}

+ (NSString *)stringFromDate:(NSDate *)date
{
    if (date == nil)
    {
        date = [NSDate date];
    }
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *stringTime = [dateFormat stringFromDate:date];
    return stringTime;
}

@end
