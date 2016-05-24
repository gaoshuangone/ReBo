     //
//  CommonUtils.m
//  MotherAndBaby
//
//  Created by duanjycc on 13-7-30.
//  Copyright (c) 2013年 daoshun. All rights reserved.
//

#import "CommonUtils.h"
#import <CommonCrypto/CommonDigest.h>       // MD5
#import <QuartzCore/QuartzCore.h>           // 绘图
#import <Accelerate/Accelerate.h>           // 图片处理
//#import "WToast.h"                          // 提示类
#import "AppDelegate.h"
#import <Security/Security.h>

/* 获取设备型号时使用 */
#include <sys/types.h>
#include <sys/sysctl.h>

@implementation CommonUtils

/****************** 关于字符串方法 <S> ******************/

// 获取一个UUID字符串
+ (NSString *)createUUID {
    CFUUIDRef uuidObject = CFUUIDCreate(kCFAllocatorDefault);
    NSString *uuidStr = (NSString*)CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault, uuidObject));
    return uuidStr;
}

// 获取对象的字符串类型
+ (NSString *)stringForId:(id)object {
    NSString *str = (NSString *)object;
    
    if (str == nil) {
        str = @"";
    }
    
    if (str == NULL) {
        str = @"";
    }
    
    if ([str isKindOfClass:[NSNull class]]) {
        str = @"";
    }
    
    str = [NSString stringWithFormat:@"%@",str];
    return str;
}

// 判断空字符串
+ (BOOL)isEmpty:(NSString *)string {
    string = [self stringForId:string];
    
    if ([string isEqualToString:@""]) {
        return YES;
    }
    
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0) {
        return YES;
    } else {
        return NO;
    }
}

// 字符串MD5加密
+ (NSString *)md5Encrypt:(NSString *)password {
    const char *original_str = [password UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, (int)strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
        [hash appendFormat:@"%02X", result[i]];
    return hash;
}

// 从URL字符串中获取文件名
+ (NSString *)getFileNameByUrl:(NSString *)url {
    NSString *filename = nil;
	if ([CommonUtils isEmpty:url]) {
		return nil;
	}
    
	NSArray *aArray = [url componentsSeparatedByString:@"/"];
	filename = [aArray objectAtIndex:([aArray count] - 1)];
	aArray = [filename componentsSeparatedByString:@"?"];
	filename = [aArray objectAtIndex:0];
	
	NSString *v = @"";
	if ([aArray count] > 1) {
		v= [aArray objectAtIndex:1];
		aArray = [v componentsSeparatedByString:@"="];
		if ([aArray count] > 1) {
			v = [aArray objectAtIndex:1];
		}
		if (v == nil) v= @"";
	}
	
	return [NSString stringWithFormat:@"%@%@", v, filename];
}

/* 获取Localizable中数据 */
+ (NSString *)getLocalizable:(NSString *)name {
    NSString *string = NSLocalizedString(name, nil);
    return [CommonUtils stringForId:string];
}

/****************** 关于网络方法 ******************/

// 检测网络 (注：NotReachable.没有网络 ReachableViaWWAN.正在使用3G网络 ReachableViaWiFi.正在使用wifi网络)
//+ (NetworkStatus)checkNetwork {
//    //NotReachable:没有网络
//    //ReachableViaWWAN:正在使用3G网络
//    //ReachableViaWiFi:正在使用wifi网络
//    
//	Reachability *r = [Reachability reachabilityWithHostName:@"www.baidu.com"];
//    return [r currentReachabilityStatus];
//}

/**************** 关于"NSUserDefaults"快捷方法 **********************/

// 保存数据——NSUserDefaults
+ (void)setInfoObject:(id)object forKey:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] setObject:object forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

