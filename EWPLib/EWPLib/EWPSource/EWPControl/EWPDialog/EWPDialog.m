//
//  EWPDialog.m
//  BoXiu
//
//  Created by andy on 14-5-13.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "EWPDialog.h"
#import "CommonFuction.h"
#import "MacroMethod.h"

@interface EWPDialog ()
@property (nonatomic,strong) UIImageView *backImgView;
@property (nonatomic,strong) UIControl *backView;
@property (nonatomic,strong) UILabel *titleLable;
@property (nonatomic,strong) UILabel *messageLable;
@property (nonatomic,strong) UIView *parentView;
@property (nonatomic,strong) UIButton *closeBtn;//默认隐藏，
@property (nonatomic,copy)   ButtonBlock leftBtnBlock;
@property (nonatomic,copy)   ButtonBlock rightBtnBlock;

@end

@implementation EWPDialog

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.maskValue = 0.5;
    }
    return self;
}

- (id)initWithTitle:(NSString *)title message:(NSString *)message parentView:(UIView *)parentView
{
    self = [super initWithFrame:CGRectZero];
    if (self)
    {
        CGFloat dialogWidth = 253;
        if (message && [message length])
        {
            CGSize messageSize = [CommonFuction sizeOfString:message maxWidth:(dialogWidth - 40) maxHeight:960 withFontSize:15.0f];
            self.frame = CGRectMake((SCREEN_WIDTH - 253)/2, (SCREEN_HEIGHT - (messageSize.height + 100))/2, 253, (messageSize.height + 100));
        }
        else
        {
            self.frame = CGRectMake((SCREEN_WIDTH - 253)/2, (SCREEN_HEIGHT - 132)/2, 253, 132);
        }
        
        _backImgView  = [[UIImageView  alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _backView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_backImgView];
        
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeBtn setBackgroundImage:[UIImage imageNamed:@"dialogCloseBtn_normal.png"] forState:UIControlStateNormal];
        [_closeBtn setBackgroundImage:[UIImage imageNamed:@"diaologCloseBtn_selected.png"] forState:UIControlStateHighlighted];
        [_closeBtn addTarget:self action:@selector(hideDialog) forControlEvents:UIControlEventTouchUpInside];
        _closeBtn.hidden = YES;
        [self addSubview:_closeBtn];
        
        if (title && [title length] > 0)
        {
            _titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, self.frame.size.width, 30)];
            _titleLable.text = title;
            _titleLable.font = [UIFont boldSystemFontOfSize:17.0f];
            _titleLable.textColor = [UIColor redColor];
            _titleLable.textAlignment = NSTextAlignmentCenter;
            [self addSubview:_titleLable];
        }

        if (message && [message length] > 0)
        {
            _messageLable = [[UILabel alloc] initWithFrame:CGRectZero];
            _messageLable.text = message;
            _messageLable.textColor = [UIColor lightGrayColor];
            _messageLable.font = [UIFont systemFontOfSize:15.0f];
            _messageLable.textAlignment = NSTextAlignmentCenter;
            _messageLable.lineBreakMode = NSLineBreakByWordWrapping;
            _messageLable.numberOfLines = 0;
            [self addSubview:_messageLable];
        }
        self.parentView = [UIApplication sharedApplication].keyWindow;
//        self.parentView = parentView;
        
        _backTouchHide = YES;

    }
    return self;

}

- (void)setTitleColor:(UIColor *)titleColor
{
    if (self.titleLable)
    {
        self.titleLable.textColor = titleColor;
    }
}

- (void)setMessageColor:(UIColor *)messageColor
{
    if (self.messageLable)
    {
        self.messageLable.textColor = messageColor;
    }
}

- (void)setHideCloseBtn:(BOOL)hideCloseBtn
{
    _hideCloseBtn = hideCloseBtn;
    if (self.closeBtn)
    {
        self.closeBtn.hidden = hideCloseBtn;
    }
}

