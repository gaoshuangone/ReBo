//
//  LiveFansRank2TableViewCell.m
//  BoXiu
//
//  Created by tongmingyu on 16/1/6.
//  Copyright © 2016年 rexiu. All rights reserved.
//

#import "LiveRank2TableViewCell.h"

@interface LiveRank2TableViewCell ()

@property(nonatomic,strong) UIImageView *headImgView;  //主播头像
@property(nonatomic,strong) UILabel *nilkLabel;     //主播昵称
@property(nonatomic,strong) UIImageView *sexImgView;        //性别
@property(nonatomic,strong) UIImageView *vipImgView;        //VIP
@property(nonatomic,strong) UIImageView *wealthImgView;    //等级图标
@property(nonatomic,strong) UILabel *contributionLabel;     //贡献

@property(nonatomic,strong) UIButton *indexButton;          //名次
@property(nonatomic,strong) UIView *lineview;               //分割线
@property (nonatomic,assign) NSInteger sexNum;
@property (nonatomic,assign) NSInteger vipNum;

@end

@implementation LiveRank2TableViewCell

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
}


- (void)setUserInfo:(UserInfo *)userInfo
{
    NSURL *headUrl = [NSURL URLWithString: [NSString stringWithFormat:@"%@/%@",[AppInfo shareInstance].res_server,userInfo.photo]];
    [_headImgView sd_setImageWithURL:headUrl placeholderImage:[UIImage imageNamed:@"leftBtn_normal"]];
    
    _nilkLabel.text = userInfo.nick;
    
    if (userInfo.sex == 1) {
        self.sexNum =1;
        _sexImgView.image = [UIImage imageNamed:@"boy"];
    }
    else if (userInfo.sex == 2)
    {
        self.sexNum = 2;
        _sexImgView.image = [UIImage imageNamed:@"girl"];
    }else{
        self.sexNum = 0;
        _sexImgView.image = [UIImage imageNamed:@""];

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
    [str addAttribute:NSForegroundColorAttributeName value:[CommonFuction colorFromHexRGB:@"f7c250"] range:NSMakeRange(2,leng + 3)];
    _contributionLabel.attributedText = str;

}

- (void)setRankIndex:(NSInteger)rankIndex
{
    _rankIndex = rankIndex;
    
    [_indexButton setImage:nil forState:UIControlStateNormal];
    [_indexButton setTitle:[NSString stringWithFormat:@"%ld",_rankIndex+1] forState:UIControlStateNormal];
}

- (void)layoutSubviews
{
//    CGSize nickSize = [_nilkLabel sizeThatFits:CGSizeMake(70, MAXFLOAT)];
    CGSize nickSize = [CommonFuction sizeOfString:_nilkLabel.text maxWidth:100 maxHeight:20 withFontSize:14.0f];

    CGSize contSize = [_contributionLabel sizeThatFits:CGSizeMake(150, MAXFLOAT)];
    _indexButton.frame = CGRectMake(5, 10, 35, 35);
    _headImgView.frame = CGRectMake(55, 8, 42, 42);
    _nilkLabel.frame =CGRectMake(105, 11, nickSize.width, 15);
    if(self.sexNum >0)
    {
        _sexImgView.frame=CGRectMake(_nilkLabel.frame.origin.x + nickSize.width + 5, 8, 20, 20);
        if(self.vipNum >0)
        {
            _vipImgView.frame = CGRectMake(_nilkLabel.frame.origin.x + nickSize.width  + 28, 11, 37.5, 15);
            _wealthImgView.frame = CGRectMake(_nilkLabel.frame.origin.x + nickSize.width + 71, 11, 33, 15);
        }else
        {
            _wealthImgView.frame = CGRectMake(_nilkLabel.frame.origin.x + nickSize.width + 28, 11, 33, 15);
        }
        
    }else
    {
        if(self.vipNum >0)
        {
            _vipImgView.frame = CGRectMake(_nilkLabel.frame.origin.x + nickSize.width + 5, 11, 37.5, 15);
            _wealthImgView.frame = CGRectMake(_nilkLabel.frame.origin.x + nickSize.width + 48, 11, 33, 15);
        }else
        {
            _wealthImgView.frame = CGRectMake(_nilkLabel.frame.origin.x + nickSize.width + 5, 11, 33, 15);
        }
    }
    _contributionLabel.frame = CGRectMake(105, 32, contSize.width, contSize.height);

    _lineview.frame = CGRectMake(0, 54, SCREEN_WIDTH, 1);
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
