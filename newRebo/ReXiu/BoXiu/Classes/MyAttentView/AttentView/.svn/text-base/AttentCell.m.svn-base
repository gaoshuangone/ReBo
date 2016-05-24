//
//  AttentCell.m
//  BoXiu
//
//  Created by Andy on 14-4-12.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "AttentCell.h"
#import "AppInfo.h"
#import "UIImageView+WebCache.h"
#import "UserInfoManager.h"

@interface AttentCell()

@property (nonatomic,strong) UIImageView *bgImg;
@property (nonatomic,strong) UIImageView *headImg;
@property (nonatomic,strong) UIImageView *photoImg;

@property (nonatomic,strong) UILabel *userNameLable;
@property (nonatomic,strong) UIImageView *starLevelImageView;

@property (nonatomic,strong) UILabel *Idxcode;      //靓号
@property (nonatomic,strong) UIImageView *lineImg;


@end

@implementation AttentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        UIImage *normalImg = [CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"ffffff"] size:CGSizeMake(100, 32)];
        UIImage *selectImg = [CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"d14c49"] size:CGSizeMake(100, 32)];

        _addAttenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _addAttenBtn.layer.masksToBounds = YES;
        _addAttenBtn.layer.cornerRadius = 27/2;
        _addAttenBtn.layer.borderWidth = 1;
        _addAttenBtn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
        [_addAttenBtn setTitle:@"+关注" forState:UIControlStateNormal];
        [_addAttenBtn setTitleColor:[CommonFuction colorFromHexRGB:@"d14c49"] forState:UIControlStateNormal];
        _addAttenBtn.layer.borderColor = [CommonFuction colorFromHexRGB:@"d14c49"].CGColor;
        [_addAttenBtn setBackgroundImage:normalImg forState:UIControlStateNormal];
        [_addAttenBtn setBackgroundImage:selectImg forState:UIControlStateHighlighted];
        [self.contentView addSubview:_addAttenBtn];
        
        _bgImg= [[UIImageView alloc] initWithFrame:CGRectZero];
        _bgImg.image=[UIImage imageNamed:@"rank_online"];
        _bgImg.layer.cornerRadius = 25.0f;
        [self.contentView addSubview:_bgImg];
        
        _headImg= [[UIImageView alloc] initWithFrame:CGRectZero];
        _headImg.layer.cornerRadius = 25.0f;
        _headImg.layer.masksToBounds = YES;
        [self.contentView addSubview:_headImg];
        
        _userNameLable = [[UILabel alloc] initWithFrame:CGRectZero];
        _userNameLable.textColor = [CommonFuction colorFromHexRGB:@"454a4d"];
        _userNameLable.font = [UIFont boldSystemFontOfSize:14.0f];
        _userNameLable.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_userNameLable];
        
        _starLevelImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_starLevelImageView];

        _Idxcode = [[UILabel alloc] initWithFrame:CGRectZero];
        _Idxcode.textColor = [CommonFuction colorFromHexRGB:@"959596"];
        _Idxcode.font = [UIFont systemFontOfSize:12.0f];
        [self.contentView addSubview:_Idxcode];
        
        _lineImg = [[UIImageView alloc] initWithFrame:CGRectZero];
        _lineImg.backgroundColor = [CommonFuction colorFromHexRGB:@"f6f6f6"];
        [self.contentView addSubview:_lineImg];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setStarInfo:(StarInfo *)starInfo
{
    _starInfo = starInfo;
//   设置头像
    NSURL *headUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[AppInfo shareInstance].res_server,_starInfo.adphoto]];
    [_headImg sd_setImageWithURL:headUrl placeholderImage:nil];
    
    _userNameLable.text = starInfo.nick;
    _starLevelImageView.image = [[UserInfoManager shareUserInfoManager] imageOfStar:_starInfo.starlevelid];
    
    _Idxcode.text = [NSString stringWithFormat:@" %ld",(long)starInfo.idxcode];
}

- (void)layoutSubviews
{
    int xOffset = self.frame.size.width - 248;
    
    _bgImg.frame = CGRectMake(10, ([AttentCell height]-50)/2, 50, 50);
    _headImg.frame = CGRectMake(10, ([AttentCell height]-50)/2, 50, 50);
    _userNameLable.frame = CGRectMake(xOffset, 15, 150, 20);
    _starLevelImageView.frame = CGRectMake(xOffset, 10 + 20 + 12, 33, 15);
    _Idxcode.frame = CGRectMake(_starLevelImageView.frame.origin.x + 40, 10 + 20 + 12, 200, 15);
    _addAttenBtn.frame = CGRectMake(SCREEN_WIDTH-78, 26.8, 67, 27);
    
    self.lineImg.frame = CGRectMake(self.frame.size.width - 248, self.frame.size.height - 0.5, 248, 0.5);
}

+ (CGFloat)height
{
    return 72;
}

@end
