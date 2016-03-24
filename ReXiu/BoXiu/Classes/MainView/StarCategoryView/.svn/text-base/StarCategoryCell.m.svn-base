//
//  TableViewCell+StarCategoryCell.m
//  BoXiu
//
//  Created by tongmingyu on 15/11/4.
//  Copyright © 2015年 rexiu. All rights reserved.
//
#import "StarCategoryCell.h"
#import "UIImageView+WebCache.h"

@interface StarCategoryCell ()
@property (nonatomic,strong) UIView *starview;
@property (nonatomic,strong) UIImageView *adPhoto;
@property (nonatomic,strong) UILabel *nick;
@property (nonatomic,strong) UILabel *introduction;
@property (nonatomic,strong) UILabel *status;//播放状态
@property (nonatomic,strong) UIImageView *starperson;
@property (nonatomic,strong) UILabel *userNum;
@property (nonatomic,strong) UIImageView *hLineImg;
@property (nonatomic,strong) UILabel *heartlab;
@property (nonatomic,strong) UILabel *personcont;
@property (nonatomic,strong) UILabel *timerlab;
@end

@implementation StarCategoryCell

- (void)awakeFromNib {
    // Initialization code
    
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [CommonFuction colorFromHexRGB:@"f6f6f6"];
        self.contentView.backgroundColor = [UIColor clearColor];
        
        _starview = [[UIView alloc] initWithFrame:CGRectZero];
        _starview.layer.cornerRadius = 8.0f;
        _starview.layer.masksToBounds = YES;
        _starview.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_starview];
        
        _adPhoto = [[UIImageView alloc] initWithFrame:CGRectZero];
        _adPhoto.layer.cornerRadius = 4.0f;
        _adPhoto.layer.masksToBounds = YES;
        [self.contentView addSubview:_adPhoto];
        
        _heartlab = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_heartlab];
        
        _personcont = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_personcont];
        
        _nick = [[UILabel alloc] initWithFrame:CGRectZero];
        _nick.font = [UIFont boldSystemFontOfSize:14.0f];
        _nick.textColor = [CommonFuction colorFromHexRGB:@"454a4d"];
        [self.contentView addSubview:_nick];
        
        _introduction = [[UILabel alloc] initWithFrame:CGRectZero];
        _introduction.font = [UIFont systemFontOfSize:13.0f];
        _introduction.textColor = [CommonFuction colorFromHexRGB:@"575757"];
        _introduction.lineBreakMode = NSLineBreakByTruncatingTail;
        _introduction.numberOfLines = 1;
        [self.contentView addSubview:_introduction];
        
        _starperson = [[UIImageView alloc] initWithFrame:CGRectZero];
        _starperson.image = [UIImage imageNamed:@"star_person"];
        [self.contentView addSubview:_starperson];
        
        _status = [[UILabel alloc] initWithFrame:CGRectZero];
        _status.layer.masksToBounds = YES;
        _status.font = [UIFont systemFontOfSize:14.0f];
        _status.textColor = [CommonFuction colorFromHexRGB:@"ffffff"];
        _status.textAlignment = NSTextAlignmentCenter;
        [_adPhoto addSubview:_status];
        
        _userNum = [[UILabel alloc] initWithFrame:CGRectZero];
        _userNum.font = [UIFont boldSystemFontOfSize:12.0f];
        _userNum.textColor = [CommonFuction colorFromHexRGB:@"454a4d"];
        [self.contentView addSubview:_userNum];
        
        
        _timerlab = [[UILabel alloc] initWithFrame:CGRectZero];
        _timerlab.font = [UIFont systemFontOfSize:13.0f];
        _timerlab.textColor = [CommonFuction colorFromHexRGB:@"959596"];
        [self.contentView addSubview:_timerlab];
        
        _hLineImg = [[UIImageView alloc] initWithFrame:CGRectZero];
        _hLineImg.backgroundColor = [CommonFuction colorFromHexRGB:@"cbcbcb"];
        [self.contentView addSubview:_hLineImg];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setStarInfo:(StarInfo *)starInfo
{
    _starInfo = starInfo;


    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *dater = [dateFormat dateFromString:starInfo.showbegintime];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[dater timeIntervalSince1970]];
    
    NSString *urlString = [NSString stringWithFormat:@"%@/%@",[AppInfo shareInstance].res_server,starInfo.adphoto];
    [self.adPhoto sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"star_cover_default"]];
    
    self.nick.text = starInfo.nick;
    
    if(starInfo.praisecount == 0)
    {
        self.heartlab.text = [NSString stringWithFormat:@"%ldk",(long)starInfo.praisecount/1000];
    }
    else
    {
        self.heartlab.text = [NSString stringWithFormat:@"%.1fk",(float)starInfo.praisecount/1000];
    }
    _heartlab.font = [UIFont systemFontOfSize:14.0f];
    _heartlab.textColor = [CommonFuction colorFromHexRGB:@"454a4d"];
    
    if (!starInfo.introduction) {
        starInfo.introduction = @"全民星直播互动平台，娱乐你的生活";
    }
    
    self.introduction.text = starInfo.introduction;
    
    self.status.text = @"直播LIVE";
    _status.backgroundColor = [CommonFuction colorFromHexRGB:@"d14c49" alpha:0.8];

    // 调整行间距
