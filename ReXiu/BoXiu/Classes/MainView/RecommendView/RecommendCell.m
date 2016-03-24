//
//  RecommendCell.m
//  BoXiu
//
//  Created by andy on 14-9-24.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "RecommendCell.h"
#import "UIImageView+WebCache.h"

@interface RecommendCell ()
@property (nonatomic,strong) UIView *starview;

@property (nonatomic,strong) UIImageView *photo;
//@property (nonatomic,strong) UIButton *starBtn;
@property (nonatomic,strong) UIImageView *starLevel;
@property (nonatomic,strong) UILabel *nick;
@property (nonatomic,strong) UILabel *introduction;
@property (nonatomic,strong) UIButton *attendBtn;
@property (nonatomic,strong) UIImageView *status;//播放状态
@property (nonatomic,strong) UIImageView *starperson;
@property (nonatomic,strong) UIImageView *starheart;
@property (nonatomic,strong) UILabel *userNum;
@property (nonatomic,strong) UILabel *livelab;
@property (nonatomic,strong) UIImageView *hLineImg;
@property (nonatomic,strong) UIView *line;
@property (nonatomic,strong) UILabel *heartlab;
@property (nonatomic,strong) UILabel *personcont;
@property (nonatomic,assign) NSInteger userid;

@end


@implementation RecommendCell

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
        
        _photo = [[UIImageView alloc] initWithFrame:CGRectZero];
//        _photo.contentMode = UIViewContentModeScaleAspectFit;
        _photo.layer.cornerRadius = 8.0f;
        _photo.layer.masksToBounds = YES;
        [self.contentView addSubview:_photo];
        
        _starview = [[UIView alloc] initWithFrame:CGRectZero];
        _starview.backgroundColor = [UIColor whiteColor];
        [_photo addSubview:_starview];
        
        _adPhoto = [[UIImageView alloc] initWithFrame:CGRectZero];
        _adPhoto.layer.cornerRadius = 20.0f;
        _adPhoto.layer.masksToBounds = YES;
        [_starview addSubview:_adPhoto];
        
        _livelab = [[UILabel alloc] initWithFrame:CGRectZero];
        _livelab.font = [UIFont boldSystemFontOfSize:13.0f];
        _livelab.layer.cornerRadius = 4.0f;
        _livelab.layer.masksToBounds = YES;
        _livelab.textAlignment = NSTextAlignmentCenter;
        _livelab.textColor = [CommonFuction colorFromHexRGB:@"ffffff"];
        [_photo addSubview:_livelab];
        
        _starLevel = [[UIImageView alloc] initWithFrame:CGRectZero];
        [_starview addSubview:_starLevel];
        
        _heartlab = [[UILabel alloc] initWithFrame:CGRectZero];
        [_starview addSubview:_heartlab];
        
        _personcont = [[UILabel alloc] initWithFrame:CGRectZero];
        [_starview addSubview:_personcont];
        
        _nick = [[UILabel alloc] initWithFrame:CGRectZero];
        _nick.font = [UIFont boldSystemFontOfSize:14.0f];
        _nick.textColor = [CommonFuction colorFromHexRGB:@"454a4d"];
        [_starview addSubview:_nick];
        
        _introduction = [[UILabel alloc] initWithFrame:CGRectZero];
        _introduction.font = [UIFont systemFontOfSize:13.0f];
        _introduction.textColor = [CommonFuction colorFromHexRGB:@"454a4d"];
//        _introduction.lineBreakMode = NSLineBreakByTruncatingTail;
        _introduction.numberOfLines = 1;
        [_starview addSubview:_introduction];
        
        _starperson = [[UIImageView alloc] initWithFrame:CGRectZero];
        _starperson.image = [UIImage imageNamed:@"star_person"];
        [_starview addSubview:_starperson];
        
        _line=[[UIView alloc] initWithFrame:CGRectZero];
        _line.backgroundColor = [CommonFuction colorFromHexRGB:@"cbcbcb"];
        [_starview addSubview:_line];
        
        _starheart = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.starheart.image = [UIImage imageNamed:@"star_heart"];
        [_starview addSubview:_starheart];
        
        _status = [[UIImageView alloc] initWithFrame:CGRectZero];
        [_starview addSubview:_status];
        
        _userNum = [[UILabel alloc] initWithFrame:CGRectZero];
        _userNum.font = [UIFont boldSystemFontOfSize:12.0f];
        _userNum.textColor = [CommonFuction colorFromHexRGB:@"454a4d"];
