//
//  singleGiftAnimateView.m
//  BoXiu
//
//  Created by apple on 14-12-21.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "SingleGiftAnimateView.h"
#import "UIImageView+WebCache.h"

@interface SingleGiftAnimateView()
@property (nonatomic,strong) UIImageView *signleGiftImg;
@property (nonatomic,strong) UILabel *nickLabel;
@end

@implementation SingleGiftAnimateView

- (void)initView:(CGRect)frame
{
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"singleGift"]];
    
    _signleGiftImg = [[UIImageView alloc] initWithFrame:CGRectMake(41, 8, 40, 40)];
    [self addSubview:_signleGiftImg];
    
    _nickLabel = [[UILabel alloc] initWithFrame:CGRectMake(14, 52, 99, 19)];
    _nickLabel.textAlignment = NSTextAlignmentCenter;
    _nickLabel.font = [UIFont systemFontOfSize:13.0f];
    _nickLabel.textColor = [UIColor whiteColor];
    _nickLabel.backgroundColor = [CommonFuction colorFromHexRGB:@"f14642"];
    [self addSubview:_nickLabel];
}

- (void)startAnimationWithMessage:(NSString *)message giftUrl:(NSString *)giftUrl animationComplete:(GiftAnimationComplete)animationComplete
{
    self.animationComplete = animationComplete;
    
    [UIView animateWithDuration:2 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        [_signleGiftImg sd_setImageWithURL:[NSURL URLWithString:giftUrl] placeholderImage:nil];
        _nickLabel.text = message;

        self.alpha = 0.01;
        CGRect frame = self.frame;
        frame.origin.y += 90;
        self.frame = frame;
    } completion:^(BOOL finished) {
        
        if (finished)
        {
            self.animationComplete();
        }
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
