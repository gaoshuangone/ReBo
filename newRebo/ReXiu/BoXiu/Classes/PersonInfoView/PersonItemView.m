//
//  PersonItemView.m
//  BoXiu
//
//  Created by tongmingyu on 15-3-17.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import "PersonItemView.h"

@interface PersonItemView()

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIImageView *smallImgView;


@end

@implementation PersonItemView

- (id)initWithFrame:(CGRect)frame title:(NSString *)title smallImg:(UIImage *)smallImg
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        
        self.title = title;
        self.smallImg = smallImg;
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    if (title == nil)
    {
        return;
    }
    
    if (_titleLabel == nil)
    {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.font = [UIFont systemFontOfSize:14.0f];
        _titleLabel.textColor = [CommonFuction colorFromHexRGB:@"454a4d"];
        _titleLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:_titleLabel];
    }
    _titleLabel.text = title;
}
-(void)setViewLine{
    _viewLine = [CommonUtils CommonViewLineWithFrame:CGRectMake(45, 42, SCREEN_WIDTH-45, 0.5)];
    _viewLine.backgroundColor = [CommonFuction colorFromHexRGB:@"cbcbcb"];
    [self addSubview:_viewLine];
}
-(void)setViewLineHid{
    if (_viewLine) {
        _viewLine.hidden = YES;
    }
}
- (void)setSmallImg:(UIImage *)smallImg
{
    _smallImg = smallImg;
    
    if (_smallImgView == nil)
    {
        _smallImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self addSubview:_smallImgView];
    }
    _smallImgView.image = smallImg;
}

- (void)layoutSubviews
{
    _smallImgView.frame = CGRectMake(10, 8, 25, 25);
    _titleLabel.frame = CGRectMake(10+25+10, 14, 60, 15);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