//        [_starview addSubview:_userNum];      (6, 198, 65, 65)

        
        _attendBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_attendBtn addTarget:self action:@selector(OnAttend:) forControlEvents:UIControlEventTouchUpInside];
//        [_starview addSubview:_attendBtn];
        
//        UIView *liveview = [[UIView alloc]initWithFrame:CGRectMake(275, 170, 41, 38)];
//        liveview.backgroundColor = [UIColor clearColor];
//        [self.contentView  addSubview:liveview];
        
        _hLineImg = [[UIImageView alloc] initWithFrame:CGRectZero];
        _hLineImg.backgroundColor = [CommonFuction colorFromHexRGB:@"cbcbcb"];
        [_starview addSubview:_hLineImg];
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
    UIImage *image;
    NSString *urlphoto = [NSString stringWithFormat:@"%@%@",[AppInfo shareInstance].res_server,starInfo.adphoto];

    [self.photo sd_setImageWithURL:[NSURL URLWithString:urlphoto] placeholderImage:nil];
    image = self.photo.image;

    float fleng = self.photo.image.size.width/self.photo.image.size.height;
    float Proportion = 306.000000/245.000000;
    float  j = image.size.width/image.size.height;
    float k = 4.000000/3.000000;
    
    if (j == k )
    {
        [_photo setImage:image];
    }
    else if (fleng <=1 || Proportion< fleng) {
        float r =image.size.height -(image.size.width / Proportion);
        CGRect rect = CGRectMake(0,r/2, image.size.width, 245*(image.size.width/306) );//创建矩形框
        UIImageView *contentView = [[UIImageView alloc] initWithFrame:rect];
        contentView.image=[UIImage imageWithCGImage:CGImageCreateWithImageInRect([image CGImage], rect)];
        [_photo setImage:contentView.image];
        
    }
    else
    {
        float r =image.size.width -(image.size.height * Proportion);
        CGRect rect = CGRectMake(r+10/2,0, image.size.width/245*306, image.size.height );//创建矩形框
        UIImageView *contentView = [[UIImageView alloc] initWithFrame:rect];
        contentView.image=[UIImage imageWithCGImage:CGImageCreateWithImageInRect([image CGImage], rect)];
        [_photo setImage:contentView.image];
    }
    if (image == nil) {
        [_photo setImage:[UIImage imageNamed:@"star_cover_default"]];
    }
    
    NSString *urlString = [NSString stringWithFormat:@"%@/%@",[AppInfo shareInstance].res_server,starInfo.photo];
    [self.adPhoto sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"rank_online"]];
    
    self.starLevel.image = [[UserInfoManager shareUserInfoManager] imageOfStar:starInfo.starlevelid];
    
    self.nick.text = starInfo.nick;
    if (starInfo.praisecount<1000) {
        self.heartlab.text = [NSString stringWithFormat:@"%ld",(long)starInfo.praisecount];
    }
    else if (starInfo.praisecount >=1000 && starInfo.praisecount <9950)
    {
        self.heartlab.text = [NSString stringWithFormat:@"%.1fk",(float)starInfo.praisecount/1000];
    }
    else
    {
        self.heartlab.text = [NSString stringWithFormat:@"%.1fw",(float)starInfo.praisecount/10000];
    }
    _heartlab.font = [UIFont systemFontOfSize:14.0f];
    _heartlab.textColor = [CommonFuction colorFromHexRGB:@"959596"];
    if(starInfo.count < 1000)
    {
        self.personcont.text = [NSString stringWithFormat:@"%ld",(long)starInfo.count];
    }
    else if(starInfo.count >= 1000 && starInfo.count <9950)
    {
        self.personcont.text = [NSString stringWithFormat:@"%.1fk",(float)starInfo.count/1000];
    }
    else
    {
        self.personcont.text = [NSString stringWithFormat:@"%.1fw",(float)starInfo.count/10000];
    }
    _personcont.font = [UIFont systemFontOfSize:14.0f];
    _personcont.textColor = [CommonFuction colorFromHexRGB:@"959596"];
    
    if (!starInfo.introduction) {
        starInfo.introduction =  @"全民星直播互动平台，娱乐你的生活";
    }

    self.introduction.text = starInfo.introduction;
    
    // 调整行间距
