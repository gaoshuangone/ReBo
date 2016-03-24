//
//  TheCarCell.m
//  BoXiu
//
//  Created by tongmingyu on 14-8-29.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "TheCarCell.h"
#import "AppInfo.h"
#import "UIButton+WebCache.h"
#import "CarSmallCell.h"
#import "InviterCell.h"
#import "InviterFriendViewController.h"

@interface InviterCell()


@property (nonatomic,strong) UIImageView *imgView;

@property (nonatomic,strong) UIImageView *imgViewGou;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *statelabel;

@property (nonatomic,strong) NSString *Strunit;
@property (nonatomic,strong) NSString *StrName;

@end


@implementation InviterCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubView];
        
    }
    return self;
}

- (void)initSubView
{
    _imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:_imgView];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:_titleLabel];
    
    _statelabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:_statelabel];
    _imgViewGou = [[UIImageView alloc] initWithFrame:CGRectZero];
    _imgViewGou.image = [UIImage imageNamed:@"gouQY"];
    [self.contentView addSubview:_imgViewGou];
}
-(void)setViewLine{
    UIView* view = [CommonUtils CommonViewLineWithFrame:CGRectMake(43, 47.5, SCREEN_WIDTH-45, 0.5)];
    view.backgroundColor = [UIColor lightGrayColor];
    view.alpha = 0.35;
    [self addSubview:view];
}
- (void)setReward:(Reward *)reward
{
    if (reward)
    {
        _reward = reward;
        
        //判断类型赋响应图片
        if ([reward.type isEqualToString:@"vip"])
        {
            if (reward.rewardId == 4)
            {
                [_imgView setImage:[UIImage imageNamed:@"yellovipYQ"]];
            }
            else if (reward.rewardId == 3)
            {
                [_imgView setImage:[UIImage imageNamed:@"zivipYQ"]];
            }
        }
        
        if ([reward.type isEqualToString:@"car"])
        {
            [_imgView setImage:[UIImage imageNamed:@"carYQ"]];

        }
        
        if([reward.type isEqualToString:@"coin"])
        {
            [_imgView setImage:[UIImage imageNamed:@"rechageIcon@2x"]];
        }

        if(reward.unit ==1 )
        {
            _Strunit=@"天";
        }
        else if (reward.unit == 2)
        {
            _Strunit=@"个月";
        }
        else
        {
            _Strunit=@"年";
        }
//       拼接奖励
        if ([reward.type isEqualToString:@"vip" ]|| [reward.type isEqualToString: @"car" ])
        {
            _StrName = [NSString stringWithFormat:@"%@  %ld%@",reward.name,(long)reward.count,_Strunit];
        }
        
         _titleLabel.text = _StrName;
        _titleLabel.font = [UIFont systemFontOfSize:14.0f];
        _titleLabel.textColor = [CommonFuction colorFromHexRGB:@"454a4d"];
    
        //判断邀请数，设置相应状态      gouQY
        if (_successCount>=_count)
        {
            _statelabel.text=@"已获得";
            _statelabel.font = [UIFont systemFontOfSize:14.0f];
            _statelabel.textColor = [CommonFuction colorFromHexRGB:@"d14c49"];

        }
        else
        {
            _statelabel.text=@"未获得";
            _statelabel.font = [UIFont systemFontOfSize:14.0f];
            _statelabel.textColor = [CommonFuction colorFromHexRGB:@"959596"];

        }
    }
}

 - (void)layoutSubviews
{

    _imgView.frame =  CGRectMake(9, (51-28)/2+3-5, 28, 28);
    
    _titleLabel.frame = CGRectMake(38.5+5, 13.2-5, 135, 30);
 
    _statelabel.frame = CGRectMake(SCREEN_WIDTH-84+12, 18.5-3, 48, 15) ;
    
    //判断邀请数，设置相应状态
    if (_successCount>=_count)
    {
        _imgViewGou.frame = CGRectMake(SCREEN_WIDTH-84+62, 18.5-2, 8.5, 9.5);
    }
    
}



+ (CGFloat)height
{
    return 51.0f;
}


- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}





@end
