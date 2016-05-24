//
//  CustomMethod.h
//  MessageList
//
//  Created by 刘超 on 13-11-13.
//  Copyright (c) 2013年 刘超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RegexKitLite.h"
#import "OHAttributedLabel.h"
#import "SCGIFImageView.h"

@interface CustomMethod : NSObject

+ (NSString *)escapedString:(NSString *)oldString;

+ (void)drawImage:(OHAttributedLabel *)label;

+ (void)drawImage:(OHAttributedLabel *)label isAlpha:(BOOL)isAlpha;

+ (NSArray *)addHttpArr:(NSString *)text;

+ (NSArray *)addPhoneNumArr:(NSString *)text;

+ (NSArray *)addEmailArr:(NSString *)text;

+ (NSArray *)addLocalImageArr:(NSString *)text;//[]分隔符

+ (NSArray *)addWebImageArr:(NSString *)text;//<>分隔符

+ (NSArray *)addLinkArr:(NSString *)text;//{}分隔符

/**
 *  查找以指定开始字符开始，指定字符结束的字符串
 *
 *  @param text       原始字符串
 *  @param beginFlage 开始字符标识
 *  @param endFlag    结束字符标识
 *
 *  @return 数组
 */
+ (NSArray *)addObjectArr:(NSString *)text beginFlage:(NSString *)beginFlage endFlag:(NSString *)endFlag;

+ (NSString *)transFormStringToLocalImage:(NSString *)originalStr localImgDic:(NSDictionary *)localImgDic;

+ (NSString *)transformStringToWebImage:(NSString *)originalStr imgSize:(CGSize)imgSize;

+ (NSString *)replaceUserIdWithUserName:(NSString *)originalStr chatMemberDic:(NSDictionary *)_chatMemberDic outParam:(NSMutableArray *)outParam;
@end
