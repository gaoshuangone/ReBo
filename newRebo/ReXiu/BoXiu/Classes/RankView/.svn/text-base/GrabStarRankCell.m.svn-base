//
//  GrabStarRankCell.m
//  BoXiu
//
//  Created by tongmingyu on 14-10-21.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "GrabStarRankCell.h"
#import "SpecialRankModel.h"
#import "UserInfoManager.h"
#import "UIImageView+WebCache.h"

@interface GrabStarRankCell()

@property (nonatomic,strong) UIButton *indexBtn;
@property (nonatomic,strong) UIImageView *onLineStateImgView;
@property (nonatomic,strong) UILabel *userNameLable;
@property (nonatomic,strong) UILabel *rankContentLable;
@property (nonatomic,strong) UIImageView *rankImageView;
@property (nonatomic,strong) UIImageView *lineImg;
@property (nonatomic,strong) UIImageView *bgImg;

@end

@implementation GrabStarRankCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self initRankCell];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)initRankCell
{
    _indexBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _indexBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    _indexBtn.userInteractionEnabled= NO;
    [self.contentView addSubview:_indexBtn];
    
    _bgImg = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:_bgImg];
    
    _headImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _headImgView.layer.masksToBounds = YES;
    _headImgView.layer.cornerRadius = 22.0f;
    [self.contentView addSubview:_headImgView];
    
    _onLineStateImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _onLineStateImgView.image = [UIImage imageNamed:@"startIconGR"];
//    _onLineStateImgView.layer.masksToBounds = YES;
//    _onLineStateImgView.layer.cornerRadius = 7.0f;
    [self.contentView addSubview:_onLineStateImgView];
    
    _rankImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:_rankImageView];
    
    _userNameLable = [[UILabel alloc] initWithFrame:CGRectZero];
    _userNameLable.font = [UIFont systemFontOfSize:14];
    _userNameLable.textColor = [CommonFuction colorFromHexRGB:@"454a4d"];
    [self.contentView addSubview:_userNameLable];
    
    _rankContentLable = [[UILabel alloc] initWithFrame:CGRectZero];
    _rankContentLable.font = [UIFont systemFontOfSize:14];
    _rankContentLable.textColor = [CommonFuction colorFromHexRGB:@"959596"];
    [self.contentView addSubview:_rankContentLable];
    
    _lineImg = [[UIImageView alloc] initWithFrame:CGRectZero];
    _lineImg.backgroundColor = [CommonFuction colorFromHexRGB:@"e5e5e5"];
    [self.contentView addSubview:_lineImg];
}

- (void)setStarGift:(StarGift *)starGift
{
    _starGift = starGift;

    NSURL *headUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[AppInfo shareInstance].res_server,starGift.starInfo.photo]];
    [_headImgView sd_setImageWithURL:headUrl placeholderImage:[UIImage imageNamed:@"rank_online"]];
    
    if (starGift.starInfo.onlineflag)
    {
        _bgImg.image = [UIImage imageNamed:@"rank_online"];
        _onLineStateImgView.hidden = NO;
//        _headImgView.layer.borderWidth = 2.0f;
//        _headImgView.layer.borderColor = [CommonFuction colorFromHexRGB:@"00c2b9"].CGColor;
    }
    else
    {
        _bgImg.image = [UIImage imageNamed:@"rankNoOnline"];
        _onLineStateImgView.hidden = YES;
//        _headImgView.layer.borderWidth = 2.0f;
//        _headImgView.layer.borderColor = [UIColor clearColor].CGColor;
    }
    
    _userNameLable.text = starGift.starInfo.nick;
    
    NSString *giftCount = [NSString stringWithFormat:@"%ld ",(long)starGift.value];
    NSInteger leng = [giftCount length];
    NSString *rangContent = nil;
    if (starGift.giftUnit)
    {
        rangContent = [NSString stringWithFormat:@"共 %@%@%@ ",giftCount,starGift.giftUnit,starGift.giftName];
    }
    else
    {
        rangContent = [NSString stringWithFormat:@" 共%@个%@ ",giftCount,starGift.giftName];
    }
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:rangContent];
    [str addAttribute:NSForegroundColorAttributeName value:[CommonFuction colorFromHexRGB:@"959596"] range:NSMakeRange(0,2)];
    [str addAttribute:NSForegroundColorAttributeName value:[CommonFuction colorFromHexRGB:@"ffdb83"] range:NSMakeRange(2,leng)];
    [str addAttribute:NSForegroundColorAttributeName value:[CommonFuction colorFromHexRGB:@"959596"] range:NSMakeRange(leng+2,1)];
    _rankContentLable.attributedText = str;
    
    NSURL *giftUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[AppInfo shareInstance].res_server,starGift.giftImg]];
    [_rankImageView sd_setImageWithURL:giftUrl placeholderImage:nil];
}

- (void)setRankIndex:(NSInteger)rankIndex
{
    _rankIndex = rankIndex;
    
    if(_rankIndex == 0)
    {
        [_indexBtn setTitle:nil forState:UIControlStateNormal];
        [_indexBtn setImage:[UIImage imageNamed:@"01GR"] forState:UIControlStateNormal];
    }
    else if (_rankIndex == 1)
    {
        [_indexBtn setTitle:nil forState:UIControlStateNormal];
        [_indexBtn setImage:[UIImage imageNamed:@"02GR"] forState:UIControlStateNormal];
    }
    else if (_rankIndex == 2)
    {
        [_indexBtn setTitle:nil forState:UIControlStateNormal];
        [_indexBtn setImage:[UIImage imageNamed:@"03GR"] forState:UIControlStateNormal];
    }
    else
    {
        [_indexBtn setImage:nil forState:UIControlStateNormal];
        [_indexBtn setTitle:[NSString stringWithFormat:@"%ld",_rankIndex+1] forState:UIControlStateNormal];
       
        [_indexBtn setTitleColor:[CommonFuction colorFromHexRGB:@"454a4d"] forState:UIControlStateNormal];
        _indexBtn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    }
}

- (void)layoutSubviews
{
    NSString *machineName = [AppInfo getMachineName];

    int nXOffset = 10;

    _indexBtn.frame = CGRectMake(nXOffset,(self.frame.size.height - 22)/2-8-4,14*5/3,28*5/3);

    nXOffset = nXOffset + 24 + 10;
    
//    _bgImg.frame = CGRectMake(nXOffset, (self.frame.size.height - 50)/2 , 50, 50);
    _headImgView.frame = CGRectMake(nXOffset + 3, (self.frame.size.height - 40)/2-1.5 , 44, 44);
    nXOffset = nXOffset + 50 + 10;
    
    _onLineStateImgView.frame = CGRectMake(_headImgView.frame.origin.x + 22+4+4,(self.frame.size.height - 16)/2+7+4+4+4, 14, 14);

    
    _userNameLable.frame = CGRectMake(nXOffset, 13, 150, 20);
    
    _rankContentLable.frame = CGRectMake(nXOffset, 35, 150, 20);
    
    _rankImageView.frame = CGRectMake(self.frame.size.width -  25 - 15, (self.frame.size.height - 22)/2, 22, 22);
    if ([machineName isEqualToString :@"iPhone 6 Plus (A1522/A1524)"])
    {
        _rankImageView.frame = CGRectMake(self.frame.size.width -  25 - 22, (self.frame.size.height - 27)/2, 27, 27);
    }
    self.lineImg.frame = CGRectMake(nXOffset, self.frame.size.height - 0.5, self.frame.size.width-nXOffset, 0.5);
}

+ (CGFloat)height
{
    return 70.0f;
}

@end
