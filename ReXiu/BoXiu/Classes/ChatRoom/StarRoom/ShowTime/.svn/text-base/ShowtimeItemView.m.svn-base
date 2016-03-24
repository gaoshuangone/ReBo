//
//  ShowtimeItemView.m
//  BoXiu
//
//  Created by tongmingyu on 15-1-28.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import "ShowtimeItemView.h"


@interface ShowtimeItemView ()

@property (nonatomic,strong) UIImageView *praiseImgView;
@property (nonatomic,strong) UIView *backView;
@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic,strong) UIView *praiseInfoView;

@end

@implementation ShowtimeItemView

- (id)initShowTimeWithFrame:(CGRect)frame title:(NSString *)title praiseImgName:(NSString *)praiseImgName
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.layer.masksToBounds = YES;
        _animateWithDuration = 0.5;
        
        _praiseImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _praiseImgView.image = [UIImage imageNamed:praiseImgName];
        [self addSubview:_praiseImgView];
        
        _backView = [[UIView alloc] initWithFrame:CGRectZero];
        _backView.alpha = 0.4f;
        _backView.layer.masksToBounds = YES;
        [_backView.layer setCornerRadius:14.0f];
        _backView.backgroundColor = [UIColor blackColor];
        [self addSubview:_backView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.text = title;
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont boldSystemFontOfSize:11.0f];
        _titleLabel.text = title;
        [self addSubview:_titleLabel];
        
    }
    return self;
}


- (void)layoutSubviews
{
    _praiseImgView.frame = CGRectMake(0, 0, 28, 28);
    _backView.frame = CGRectMake(28, 0, self.frame.size.width-28, 28);
    CGSize size = [CommonFuction sizeOfString:self.titleLabel.text maxWidth:70 maxHeight:20 withFontSize:11.0f];
    _titleLabel.frame = CGRectMake(35, 4, size.width, 20);
}

- (UIView *)praiseInfoViewWithNick:(NSString *)nick praiseNum:(NSInteger)praiseNum
{
    UIView *praiseInfoView = [[UIView alloc] initWithFrame:CGRectMake(70, 0, 200, self.frame.size.height)];
    praiseInfoView.backgroundColor = [UIColor clearColor];
    
    UILabel *nickLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 4, 110, 20)];
    nickLabel.tag = 100;
    nickLabel.text = nick;
    nickLabel.textColor = [UIColor whiteColor];
    if (self.needBold)
    {
        nickLabel.font = [UIFont boldSystemFontOfSize:11.0f];
    }
    else
    {
        nickLabel.font = [UIFont systemFontOfSize:11.0f];
    }
    
    [praiseInfoView addSubview:nickLabel];
    
    UILabel *praiseNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(115, 4, 70, 20)];
    praiseNumLabel.tag = 101;
    if(praiseNum == 0)
    {
        praiseNumLabel.text = @"";
    }
    else
    {
        praiseNumLabel.text = [NSString stringWithFormat:@"%d",praiseNum];
    }
    
    praiseNumLabel.textColor = [UIColor whiteColor];
    praiseNumLabel.textAlignment = NSTextAlignmentRight;
    if (self.needBold)
    {
        praiseNumLabel.font = [UIFont boldSystemFontOfSize:11.0f];
    }
    else
    {
        praiseNumLabel.font = [UIFont systemFontOfSize:11.0f];
    }
    
    [praiseInfoView addSubview:praiseNumLabel];
    
    return praiseInfoView;
}

- (void)setNick:(NSString *)nick praiseNum:(NSInteger)praiseNum
{
    if (_praiseInfoView == nil)
    {
        _praiseInfoView = [self praiseInfoViewWithNick:nick praiseNum:praiseNum];
        [_backView addSubview:_praiseInfoView];
    }
    else
    {
        UILabel *nickLable = (UILabel *)[_praiseInfoView viewWithTag:100];
        
        
        UILabel *praiseNumLabel = (UILabel *)[_praiseInfoView viewWithTag:101];
        if(praiseNum == 0 && nick == nil)
        {
            nickLable.text = @"";
            praiseNumLabel.text = @"";
        }
        else
        {
            nickLable.text = nick;
            praiseNumLabel.text = [NSString stringWithFormat:@"%d",praiseNum];
        }
    }
}

- (void)updateNick:(NSString *)nick praiseNum:(NSInteger)praiseNum
{
    if (nick)
    {
        UIView *newPraiseInfoView = [self praiseInfoViewWithNick:nick praiseNum:praiseNum];
        
        CGRect frame = newPraiseInfoView.frame;
        frame.origin.y = self.frame.size.height;
        newPraiseInfoView.frame = frame;
        [_backView addSubview:newPraiseInfoView];
        
        [UIView animateWithDuration:_animateWithDuration delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            CGRect rect = _praiseInfoView.frame;
            rect.origin.y = -self.frame.size.height;
            _praiseInfoView.frame = rect;
            
            rect = newPraiseInfoView.frame;
            rect.origin.y = 0;
            newPraiseInfoView.frame = rect;

        } completion:^(BOOL finished) {
            [_praiseInfoView removeFromSuperview];
            _praiseInfoView = newPraiseInfoView;
        }];
    
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
