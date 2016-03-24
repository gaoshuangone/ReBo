//
//  EWPActivityIndicatorView.m
//  EWPActivityIndicatorView
//
//  Created by Andy on 13-11-19.
//  Copyright (c) 2013年 jiangbin. All rights reserved.
//

#import "EWPActivityIndicatorView.h"

#define Default_PromptTitle @"正在加载数据..."

@interface EWPActivityIndicatorView ()

@property (nonatomic,strong) UIActivityIndicatorView *activityIndicatorView;
@property (nonatomic,strong) UILabel *promptTitleLable;
@property (nonatomic,strong) NSTimer *timer;
@end
@implementation EWPActivityIndicatorView

- (id)initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyle)style
{
    self = [super init];
    if (self) {
        // Initialization code

//        self.backgroundColor = [UIColor clearColor];
        self.opaque = NO;
        
//        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake((self.frame.size.width - 80)/2, (self.frame.size.height - 80)/2, 80, 80)];
//        backView.center = self.center;
//        backView.backgroundColor = [UIColor blackColor];
//        backView.alpha = 0.0;
//        backView.layer.cornerRadius = 0.5;
//        [self addSubview:backView];
        _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectZero];
        _activityIndicatorView.activityIndicatorViewStyle = style;
        [self addSubview:_activityIndicatorView];
        
//        _timer = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(loadFail) userInfo:nil repeats:NO];
    }
    return self;
}

- (void)layoutSubviews
{
    _activityIndicatorView.frame = CGRectMake((self.frame.size.width - 60)/2, (self.frame.size.height - 60)/2, 60, 60);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)setPromptTitle:(NSString *)promptTitle
{
    self.promptTitleLable.text = promptTitle;
}

- (void)startAnimating
{
    // adding it as subview of app's UIWindow

    [_activityIndicatorView startAnimating];
}

- (void)stopAnimating
{
    if (_timer)
    {
        [_timer invalidate];
    }
    
    [_activityIndicatorView stopAnimating];
    [self removeFromSuperview];
}

- (void)loadFail
{
    [self performSelector:@selector(stopAnimating) withObject:nil afterDelay:3];
}
@end
