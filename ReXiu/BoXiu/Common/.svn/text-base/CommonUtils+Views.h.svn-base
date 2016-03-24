//
//  CommonUtils+Views.h
//  CommonUtils
//
//  Created by gs on 15/1/22.
//  Copyright (c) 2015年 gaos. All rights reserved.
//

#import "CommonUtils.h"

@interface CommonUtils (Views)

//############################设置UIView#############################################################################################

/*
 返回一条线，主要用作填充tableView上的颜色
 */
+(UIView*)CommonViewLineWithFrame:(CGRect)frame;

//############################设置UIButton#############################################################################################

/*
 UIBarButtonItem返回
 */
+(UIBarButtonItem*)commonButtonItemWithTarget:(id)target withAction:(SEL)action withImageNameIndex:(NSInteger)index;
/*
 隐藏的button，主要用作点击响应
 */
+(UIButton*)commonButtonWithFrame:(CGRect)frame withTarget:(id)target withAction:(SEL)action;
/*
 固定尺寸的button
 */
+(UIButton*)commonButNormalWithFrame:(CGRect)frame withBounds:(CGSize)bounds withOriginX:(CGFloat)x withOriginY:(CGFloat)y isRelativeCoordinate:(BOOL)isRC withTarget:(id)target withAction:(SEL)action;
/*
 调整button属性
 */
+(void)commonButSetWithButton:(UIButton*)button WithImageName:(NSString*)imageName withTitle:(NSString*)title withFontSize:(NSInteger)size withColor:(UIColor*)color;

//############################设置标签文字############################################################################################
/*
 只返回一行的label
 isRelativeCoordinate：是否是相对坐标（即加上自身的Wide，Hight的一半）
 */
+(UILabel *)commonSignleLabelWithText:(NSString*)text withFontSize:(CGFloat)fontSize withOriginX:(CGFloat)x withOriginY:(CGFloat)y isRelativeCoordinate:(BOOL)isRC;
/*
 返回多行的label
 相对坐标（即加上自身的Wide，Hight的一半）
 */
+(UILabel *)commonMoreLabelWithText:(NSString*)text withFontSize:(CGFloat)fontSize withBoundsWide:(CGFloat)boundsWide withOriginX:(CGFloat)x withOriginY:(CGFloat)y;







+(float)getLabelHeight:(NSString *)text width:(float)width font:(UIFont *)font;
@end


