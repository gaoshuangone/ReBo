//
//  VIPItem.m
//  BoXiu
//
//  Created by andy on 14-10-29.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "VIPItem.h"

@interface VIPItem ()
@property (nonatomic,strong) UILabel *titleLable;
@property (nonatomic,strong) UIImageView *yellowImg;
@property (nonatomic,strong) UIImageView *purpleImg;
@property (nonatomic,strong) UIImageView *hLineImg;
@end

@implementation VIPItem

- (id)initWithFrame:(CGRect)frame title:(NSString *)title isYellow:(BOOL)isYellow isPurple:(BOOL)isPurple
{
    self = [super initWithFrame:frame];
    if (self)
    {
        UIColor *bkColor = [UIColor colorWithWhite:1 alpha:1];
        self.backgroundColor = bkColor;
        
        _titleLable = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLable.font = [UIFont systemFontOfSize:13.0f];
        _titleLable.textColor = [CommonFuction colorFromHexRGB:@"959595"];
        _titleLable.text = title;
        [self addSubview:_titleLable];
        
        if (isYellow)
        {
            _yellowImg = [[UIImageView alloc] initWithFrame:CGRectZero];
            _yellowImg.image = [UIImage imageNamed:@"gouSC"];
            [self addSubview:_yellowImg];
        }
        
        if (isPurple)
        {
            _purpleImg = [[UIImageView alloc] initWithFrame:CGRectZero];
            _purpleImg.image = [UIImage imageNamed:@"gouSC"];
            [self addSubview:_purpleImg];
        }
        
       
        
        _hLineImg = [[UIImageView alloc] initWithFrame:CGRectZero];
        _hLineImg.backgroundColor = [CommonFuction colorFromHexRGB:@"f6f6f6f"];
        _hLineImg.alpha = 0.08;
        [self addSubview:_hLineImg];
    }
    return self;
}

-(void)changeFrameTitle{
    _titleLable.textColor = [CommonFuction colorFromHexRGB:@"454a4d"];
    self.titleLable.frame = CGRectMake(20+25+10, 3, 100, 30);
    if ([_titleLable.text isEqualToString:@"紫色VIP"]) {
      self.hLineImg.frame = CGRectMake(0, self.frame.size.height - 0.5, self.frame.size.width, 0.5);
    }
}
- (void)layoutSubviews
{
    
        
    if (self.isVipType) {
        return;
    }
    
    CGSize size = [CommonFuction sizeOfString:self.titleLable.text maxWidth:200 maxHeight:20 withFontSize:13.0f];
    self.titleLable.frame = CGRectMake(16, (self.frame.size.height - size.height)/2, size.width, size.height);
    
    if (_yellowImg)
    {
        self.yellowImg.frame = CGRectMake(202, (self.frame.size.height - _yellowImg.image.size.height)/2, _yellowImg.image.size.width, _yellowImg.image.size.height);
    }
    
    if (_purpleImg)
    {
        self.purpleImg.frame = CGRectMake(268, (self.frame.size.height - _purpleImg.image.size.height)/2, _purpleImg.image.size.width, _purpleImg.image.size.height);
    }
    
    if (!self.hideHLine)
    {
        self.hLineImg.frame = CGRectMake(0, self.frame.size.height - 0.5, self.frame.size.width, 0.5);
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
