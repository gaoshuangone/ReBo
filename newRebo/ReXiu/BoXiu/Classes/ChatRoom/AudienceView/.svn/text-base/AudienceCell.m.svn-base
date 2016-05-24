//
//  AudienceCell.m
//  BoXiu
//
//  Created by andy on 14-5-16.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "AudienceCell.h"
#import "AppInfo.h"
#import "UIImageView+WebCache.h"
#import "CommonFuction.h"

@interface AudienceCell ()
@property (nonatomic,strong) UIImageView *headImageView;
@property (nonatomic,strong) UILabel *nickLable;
@property (nonatomic,strong) UILabel *userIdLabel;
@property (nonatomic,strong) UIImageView *vipImageView;
@property (nonatomic,strong) UIImageView *starImageView;
@property (nonatomic,strong) UIImageView *consumImgeView;
@property (nonatomic,strong) UIImageView *arrowImageView;
@property (nonatomic,strong) UIImageView *lineImageView;
@property (nonatomic,strong) UIImageView *defaultHead;

@end

@implementation AudienceCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self initView];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)initView
{
    self.IsOpen = NO;
    
//    _defaultHead = [[UIImageView alloc] initWithFrame:CGRectZero];
//    _defaultHead.image = [UIImage imageNamed:@"audiece_default"];
//    [self.contentView addSubview:_defaultHead];
    
    _headImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _headImageView.layer.masksToBounds = YES;
    _headImageView.layer.cornerRadius = 47/2;
    [self.contentView addSubview:_headImageView];
    
    _nickLable = [[UILabel alloc] initWithFrame:CGRectZero];
    _nickLable.font = [UIFont systemFontOfSize:14.0f];
//    _nickLable.textColor = [UIColor colorWithRed:107/255.0 green:107/255.0 blue:107/255.0 alpha:1.0];
    [self.contentView addSubview:_nickLable];

    _userIdLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _userIdLabel.font = [UIFont systemFontOfSize:13.0f];
    _userIdLabel.textColor = [CommonFuction colorFromHexRGB:@"f7c250"];
//    [self.contentView addSubview:_userIdLabel];
 
    _vipImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview: _vipImageView];
    
    _starImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _starImageView.hidden = YES;
    [self.contentView addSubview: _starImageView];
    
    _consumImgeView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _consumImgeView.hidden = YES;
    [self.contentView addSubview:_consumImgeView];
    
    _arrowImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _arrowImageView.image = [UIImage imageNamed:@"arrow_fold"];
    [self.contentView addSubview:_arrowImageView];
    
    _lineImageView= [[UIImageView alloc] initWithFrame:CGRectZero];
    _lineImageView.backgroundColor = [CommonFuction colorFromHexRGB:@"E2E2E2"];
    [self.contentView addSubview:_lineImageView];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setUserInfo:(UserInfo *)userInfo
{
    _userInfo = userInfo;
    
    if (userInfo.nick)
    {
        self.nickLable.text = userInfo.nick;
    }
 
    if (userInfo.idxcode)
    {
        self.userIdLabel.text = [NSString stringWithFormat:@" %ld",(long)userInfo.idxcode];
    }
    
    if (userInfo.hidden == 2)
    {
        self.nickLable.textColor = [UIColor redColor];
    }
    else
    {
        self.nickLable.textColor =[CommonFuction colorFromHexRGB:@"454a4d"];
//        [UIColor colorWithRed:107/255.0 green:107/255.0 blue:107/255.0 alpha:1.0];
    }
 
    NSURL *headUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[AppInfo shareInstance].res_server,userInfo.photo]];
    [self.headImageView sd_setImageWithURL:headUrl placeholderImage:nil];
    self.vipImageView.image = [[UserInfoManager shareUserInfoManager] imageOfVip:userInfo.privlevelweight];

