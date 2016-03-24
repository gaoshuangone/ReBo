//
//  LiveRankTableViewCell.m
//  BoXiu
//
//  Created by tongmingyu on 16/1/5.
//  Copyright © 2016年 rexiu. All rights reserved.
//

#import "LiveRankTableViewCell.h"

@interface LiveRankTableViewCell ()

@property(nonatomic,strong) UIImageView *headImgView;  //主播头像
@property(nonatomic,strong) UILabel *nilkLabel;     //主播昵称
@property(nonatomic,strong) UIImageView *sexImgView;        //性别
@property(nonatomic,strong) UIImageView *vipImgView;        //VIP
@property(nonatomic,strong) UIImageView *wealthImgView;    //等级图标
@property(nonatomic,strong) UILabel *contributionLabel;     //贡献
@property(nonatomic,strong) UIImageView *rankImgView;       //NO.1
@property(nonatomic,strong) UIImageView *rank2ImgView;       //NO.2
@property(nonatomic,strong) UIImageView *rank3ImgView;       //NO.3
@property(nonatomic,strong) UIButton *indexButton;          //名次
@property(nonatomic,strong) UIView *lineview;               //分割线

@property (nonatomic,assign) NSInteger sexNum;
@property (nonatomic,assign) NSInteger vipNum;

@end

@implementation LiveRankTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubView];
        
    }
    return self;
}

-(void)initSubView
{
    _headImgView= [[UIImageView alloc] initWithFrame:CGRectZero];
    _headImgView.image = [UIImage imageNamed:@"leftBtn_normal"];
    _headImgView.layer.cornerRadius = 21.0f;
    _headImgView.layer.masksToBounds = YES;
    
    _nilkLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _nilkLabel.textColor = [CommonFuction colorFromHexRGB:@"454a4d"];
    _nilkLabel.font = [UIFont systemFontOfSize:14.0f];
    
    _sexImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
    
    _rankImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _rank2ImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _rank3ImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
    
    _vipImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
    
    _wealthImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
    
    _contributionLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _contributionLabel.font = [UIFont systemFontOfSize:12.0f];
    
    _indexButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _indexButton.titleLabel.font=[UIFont systemFontOfSize:16];
    [_indexButton setTitleColor:[CommonFuction colorFromHexRGB:@"454a4d"] forState:UIControlStateNormal];
    _indexButton.userInteractionEnabled= NO;
    
    _lineview = [[UIView alloc] initWithFrame:CGRectZero];
    _lineview.backgroundColor = [CommonFuction colorFromHexRGB:@"f2f2f2"];
    
    [self.contentView addSubview:_lineview];
    [self.contentView addSubview:_indexButton];
    [self.contentView addSubview:_contributionLabel];
    [self.contentView addSubview:_wealthImgView];
    [self.contentView addSubview: _vipImgView];
    [self.contentView addSubview:_sexImgView];
    [self.contentView addSubview:_nilkLabel];
    [self.contentView addSubview:_headImgView];
    [self.contentView addSubview:_rankImgView];
    [self.contentView addSubview:_rank2ImgView];
    [self.contentView addSubview:_rank3ImgView];
}

- (void)setUserInfo:(UserInfo *)userInfo
{
    NSURL *headUrl = [NSURL URLWithString: [NSString stringWithFormat:@"%@/%@",[AppInfo shareInstance].res_server,userInfo.photo]];
    [_headImgView sd_setImageWithURL:headUrl placeholderImage:[UIImage imageNamed:@"leftBtn_normal"]];
    
    _nilkLabel.text = userInfo.nick;
    
    if (userInfo.sex == 1) {
        self.sexNum = 1;
        _sexImgView.image = [UIImage imageNamed:@"boy"];
    }
    else if (userInfo.sex == 2)
    {
        self.sexNum = 2;
        _sexImgView.image = [UIImage imageNamed:@"girl"];
    }else{
        _sexImgView.image = [UIImage imageNamed:@""];
        self.sexNum = 0;
    }
    
    if(userInfo.isPurpleVip)
    {
        self.vipNum = 1;
        _vipImgView.image = [UIImage imageNamed:@"pvip"];
    }else if (userInfo.isYellowVip)
    {
        self.vipNum = 2;
        _vipImgView.image = [UIImage imageNamed:@"yvip"];
    }else
    {
        self.vipNum = 0;
        _vipImgView.image = [UIImage imageNamed:@""];
    }

    _wealthImgView.image = [[UserInfoManager shareUserInfoManager] imageOfconsumerlevelweight:userInfo.consumerlevelweight];

    
    NSString *countStr = [NSString stringWithFormat:@"%lld ",userInfo.coin];
    NSInteger leng = [countStr length];
    NSString *mosaicStr = [NSString stringWithFormat:@"贡献 %lld 热豆",userInfo.coin];

    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:mosaicStr];
    [str addAttribute:NSForegroundColorAttributeName value:[CommonFuction colorFromHexRGB:@"959596"] range:NSMakeRange(0,2)];
    [str addAttribute:NSForegroundColorAttributeName value:[CommonFuction colorFromHexRGB:@"f7c250"] range:NSMakeRange(2,leng + 3 )];
    _contributionLabel.attributedText = str;
}

