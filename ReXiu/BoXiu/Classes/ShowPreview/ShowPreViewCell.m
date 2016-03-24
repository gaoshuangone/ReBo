//
//  ShowPreViewCell.m
//  BoXiu
//
//  Created by tongmingyu on 14-10-28.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "ShowPreViewCell.h"
#import "UserInfoManager.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "UMSocial.h"

@interface ShowPreViewCell()

@property (nonatomic, strong) UIImageView *bgImgView;
@property (nonatomic, strong) UILabel *stateLabel;
@property (nonatomic, strong) UILabel *nickLabel;
@property (nonatomic, strong) UILabel *liveLabel;
@property (nonatomic, strong) UIImageView *showStarIcon;
@property (nonatomic, strong) UIButton *preImgBtn;
@property (nonatomic, strong) UIImageView *personImg;
@property (nonatomic, strong) UIImageView *photo;
@property (nonatomic, strong) UIImageView *cutImg;
@property (nonatomic,strong) UIView *bgview;

@property (nonatomic, strong) UIButton *joinRoomBtn;
@property (nonatomic, strong) NSString *shareSt;
@end

@implementation ShowPreViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [CommonFuction colorFromHexRGB:@"f6f6f6"];
        self.contentView.backgroundColor = [UIColor clearColor];
        
        _personImg = [[UIImageView alloc] initWithFrame:CGRectZero];
//        _personImg.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:_personImg];
        
        _bgview = [[UIView alloc] initWithFrame:CGRectMake(0, 7, SCREEN_WIDTH, 193.5)];
        _bgview.backgroundColor = [CommonFuction colorFromHexRGB:@"000000" alpha:0.3];
//        [self.contentView addSubview:_bgview];
        
        _cutImg = [[UIImageView alloc] initWithFrame:CGRectZero];
        _photo = [[UIImageView alloc] initWithFrame:CGRectMake(18, 15, 47, 47)];
    
        _dateLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _dateLabel.font = [UIFont systemFontOfSize:18.0f];
        _dateLabel.textColor = [CommonFuction colorFromHexRGB:@"ffffff"];
        _dateLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_dateLabel];
        
        
        _bgImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _bgImgView.image = [[UIImage imageNamed:@"showpreViewBg"] stretchableImageWithLeftCapWidth:6 topCapHeight:2];
        [self.contentView addSubview:_bgImgView];
        
        _stateLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _stateLabel.font = [UIFont systemFontOfSize:20.0f];
        [_bgImgView addSubview:_stateLabel];
        
        _nickLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nickLabel.font = [UIFont boldSystemFontOfSize:13.0f];
        _nickLabel.textColor = [CommonFuction colorFromHexRGB:@"ffffff"];
        [_bgImgView addSubview:_nickLabel];
        
        _liveLabel =[[UILabel alloc] initWithFrame:CGRectZero];
        _liveLabel.font = [UIFont systemFontOfSize:16.0f];
        _liveLabel.textColor = [CommonFuction colorFromHexRGB:@"ffffff"];
        [_bgImgView addSubview:_liveLabel];
        
        _preImgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_preImgBtn addTarget:self action:@selector(OnClickPro:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_preImgBtn];
       
        
        _showStarIcon = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_showStarIcon];
        
        UIView *liveview = [[UIView alloc]initWithFrame:CGRectMake(275, 163, 41, 38)];
        liveview.backgroundColor = [UIColor clearColor];
        [self.contentView  addSubview:liveview];
        UITapGestureRecognizer *setinfor = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shareBoxiu)];
        
        _joinRoomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _joinRoomBtn.frame = CGRectMake(18, 11 , 15, 15);
        [_joinRoomBtn setBackgroundImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
        [_joinRoomBtn addTarget:self action:@selector(shareBoxiu) forControlEvents:UIControlEventTouchUpInside];
        
        NSInteger hideSwitch = [[[AppInfo shareInstance].hideSwitch substringFromIndex:1] integerValue];
        if(hideSwitch != 1)
        {
            [liveview addGestureRecognizer:setinfor];
            [liveview addSubview:_joinRoomBtn];
            
        }

    }
    return self;
}