if(self.userInfo.userId == [[UserInfoManager shareUserInfoManager] currentStarInfo].userId)
   {
        EWPLog(@"%ld",(long)[[UserInfoManager shareUserInfoManager] currentStarInfo].starlevelid);
        self.starImageView.image = [[UserInfoManager shareUserInfoManager] imageOfconsumerlevelweight:[[UserInfoManager shareUserInfoManager] currentStarInfo].consumerlevelweight];
   }
    else
   {
//       self.consumImgeView.image = [[UserInfoManager shareUserInfoManager] imageOfconsumerlevelweight:[[UserInfoManager shareUserInfoManager] currentStarInfo].privlevelweight];

        self.consumImgeView.image = [[UserInfoManager shareUserInfoManager] imageOfconsumerlevelweight:userInfo.consumerlevelweight];
//        self.consumImgeView.image = [[UserInfoManager shareUserInfoManager]imageOfStar:userInfo.privlevelweight];
        self.starImageView.image = nil;
    }
}

- (void)setOpen:(BOOL)IsOpen
{
    _IsOpen = IsOpen;
    if (IsOpen)
    {
        self.arrowImageView.image = [UIImage imageNamed:@"arrow_fold"];
//        self.lineImageView.image = [UIImage imageNamed:@"line_open"];
//        _lineImageView.backgroundColor = [CommonFuction colorFromHexRGB:@"ffffff"];
    }
    else
    {
        self.arrowImageView.image = [UIImage imageNamed:@"rightArrow"];
//        self.lineImageView.image = nil;
//        self.lineImageView.backgroundColor = [UIColor grayColor];
//        _lineImageView.backgroundColor = [CommonFuction colorFromHexRGB:@"cbcbcb"];
    }
}

- (void)layoutSubviews
{
    _defaultHead.frame = CGRectMake(13, (58 - 47)/2, 47, 47);
    self.headImageView.frame = CGRectMake(17, (58 - 47)/2 , 47, 47);

    CGSize nickSize = [CommonFuction sizeOfString:self.userInfo.nick maxWidth:300 maxHeight:30 withFontSize:15.0f];
    self.nickLable.frame = CGRectMake(47+30, 10, nickSize.width, nickSize.height);
    
    int nXOffset = 77;
     if(self.userInfo.userId == [[UserInfoManager shareUserInfoManager] currentStarInfo].userId)
    {
        self.consumImgeView.hidden = YES;
        self.starImageView.hidden = NO;
        self.starImageView.frame = CGRectMake(nXOffset, 32, 33, 15);
        nXOffset += 33;
    }
    else
    {
        self.consumImgeView.hidden = NO;
        self.starImageView.hidden = YES;
        self.consumImgeView.frame = CGRectMake(nXOffset, 33, 36, 15);
        nXOffset += 37;
    }
    
    if (self.userInfo.privlevelweight == 10 || self.userInfo.privlevelweight == 14)
    {
        self.vipImageView.hidden = NO;
        nXOffset += 2;
        self.vipImageView.frame = CGRectMake(nXOffset, 33, 36, 15);
        nXOffset += 40;
    }
    else
    {
        self.vipImageView.hidden = YES;
    }
    
    CGSize idSize = [CommonFuction sizeOfString:self.userIdLabel.text maxWidth:300 maxHeight:30 withFontSize:15.0f];
    self.userIdLabel.frame = CGRectMake(nXOffset + 5, 31, idSize.width, idSize.height);
    
//    CGSize arrowSize = self.arrowImageView.image.size;
//    self.arrowImageView.frame = CGRectMake(self.frame.size.width - arrowSize.width - 20, (60 - arrowSize.height)/2, arrowSize.width, arrowSize.height);

    self.lineImageView.frame = CGRectMake(self.nickLable.frame.origin.x, self.frame.size.height - 0.5, self.frame.size.width, 0.5);

    
}

+ (CGFloat)height
{
    return 58.0f;
}

@end
