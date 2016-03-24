//
//  RXAlertView.m
//  BoXiu
//
//  Created by andy on 14-10-20.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "RXAlertView.h"
#import "CommonFuction.h"

@interface RXAlertView ()
@property (nonatomic,strong) UILabel *titleLable;
@property (nonatomic,strong) UILabel *messageLable;

@property (nonatomic,copy)   RXAlertViewBtnBlock leftBtnBlock;
@property (nonatomic,copy)   RXAlertViewBtnBlock rightBtnBlock;

@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *message;
@end

@implementation RXAlertView

- (id)initWithFrame:(CGRect)frame title:(NSString *)title message:(NSString *)message
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.layer.borderColor = [UIColor whiteColor].CGColor;
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 4.0f;
        self.layer.borderWidth = 1.0f;
        self.backGroundAlpha = 0.5;
        self.title = title;
        self.message = message;
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
            _titleLable.font = [UIFont boldSystemFontOfSize:18.0f];
            _titleLable.textColor = [CommonFuction colorFromHexRGB:@"343a36"];
            _titleLable.textAlignment = NSTextAlignmentCenter;
            [self addSubview:_titleLable];
        }
        _titleLable.text = title;
    }
}

- (void)setMessage:(NSString *)message
{
    _message = message;
    if (message)
    {
        if (_messageLable == nil)
        {
            _messageLable = [[UILabel alloc] initWithFrame:CGRectZero];
            _messageLable.font = [UIFont systemFontOfSize:15.0f];
            _messageLable.textColor = [CommonFuction colorFromHexRGB:@"575757"];
            _messageLable.lineBreakMode = NSLineBreakByWordWrapping;
            _messageLable.numberOfLines = 0;
            [self addSubview:_messageLable];
        }
        _messageLable.text = message;
    }
}

- (void)setLeftBtnTitle:(NSString *)leftBtnTitle normalImg:(UIImage *)normalImg selectedImg:(UIImage *)selectedImg buttonBlock:(RXAlertViewBtnBlock)buttonBlock
{
    if (leftBtnTitle && buttonBlock)
    {
        self.leftBtnBlock = buttonBlock;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 1;
        button.titleLabel.font = [UIFont systemFontOfSize:18.0f];
        button.backgroundColor = [CommonFuction colorFromHexRGB:@"d14c49"];

        if (normalImg && [normalImg isKindOfClass:[UIImage class]])
        {
            [button setBackgroundImage:normalImg forState:UIControlStateNormal];
        }
        
        if (selectedImg && [selectedImg isKindOfClass:[UIImage class]])
        {
            [button setBackgroundImage:selectedImg forState:UIControlStateHighlighted];
        }
        
        if (leftBtnTitle)
        {
            [button setTitle:leftBtnTitle forState:UIControlStateNormal];
        }
        
        [button addTarget:self action:@selector(OnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
}

- (void)setRightBtnTitle:(NSString *)rightBtnTitle normalImg:(UIImage *)normalImg selectedImg:(UIImage *)selectedImg buttonBlock:(RXAlertViewBtnBlock)buttonBlock
{
    if (rightBtnTitle && buttonBlock)
    {
        self.rightBtnBlock = buttonBlock;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 2;
        button.titleLabel.font = [UIFont systemFontOfSize:18.0f];
        button.backgroundColor = [CommonFuction colorFromHexRGB:@"d14c49"];
        if (normalImg && [normalImg isKindOfClass:[UIImage class]])
        {
            [button setBackgroundImage:normalImg forState:UIControlStateNormal];
        }
        
        if (selectedImg && [selectedImg isKindOfClass:[UIImage class]])
        {
            [button setBackgroundImage:selectedImg forState:UIControlStateHighlighted];
        }
        
        if (rightBtnTitle)
        {
            [button setTitle:rightBtnTitle forState:UIControlStateNormal];
        }
        [button addTarget:self action:@selector(OnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
}

- (void)OnClick:(id)sender
{
    UIButton *button = (UIButton *)sender;
    if (button.tag == 1)
    {
        if (self.leftBtnBlock)
        {
            self.leftBtnBlock(sender);
            [self hide];
        }
    }
    else
    {
        if (self.rightBtnBlock)
        {
            self.rightBtnBlock(sender);
            [self hide];
        }
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat nYOffset = 0;
    if (_titleLable)
    {
        _titleLable.frame = CGRectMake(0, 21, self.frame.size.width, 20);
        nYOffset = _titleLable.frame.origin.y + _titleLable.frame.size.height;
        nYOffset += 10;//间距
    }
    else
    {
        nYOffset += 20;
    }

    if (_messageLable)
    {
        CGSize messageSize = [CommonFuction sizeOfString:self.message maxWidth:self.frame.size.width - 34 * 2 maxHeight:self.frame.size.height withFontSize:15.0f];
        _messageLable.frame = CGRectMake((self.frame.size.width  - messageSize.width)/2, nYOffset, messageSize.width, messageSize.height);
        nYOffset += messageSize.height;
        nYOffset += 20;//间距
    }
    

    
    if (self.leftBtnBlock && self.rightBtnBlock)
    {
        UIButton *leftBtn = (UIButton *)[self viewWithTag:1];
        int space = (self.frame.size.width - 114 * 2)/3;
        
        leftBtn.frame = CGRectMake(space,self.frame.size.height - 50, 114, 38);
        
        UIButton *rightBtn = (UIButton *)[self viewWithTag:2];
        rightBtn.frame = CGRectMake(space * 2 + 114, self.frame.size.height - 50, 114, 38);
    }
    else if (self.leftBtnBlock)
    {
        int space = (self.frame.size.width - 114 )/2;
        UIButton *leftBtn = (UIButton *)[self viewWithTag:1];
        leftBtn.frame = CGRectMake(space,self.frame.size.height - 50, 114, 38);
    }
    else
    {
        int space = (self.frame.size.width - 114 )/2;
        UIButton *rightBtn = (UIButton *)[self viewWithTag:1];
        rightBtn.frame = CGRectMake(space,self.frame.size.height - 50, 114, 38);
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