-(void)setLiveScheData:(LiveSchedulesData *)liveScheData
{
    _liveScheData = liveScheData;
    double time2 =  _liveScheData.starTimeInMillis - [AppInfo shareInstance].nowtimesMillis;
    NSDate *severDate = [NSDate dateWithTimeIntervalSince1970:[AppInfo shareInstance].nowtimesMillis/1000];
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *DateStr = [dateFormatter stringFromDate:severDate];
    int nowHour = [[DateStr substringWithRange:NSMakeRange(11, 2)] intValue];

    int hour = (int)(time2  / (60 * 60 *1000));
    int timerhour = nowHour + hour;
    if(timerhour < 24)
    {
        _dateLabel.text=@"今天";
    }else if(24< timerhour && timerhour <48)
    {
        _dateLabel.text=@"明天";
    }else
    {
       _dateLabel.text = [liveScheData.date substringWithRange:NSMakeRange(5, 5)];

    }


    _nickLabel.text = liveScheData.nick;
    _liveLabel.text = liveScheData.liveName;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[AppInfo shareInstance].res_server,liveScheData.mobileImg]];
    NSURL *photourl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[AppInfo shareInstance].res_server,liveScheData.photo]];
   
//    [_preImgBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:url] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"recommendDefault"]];
    
    [_cutImg sd_setImageWithURL:url placeholderImage:nil];
    

    [_photo sd_setImageWithURL:photourl placeholderImage:nil];
    
    UIImage *image= _cutImg.image;
    if (!image) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSData *data = [[NSData alloc] initWithContentsOfURL:url];
            _cutImg.image = [UIImage imageWithData:data];
            
            if (_cutImg.image) {
                [self getImg: _cutImg.image];
            }else
            {
                _cutImg.image = [UIImage imageNamed:@"v3_star_cover_default"];
                [self getImg: _cutImg.image];
            }
            
        });

    }else
    {
        [self getImg:image];
    }
    
    _stateLabel.textColor = [CommonFuction colorFromHexRGB:@"ffffff"];
    _stateLabel.text = liveScheData.startTime;
    
    if(liveScheData.recommendno)
    {
        _showStarIcon.image = [UIImage imageNamed:@"Recommend"];
    }
    else
    {
        _showStarIcon.image = [UIImage imageNamed:@""];
    }
    
    
    NSTimeInterval currentDate = [[NSDate date] timeIntervalSince1970] * 1000;
    long long dTime = [[NSNumber numberWithDouble:currentDate] longLongValue];
    if (liveScheData.starTimeInMillis < dTime && dTime < liveScheData.endTimeInMillis)
    {
//        直播中...
        
    }
    else
    {
        if (liveScheData.topflag)
        {
            [_joinRoomBtn setTitle:@"预约点歌" forState:UIControlStateNormal];
        }
        else
        {
            
        }
    }
    
    
}
-(void)getImg:(UIImage *)image
{
    //    NSLog(@"图片的宽%f,图片的高%f,图片的宽高比%f",image.size.width,image.size.height,image.size.width/image.size.height);
    float fleng = image.size.width/image.size.height;
    float Proportion = 400.000000/236.000000;
    
    int x = image.size.width;
    double  j = x%400;
    int y = image.size.height;
    double k = y%236;
    if (j == 0 && k==0 )
    {
        [_personImg setImage:image];
    }
    else if (fleng <=1 || Proportion> fleng) {
        //        NSLog(@"截取屏幕的高度");
        float r =image.size.height -(image.size.width / Proportion);
        CGRect rect = CGRectMake(0,r/2, image.size.width, 236*(image.size.width/400) );//创建矩形框
        UIImageView *contentView = [[UIImageView alloc] initWithFrame:rect];
        contentView.image=[UIImage imageWithCGImage:CGImageCreateWithImageInRect([image CGImage], rect)];
        [_personImg setImage:contentView.image];
        
    }
    else
    {
        //        NSLog(@"截取屏幕的宽度");
        float r =image.size.width -(image.size.height * Proportion);
        CGRect rect = CGRectMake(r/2,0, image.size.height/236*400, image.size.height );//创建矩形框
        UIImageView *contentView = [[UIImageView alloc] initWithFrame:rect];
        contentView.image=[UIImage imageWithCGImage:CGImageCreateWithImageInRect([image CGImage], rect)];
        [_personImg setImage:contentView.image];
    }
    image = nil;
}

