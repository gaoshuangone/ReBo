//
//  BarrageMessageLabel.m
//  BoXiu
//
//  Created by andy on 14-12-19.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "BarrageMessageLabel.h"
#import "BarrageItem.h"

@interface BarrageMessageLabel ()
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,copy) Completion completion;

@end

@implementation BarrageMessageLabel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)starAnimationWithDuraion:(CGFloat)duration completion:(void (^)())completion
{
    if (duration > 0)
    {
        self.completion = completion;
        UIView *superView = self.superview;
        if (superView)
        {
            [self addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
            CGRect superViewFrame = superView.frame;
            CGRect frame = self.frame;
            CGFloat timeInterval = duration / (superViewFrame.size.width + frame.size.width);
            self.timer = [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(changeFrame) userInfo:nil repeats:YES];
            [self.timer fire];
        }

    }
}

- (void)starAnimationWithRate:(CGFloat)rate completion:(Completion)completion
{
    if (rate == 0)
    {
        rate = 100;
    }
    self.completion = completion;
    UIView *superView = self.superview;
    if (superView)
    {
        [self addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
        CGFloat timeInterval = 1 / rate;
        
        _timer = [NSTimer timerWithTimeInterval:timeInterval target:self selector:@selector(changeFrame) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
        [_timer fire];
        
    }
    

}

- (BOOL)checkExceedLocation:(CGPoint)location
{
    BOOL exceedLocation = NO;
    CGRect frame = self.frame;
    if (frame.origin.x < location.x && location.x > (frame.origin.x + frame.size.width))
    {
        exceedLocation = YES;
    }
    
    return exceedLocation;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"frame"])
    {
        if (!_isExceedLocation)
        {
             _isExceedLocation = [self checkExceedLocation:self.fixedLocation];
        }
       
        BOOL commpleteState = [self checkExceedLocation:CGPointZero];
        if (commpleteState)
        {
            [self.timer invalidate];
            [self removeObserver:self forKeyPath:@"frame" context:nil];
            self.completion();
        }
    }
}

- (void)changeFrame
{
    CGRect frame = self.frame;
    frame.origin.x -= 1;
    self.frame = frame;
}


@end
