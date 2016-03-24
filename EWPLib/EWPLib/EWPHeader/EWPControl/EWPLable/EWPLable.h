//
//  EWPLable.h
//  MemberMarket
//
//  Created by andy on 13-11-27.
//  Copyright (c) 2013年 yiwopai. All rights reserved.
//

#import <UIKit/UIKit.h>

/**扩展uilable，内部实现基于CoreText*/
@interface EWPLable : UIView

/*lable内容*/
@property (nonatomic,strong) NSString *content;
/*内容颜色，默认黑色*/
@property (nonatomic,strong) UIColor *contentColor;

/*设置字体*/
@property (nonatomic,strong) UIFont *contentFont;

/*行间距，默认为8*/
@property (nonatomic,assign) CGFloat lineSpace;

/*对其方式*/
@property (nonatomic,assign) NSTextAlignment contentAlignment;

/*返回高度*/
- (CGFloat)heightForContentByWidth:(CGFloat) width;

@end