// 取得数据——NSUserDefaults
+ (id)getInfoObject:(NSString *)key {
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

// 删除数据——NSUserDefaults
+ (void)delInfoObject:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


/****************** 关于绘图方法 ******************/

/**********************************************************
 函数名称：+ (void)addShadowForView:(UIView *)view toRadius:(NSInteger)radius toBorderWidth:(NSInteger)width toColor:(UIColor *)color
 函数描述：视图添加圆角和边框
 输入参数：(UIView *)view:需要添加圆角和边框的视图，必须有
 (NSInteger)radius:圆角半径，必须有，0：没有半径
 (NSInteger)width:边框半径，必须有，0：没有边框
 (UIColor *)color:边框颜色，可以nil，默认黑色
 输出参数：N/A
 返回值：N/A
 **********************************************************/
+ (void)addShadowForView:(UIView *)view toRadius:(NSInteger)radius toBorderWidth:(NSInteger)width toColor:(UIColor *)color {
    if (!view || ![view isKindOfClass:[UIView class]]) return;  // 视图判断
    
    // 半径判断
    if (radius > 0) {
        [view.layer setMasksToBounds:YES];
        [view.layer setCornerRadius:radius]; // 设置圆角半径
    }else {
        [view.layer setMasksToBounds:NO];
        [view.layer setCornerRadius:0];
    }
    
    // 宽度判断
    if (width > 0) { // 边框宽度和颜色
        [view.layer setBorderWidth:width];  // 设置边框宽度
        
        UIColor *borderColor = color;       // 边框颜色
        borderColor = color?color:[UIColor blackColor];
        
        [view.layer setBorderColor:[borderColor CGColor]];  // 设置边框颜色
    }else {
        [view.layer setBorderWidth:0];  // 设置边框宽度
        [view.layer setBorderColor:nil];  // 设置边框颜色
    }
}


/****************** 关于用户提示 ******************/

/* 温馨提示 */
//+ (void)showTips:(NSString *)message {
//    if ([CommonUtils isEmpty:message]) return;
//    [WToast showWithText:message];
//}

+ (void)showAlertView:(NSString *)message {
    [self showAlertView:message delegate:nil];
}

+ (void)showAlertView:(NSString *)message delegate:(id)delegate {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                    message:message
                                                   delegate:delegate
                                          cancelButtonTitle:@"关闭"
                                          otherButtonTitles:nil];
    [alert show];
}



+ (NSString*)getDeviceVersion
{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = (char*)malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    return platform;
}

/* 获取 型号 */
+ (NSString *)platformStringsss {
    NSString *platform = [self getDeviceVersion];
    
    //iPhone
    if ([platform isEqualToString:@"iPhone1,1"])   return @"iPhone 2G";
    if ([platform isEqualToString:@"iPhone1,2"])   return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"])   return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"])   return @"iPhone 4(GSM)";
    if ([platform isEqualToString:@"iPhone3,2"])   return @"iPhone 4(GSM Rev A)";
    if ([platform isEqualToString:@"iPhone3,3"])   return @"iPhone 4(CDMA)";
    if ([platform isEqualToString:@"iPhone4,1"])   return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"])   return @"iPhone 5(GSM)";
    if ([platform isEqualToString:@"iPhone5,2"])   return @"iPhone 5(GSM+CDMA)";
    if ([platform isEqualToString:@"iPhone5,3"])   return @"iPhone 5c(GSM)";
    if ([platform isEqualToString:@"iPhone5,4"])   return @"iPhone 5c(Global)";
    if ([platform isEqualToString:@"iPhone6,1"])   return @"iPhone 5s(GSM)";
    if ([platform isEqualToString:@"iPhone6,2"])   return @"iPhone 5s(Global)";
     if ([platform isEqualToString:@"iPhone7,1"])   return @"iPhone 6 Plus";
     if ([platform isEqualToString:@"iPhone7,2"])   return @"iPhone 6";
    //iPot Touch
    if ([platform isEqualToString:@"iPod1,1"])     return @"iPod Touch 1G";
    if ([platform isEqualToString:@"iPod2,1"])     return @"iPod Touch 2G";
    if ([platform isEqualToString:@"iPod3,1"])     return @"iPod Touch 3G";
    if ([platform isEqualToString:@"iPod4,1"])     return @"iPod Touch 4G";
    if ([platform isEqualToString:@"iPod5,1"])     return @"iPod Touch 5G";
    
    //iPad
    if ([platform isEqualToString:@"iPad1,1"])     return @"iPad";
    if ([platform isEqualToString:@"iPad2,1"])     return @"iPad 2(WiFi)";
    if ([platform isEqualToString:@"iPad2,2"])     return @"iPad 2(GSM)";
    if ([platform isEqualToString:@"iPad2,3"])     return @"iPad 2(CDMA)";
    if ([platform isEqualToString:@"iPad2,4"])     return @"iPad 2(WiFi + New Chip)";
    
    if ([platform isEqualToString:@"iPad2,5"])     return @"iPad Mini(WiFi)";
    if ([platform isEqualToString:@"iPad2,6"])     return @"iPad Mini(GSM)";
    if ([platform isEqualToString:@"iPad2,7"])     return @"iPad Mini(GSM+CDMA)";
    
    if ([platform isEqualToString:@"iPad3,1"])     return @"iPad 3(WiFi)";
    if ([platform isEqualToString:@"iPad3,2"])     return @"iPad 3(GSM+CDMA)";
    if ([platform isEqualToString:@"iPad3,3"])     return @"iPad 3(GSM)";
    if ([platform isEqualToString:@"iPad3,4"])     return @"iPad 4(WiFi)";
    if ([platform isEqualToString:@"iPad3,5"])     return @"iPad 4(GSM)";
    if ([platform isEqualToString:@"iPad3,6"])     return @"iPad 4(GSM+CDMA)";
    
    if ([platform isEqualToString:@"i386"] || [platform isEqualToString:@"x86_64"]) return @"iPhone Simulator";
    
    return platform;
}



