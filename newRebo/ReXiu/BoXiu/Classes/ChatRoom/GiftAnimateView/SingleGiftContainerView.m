//
//  SingleGiftContainerView.m
//  BoXiu
//
//  Created by tongmingyu on 14-12-22.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "SingleGiftContainerView.h"
#import "SingleGiftAnimateView.h"

@implementation SingleGiftContainerView

- (void)initView:(CGRect)frame
{
    [super initView:frame];
    self.giftType = 1;

}

- (void)addGiftMessage:(NSString *)message giftUrl:(NSString *)giftUrl
{
    if (message && giftUrl)
    {
        //将单个礼物增加进来
        self.canShowNextGiftAnimation = NO;
        dispatch_sync(dispatch_get_main_queue(), ^{
            SingleGiftAnimateView *singleGiftAnimationView = [[SingleGiftAnimateView alloc] initWithFrame:CGRectMake((self.frame.size.width - 127)/2, 0, 127, 90) showInView:self];
            [self addSubview:singleGiftAnimationView];
            
            [singleGiftAnimationView startAnimationWithMessage:message giftUrl:giftUrl animationComplete:^{
                
                self.canShowNextGiftAnimation = YES;
                [singleGiftAnimationView removeFromSuperview];
            }];
        });

    }
}

- (BOOL)canAddNextGiftAnimation
{
    return self.canShowNextGiftAnimation;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
