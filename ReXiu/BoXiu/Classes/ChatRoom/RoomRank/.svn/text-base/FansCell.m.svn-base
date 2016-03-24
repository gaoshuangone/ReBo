//
//  FansCell.m
//  BoXiu
//
//  Created by tongmingyu on 14-5-12.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "FansCell.h"
#import "UIButton+WebCache.h"
#import "AppInfo.h"

@interface FansCell ()
@property (nonatomic,strong) UIButton *headImgBtn;
@property (nonatomic,strong) UILabel *userNameLable;
@property (nonatomic,strong) UIImageView *consumptionLevelImageView;
@property (nonatomic,strong) UIImageView *vipLevelImageView;
@property (nonatomic,strong) UIButton *indexButton;
@property (nonatomic,strong) UILabel *idxcodeLabel;
@property (nonatomic,strong) UIImageView *lineImg;
@property (nonatomic,strong) UILabel *weightLabel;
@property (nonatomic,strong) UILabel *contributeLabel;
@property (nonatomic,strong) UIImageView *bgImgView;

@end

@implementation FansCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        _bgImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _bgImgView.image = [UIImage imageNamed:@" "];
        [self.contentView addSubview:_bgImgView];
     
        
        
        _headImgBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _headImgBtn.frame = CGRectZero;
        [_headImgBtn.layer setMasksToBounds:YES];
        _headImgBtn.userInteractionEnabled = NO;
        [_headImgBtn.layer setCornerRadius:20.0f]; //设置矩形四个圆角半径
        [self.contentView addSubview:_headImgBtn];
        
        _userNameLable = [[UILabel alloc] initWithFrame:CGRectZero];
        _userNameLable.textColor = [CommonFuction colorFromHexRGB:@"4c4855"];
        _userNameLable.font = [UIFont boldSystemFontOfSize:13.0f];
        [self.contentView addSubview:_userNameLable];
        
        _consumptionLevelImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_consumptionLevelImageView];

        
        _vipLevelImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_vipLevelImageView];
        
        _indexButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _indexButton.titleLabel.font=[UIFont systemFontOfSize:16];
        [_indexButton setTitleColor:[CommonFuction colorFromHexRGB:@"454a4d"] forState:UIControlStateNormal];
        _indexButton.userInteractionEnabled= NO;
        [self.contentView addSubview:_indexButton];
        
        _idxcodeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _idxcodeLabel.textColor = [CommonFuction colorFromHexRGB:@"d14c49"];
        _idxcodeLabel.font = [UIFont systemFontOfSize:12.0f];
        [self.contentView addSubview:_idxcodeLabel];
        
        _lineImg = [[UIImageView alloc] initWithFrame:CGRectZero];
        _lineImg.backgroundColor = [CommonFuction colorFromHexRGB:@"d4d4d4"];
        [self.contentView addSubview:_lineImg];
   
        _contributeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _contributeLabel.textColor = [CommonFuction colorFromHexRGB:@"4c4855"];
        _contributeLabel.text = @"贡献值";
        _contributeLabel.font = [UIFont systemFontOfSize:12];
        _contributeLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_contributeLabel];
        
        _weightLabel = [[UILabel alloc] init];
        _weightLabel.textColor = [CommonFuction colorFromHexRGB:@"f7c250"];
        _weightLabel.textAlignment = NSTextAlignmentCenter;
        _weightLabel.font = [UIFont boldSystemFontOfSize:12];
        [self.contentView addSubview:_weightLabel];
    }
    return self;
}