#pragma mark- 分享
-(void) shareBoxiu
{
    NSString *sharelink = [NSString stringWithFormat:@"http://www.51rebo.cn/%@",self.liveScheData.starIdxcode];
    [UMSocialData defaultData].extConfig.wechatSessionData.url = sharelink;
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = sharelink;
    [UMSocialData defaultData].extConfig.qqData.url = sharelink;
    [UMSocialData defaultData].extConfig.qzoneData.url = sharelink;
    [UMSocialData defaultData].extConfig.wechatSessionData.url = sharelink;
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = sharelink;
    [UMSocialData defaultData].extConfig.title = @"#热波间#最火的全民娱乐直播在线平台，潮人聚集地";
    UIImage* image = nil;
    if (_photo) {
        image = _photo.image;
    }else{
        image =[UIImage imageNamed:@"reboLogo"];
    }
  int  datemonth = [[_liveScheData.date substringWithRange:NSMakeRange(5, 2)] intValue];
  int  dateday = [[_liveScheData.date substringWithRange:NSMakeRange(8, 2)] intValue];
  int  datehour = [[_liveScheData.showTime substringWithRange:NSMakeRange(0, 2)] intValue];
  int  datebranch = [[_liveScheData.showTime substringWithRange:NSMakeRange(3, 2)] intValue];

    if (datebranch == 0) {
        _shareSt = [NSString stringWithFormat:@"%d月%d日 %d点00分,“%@”会在#热波间#和大家进行精彩的直播互动哦，喜欢我记得来捧场哦！http://www.51rebo.cn/%@",datemonth,dateday,datehour,_liveScheData.nick,self.liveScheData.starIdxcode];
   
    }
    else
    {
        _shareSt = [NSString stringWithFormat:@"%d月%d日 %d点%d分,“%@”会在#热波间#和大家进行精彩的直播互动哦，喜欢我记得来捧场哦！http://www.51rebo.cn/%@",datemonth,dateday,datehour,datebranch,_liveScheData.nick,self.liveScheData.starIdxcode];

    }
    [UMSocialConfig setFinishToastIsHidden:NO position:UMSocialiToastPositionBottom];

    [UMSocialData defaultData].extConfig.wechatTimelineData.title = [NSString stringWithFormat:@"%@",_shareSt];
    [UMSocialSnsService presentSnsIconSheetView:[AppDelegate shareAppDelegate].lrSliderMenuViewController
                                         appKey:nil
                                      shareText:_shareSt
                                     shareImage:image
                                shareToSnsNames:@[UMShareToSina,UMShareToTencent,UMShareToQQ,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSms]
                                       delegate:nil];
    
}

- (void)layoutSubviews
{
    self.contentView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    _showStarIcon.frame = CGRectMake(0, 5, 40, 40);
//    _bgImgView.frame = CGRectMake(40, 36, 265, 115);
    
    CGSize stateSize = [CommonFuction sizeOfString:self.stateLabel.text maxWidth:120 maxHeight:18 withFontSize:18.0f];
    CGSize dateSize = [CommonFuction sizeOfString:self.dateLabel.text maxWidth:120 maxHeight:18 withFontSize:18.0f];

    _stateLabel.frame = CGRectMake((SCREEN_WIDTH - (stateSize.width+15)), 12 + 7, 100, 18);
    _dateLabel.frame = CGRectMake((SCREEN_WIDTH - dateSize.width- 66), 12 + 7, dateSize.width, 18);

    _nickLabel.frame = CGRectMake(10, 175, 140, 14);
    _liveLabel.frame = CGRectMake(10, 148, 278, 18);
//    _preImgBtn.frame = CGRectMake(53, 82, 243, 60);
    _personImg.frame = CGRectMake(0, 5, SCREEN_WIDTH, 193.5);
}


#pragma mark 进入房间
-(void)InforRoom:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didLinkType:)])
    {
        [self.delegate didLinkType:self.liveScheData];
    }
}

-(void)OnClickPro:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didRoom:)])
    {
        [self.delegate didRoom:self.liveScheData];
    }
}

+ (CGFloat)height
{
    return 199.5f;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