- (void)setLeftBtnTitle:(NSString *)leftBtnTitle normalImg:(UIImage *)normalImg selectedImg:(UIImage *)selectedImg buttonBlock:(ButtonBlock)buttonBlock
{
    if (leftBtnTitle && buttonBlock)
    {
        self.leftBtnBlock = buttonBlock;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 1;
        button.titleLabel.font = [UIFont systemFontOfSize:15.0f];
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

- (void)setRightBtnTitle:(NSString *)rightBtnTitle normalImg:(UIImage *)normalImg selectedImg:(UIImage *)selectedImg buttonBlock:(ButtonBlock)buttonBlock
{
    if (rightBtnTitle && buttonBlock)
    {
        self.rightBtnBlock = buttonBlock;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 2;
        button.titleLabel.font = [UIFont systemFontOfSize:15.0f];
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

- (void)show
{
    if (self.dialogBKImage)
    {
        self.backImgView.image = [self.dialogBKImage stretchableImageWithLeftCapWidth:5 topCapHeight:5];
    }
    
    _backView = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, self.parentView.frame.size.width, self.parentView.frame.size.height)];
    _backView.backgroundColor = [UIColor blackColor];
    _backView.alpha = 0.1;
    if(self.backTouchHide)
        [_backView addTarget:self action:@selector(hideDialog) forControlEvents:UIControlEventTouchUpInside];
    [self.parentView addSubview:_backView];
    
    [self.parentView addSubview:self];
}

- (void)hideDialog
{
    if (_backView)
    {
         [_backView removeFromSuperview];
    }
   
    [self removeFromSuperview];
}

- (void)OnClick:(id)sender
{
    UIButton *button = (UIButton *)sender;
    if (button.tag == 1)
    {
        if (self.leftBtnBlock)
        {
            self.leftBtnBlock(sender);
            [self hideDialog];
        }
    }
    else
    {
        if (self.rightBtnBlock)
        {
            self.rightBtnBlock(sender);
            [self hideDialog];
        }
    }
}

- (void)layoutSubviews
{
     CGRect frame = self.frame;
    CGFloat nYOffset = 2;
    CGFloat contentHeight = frame.size.height - 50;
    
    if (!self.closeBtn.hidden)
    {
        self.closeBtn.frame = CGRectMake(self.frame.size.width - 37 - 2, nYOffset, 37, 37);
        nYOffset += 37;
        contentHeight -= 37;
    }
    
    if (self.titleLable)
    {
        self.titleLable.frame = CGRectMake(0, nYOffset, self.frame.size.width, 30);
        nYOffset += 30;
        contentHeight -= 30;
    }

    
    if (self.messageLable)
    {
        CGSize messageSize = [CommonFuction sizeOfString:self.messageLable.text maxWidth:(frame.size.width - 40) maxHeight:960 withFontSize:15.0f];
        self.messageLable.frame = CGRectMake((frame.size.width - messageSize.width)/2, nYOffset + (contentHeight - messageSize.height)/2, messageSize.width, messageSize.height);
    }
    
    if (self.leftBtnBlock && self.rightBtnBlock)
    {
        UIButton *leftBtn = (UIButton *)[self viewWithTag:1];
        int space = (frame.size.width - 77 * 2)/3;
        
        leftBtn.frame = CGRectMake(space,frame.size.height - 50, 77, 29);
        
        UIButton *rightBtn = (UIButton *)[self viewWithTag:2];
        rightBtn.frame = CGRectMake(space * 2 + 77, frame.size.height - 50, 77, 29);
    }
    else if (self.leftBtnBlock)
    {
        int space = (frame.size.width - 77 )/2;
        UIButton *leftBtn = (UIButton *)[self viewWithTag:1];
        leftBtn.frame = CGRectMake(space,frame.size.height - 50, 77, 29);
    }
    else
    {
         int space = (frame.size.width - 77 )/2;
        UIButton *rightBtn = (UIButton *)[self viewWithTag:1];
        rightBtn.frame = CGRectMake(space,frame.size.height - 50, 77, 29);
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
