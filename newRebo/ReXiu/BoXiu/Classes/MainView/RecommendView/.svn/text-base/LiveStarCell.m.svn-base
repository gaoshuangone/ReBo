//
//  LiveStarCell.m
//  BoXiu
//
//  Created by tongmingyu on 14-12-29.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "LiveStarCell.h"
#import "UIImageView+WebCache.h"
#import "UserInfoManager.h"
#import "UIButton+WebCache.h"

@interface LiveStarCell()
@property (nonatomic,strong) UIView *bottomView;
@property (nonatomic,strong) UIImageView *bottomImgView;

@property (nonatomic,strong) UIImageView *starLevel;
@property (nonatomic,strong) UILabel *nick;
@property (nonatomic,strong) UILabel *statu;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *userNum;
@property (nonatomic,strong) UIImageView *postImg;
@end

@implementation LiveStarCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        
        _postImg = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_postImg];
        
        _bottomView = [[UIView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_bottomView];
        
        _bottomImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _bottomImgView.image = [UIImage imageNamed:@"starposterBg"];
        [_bottomView addSubview:_bottomImgView];
        
        _starLevel = [[UIImageView alloc] initWithFrame:CGRectZero];
        [_bottomView addSubview:_starLevel];
        
        _nick = [[UILabel alloc] initWithFrame:CGRectZero];
        _nick.font = [UIFont boldSystemFontOfSize:14.0f];
        _nick.textColor = [UIColor whiteColor];//[CommonFuction colorFromHexRGB:@"e7e7e7"];
        [_bottomView addSubview:_nick];
        
        _statu = [[UILabel alloc] initWithFrame:CGRectZero];
        _statu.textAlignment = NSTextAlignmentRight;
        _statu.font = [UIFont systemFontOfSize:13.0f];
        _statu.textColor = [CommonFuction colorFromHexRGB:@"e7e7e7"];
        [_bottomView addSubview:_statu];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.font = [UIFont systemFontOfSize:12.0f];
        _titleLabel.textColor = [CommonFuction colorFromHexRGB:@"e7e7e7"];
        [_bottomView addSubview:_titleLabel];
        
        _userNum = [[UILabel alloc] initWithFrame:CGRectZero];
        _userNum.textAlignment = NSTextAlignmentRight;
        _userNum.font = [UIFont boldSystemFontOfSize:12.0f];
        _userNum.textColor = [CommonFuction colorFromHexRGB:@"f7c250"];
        [_bottomView addSubview:_userNum];
        
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnLiveStarRoom)]];
    }
    
    return self;
}


-(void)setLiveStarData:(LiveSchedulesData *)liveStarData
{
    _liveStarData = liveStarData;
    if (liveStarData)
    {
        NSString *url = [NSString stringWithFormat:@"%@%@",[AppInfo shareInstance].res_server,liveStarData.roomposter];
        [_postImg sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil];
        _nick.text = liveStarData.nick;
        _starLevel.image = [[UserInfoManager shareUserInfoManager] imageOfStar:liveStarData.starlevelid];
        _titleLabel.text = liveStarData.liveName;
        _userNum.text = [NSString stringWithFormat:@"%d人",liveStarData.showusernum];
        if (liveStarData.onlineflag)
        {
            _statu.text = @"直播中";
        }
        else
        {
            _statu.text = [NSString stringWithFormat:@"%@ 直播",liveStarData.startTime];
        }
    }
}


-(void)OnLiveStarRoom
{
    if (_delegate && [_delegate respondsToSelector:@selector(liveStarCell:liveStarData:)])
    {
        [_delegate liveStarCell:self liveStarData:_liveStarData];
    }
}


-(void)layoutSubviews
{
    self.contentView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    _postImg.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    _bottomView.frame = CGRectMake(0, 128, self.frame.size.width, [LiveStarCell height] - 128);
    
    _bottomImgView.frame = CGRectMake(0, 0, _bottomView.frame.size.width, _bottomView.frame.size.height);
    
    _starLevel.frame = CGRectMake(6, 8, 33, 15);
    _nick.frame = CGRectMake(44, 7, 200, 20);
    _statu.frame = CGRectMake(215, 8, 90, 20);
    _titleLabel.frame = CGRectMake(6, 27, 220, 20);
    _userNum.frame = CGRectMake(223, 27, 82, 20);
}

+(CGFloat)height
{
    return 180;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
