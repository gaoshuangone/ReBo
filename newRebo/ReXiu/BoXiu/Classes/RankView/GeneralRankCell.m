//
//  GeneralRankCell.m
//  BoXiu
//
//  Created by andy on 14-4-29.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "GeneralRankCell.h"
#import "UIImageView+WebCache.h"
#import "AppInfo.h"
#import "UserInfoManager.h"

@interface GeneralRankCell ()

@property (nonatomic,strong) UILabel *userNameLable;
@property (nonatomic,strong) UIImageView *consumptionLevelImageView;
@property (nonatomic,strong) UIImageView *starLevelImageView;
@property (nonatomic,strong) UIButton *indexButton;

//新增需求添加的
@property (nonatomic,strong) UIImageView *starIcon;  //直播小图标
@property (nonatomic,strong) UILabel *Idxcode;      //靓号
@property (nonatomic,strong) UIImageView *rightArrow;    //右边小箭头图标

@property (nonatomic,strong) UIImageView *lineImg;
@property (nonatomic,strong) UIImageView *bgImg;

@end

@implementation GeneralRankCell//

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self initCell];
        
        self.rankCellType = RankCellTypeStar;
        
        if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
            [self setSeparatorInset:UIEdgeInsetsZero];
        }
    }
    return self;
}

- (void)initCell
{
//    _bgImg = [[UIImageView alloc] initWithFrame:CGRectZero];
//   [self.contentView addSubview:_bgImg];
    
    _headImg = [[UIImageView alloc] initWithFrame:CGRectZero];
    [_headImg.layer setMasksToBounds:YES];
    [_headImg.layer setCornerRadius:22.0f]; //设置矩形四个圆角半径
    [self.contentView addSubview:_headImg];
    
    _userNameLable = [[UILabel alloc] initWithFrame:CGRectZero];
    _userNameLable.textColor = [CommonFuction colorFromHexRGB:@"454a4d"];
    _userNameLable.font = [UIFont systemFontOfSize:14.0f];
    [self.contentView addSubview:_userNameLable];
    
    _consumptionLevelImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:_consumptionLevelImageView];
    
    _starLevelImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:_starLevelImageView];
    
    _indexButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _indexButton.titleLabel.font=[UIFont systemFontOfSize:18];
    _indexButton.userInteractionEnabled= NO;
    [self.contentView addSubview:_indexButton];
    
    _starIcon = [[UIImageView alloc] initWithFrame:CGRectZero];
    _starIcon.image = [UIImage imageNamed:@"startIconGR"];
    [self.contentView addSubview:_starIcon];
    
    _Idxcode = [[UILabel alloc] initWithFrame:CGRectZero];
    _Idxcode.textColor = [CommonFuction colorFromHexRGB:@"959596"];
    _Idxcode.font = [UIFont systemFontOfSize:12.0f];
    [self.contentView addSubview:_Idxcode];
    
    _rightArrow = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:_rightArrow];
    
    _lineImg = [[UIImageView alloc] initWithFrame:CGRectZero];
    _lineImg.backgroundColor = [CommonFuction colorFromHexRGB:@"e5e5e5"];
    [self.contentView addSubview:_lineImg];

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

- (void)setStarInfo:(StarInfo *)starInfo
{
    if (starInfo == nil)
    {
        return;
    }
    _starInfo = starInfo;
    
    NSURL *headUrl;
    
    if([_starInfo isKindOfClass:[StarInfo class]]){
        _starLevelImageView.image = [[UserInfoManager shareUserInfoManager] imageOfStar:_starInfo.starlevelid];
    }

    headUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[AppInfo shareInstance].res_server,_starInfo.photo]];
    [_headImg sd_setImageWithURL:headUrl placeholderImage:[UIImage imageNamed:@"rank_online"]];
        
    _consumptionLevelImageView.image = [[UserInfoManager shareUserInfoManager] imageOfconsumerlevelweight:_starInfo.consumerlevelweight];
    
    if (starInfo.onlineflag)
    {
        _bgImg.image = [UIImage imageNamed:@"rank_online"];
        _starIcon.hidden = NO;
    }
    else
    {
        _bgImg.image = [UIImage imageNamed:@"rankNoOnline"];
        _starIcon.hidden = YES;
    }

    _userNameLable.text = _starInfo.nick;

    if (_selectBtntag)
    {
        _Idxcode.hidden = YES;
    }
    else
    {
        _Idxcode.hidden = NO;
        _rightArrow.hidden = NO;
        _Idxcode.text = [NSString stringWithFormat:@" %ld",starInfo.idxcode];
//        [_rightArrow setImage:[UIImage imageNamed:@"rank_arrow"]];
    }
    
}

