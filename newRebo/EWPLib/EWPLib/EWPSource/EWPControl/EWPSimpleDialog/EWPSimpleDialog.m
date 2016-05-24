//
//  EWPSimpleDialog.m
//  EWPLib
//
//  Created by Andy on 14-9-3.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "EWPSimpleDialog.h"
#import "EWPFramework.h"

@interface EWPSimpleDialog ()
@property (nonatomic,strong) UIView *backView;
@end
@implementation EWPSimpleDialog

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _backGroundAlpha = 0.2;
       
    }
    return self;
}

- (void)showInWindow
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [self showInView:keyWindow];
}

- (void)showInView:(UIView *)view
{
    _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
    _backView.backgroundColor = [UIColor blackColor];
    _backView.alpha = _backGroundAlpha;
    
    CGRect frame = self.frame;
    frame.origin.y = (view.frame.size.height - frame.size.height)/2;
    frame.origin.x = (view.frame.size.width - frame.size.width)/2;
    self.frame = frame;
    
    [view addSubview:_backView];
    [view addSubview:self];
}

- (void)showInView:(UIView *)view withColor:(UIColor*)color withAlpha:(CGFloat)alpha{

    _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
    _backView.backgroundColor = color;
    _backView.alpha = alpha;
    
    CGRect frame = self.frame;
    frame.origin.y = (view.frame.size.height - frame.size.height)/2;
    frame.origin.x = (view.frame.size.width - frame.size.width)/2;
    self.frame = frame;
    
    [view addSubview:_backView];
    [view addSubview:self];
}
- (void)hide
{
    [_backView removeFromSuperview];
    [self removeFromSuperview];
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
