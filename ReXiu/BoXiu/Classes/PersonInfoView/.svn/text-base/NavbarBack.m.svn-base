//
//  NavbarBack.m
//  BoXiu
//
//  Created by tongmingyu on 15-3-17.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import "NavbarBack.h"

@interface NavbarBack()

@property (nonatomic,strong) EWPButton *backBtn;
@property (nonatomic,strong) EWPButton *rightBtn;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIImageView *sexImgView;

@end

@implementation NavbarBack

- (void)initView:(CGRect)frame
{
    self.backgroundColor = [UIColor clearColor];
    _backBtn = [EWPButton buttonWithType:UIButtonTypeCustom];
    
    __weak typeof(self) weakSelf = self;
    _backBtn.buttonBlock = ^(id sender)
    {
        __strong typeof(self) strongSelf = weakSelf;
        if (strongSelf.backButtonBlock)
        {
            strongSelf.backButtonBlock(sender);
        }
    };
    [_backBtn setImage:[UIImage imageNamed:@"navBack_normal"] forState:UIControlStateNormal];
    _backBtn.frame = CGRectMake(0, -5, 50, frame.size.height);
    [self addSubview:_backBtn];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _titleLabel.textColor = [CommonFuction colorFromHexRGB:@"454a4d"];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    _titleLabel.font = [UIFont systemFontOfSize:18.0f];
    [self addSubview:_titleLabel];
    
    _sexImgView = [[UIImageView alloc] init];
    [self addSubview:_sexImgView];
    
    _rightBtn = [EWPButton buttonWithType:UIButtonTypeCustom];
    _rightBtn.buttonBlock = ^(id sender)
    {
        __strong typeof(self) strongSelf = weakSelf;
        if (strongSelf.navRightBtnBlock)
        {
            strongSelf.navRightBtnBlock(sender);
        }
    };

    [self addSubview:_rightBtn];
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    if (title)
    {
        _titleLabel.text = title;
    }
   [self setNeedsLayout];
}


- (void)setRightImg:(UIImage *)rightImg
{
    _rightImg = rightImg;
    if (rightImg)
    {
        [_rightBtn setImage:rightImg forState:UIControlStateNormal];
        _rightBtn.frame = CGRectMake(SCREEN_WIDTH - 40, 4 , rightImg.size.width + 10-5, rightImg.size.height + 10);
    }
}

- (void)setSexImg:(UIImage *)sexImg
{
    _sexImg = sexImg;
    _sexImgView.image = sexImg;
    
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    NSInteger width = 18;
    
    if (_title)
    {
        CGSize nickSize = [CommonFuction sizeOfString:_title maxWidth:200 maxHeight:20 withFontSize:18.0f];
        width += nickSize.width;
        
        CGFloat xPos = (self.frame.size.width -  90 - width)/2;
        _titleLabel.frame = CGRectMake((SCREEN_WIDTH-nickSize.width)/2, (self.frame.size.height - nickSize.height)/2-5, nickSize.width, nickSize.height);
        
        if (_sexImg)
        {
            _sexImgView.frame = CGRectMake(_titleLabel.frame.origin.x + _titleLabel.frame.size.width + 5, (self.frame.size.height - 13)/2, 13, 13);
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