- (void)setUserInfo:(UserInfo *)userInfo
{
    [self setStarInfo:(StarInfo *)userInfo];
}

- (UserInfo *)userInfo
{
    return (UserInfo *)_starInfo;
}

- (void)layoutSubviews
{
    int nXOffset = 12;
    _indexButton.frame = CGRectMake(nXOffset,(self.frame.size.height - 22)/2-8-4,14*5/3,28*5/3);
    nXOffset = nXOffset + 24 + 10;
    
//    _bgImg.frame = CGRectMake(nXOffset, (self.frame.size.height - 50)/2 , 50, 50);
    _headImg.frame = CGRectMake(nXOffset + 3, (self.frame.size.height - 40)/2-1.5 , 44, 44);
    nXOffset = nXOffset + 50 + 10;
    
    _starIcon.frame = CGRectMake(_headImg.frame.origin.x + 22+4+4,(self.frame.size.height - 16)/2+7+4+4+4, 14, 14);
    
    _userNameLable.frame = CGRectMake(_headImg.frame.origin.x + _headImg.frame.size.width + 15, 14, self.frame.size.width -(_headImg.frame.origin.x + _headImg.frame.size.width + 15 +15), 20);
    _consumptionLevelImageView.frame = CGRectMake( _userNameLable.frame.origin.x, 10 + 20 + 10, 36, 15);
    _starLevelImageView.frame = CGRectMake( _consumptionLevelImageView.frame.origin.x, 10 + 20 + 10, 33, 15);
    
    if (_consumptionLevelImageView.hidden == YES)
    {
        _Idxcode.frame = CGRectMake(_consumptionLevelImageView.frame.origin.x + 40, 10 + 20 + 7, 160, 24);
    }
    else
    {
        _Idxcode.frame = CGRectMake(_consumptionLevelImageView.frame.origin.x + 45, 10 + 20 + 7, 160, 24);
    }

    _rightArrow.frame = CGRectMake(295, 30, 9, 17);
    
    self.lineImg.frame = CGRectMake(nXOffset, self.frame.size.height - 0.5, self.frame.size.width-nXOffset, 0.5);

}

+ (CGFloat)height
{
    return 71.0f;
}


-(void) setRankIndex:(NSInteger)rankIndex
{
    _rankIndex=rankIndex;

    if(_rankIndex==0)
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
        [_indexButton setTitle:[NSString stringWithFormat:@"%ld",_rankIndex+1] forState:UIControlStateNormal];
         [_indexButton setTitleColor:[CommonFuction colorFromHexRGB:@"454a4d"] forState:UIControlStateNormal];
        _indexButton.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    }
    
}

-(void) setRankCellType:(NSInteger)rankCellType
{
    _rankCellType=rankCellType;
    switch (_rankCellType)
    {
        case RankCellTypeStar:
            _starLevelImageView.hidden=NO;
            _consumptionLevelImageView.hidden=YES;
            _rightArrow.hidden = NO;
//            _starIcon.hidden = NO;
            break;
        case RankCellTypeUser:
            _starLevelImageView.hidden=YES;
            _consumptionLevelImageView.hidden=NO;
            _rightArrow.hidden = YES;
            _starIcon.hidden = YES;
            
            break;
        default:
            break;
    }
}


#pragma mark _

- (void) personArchives
{
    if (_starInfo.onlineflag == 1)
    {
        EWPLog(@"到直播间");
        
    }
    else
    {
        EWPLog(@"到个人档案");
        if (self.delegate && [self.delegate respondsToSelector:@selector(generalRankCell:didSeletedUserInfo:)])
        {
            [self.delegate generalRankCell:self didSeletedUserInfo:self.userInfo];
        }
    }
   
}


@end
