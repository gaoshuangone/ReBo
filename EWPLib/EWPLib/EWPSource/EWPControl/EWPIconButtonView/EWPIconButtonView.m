//
//  EWPIconButtonView.m
//  EWPLib
//
//  Created by andy on 14-9-17.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "EWPIconButtonView.h"
#import "CommonFuction.h"

@interface EWPIconButtonView ()
@property (nonatomic,strong) UILabel *btnTitle;
@property (nonatomic,strong) UIImageView *btnImageView;
@end

@implementation EWPIconButtonView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (id)initWithTitle:(NSString *)title Image:(UIImage *)image
{
    self = [super init];
    if (self)
    {
        _fontSize = 17.0f;
        _spaceOfImageTitle = 5;
        
        _btnTitle = [[UILabel alloc] init];
        _btnTitle.text = title;
        _btnTitle.font = [UIFont systemFontOfSize:21.0f];
        [self addSubview:_btnTitle];
        
        _btnImageView = [[UIImageView alloc] init];
        _btnImageView.image = image;
        [self addSubview:_btnImageView];
        
    }
    return self;
}

- (void)setFontSize:(CGFloat)fontSize
{
    _fontSize = fontSize;
    if (self.btnTitle)
    {
        self.btnTitle.font = [UIFont systemFontOfSize:fontSize];
    }
    [self setNeedsLayout];
}

- (void)setSpaceOfImageTitle:(CGFloat)spaceOfImageTitle
{
    _spaceOfImageTitle = spaceOfImageTitle;
    [self setNeedsLayout];
}

- (void)setTextColor:(UIColor *)textColor
{
    if (self.btnTitle)
    {
        [self.btnTitle setTextColor:textColor];
    }
}

- (void)setBtnIcon:(UIImage *)image
{
    if (self.btnImageView)
    {
        self.btnImageView.image = image;
        //        [self setNeedsLayout];
        //        [self setNeedsDisplay];
    }
}

- (void)layoutSubviews
{
    CGFloat imageWith = self.btnImageView.image.size.width;
    CGFloat imageHeight = self.btnImageView.image.size.height;
    CGSize titleSize  = [CommonFuction sizeOfString:self.btnTitle.text maxWidth:300 maxHeight:480 withFontSize:self.fontSize];
    CGFloat contentWidth = imageWith + self.spaceOfImageTitle + titleSize.width;
    CGFloat contentHeight = imageHeight > titleSize.width? imageHeight : titleSize.height;
    
    CGRect frame = self.frame;
    frame.size.width = frame.size.width > contentWidth ? frame.size.width : contentWidth;
    frame.size.height = frame.size.height > contentHeight ? frame.size.height :contentHeight;
    self.frame = frame;
    
    self.btnImageView.frame = CGRectMake((frame.size.width - contentWidth)/2, (frame.size.height - imageHeight) / 2, imageWith, imageHeight);
    self.btnTitle.frame = CGRectMake(self.btnImageView.frame.origin.x + imageWith + self.spaceOfImageTitle, (frame.size.height - titleSize.height)/2, titleSize.width, titleSize.height);
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
