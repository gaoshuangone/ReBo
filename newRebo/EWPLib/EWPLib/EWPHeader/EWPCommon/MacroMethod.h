//
//  MacroMethod.h
//  EWPLib
//
//  Created by andy on 14-6-17.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#ifndef EWPLib_MacroMethod_h
#define EWPLib_MacroMethod_h

/*宏方法*/

#define IOS_DEUBG
#define INTERFACE_IS_PAD     ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
#define INTERFACE_IS_PHONE   ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
#define ISBIGSYSTEM5 ([[[UIDevice currentDevice] systemVersion] floatValue]>=5.0)
#define ISBIGSYSTEM6 ([[[UIDevice currentDevice] systemVersion] floatValue]>=6.0 && [[[UIDevice currentDevice] systemVersion] floatValue]<7.0)
#define ISBIGSYSTEM7 ([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0 && [[[UIDevice currentDevice] systemVersion] floatValue]<8.0)
#define ISBIGSYSTEM8 ([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_WIDTH  ([[UIScreen mainScreen] bounds].size.width)

#define RGB(r,g,b,a)  [UIColor colorWithRed:(double)r/255.0f green:(double)g/255.0f blue:(double)b/255.0f alpha:a]

#define debugMethod() NSLog(@"%s", __func__)


//iphone5或iphone6的放大显示模式

#define IPHONE_5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)


//iphone6的标准显示模式
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)//是否为iphone6 4.7

#define iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)//是否为iphone6 5.7

#define iphone6_6P_isYES   iPhone6||iPhone6Plus//是否为iphone6

#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#define IOSLog(log) [NSString stringWithFormat:@"%s-Line:%d Content:%@",__PRETTY_FUNCTION__,__LINE__,log];

#ifdef DEBUG
#define LogMethod	NSLog(@"%s-%d", __PRETTY_FUNCTION__, __LINE__);
#define debugMethod() NSLog(@"%s", __func__)
#define EWPLog(...) NSLog(@"%s %@", __PRETTY_FUNCTION__, [NSString stringWithFormat:__VA_ARGS__])

//打印函数所在详细位置
#define DLog(format, ...) do {                                                                          \
fprintf(stderr, "<%s : %d> %s\n",                                           \
[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],  \
__LINE__, __func__);                                                        \
(NSLog)((format), ##__VA_ARGS__);                                           \
fprintf(stderr, "-------\n");                                               \
} while (0)

//打印结构体rect Size Point
#define NSLogRect(rect) NSLog(@"%s x:%.4f, y:%.4f, w:%.4f, h:%.4f", #rect, rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)
#define NSLogSize(size) NSLog(@"%s w:%.4f, h:%.4f", #size, size.width, size.height)
#define NSLogPoint(point) NSLog(@"%s x:%.4f, y:%.4f", #point, point.x, point.y)

#else//DEBUG

#define DLog(format, ...)
#define debugMethod()
#define EWPLog(...) do { } while (0)

#endif//DEBUG

//Notification
#define ShowBarAndChat  @"ShowBarAndChat"

#endif
