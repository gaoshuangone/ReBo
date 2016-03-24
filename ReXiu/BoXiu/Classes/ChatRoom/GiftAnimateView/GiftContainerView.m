//
//  GiftContainerView.m
//  BoXiu
//
//  Created by tongmingyu on 14-12-22.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "GiftContainerView.h"


@implementation GiftAnimationData


@end

@interface GiftContainerView ()

@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,strong) dispatch_queue_t giftAnimationQueue;
@property (nonatomic,strong) NSMutableArray *giftAnimationBuffer;

@end

@implementation GiftContainerView

- (void)initView:(CGRect)frame
{
    self.hidden = YES;
    self.userInteractionEnabled = NO;
    
    _giftAnimationQueue = dispatch_queue_create("GiftAnimationQueue", DISPATCH_QUEUE_SERIAL);
    
    _giftAnimationBuffer = [NSMutableArray array];
    
    self.canShowNextGiftAnimation = YES;
    self.layer.masksToBounds = YES;
    self.backgroundColor = [UIColor clearColor];
    _giftAnimationViews = [NSMutableArray array];
}

- (void)showGiftAnimation
{
    if (_timer == nil)
    {
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(getGiftAnimationData) userInfo:nil repeats:YES];
    }
}

- (void)hideGiftAnimation
{
    if (_timer)
    {
        [_timer invalidate];
        _timer = nil;
    }
    self.hidden = YES;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)addGiftMessage:(NSString *)message giftUrl:(NSString *)giftUrl
{
    
}

- (void)getGiftAnimationData
{
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(getGiftAnimationDataFromQueue:)])
    {
        dispatch_async(_giftAnimationQueue, ^{
            GiftAnimationData *giftAnimationData = nil;
            if (_giftAnimationBuffer.count > 0)
            {
                //礼物缓冲有数据,获取第一个数据检查是否是多礼物动画，
                giftAnimationData = [self.giftAnimationBuffer firstObject];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.hidden = NO;
                });
                [self addGiftMessage:giftAnimationData.giftMessage giftUrl:giftAnimationData.giftUrl];
                [self.giftAnimationBuffer removeObject:giftAnimationData];
            }
            else
            {
                giftAnimationData = [self.dataSource getGiftAnimationDataFromQueue:self.giftType];
                if (giftAnimationData)
                {
                    if([self respondsToSelector:@selector(canAddNextGiftAnimation)] && [self canAddNextGiftAnimation])
                    {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            self.hidden = NO;
                        });
                        [self addGiftMessage:giftAnimationData.giftMessage giftUrl:giftAnimationData.giftUrl];
                    }
                    else
                    {
                        [_giftAnimationBuffer addObject:giftAnimationData];
                    }
                }
                else
                {
                    //如果结束隐藏，停掉定时器
                    if (self.canShowNextGiftAnimation && self.giftAnimationViews.count == 0)
                    {
                        [_timer invalidate];
                        _timer = nil;
                        dispatch_async(dispatch_get_main_queue(), ^{
                            self.hidden = YES;
                        });
                    }
                    
                }
            }
        });
    }
}


- (GiftAnimationData *)getGiftAnimationDataFromQueue
{
    return nil;
}

@end
