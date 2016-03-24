//
//  MoreGiftContainerView.m
//  BoXiu
//
//  Created by tongmingyu on 14-12-22.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "MoreGiftContainerView.h"
#import "MoreGIftAnimationView.h"

@implementation MoreGiftContainerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)initView:(CGRect)frame
{
    [super initView:frame];
    self.giftType = 2;

}

- (void)addGiftMessage:(NSString *)message giftUrl:(NSString *)giftUrl
{
    dispatch_sync(dispatch_get_main_queue(), ^{
        if (message && giftUrl)
        {
            self.canShowNextGiftAnimation = NO;
            MoreGIftAnimationView *moreGiftAnimationItem = [[MoreGIftAnimationView alloc] initWithFrame:CGRectMake(0,self.frame.size.height, self.frame.size.width, 60) showInView:self];
            moreGiftAnimationItem.fixedLocation = CGPointMake(self.frame.origin.x, self.frame.size.height - 60);
            [self addSubview:moreGiftAnimationItem];
            [self.giftAnimationViews addObject:moreGiftAnimationItem];
            
            [moreGiftAnimationItem startAnimationWithMessage:message giftUrl:giftUrl animationComplete:^{
                [self.giftAnimationViews removeObject:moreGiftAnimationItem];
                [moreGiftAnimationItem removeFromSuperview];
            }];
        }

    });
  }


- (BOOL)canAddNextGiftAnimation
{
    if (self.giftAnimationViews && [self.giftAnimationViews count])
    {
        MoreGIftAnimationView *moreGiftAnimationItem = [self.giftAnimationViews lastObject];
        self.canShowNextGiftAnimation = moreGiftAnimationItem.isExceedLocation;
    }
    else
    {
        self.canShowNextGiftAnimation = YES;
    }
    return self.canShowNextGiftAnimation;
}


@end