- (void)setUserInfo:(UserInfo *)userInfo
{
    _userInfo = userInfo;
    
    if (self.isThis)
    {
        UserInfo *currentInfo = [UserInfoManager shareUserInfoManager].currentUserInfo;
        if (userInfo.hidden == 2)
        {
            if (currentInfo.issupermanager && !userInfo.issupermanager)
            {
                NSURL *headUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[AppInfo shareInstance].res_server,userInfo.photo]];
                [_headImgBtn sd_setBackgroundImageWithURL:headUrl forState:UIControlStateNormal placeholderImage:nil];
                _userNameLable.text = [NSString stringWithFormat:@"%@",userInfo.nick];
                _idxcodeLabel.text = [NSString stringWithFormat:@"(%ld)",(long)userInfo.idxcode];
                _consumptionLevelImageView.hidden = NO;
                _consumptionLevelImageView.image = [[UserInfoManager shareUserInfoManager] imageOfconsumerlevelweight:userInfo.consumerlevelweight];
                
                _vipLevelImageView.hidden = NO;
                _vipLevelImageView.image = [[UserInfoManager shareUserInfoManager] imageOfVip:userInfo.privlevelweight];
                
                _weightLabel.text = [NSString stringWithFormat:@"%lld",userInfo.coin];
            }
            else
            {
                [_headImgBtn setBackgroundImage:[UIImage imageNamed:@"mysteriousHead"] forState:UIControlStateNormal];
                
                if(userInfo.userId == currentInfo.userId)
                {
                    _userNameLable.text = @"我";
                    _idxcodeLabel.text = [NSString stringWithFormat:@"(%ld)",(long)userInfo.idxcode];
                    NSURL *headUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[AppInfo shareInstance].res_server,userInfo.photo]];
                    [_headImgBtn sd_setBackgroundImageWithURL:headUrl forState:UIControlStateNormal placeholderImage:nil];
                    _weightLabel.text = [NSString stringWithFormat:@"%lld",userInfo.coin];
                    _consumptionLevelImageView.hidden = NO;
                    _consumptionLevelImageView.image = [[UserInfoManager shareUserInfoManager] imageOfconsumerlevelweight:userInfo.consumerlevelweight];
                    _vipLevelImageView.hidden = NO;
                    _vipLevelImageView.image = [[UserInfoManager shareUserInfoManager] imageOfVip:userInfo.privlevelweight];
                }
                else
                {
                    _idxcodeLabel.text = @"******";
                    _userNameLable.text = userInfo.hiddenindex;
                    _weightLabel.text = @"保密";
                    _consumptionLevelImageView.hidden = YES;
                    _vipLevelImageView.hidden = YES;
                }
            }
        }
        else
        {
            NSURL *headUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[AppInfo shareInstance].res_server,userInfo.photo]];
            [_headImgBtn sd_setBackgroundImageWithURL:headUrl forState:UIControlStateNormal placeholderImage:nil];
            
            _userNameLable.text = userInfo.nick;
            _idxcodeLabel.text = [NSString stringWithFormat:@"(%ld)",(long)userInfo.idxcode];
            _consumptionLevelImageView.hidden = NO;
            _consumptionLevelImageView.image = [[UserInfoManager shareUserInfoManager] imageOfconsumerlevelweight:userInfo.consumerlevelweight];
            
            _vipLevelImageView.hidden = NO;
            _vipLevelImageView.image = [[UserInfoManager shareUserInfoManager] imageOfVip:userInfo.privlevelweight];
            
            _weightLabel.text = [NSString stringWithFormat:@"%lld",userInfo.coin];
        }
    }
    else
    {
        NSURL *headUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[AppInfo shareInstance].res_server,userInfo.photo]];
        [_headImgBtn sd_setBackgroundImageWithURL:headUrl forState:UIControlStateNormal placeholderImage:nil];
        
        _userNameLable.text = userInfo.nick;
        _idxcodeLabel.text = [NSString stringWithFormat:@"(%ld)",(long)userInfo.idxcode];
        _consumptionLevelImageView.hidden = NO;
        _consumptionLevelImageView.image = [[UserInfoManager shareUserInfoManager] imageOfconsumerlevelweight:userInfo.consumerlevelweight];
        
        if (self.userInfo.privlevelweight == 10 || self.userInfo.privlevelweight == 14)
        {
            _vipLevelImageView.hidden = NO;
        }
        else
        {
            _vipLevelImageView.hidden = YES;
        }
        _vipLevelImageView.image = [[UserInfoManager shareUserInfoManager] imageOfVip:userInfo.privlevelweight];
        _weightLabel.text = [NSString stringWithFormat:@"%lld",userInfo.coin];
    }

}

- (void)layoutSubviews
{
    int nXOffset = 0;
    _indexButton.frame = CGRectMake(5,[FansCell height]/4,[FansCell height]/2,[FansCell height]/2);
    
    _bgImgView.frame = CGRectMake([FansCell height]/2 + 5, ([FansCell height] -40)/2, 40, 40);
    _bgImgView.center =CGPointMake( _bgImgView.center.x, 30);
    
    
    
    _headImgBtn.frame = CGRectMake([FansCell height]/2 + 5 , ([FansCell height] -40)/2, 40, 40);
    _headImgBtn.center = _bgImgView.center;
    _indexButton.center =CGPointMake(_indexButton.center.x, _bgImgView.center.y);
    nXOffset = _headImgBtn.frame.origin.x + _headImgBtn.frame.size.width + 15;
    
    CGSize size = [CommonFuction sizeOfString:_userNameLable.text maxWidth:(self.frame.size.width - (nXOffset + 5 )) maxHeight:15 withFontSize:14.0f];
    _userNameLable.frame = CGRectMake(nXOffset, 10, 100, 20);
    
    _idxcodeLabel.frame = CGRectMake(_userNameLable.frame.origin.x + size.width, 8, 70, 24);
    _idxcodeLabel.hidden = YES;//放不下，暂时不现实号码
    
    _consumptionLevelImageView.frame = CGRectMake( _userNameLable.frame.origin.x, 10 + 21 , 36, 15);
    
    _vipLevelImageView.frame = CGRectMake(_consumptionLevelImageView.frame.origin.x + _consumptionLevelImageView.frame.size.width + 2, 10 + 21, 36, 15);
   
    _contributeLabel.frame = CGRectMake(self.frame.size.width - 90 -14, 18-10+3, 90, 15);
    _weightLabel.frame = CGRectMake(self.frame.size.width - 90 -14, 35-10+3, 90, _userNameLable.frame.size.height);
    
    self.lineImg.frame = CGRectMake(nXOffset, self.frame.size.height - 0.5, self.frame.size.width-nXOffset, 0.5);
}

- (void)setRankIndex:(NSInteger)rankIndex
{
    _rankIndex = rankIndex;
    
    if(_rankIndex == 0)
    {
        [_indexButton setTitle:nil forState:UIControlStateNormal];
        [_indexButton setImage:[UIImage imageNamed:@"01GR"] forState:UIControlStateNormal];
    }
    else if (_rankIndex == 1)
    {
        [_indexButton setTitle:nil forState:UIControlStateNormal];
        [_indexButton setImage:[UIImage imageNamed:@"02GR"] forState:UIControlStateNormal];
    }
    else if (_rankIndex == 2)
    {
        [_indexButton setTitle:nil forState:UIControlStateNormal];
        [_indexButton setImage:[UIImage imageNamed:@"03GR"] forState:UIControlStateNormal];
    }
    else
    {
        [_indexButton setImage:nil forState:UIControlStateNormal];
        [_indexButton setTitle:[NSString stringWithFormat:@"%d",_rankIndex+1] forState:UIControlStateNormal];
    }
}

+ (CGFloat)height
{
    return 70.0f;
}

@end
