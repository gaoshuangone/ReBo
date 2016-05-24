//
//  GiftItem.m
//  BoXiu
//
//  Created by andy on 15/5/25.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import "GiftItem.h"
#import "UIImageView+WebCache.h"

@interface GiftItem ()

@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *countLabel;

@end

@implementation GiftItem

- (void)initView:(CGRect)frame
{
    _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self addSubview:_imageView];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _titleLabel.font = [UIFont systemFontOfSize:11.0f];
    _titleLabel.textColor = [CommonFuction colorFromHexRGB:@"575757"];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_titleLabel];
    
    _countLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _countLabel.font = [UIFont boldSystemFontOfSize:11.0f];
    _countLabel.textColor = [CommonFuction colorFromHexRGB:@"f7c250"];
    _countLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_countLabel];
    
}

- (void)setReward:(Reward *)reward
{
    if (reward == nil || reward.type == nil)
    {
        return;
    }
    
    NSString *unit = nil;
    if (reward.unit == 1)
    {
        unit = @"天";
    }
    else if (reward.unit == 2)
    {
        unit = @"月";
    }
    else if (reward.unit == 3)
    {
        unit = @"年";
    }
    
    if ([reward.type isEqualToString:@"car"])
    {
        NSString *imgsrc = [NSString stringWithFormat:@"%@/%@",[AppInfo shareInstance].res_server,reward.imgsrc];
        
        [_imageView sd_setImageWithURL:[NSURL URLWithString:imgsrc] placeholderImage:[UIImage imageNamed:@"car"]];
        _countLabel.text = [NSString stringWithFormat:@"%ld%@",(long)reward.count,unit];
    }
    
    if ([reward.type isEqualToString:@"coin"])
    {
        _imageView.image = [UIImage imageNamed:@"Gold"];
        _countLabel.text = [NSString stringWithFormat:@"%ld",(long)reward.count];
    }
    
    if ([reward.type isEqualToString:@"vip"])
    {
        if (reward.rewardId == 3)
        {
            //id是3代表紫色vip
            _imageView.image = [UIImage imageNamed:@"Violet"];
        }
        else
        {
            //id是4代表黄色vip
           _imageView.image = [UIImage imageNamed:@"Yellow"];
        }
        _countLabel.text = [NSString stringWithFormat:@"%ld%@",(long)reward.count,unit];
    }
    
    if (reward.name)
    {
        _titleLabel.text = reward.name;
    }
    

}

- (void)layoutSubviews
{
    if (_reward.type && [_reward.type isEqualToString:@"car"])
    {
        _imageView.frame = CGRectMake((self.frame.size.width - 70)/2, 10, 70, 70);
    }
    else
    {
        _imageView.frame = CGRectMake((self.frame.size.width - 36.5)/2, 10, 36.5, 38.5);
    }
    
    _titleLabel.frame = CGRectMake(0, 60, self.frame.size.width, 15);
    _countLabel.frame = CGRectMake(0, 75, self.frame.size.width, 15);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
