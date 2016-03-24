//
//  GiftAnimatiionView.m
//  BoXiu
//
//  Created by tongmingyu on 14-12-22.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "GiftAnimationView.h"
#import "SingleGiftContainerView.h"
#import "MoreGiftContainerView.h"

@implementation GiftAnimationData


@end


@interface GiftAnimationView ()

@property (nonatomic,strong) SingleGiftContainerView *singleGiftContainerView;
@property (nonatomic,strong) MoreGiftContainerView *moreGiftContainerView;

@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,strong) dispatch_queue_t giftAnimationQueue;

@property (nonatomic,strong) NSMutableArray *giftAnimationBuffer;

@end

@implementation GiftAnimationView

- (void)initView:(CGRect)frame
{
    self.hidden = YES;
    self.userInteractionEnabled = NO;

    _singleGiftContainerView = [[SingleGiftContainerView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 200) showInView:self];
    [self addSubview:_singleGiftContainerView];
    
    _moreGiftContainerView = [[MoreGiftContainerView alloc] initWithFrame:CGRectMake(0, 140, frame.size.width, frame.size.height - 140) showInView:self];
    [self addSubview:_moreGiftContainerView];
    
    _giftAnimationQueue = dispatch_queue_create("GiftAnimationQueue", DISPATCH_QUEUE_SERIAL);
    
    _giftAnimationBuffer = [NSMutableArray array];
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

- (void)getGiftAnimationData
{
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(getGiftAnimationDataFromQueue)])
    {
        dispatch_async(_giftAnimationQueue, ^{
            
            GiftAnimationData *giftAnimationData = nil;
            //由于多礼物动画每次都有所以先检查
            if (_moreGiftContainerView.canShowNextGiftAnimation)
            {
                //多礼物动画可追加
                if (_giftAnimationBuffer.count > 0)
                {
                    //礼物缓冲有数据,获取第一个数据检查是否是多礼物动画，
                    giftAnimationData = [self.giftAnimationBuffer firstObject];
                    if (giftAnimationData.giftType == 2)
                    {
                        //多礼物动画
                        dispatch_async(dispatch_get_main_queue(), ^{
                            self.hidden = NO;
                        });
                        [_moreGiftContainerView addGiftMessage:giftAnimationData.giftMessage giftUrl:giftAnimationData.giftUrl];
                        [self.giftAnimationBuffer removeObject:giftAnimationData];
                    }
                }
                else
                {
                    //礼物缓冲为空，从外面数据源获取数据，
                    giftAnimationData = [self.dataSource getGiftAnimationDataFromQueue];
                    if (giftAnimationData)
                    {
                        //如果获取到数据检查是否是多礼物动画，如果是则追加到多礼物动画队列，否则加入到缓冲里
                        if (giftAnimationData.giftType == 2)
                        {
                            //从外面获取的到数据是多礼物动画
                            dispatch_async(dispatch_get_main_queue(), ^{
                                self.hidden = NO;
                            });
                            [_moreGiftContainerView addGiftMessage:giftAnimationData.giftMessage giftUrl:giftAnimationData.giftUrl];
                        }
                        else
                        {
                            //如果从外面获取的数据不是多礼物动画，则加到缓冲里
                            [_giftAnimationBuffer addObject:giftAnimationData];
                        }
                    }
                    else
                    {
                        //如果没获取到数据，检查丹礼物动画和多礼物动画是都都结束了，如果结束隐藏，停掉定时器
                        if (_singleGiftContainerView.canShowNextGiftAnimation && _moreGiftContainerView.giftAnimationViews.count == 0)
                        {
                            [_timer invalidate];
                            _timer = nil;
                            dispatch_async(dispatch_get_main_queue(), ^{
                                self.hidden = YES;
                            });
                        }

                    }
                }
            }
            
            //检查单礼物动画队列是否可追加
            if (_singleGiftContainerView.canShowNextGiftAnimation)
            {
                //丹礼物动画队列可追加
                if (_giftAnimationBuffer.count > 0)
                {
                    //缓冲里有数据，获取第一个礼物动画检查是否是丹礼物动画
                    giftAnimationData = [self.giftAnimationBuffer firstObject];
                    if (giftAnimationData.giftType == 1)
                    {
                        //是丹礼物动画，追加到队列，并移除缓冲里数据
                        dispatch_async(dispatch_get_main_queue(), ^{
                            self.hidden = NO;
                        });
                        [_singleGiftContainerView addGiftMessage:giftAnimationData.giftMessage giftUrl:giftAnimationData.giftUrl];
                        [self.giftAnimationBuffer removeObject:giftAnimationData];
                    }

                }
                else
                {
                    //从外面数据源获取礼物动画数据
                    giftAnimationData = [self.dataSource getGiftAnimationDataFromQueue];
                    if (giftAnimationData)
                    {
                        //外部数据有丹礼物动画
                        if (giftAnimationData.giftType == 1)
                        {
                            //是丹礼物动画数据，追加到队列中
                            dispatch_async(dispatch_get_main_queue(), ^{
                                self.hidden = NO;
                            });
                            [_singleGiftContainerView addGiftMessage:giftAnimationData.giftMessage giftUrl:giftAnimationData.giftUrl];
                        }
                        else
                        {
                            //不是单礼物数据，增加到缓冲中
                            [_giftAnimationBuffer addObject:giftAnimationData];
                        }
                    }
                    else
                    {
                        //外部数据源无数据检查丹礼物队列和多礼物我数据队列是否都结束，
                        if (_singleGiftContainerView.canShowNextGiftAnimation && _moreGiftContainerView.giftAnimationViews.count == 0)
                        {
                            //借宿停掉定时器，界面隐藏
                            [_timer invalidate];
                            _timer = nil;
                            dispatch_async(dispatch_get_main_queue(), ^{
                                self.hidden = YES;
                            });
                        }
                        
                    }

                }
            }
        });
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
