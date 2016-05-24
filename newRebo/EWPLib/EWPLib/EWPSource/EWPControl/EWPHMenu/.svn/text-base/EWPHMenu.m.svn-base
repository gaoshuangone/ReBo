//
//  EWPHMenu.m
//  BoXiu
//
//  Created by andy on 14-10-25.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "EWPHMenu.h"

@interface EWPHMenu ()
@property (nonatomic,strong) UILabel *titleLable;
@property (nonatomic,strong) UIImageView *arrowImgView;

@property (nonatomic,strong) UIImageView *topLineImg;
@property (nonatomic,strong) UIImageView *endLineImg;
@end

@implementation EWPHMenu

- (id)initWithFrame:(CGRect)frame title:(NSString *)title
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        
        self.titleSize = 14.0f;
        self.titleColor = [CommonFuction colorFromHexRGB:@"575757"];
        self.title = title;
        
        _arrowImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self addSubview:_arrowImgView];
        
        _topLineImg = [[UIImageView alloc] initWithFrame:CGRectZero];
        _topLineImg.backgroundColor = [CommonFuction colorFromHexRGB:@"cbcbcb"];
        [self addSubview:_topLineImg];
        
        _endLineImg = [[UIImageView alloc] initWithFrame:CGRectZero];
        _endLineImg.backgroundColor = [CommonFuction colorFromHexRGB:@"cbcbcb"];
        [self addSubview:_endLineImg];
        
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    if (title)
    {
        if (_titleLable == nil)
        {
            _titleLable = [[UILabel alloc] initWithFrame:CGRectZero];
            _titleLable.font = [UIFont systemFontOfSize:self.titleSize];
            _titleLable.textColor = self.titleColor;
            [self addSubview:_titleLable];
        }
    }
    
    if (_titleLable)
    {
        _titleLable.text = title;
    }
}

- (void)setContentView:(UIView *)contentView
{
    _contentView = contentView;
    if (contentView)
    {
        [self addSubview:_contentView];
    }
}

- (void)setArrowImg:(UIImage *)arrowImg
{
    if (arrowImg && _arrowImgView)
    {
        _arrowImgView.image = arrowImg;
    }
}

- (void)layoutSubviews
{
    _topLineImg.frame = CGRectMake(0, 0, self.frame.size.width, 0.5);
    _endLineImg.frame = CGRectMake(0,self.frame.size.height, self.frame.size.width, 0.5);
    
    if (_titleLable)
    {
        CGSize size = [CommonFuction sizeOfString:self.title maxWidth:100 maxHeight:30 withFontSize:self.titleSize];
        self.titleLable.frame = CGRectMake(10, (self.frame.size.height - size.height)/2, size.width, size.height);
    }
    
    if (_contentView)
    {
        CGRect rect = self.contentView.frame;
        CGFloat nXOffset = 0;
        if (_titleLable && self.title)
        {
            nXOffset = _titleLable.frame.origin.x + _titleLable.frame.size.width;
        }
        self.contentView.frame = CGRectMake(nXOffset + 15, (self.frame.size.height - rect.size.height)/2,rect.size.width, rect.size.height);
    }
    
    if (_arrowImgView)
    {
        CGSize imgSize = self.arrowImgView.image.size;
        self.arrowImgView.frame = CGRectMake(self.frame.size.width - 20 - imgSize.width, (self.frame.size.height - imgSize.height)/2, imgSize.width, imgSize.height);
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