- (void)setRankIndex:(NSInteger)rankIndex
{
    _rankIndex = rankIndex;
    
    if(_rankIndex == 0)
    {
        _rankImgView.image = [UIImage imageNamed:@"rank1"];
        [_indexButton setTitle:nil forState:UIControlStateNormal];
        [_indexButton setImage:[UIImage imageNamed:@"01GR"] forState:UIControlStateNormal];
    }
    else if (_rankIndex == 1)
    {
        _rank2ImgView.image = [UIImage imageNamed:@"rank2"];
        [_indexButton setTitle:nil forState:UIControlStateNormal];
        [_indexButton setImage:[UIImage imageNamed:@"02GR"] forState:UIControlStateNormal];
    }
    else if (_rankIndex == 2)
    {
        _rank3ImgView.image = [UIImage imageNamed:@"rank3"];
        [_indexButton setTitle:nil forState:UIControlStateNormal];
        [_indexButton setImage:[UIImage imageNamed:@"03GR"] forState:UIControlStateNormal];
    }
    else
    {
        [_indexButton setImage:nil forState:UIControlStateNormal];
        [_indexButton setTitle:[NSString stringWithFormat:@"%ld",_rankIndex+1] forState:UIControlStateNormal];
    }
}
- (void)layoutSubviews
{
    CGSize nickSize = [_nilkLabel sizeThatFits:CGSizeMake(110, MAXFLOAT)];
    for (int count = 0; count <3; count++) {
        if (count == 1) {
            _nilkLabel.frame =CGRectMake(0, 89, nickSize.width, 15);
        }else
        {
            _nilkLabel.frame =CGRectMake((SCREEN_WIDTH - 33 - _wealthImgView.frame.origin.x)/2 , 86, nickSize.width, 15);
        }
        if(self.sexNum >0)
        {
            _sexImgView.frame=CGRectMake(_nilkLabel.frame.origin.x + nickSize.width + 5, 84, 20, 20);
            if(self.vipNum >0)
            {
                _vipImgView.frame = CGRectMake(_nilkLabel.frame.origin.x + nickSize.width + 28, 86, 37.5, 15);
                _wealthImgView.frame = CGRectMake(_nilkLabel.frame.origin.x + nickSize.width + 71, 86, 33, 15);
            }else
            {
                _wealthImgView.frame = CGRectMake(_nilkLabel.frame.origin.x + nickSize.width + 28, 86, 33, 15);
            }
            
        }else
        {
            if(self.vipNum >0)
            {
                _vipImgView.frame = CGRectMake(_nilkLabel.frame.origin.x + nickSize.width + 5, 86, 37.5, 15);
                _wealthImgView.frame = CGRectMake(_nilkLabel.frame.origin.x + nickSize.width + 48, 86, 33, 15);
            }else
            {
                _wealthImgView.frame = CGRectMake(_nilkLabel.frame.origin.x + nickSize.width + 5, 86, 33, 15);
            }
        }//256
    }
     CGSize contSize = [_contributionLabel sizeThatFits:CGSizeMake(150, MAXFLOAT)];
    _contributionLabel.frame = CGRectMake((SCREEN_WIDTH - contSize.width)/2,86 + _nilkLabel.frame.size.height + 8, contSize.width, contSize.height);
    _indexButton.frame = CGRectMake(10, 16, 35, 35);
    _headImgView.frame = CGRectMake((SCREEN_WIDTH -40)/2, 24, 42, 42);
     _lineview.frame = CGRectMake(0, 129, SCREEN_WIDTH, 1);
    _rankImgView.frame = CGRectMake((SCREEN_WIDTH - 97)/2, 5.5, 97, 69);
    _rank2ImgView.frame = CGRectMake((SCREEN_WIDTH - 71)/2, 25, 71, 55);
    _rank3ImgView.frame = CGRectMake((SCREEN_WIDTH - 46)/2, 57, 46, 17);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
