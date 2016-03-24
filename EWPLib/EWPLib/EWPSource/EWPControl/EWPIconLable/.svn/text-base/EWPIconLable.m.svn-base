//
//  EWPIconLable.m
//  Community
//
//  Created by Andy on 14-6-25.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "EWPIconLable.h"
#import "CommonFuction.h"

@interface EWPIconLable ()

@property (nonatomic,strong) UILabel *titleLable;
@end

@implementation EWPIconLable

- (id)initWithFrame:(CGRect)frame icon:(UIImage *)icon title:(NSString *)title
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.textSize = 14.0f;
        self.textColor = [UIColor blackColor];
        [self initViewWithIcon:icon title:title];
    }
    return self;
}

- (void)initViewWithIcon:(UIImage *)icon title:(NSString *)title
{
    _iconView = [[UIImageView alloc] initWithFrame:CGRectZero];
    if (icon)
    {
        _iconView.image = icon;
    }
    [self addSubview:_iconView];
    
    _titleLable = [[UILabel alloc] initWithFrame:CGRectZero];
    _titleLable.backgroundColor = [UIColor clearColor];
    _titleLable.textColor = self.textColor;
    if (title)
    {
        _titleLable.text = title;
    }
    [self addSubview:_titleLable];
    self.textXOffset = 0;
}

- (void)setTextSize:(CGFloat)textSize
{
    _textSize = textSize;
    if (self.titleLable)
    {
        self.titleLable.font = [UIFont systemFontOfSize:textSize];
    }
}
- (void)SetTitle:(NSString *)title icon:(UIImage *)icon
{
    if (_titleLable)
    {
        _titleLable.text = title;
    }
    
    if (_iconView)
    {
        _iconView.image = icon;
    }
}

- (void)SetTitle:(NSString *)title
{
    [self SetTitle:title icon:_iconView.image];
}

- (void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    if (self.titleLable)
    {
        self.titleLable.textColor = textColor;
    }
}

- (void)layoutSubviews
{
    CGFloat nXOffset = 0;
    if (self.iconView.image)
    {
        
        self.iconView.frame = CGRectMake(nXOffset, (self.frame.size.height - self.iconView.image.size.height)/2,self.iconView.image.size.width, self.iconView.image.size.height);
        nXOffset += self.iconView.image.size.width;

    }
    nXOffset += self.textXOffset;
    
    if (self.titleLable.text)
    {
        CGSize size =  [CommonFuction sizeOfString:self.titleLable.text maxWidth:320 maxHeight:640 withFontSize:_textSize];
        self.titleLable.frame = CGRectMake(nXOffset, (self.frame.size.height - size.height)/2, self.frame.size.width - nXOffset, size.height);
    }
   
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
