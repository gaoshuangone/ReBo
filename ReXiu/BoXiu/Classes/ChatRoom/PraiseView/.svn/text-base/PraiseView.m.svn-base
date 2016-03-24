//
//  PWMainView.m
//  PWProgressView
//
//  Created by Peter Willsey on 1/8/14.
//  Copyright (c) 2014 Peter Willsey. All rights reserved.
//

#import "PraiseView.h"
#import "UserInfoManager.h"

static const CGFloat PWCenterHoleInsetRatio             = 0.15f;
static const CGFloat PWProgressShapeInsetRatio          = 0.03f;
static const CGFloat PWDefaultAlpha                     = 0.45f;
static const CGFloat PWScaleAnimationScaleFactor        = 2.3f;
static const CFTimeInterval PWScaleAnimationDuration    = 0.5;

@interface PraiseView ()

@property (nonatomic, strong) CAShapeLayer *progressShape;

@end


@implementation PraiseView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        if (([UserInfoManager shareUserInfoManager].currentUserInfo.leavecount !=0 && [UserInfoManager shareUserInfoManager].currentUserInfo.getcount == 0)|| ([AppInfo shareInstance].bLoginSuccess && [UserInfoManager shareUserInfoManager].currentStarInfo.onlineflag))
        {

            self.layer.cornerRadius = 5.0f;
            self.clipsToBounds = YES;
            
            self.alpha = PWDefaultAlpha;
            
            self.progressShape = [CAShapeLayer layer];
            self.progressShape.fillColor   = [UIColor clearColor].CGColor;
            self.progressShape.strokeColor = [UIColor blackColor].CGColor;
            
            [self.layer addSublayer:self.progressShape];
        }
        
         [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Praise:)]];
    }
    return self;
}


- (void)layoutSubviews
{
    CGFloat centerHoleInset     = PWCenterHoleInsetRatio * CGRectGetWidth(self.bounds);
    CGFloat progressShapeInset  = PWProgressShapeInsetRatio * CGRectGetWidth(self.bounds);
//        CGFloat diameter = CGRectGetWidth(self.bounds) - (2 * centerHoleInset) - (2 * progressShapeInset)+10;
    CGFloat diameter = CGRectGetWidth(self.bounds) - (2 * centerHoleInset) - (2 * progressShapeInset)+10;
    CGFloat radius = diameter / 2.0f;
    
    self.progressShape.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake((CGRectGetWidth(self.bounds) / 2.0f) - (radius / 2.0f),
                                                                                 (CGRectGetHeight(self.bounds) / 2.0f) - (radius / 2.0f),
                                                                                 radius,
                                                                                 radius)
                                                         cornerRadius:radius].CGPath;
    
    self.progressShape.lineWidth = radius;
}


- (void)setProgress:(float)progress
{
    self.progressShape.strokeStart = progress;
    
    if (_progress == 1.0f && progress < 1.0f)
    {
        [self.progressShape removeAllAnimations];
    }
    
    _progress = [self pinnedProgress:progress];
    
    if (_progress == 1.0f)
    {
        CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnimation.toValue = @(PWScaleAnimationScaleFactor);
        scaleAnimation.duration = PWScaleAnimationDuration;
        scaleAnimation.removedOnCompletion = NO;
        scaleAnimation.autoreverses = NO;
        scaleAnimation.fillMode = kCAFillModeForwards;
        [self.progressShape addAnimation:scaleAnimation forKey:@"transform.scale"];
    }
}

- (float)pinnedProgress:(float)progress
{
    float pinnedProgress = MAX(0.0f, progress);
    pinnedProgress = MIN(1.0f, progress);
    
    [self setNeedsLayout];
    
    return pinnedProgress;
}


-(void)Praise:(UITapGestureRecognizer *)tapGestureRecognizer
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(sendApprove)])
    {
        [self.delegate sendApprove];
    }
}

@end