/* ios去掉字符串中的html标签的方法 */
+ (NSString *)filterHTML:(NSString *)html {
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    //    NSString * regEx = @"<([^>]*)>";
    //    html = [html stringByReplacingOccurrencesOfString:regEx withString:@""];
    return html;
}



/* 标示 */
+ (id)secAttrForSection:(NSInteger)section
{
    switch (section)
    {
        case 0: return (__bridge id)kSecAttrAccount;
        case 1: return (id)CFBridgingRelease(kSecValueData);
        case 2: return (__bridge id)kSecValueData;
    }
    return nil;
}

/* 检查手机号 */
+ (BOOL)checkMobile:(NSString *)_text
{
    
//    if (strPhoneNum != nil && ![strPhoneNum isEqualToString:@""]) {
    
//        NSString *regexPhone = @"^1[3|5|8][0-9][0-9]{8}$";
//        NSPredicate *predicatephone = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexPhone];
//        if (![predicatephone0 evaluateWithObject:strPhoneNum]) {手机号是13/15/18开头的11位数字号码！"
    _text = [_text stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([_text toString].length<=3) {
        return NO;
    }
    if ([[_text substringToIndex:2] isEqualToString:@"17"]) {
        return YES;
    }
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:_text];

}

/*[\u4e00-\u9fa5] //匹配中文字符

^[1-9]\d*$    //匹配正整数
^[A-Za-z]+$   //匹配由26个英文字母组成的字符串
^[A-Z]+$      //匹配由26个英文字母的大写组成的字符串
^[a-z]+$      //匹配由26个英文字母的小写组成的字符串

^[A-Za-z0-9]+$ //匹配由数字和26个英文字母组成的字符串*/
 /* 检查手机号 */
+(BOOL)checkPhoneNumberCountWithCurrentTextField:(UITextField *)currentTextFiled withTargetTextField:(UITextField *)targerTextField{
   
    
    if (currentTextFiled == targerTextField) {
        if (currentTextFiled.text.length<=11) {
            
            if (currentTextFiled.text.length == 11) {
                if ([currentTextFiled.text isEqualToString:@""]) {
                    return YES;
                }else{
//                    [SVProgressHUD showErrorWithStatus:@"手机号位数超过限制"];
//                    [MBProgressHUD hudShowWithStatus:self :@"手机号位数超过限制"];
                    return NO;
                }
            }
            
            return YES;
        }else{
//            [SVProgressHUD showErrorWithStatus:@"手机号位数超过限制"];
//            [MBProgressHUD hudShowWithStatus:self :@"手机号位数超过限制"];
            return NO;
        }
    }
    return YES;
}

/* 检查含有数字标点 */
+ (BOOL)checkShuZiWithBiaoDianWithString:(NSString*)string{
    NSString *regex=@"^[A-Za-z /\u4e00-\u9fa5]+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if (![predicate evaluateWithObject:string]) {
        return YES;
    }
    return NO;
    
}
/* 格式化手机号 */
+ (NSString*)changePhoneNumberWithNumber:(NSString*)number withType:(NSString*)type{
    
    if (number.length<=0) {
        return @"";
    }

    NSString* str = [number toString];

    NSString* str1 = [str substringToIndex:3];
    

    NSString*  str2 = [str substringFromIndex:3];

    NSString* str3 = [str2 substringToIndex:4];
  
    NSString* str4 = [str substringFromIndex:7];


    return[NSString stringWithFormat:@"%@%@%@%@%@",str1,type,str3,type,str4];
}
/* 检查是否是数字和小数点 */  //YES return；
+ (BOOL)checkNumber:(NSString *)string WithTextFieldText:(NSString*)text{
    
    
        NSCharacterSet*cs;
         cs =[[NSCharacterSet characterSetWithCharactersInString:@"0123456789." ]invertedSet];
         NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs]componentsJoinedByString:@""];
        BOOL basicTest = [string isEqualToString:filtered];
    
    
    if ([text rangeOfString:@"."].length>0) {
        if ([string isEqualToString:@"."]) {
            return NO;
        }
    }
        return basicTest;

}
/* 检查匹配由数字和26个英文字母组成的字符串*/  //YES return；
+(BOOL)checkStringNumbersWithlettersWithString:(NSString*)string;{
    NSString *regex=@"^[A-Za-z0-9]+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if (![predicate evaluateWithObject:string]) {
        return YES;
    }
    return NO;
}
+(void)heightForText:(NSString *)text withFontSize:(CGFloat)size withWide:(CGFloat)wide withBlocl:(void (^)(CGFloat))block{
    
    
    NSDictionary *attrbute = @{NSFontAttributeName:[UIFont systemFontOfSize:size]};
    
    block( [text boundingRectWithSize:CGSizeMake(wide, 1000) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrbute context:nil].size.height);
    
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

@end