//    [AppInfo setLabel:self.introduction string:starInfo.introduction withLineSpacing:2.5];
//    _introduction.font = [UIFont systemFontOfSize:13.0f];

    if (starInfo.onlineflag)
    {
        //设置直播图片
        self.status.image = [UIImage imageNamed:@"playing"];
        _livelab.text =@"直播LIVE";
        _livelab.backgroundColor = [CommonFuction colorFromHexRGB:@"d14c49"];
        self.livelab.frame = CGRectMake(235, 7, 65, 23);

    }
    else
    {
        //设置未开播图片
        self.status.image = [UIImage imageNamed:@"notplaying"];
        _livelab.text = @"未开播";
        _livelab.backgroundColor = [CommonFuction colorFromHexRGB:@"000000" alpha:0.6];
        self.livelab.frame = CGRectMake(245, 7, 55, 23);


    }
    self.userNum.text = [NSString stringWithFormat:@"%ld人",starInfo.count];
    
    if ([AppInfo shareInstance].bLoginSuccess)
    {
        if (starInfo.attentionflag)
        {
            //已关注图片
            [self.attendBtn setImage:[UIImage imageNamed:@"main_attend_selected"] forState:UIControlStateNormal];
        }
        else
        {
            //未关注图片
            [self.attendBtn setImage:[UIImage imageNamed:@"main_attend_normal"] forState:UIControlStateNormal];
        }
    }
    else
    {
        //未关注图片
        [self.attendBtn setImage:[UIImage imageNamed:@"main_attend_normal"] forState:UIControlStateNormal];
    }

    
}

- (void)layoutSubviews
{
    self.starview.frame = CGRectMake(0, 173, SCREEN_WIDTH - 14, 65);
    self.photo.frame = CGRectMake(7, 5, SCREEN_WIDTH - 14, 231);
    self.adPhoto.frame = CGRectMake(10.5, 12.5, 40, 40);
    self.nick.frame = CGRectMake(59, 11.5, 85, 20);
    self.nick.bounds = CGRectMake(0, 0, 80, 40);
    CGSize nickSize = [CommonFuction sizeOfString:self.nick.text maxWidth:100 maxHeight:100 withFontSize:15.0f];
    if (nickSize.width<80) {
        self.starLevel.frame = CGRectMake(nickSize.width + 63, 12.5, 33, 15);
        
    }
    else
    {
        self.starLevel.frame = CGRectMake(59 + self.nick.bounds.size.width, 12.5, 33, 15);
    }
    
    CGSize heartSize = [CommonFuction sizeOfString:self.heartlab.text maxWidth:150 maxHeight:14 withFontSize:14.0f];
    self.heartlab.frame = CGRectMake(SCREEN_WIDTH - heartSize.width - 24, 15, 40, 14);

    self.starheart.frame = CGRectMake(SCREEN_WIDTH - heartSize.width - 24 - 14, 15, 11, 11);

    self.line.frame = CGRectMake(SCREEN_WIDTH - heartSize.width - 24 - 14 - 8, 15, 0.5, 13);

    CGSize personSize = [CommonFuction sizeOfString:self.personcont.text maxWidth:150 maxHeight:14 withFontSize:14.0f];

    self.personcont.frame = CGRectMake(SCREEN_WIDTH - heartSize.width - 37 - 15 - personSize.width, 15, 40, 14);
    
    self.starperson.frame = CGRectMake(SCREEN_WIDTH - heartSize.width - 37 - 16 - personSize.width - 13, 15, 11, 11);

//    [self.nick sizeToFit];
    self.introduction.frame = CGRectMake(61, 23, 180,40 );
//    self.status.frame = CGRectMake(62, 256, 46, 15);
    
//    self.userNum.frame = CGRectMake(173, 6257, 100, 15);
//    self.attendBtn.frame = CGRectMake(260, 200, 47, 47);
    self.hLineImg.frame = CGRectMake(0, self.frame.size.height - 0.5, self.frame.size.width, 0.5);
}

- (void)OnAttend:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(recommendCell:attendStar:)])
    {
//        [self.delegate recommendCell:self attendStar:self.starInfo];
    }
}

+ (CGFloat)height
{
    return 238.0f;
}
@end
