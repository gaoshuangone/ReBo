//
//  IconButton.m
//  ZSMagazine
//
//  Created by andy on 13-9-28.
//  Copyright (c) 2013年 woyipai. All rights reserved.
//

#import "IconButton.h"

@implementation IconButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.space = 5;
    }
    return self;
}

+ (IconButton *)ButtonWithTitle:(NSString *)buttonTitle normalIcon:(UIImage *)normalIcon selectedIcon:(UIImage *)selectedIcon
{
    IconButton *button = [IconButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectZero;
    button.backgroundColor = [UIColor clearColor];
    [button setTitle:buttonTitle forState:UIControlStateNormal];
    [button setImage:normalIcon forState:UIControlStateNormal];
    [button setImage:selectedIcon forState:UIControlStateHighlighted];
    return button;
}

- (void)setButtonIcon:(UIImage *)icon
{
    if (icon)
    {
        [self setBackgroundImage:icon forState:UIControlStateNormal];
    }
}

- (void)setButtonTitle:(NSString *)buttonTitle
{
    if (buttonTitle) {
        [self setTitle:buttonTitle forState:UIControlStateNormal];
    }
}


- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    return CGRectMake(0, 0, CGRectGetHeight(contentRect),CGRectGetHeight(contentRect));
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(CGRectGetHeight(contentRect) + self.space, 0,
                      CGRectGetWidth(contentRect) - CGRectGetHeight(contentRect),
                      CGRectGetHeight(contentRect));
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
