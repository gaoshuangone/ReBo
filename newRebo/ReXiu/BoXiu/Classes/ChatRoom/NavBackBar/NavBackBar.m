//
//  NavBackBar.m
//  BoXiu
//
//  Created by andy on 15-3-12.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import "NavBackBar.h"

@interface NavBackBar ()
@property (nonatomic,strong) EWPButton *backBtn;
@property (nonatomic,strong) UILabel *titleLabel;
@end

@implementation NavBackBar

- (void)initView:(CGRect)frame
{
    self.backgroundColor = [UIColor blackColor];
    self.alpha = 0.7;
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
    _backBtn.frame = CGRectMake(5, 0, 40, 40);
    [self addSubview:_backBtn];
    
    CGFloat xPos = _backBtn.frame.origin.x + _backBtn.frame.size.width;
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(xPos, 0, frame.size.width - 2 * xPos, frame.size.height)];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [self addSubview:_titleLabel];
}

- (void)setTitle:(NSString *)title
{
    if (title)
    {
        _titleLabel.text = title;
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
