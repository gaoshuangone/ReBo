//
//  MoreGIftAnimationView.m
//  BoXiu
//
//  Created by tongmingyu on 14-12-22.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "MoreGIftAnimationView.h"
#import "UIImageView+WebCache.h"

@interface MoreGIftAnimationView ()

@property (nonatomic,strong) UIImageView *giftImgView;
@property (nonatomic,strong) UIImageView *batchLineImg;
@property (nonatomic,strong) UILabel *msglabel;

@property (nonatomic,strong) NSTimer *timer;

@end

@implementation MoreGIftAnimationView

- (void)initView:(CGRect)frame
{
    self.backgroundColor = [UIColor clearColor];
    
    UIImageView *bkGiftImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 1, 58, 58)];
    bkGiftImgView.image = [UIImage imageNamed:@"batchGift"];
    [self addSubview:bkGiftImgView];
    
    _giftImgView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 8, 40, 40)];
    [bkGiftImgView addSubview:_giftImgView];
    
    _batchLineImg = [[UIImageView alloc] initWithFrame:CGRectMake(50, 13, 184, 36)];
    _batchLineImg.image = [UIImage imageNamed:@"batchLine"];
    [self addSubview:_batchLineImg];
    
    _msglabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 20, 170, 20)];
    _msglabel.font = [UIFont systemFontOfSize:13.0f];
    _msglabel.textColor = [UIColor whiteColor];
    _msglabel.textAlignment = NSTextAlignmentCenter;
    _msglabel.backgroundColor = [UIColor clearColor];
    [self addSubview:_msglabel];
    [self bringSubviewToFront:bkGiftImgView];
}

- (void)startAnimationWithMessage:(NSString *)message giftUrl:(NSString *)giftUrl animationComplete:(GiftAnimationComplete)animationComplete
{
    if (message && giftUrl && animationComplete)
    {
        self.animationComplete = animationComplete;
        
        [_giftImgView sd_setImageWithURL:[NSURL URLWithString:giftUrl] placeholderImage:nil];
        _msglabel.text = message;
        [self addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
        
        _timer = [NSTimer timerWithTimeInterval:0.015 target:self selector:@selector(changeFrame) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
        [_timer fire];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"frame"])
    {
        if (!_isExceedLocation)
        {
            _isExceedLocation = [self checkExceedLocation:self.fixedLocation];
        }
        
        BOOL commpleteState = [self checkExceedLocation:CGPointMake(0,0)];
        if (commpleteState)
        {
            [self.timer invalidate];
            [self removeObserver:self forKeyPath:@"frame" context:nil];
            self.animationComplete();
        }
    }
}

- (BOOL)checkExceedLocation:(CGPoint)location
{
    BOOL exceedLocation = NO;
    CGRect frame = self.frame;
    if (location.y >= frame.origin.y)
    {
        exceedLocation = YES;
    }
    
    return exceedLocation;
}


- (void)changeFrame
{
    CGRect frame = self.frame;
    frame.origin.y -= 1;
    self.frame = frame;
}
@end
