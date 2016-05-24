//
//  LoadingView.m
//  BoXiu
//
//  Created by CaiZetong on 15/7/13.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import "LoadingView.h"

//#define LoadingViewWidth        300
//#define LoadingViewHeight       200
//
//#define MarginV                 20

#define LoadingViewWidth        300
#define LoadingViewHeight       200

#define MarginV                 60

@implementation LoadingView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


// 进入房间加载动画

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(0, 0, LoadingViewWidth, LoadingViewHeight)];
    if (self)
    {
        
        self.backgroundColor = [UIColor clearColor];
        
//        self.logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(LoadingViewWidth / 2 - 58 / 2, MarginV, 58, 58)];
        self.logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(LoadingViewWidth / 2 - 46 / 2, 47.5, 46, 46)];
        self.logoImageView.contentMode = UIViewContentModeScaleAspectFit;
        self.logoImageView.image = [UIImage imageNamed:@"LiveRoom_logo.png"];
        [self addSubview:self.logoImageView];
        
        
//        self.tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.logoImageView.frame) + MarginV, LoadingViewWidth, 30)];
        self.tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.logoImageView.frame)+3, LoadingViewWidth, 30)];
        self.tipLabel.text = @"热波，给你最好的视听娱乐";
        self.tipLabel.textColor = [CommonFuction colorFromHexRGB:@"FFFFFF"];
        self.tipLabel.font = [UIFont boldSystemFontOfSize:12];
        self.tipLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.tipLabel];
        
        
        //        self.loadingLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.loadVideoAnimationView.frame) + 10, LoadingViewWidth, 30)];
        self.loadingLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.tipLabel.frame) -8, LoadingViewWidth, 30)];
        self.loadingLabel.text = @"视频加载中，请稍候";
        self.loadingLabel.textColor = [UIColor whiteColor];
        self.loadingLabel.font = [UIFont boldSystemFontOfSize:10];
        self.loadingLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.loadingLabel];
        
        //加载动画
        NSMutableArray *imageArray = [NSMutableArray array];
        for (NSInteger nIndex = 0; nIndex < 12; nIndex++)
        {
            NSString *imageName = [NSString stringWithFormat:@"loadVideo%ld",(long)nIndex];
            UIImage *image = [UIImage imageNamed:imageName];
            [imageArray addObject:image];
        }
//        _loadVideoAnimationView = [[UIImageView alloc] initWithFrame:CGRectMake((LoadingViewWidth - 132)/2, CGRectGetMaxY(self.tipLabel.frame) + MarginV, 132, 1)];
        _loadVideoAnimationView = [[UIImageView alloc] initWithFrame:CGRectMake((LoadingViewWidth - 132)/2, CGRectGetMaxY(self.loadingLabel.frame) -5, 132, 1)];
        _loadVideoAnimationView.animationImages = [NSArray arrayWithArray:imageArray];
        _loadVideoAnimationView.animationRepeatCount = 0;
        _loadVideoAnimationView.animationDuration = 1;
        [self addSubview:_loadVideoAnimationView];
        [_loadVideoAnimationView startAnimating];
        
        

    }
    return self;
}


@end
