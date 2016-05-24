//
//  SettingItemView.m
//  BoXiu
//
//  Created by andy on 14-10-21.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "SettingItemView.h"

@interface SettingItemView ()
@property (nonatomic,strong) UILabel *titleLable;
@property (nonatomic,strong) UILabel *contentLable;

@property (nonatomic,strong) UIColor *titleColor;
@property (nonatomic,strong) UIColor *contentColor;

@property (nonatomic,strong) UIImageView *topLineImg;
@property (nonatomic,strong) UIImageView *endLineImg;

@property (nonatomic,strong) UIImageView *arrowImgView;
@end
@implementation SettingItemView

- (id)initWithFrame:(CGRect)frame title:(NSString *)title content:(NSString *)content
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        
        self.title = title;
        self.content = content;
        self.titleColor = [CommonFuction colorFromHexRGB:@"454a4d"];
        self.contentColor = [CommonFuction colorFromHexRGB:@"959596"];
        _enable = YES;
        _arrowImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self addSubview:_arrowImgView];
        
    }
    return self;
}
-(void)setViewLine{
    UIView* view = [CommonUtils CommonViewLineWithFrame:CGRectMake(0, 41, SCREEN_WIDTH, 0.5)];
    view.backgroundColor = [CommonFuction colorFromHexRGB:@"cbcbcb"];
   
    [self addSubview:view];
}
- (void) setContentColor:(UIColor*)color
{
    if (color) {
        _contentColor = color;
    } else {
        _contentColor = [CommonFuction colorFromHexRGB:@"959596"];
    }
    self.contentLable.textColor = _contentColor;
}

- (void) setTitleColor:(UIColor*)color
{
    if (color) {
        _titleColor = color;
    } else {
        _titleColor = [CommonFuction colorFromHexRGB:@"454a4d"];
    }
    self.titleLable.textColor = _titleColor;
}

- (void)setTitle:(NSString *)title
{
    if (title == nil)
    {
        return;
    }
    _title = title;
    if (_titleLable == nil)
    {
        _titleLable = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLable.font = [UIFont systemFontOfSize:14.0f];
        _titleLable.textColor = self.titleColor;
        _titleLable.backgroundColor = [UIColor clearColor];
        [self addSubview:_titleLable];
    }
    _titleLable.text = title;
}

- (void)setContent:(NSString *)content
{
    if (content == nil)
    {
        return;
    }
    
    _content = content;
    if (_contentLable == nil)
    {
        _contentLable = [[UILabel alloc] initWithFrame:CGRectZero];
        _contentLable.font = [UIFont systemFontOfSize:14.0f];
        _contentLable.textColor = self.contentColor;
        _contentLable.textAlignment = NSTextAlignmentRight;
        _contentLable.backgroundColor = [UIColor clearColor];
        [self addSubview:_contentLable];
    }
    _contentLable.text = content;
}

-(void)setArrowImg:(UIImage *)arrowImg
{
    if (arrowImg && _arrowImgView)
    {
        _arrowImgView.image = arrowImg;
    }
}

- (void)setEnable:(BOOL)enable
{
    _enable = enable;
    self.userInteractionEnabled = enable;
    if (enable)
    {
        _titleLable.textColor = self.titleColor;//[CommonFuction colorFromHexRGB:@"575757"];
    }
    else
    {
        _titleLable.textColor = [CommonFuction colorFromHexRGB:@"959596"];
    }
}

- (void)layoutSubviews
{
    if (self.title)
    {
        CGSize size = [CommonFuction sizeOfString:self.title maxWidth:100 maxHeight:20 withFontSize:14.0f];
        _titleLable.frame = CGRectMake(15, (self.frame.size.height - size.height)/2, size.width, size.height);
    }
    
    CGSize imgSize = self.arrowImgView.image.size;
    self.arrowImgView.frame = CGRectMake(self.frame.size.width - 10 - imgSize.width, (self.frame.size.height - imgSize.height)/2, imgSize.width, imgSize.height);
    
    if (self.content)
    {
        
        if (self.isChangeCountFrame) {
            CGSize size = [CommonFuction sizeOfString:self.content maxWidth:100 maxHeight:20 withFontSize:14.0f];
            _contentLable.frame = CGRectMake(self.titleLable.frame.origin.x + self.titleLable.frame.size.width , (self.frame.size.height - size.height)/2, self.arrowImgView.frame.origin.x - self.titleLable.frame.origin.x - self.titleLable.frame.size.width, size.height);
        }else{
            CGSize size = [CommonFuction sizeOfString:self.content maxWidth:100 maxHeight:20 withFontSize:14.0f];
            _contentLable.frame = CGRectMake(self.titleLable.frame.origin.x + self.titleLable.frame.size.width - 10, (self.frame.size.height - size.height)/2, self.arrowImgView.frame.origin.x - self.titleLable.frame.origin.x - self.titleLable.frame.size.width, size.height);
        }
    
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
