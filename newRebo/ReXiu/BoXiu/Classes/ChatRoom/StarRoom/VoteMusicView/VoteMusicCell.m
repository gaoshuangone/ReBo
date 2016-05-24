//
//  VoteMusicCell.m
//  BoXiu
//
//  Created by tongmingyu on 14-12-25.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "VoteMusicCell.h"
#import "UserInfoManager.h"

@interface VoteMusicCell()

@property (nonatomic,strong) UIImageView *musicImgView;
@property (nonatomic,strong) UILabel *musicName;
@property (nonatomic,strong) UILabel *voteNumber;
@property (nonatomic,strong) UIImageView *voteImgView;
@property (nonatomic,strong) UIButton *voteBtn;

@end

@implementation VoteMusicCell


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self initWithView];
    }
    
    return self;
}

-(void)initWithView
{
    _musicImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:_musicImgView];
    
    _musicName = [[UILabel alloc] initWithFrame:CGRectZero];
    _musicName.textColor = [CommonFuction colorFromHexRGB:@"ffffff"];
    _musicName.font = [UIFont systemFontOfSize:14.0f];
    _musicName.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_musicName];
    
    _voteNumber = [[UILabel alloc] initWithFrame:CGRectZero];
    _voteNumber.textColor = [CommonFuction colorFromHexRGB:@"ffffff"];
    _voteNumber.font = [UIFont systemFontOfSize:14.0f];
    _voteNumber.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_voteNumber];
    
    _voteImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:_voteImgView];
    
    UIImage *selectImg = [CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"ffffff" alpha:0.5] size:CGSizeMake(54, 20)];
    
    _voteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_voteBtn setTitle:@"投票" forState:UIControlStateNormal];
    _voteBtn.titleLabel.font = [UIFont boldSystemFontOfSize:12.0f];
    _voteBtn.layer.borderWidth = 1;
    _voteBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    _voteBtn.layer.masksToBounds = YES;
    _voteBtn.layer.cornerRadius = 10;
    [_voteBtn setBackgroundImage:selectImg forState:UIControlStateHighlighted];
    UILongPressGestureRecognizer *longPressMoreVote = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(MoreVote:)];
    longPressMoreVote.minimumPressDuration = 0.8;  //按的时间
    [_voteBtn addGestureRecognizer:longPressMoreVote];
    [_voteBtn addTarget:self action:@selector(OneVote) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_voteBtn];
}


-(void)setMusicData:(MusicData *)musicData
{
    _musicData = musicData;
    _musicImgView.image = [UIImage imageNamed:@"music"];
    _musicName.text = musicData.musicname;
    _voteNumber.text = [NSString stringWithFormat:@"%ld",(long)musicData.ticket];
    _voteImgView.image = [UIImage imageNamed:@"personGas"];
}

- (void)canOperate:(NSInteger)canOperate
{
    if (canOperate == 1 && ![[UserInfoManager shareUserInfoManager]currentStarInfo].onlineflag)
    {
        _voteBtn.enabled = YES;
        [_voteBtn setTitleColor:[CommonFuction colorFromHexRGB:@"ffffff"] forState:UIControlStateNormal];
        _voteBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    }
    else
    {
        _voteBtn.enabled = NO;
        [_voteBtn setTitle:@"已结束" forState:UIControlStateNormal];
        [_voteBtn setTitleColor:[CommonFuction colorFromHexRGB:@"acacac"] forState:UIControlStateNormal];
        _voteBtn.layer.borderColor = [UIColor clearColor].CGColor;
    }
}


-(void)OneVote
{
    if (_delegate && [_delegate respondsToSelector:@selector(voteMusicCell:musicData:longPressGesture:)])
    {
        [_delegate voteMusicCell:self musicData:_musicData longPressGesture:NO];
    }
}

-(void)MoreVote:(UILongPressGestureRecognizer *)gestureRecognizer
{
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan)
    {
        EWPLog(@"长按事件");
        if (_delegate && [_delegate respondsToSelector:@selector(voteMusicCell:musicData:longPressGesture:)])
        {
           [_delegate voteMusicCell:self musicData:_musicData longPressGesture:YES];
        }
    }
}

-(void)layoutSubviews
{
    CGSize voteNumberSize = [CommonFuction sizeOfString:_voteNumber.text maxWidth:95 maxHeight:20 withFontSize:14.0f];
    _musicImgView.frame = CGRectMake(14, 13, 14, 15);
    _musicName.frame = CGRectMake(37, 11, 108, 20);
    _voteNumber.frame = CGRectMake(155, 11, voteNumberSize.width, 20);
    _voteImgView.frame = CGRectMake(161 + _voteNumber.frame.size.width, 13, 9, 11.5);
    _voteBtn.frame = CGRectMake(250, 13, 54, 20);
}


+(CGFloat)height
{
    return 43;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