//    [AppInfo setLabel:self.introduction string:starInfo.introduction withLineSpacing:2.5];
//    _introduction.font = [UIFont systemFontOfSize:12.0f];
//    _introduction.textColor = [CommonFuction colorFromHexRGB:@"575757"];
    if(starInfo.count < 1000)
    {
        self.userNum.text = [NSString stringWithFormat:@"%ld",(long)starInfo.count];
    }
    else if(starInfo.count >= 1000 && starInfo.count <9950)
    {
        self.userNum.text = [NSString stringWithFormat:@"%.1fk",(float)starInfo.count/1000];
    }
    else
    {
        self.userNum.text = [NSString stringWithFormat:@"%.1fw",(float)starInfo.count/10000];
    }
    _userNum.font = [UIFont systemFontOfSize:14.0f];
    _userNum.textColor = [CommonFuction colorFromHexRGB:@"454a4d"];
    
    NSString *timeS = [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]];
    long long nowtime = [timeS longLongValue];
    long datetimer = nowtime + [AppInfo shareInstance].timerMillis;
    
    _timerlab.text = [AppInfo formatTimeStamp:timeSp nowTimerStamp:[NSDate dateWithTimeIntervalSince1970:datetimer]];
    
}


- (void)layoutSubviews
{
    self.adPhoto.frame = CGRectMake(10, 9, 100, 75);
    self.status.frame = CGRectMake(0, 55, 100, 20);
    CGSize nickSize = [CommonFuction sizeOfString:self.nick.text maxWidth:150 maxHeight:20 withFontSize:15.0f];
    self.nick.frame = CGRectMake(124, 14, nickSize.width, 20);
//    [self.nick sizeToFit];
    self.introduction.frame = CGRectMake(124, 27, 190,40 );
    self.starperson.frame = CGRectMake(124, 68, 11, 11);
    self.userNum.frame = CGRectMake(140, 67, 100, 15);
    CGSize timesize = [CommonFuction sizeOfString:self.timerlab.text maxWidth:80 maxHeight:15 withFontSize:13.0f];
    self.timerlab.frame = CGRectMake(SCREEN_WIDTH - 14-timesize.width, 65.8, timesize.width, timesize.height);
    self.hLineImg.frame = CGRectMake(0, self.frame.size.height - 0.5, self.frame.size.width, 0.5);

}

- (void)OnAttend:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(StarCategoryCell:attendStar:)])
    {
        [self.delegate StarCategoryCell:self attendStar:self.starInfo];
    }
}

+ (CGFloat)height
{
    return 93.0f;
}
@end

