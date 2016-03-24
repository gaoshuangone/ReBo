//
//  ProgramCell.m
//  BoXiu
//
//  Created by tongmingyu on 14-10-30.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "ProgramCell.h"

@interface ProgramCell()

@property (nonatomic, strong) UIImageView *headStarImgView;
@property (nonatomic, strong) UILabel *starTitleLabel;
@property (nonatomic, strong) UILabel *noStarTitleLabel;
@property (nonatomic, strong) UILabel *LastStarTitleLabel;
@property (nonatomic, strong) UILabel *starTimeLabel;
@property (nonatomic, strong) UILabel *noStarTimeLabel;
@property (nonatomic, strong) UILabel *lastStarTimeLabel;

@property (nonatomic, strong) UIImageView *lineImgView;

@property (nonatomic, strong) UIImageView *starIconImg;
@property (nonatomic, strong) UIImageView *starIconImg2;
@property (nonatomic, strong) UIImageView *starIconImg3;

@property (nonatomic, strong) NSMutableArray *AllStarMary;

@end

@implementation ProgramCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"programBg"]];
    
        _headStarImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _headStarImgView.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(recomendListStar)];
        [_headStarImgView addGestureRecognizer:singleTap];
        [self.contentView addSubview:_headStarImgView];
        
        _lineImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _lineImgView.image = [UIImage imageNamed:@"programline"];
        [_headStarImgView addSubview:_lineImgView];
        
        _starIconImg = [[UIImageView alloc] initWithFrame:CGRectZero];
        _starIconImg.image = [UIImage imageNamed:@"NoStar"];
        [_headStarImgView addSubview:_starIconImg];
        
        _starIconImg2 = [[UIImageView alloc] initWithFrame:CGRectZero];
        _starIconImg2.image = [UIImage imageNamed:@"NoStar"];
        [_headStarImgView addSubview:_starIconImg2];
        
        _starIconImg3 = [[UIImageView alloc] initWithFrame:CGRectZero];
        _starIconImg3.image = [UIImage imageNamed:@"NoStar"];
        [_headStarImgView addSubview:_starIconImg3];
        
        _starTimeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _starTimeLabel.textAlignment = NSTextAlignmentCenter;
        _starTimeLabel.font = [UIFont boldSystemFontOfSize:10.0f];
        [_headStarImgView addSubview:_starTimeLabel];
        
        _noStarTimeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _noStarTimeLabel.textAlignment = NSTextAlignmentCenter;
        _noStarTimeLabel.font = [UIFont boldSystemFontOfSize:10.0f];
        [_headStarImgView addSubview:_noStarTimeLabel];
        
        _lastStarTimeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _lastStarTimeLabel.textAlignment = NSTextAlignmentCenter;
        _lastStarTimeLabel.font = [UIFont boldSystemFontOfSize:10.0f];
        [_headStarImgView addSubview:_lastStarTimeLabel];
        
        _starTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _starTitleLabel.font = [UIFont boldSystemFontOfSize:10.0f];
        _starTitleLabel.textAlignment = NSTextAlignmentCenter;
        [_headStarImgView addSubview:_starTitleLabel];
        
        _noStarTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _noStarTitleLabel.font = [UIFont boldSystemFontOfSize:10.0f];
        _noStarTitleLabel.textAlignment = NSTextAlignmentCenter;
        [_headStarImgView addSubview:_noStarTitleLabel];
        
        _LastStarTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _LastStarTitleLabel.font = [UIFont boldSystemFontOfSize:10.0f];
        _LastStarTitleLabel.textAlignment = NSTextAlignmentCenter;
        [_headStarImgView addSubview:_LastStarTitleLabel];
    }
    return self;
}


-(void)setLiveMary:(NSMutableArray *)liveMary
{
    _AllStarMary = liveMary;
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *date = [formatter stringFromDate:[NSDate date]];
    NSDate *todayDate = [formatter dateFromString:date];
    NSDate *tomorrowDate = [NSDate dateWithTimeIntervalSinceNow:(24*60*60)];

    
    NSTimeInterval currentDate = [[NSDate date] timeIntervalSince1970] * 1000;
    long long dTime = [[NSNumber numberWithDouble:currentDate] longLongValue];
    
    if (liveMary.count > 0)
    {
        for (int index = 0; index < [liveMary count]; index++)
        {
            LiveSchedulesData *liveData = [liveMary objectAtIndex:index];
    
            if (index == 0)
            {
                self.starTitleLabel.text = liveData.liveName;
                
                self.noStarTitleLabel.text = nil;
                self.noStarTimeLabel.text = nil;
                self.LastStarTitleLabel.text = nil;
                self.lastStarTimeLabel.text = nil;
                
                _starIconImg2.image = [UIImage imageNamed:@"NoStar"];
                _starIconImg3.image = [UIImage imageNamed:@"NoStar"];
                
                if (liveData.starTimeInMillis < dTime && dTime < liveData.endTimeInMillis)
                {
                    self.starTimeLabel.text = liveData.startTime;
                    
                    self.starTitleLabel.textColor = [CommonFuction colorFromHexRGB:@"f47f7f"];
                    self.starTimeLabel.textColor = [CommonFuction colorFromHexRGB:@"f47f7f"];
                    
//                    if (liveData.onlineflag || liveData.topflag)
//                    {
//                        _starIconImg.image = [UIImage imageNamed:@"specialStart"];
//                    }
//                    else
//                    {
                        _starIconImg.image = [UIImage imageNamed:@"star"];
//                    }
                }
                else
                {
                    self.starTitleLabel.textColor = [CommonFuction colorFromHexRGB:@"979595"];
                    self.starTimeLabel.textColor = [CommonFuction colorFromHexRGB:@"979595"];
                    
                     NSDate *serversDate=[formatter dateFromString:liveData.date];
                    
//                    if(liveData.topflag)
//                    {
//                        _starIconImg.image = [UIImage imageNamed:@"specialStop"];
//                    }
//                    else
//                    {
                        _starIconImg.image = [UIImage imageNamed:@"NoStar"];
//                    }
                    
                    if ([serversDate timeIntervalSinceDate:tomorrowDate] > 0)
                    {
                        self.starTimeLabel.text = [NSString stringWithFormat:@"%@%@",liveData.showDate,liveData.showTime];
                    }
                    else if ([serversDate timeIntervalSinceDate:todayDate] < 0)
                    {
                        self.starTimeLabel.text = liveData.startTime;
                    }
                    else
                    {
                        self.starTimeLabel.text = [NSString stringWithFormat:@"明天%@",liveData.startTime];
                    }
                }
            }
            else if (index == 1)
            {
                self.noStarTitleLabel.text = liveData.liveName;
                
                self.LastStarTitleLabel.text = nil;
                self.lastStarTimeLabel.text = nil;

                _starIconImg3.image = [UIImage imageNamed:@"NoStar"];
                
                if (liveData.starTimeInMillis < dTime && dTime <  liveData.endTimeInMillis)
                {
                    self.noStarTimeLabel.text = liveData.startTime;
                    
                    self.noStarTitleLabel.textColor = [CommonFuction colorFromHexRGB:@"f47f7f"];
                    self.noStarTimeLabel.textColor = [CommonFuction colorFromHexRGB:@"f47f7f"];

                    _starIconImg2.image = [UIImage imageNamed:@"star"];
                }
                else
                {
                    self.noStarTitleLabel.textColor = [CommonFuction colorFromHexRGB:@"979595"];
                    self.noStarTimeLabel.textColor = [CommonFuction colorFromHexRGB:@"979595"];
                    
                    NSDate *serversDate=[formatter dateFromString:liveData.date];
                    
                    if ([serversDate timeIntervalSinceDate:tomorrowDate] > 0)
                    {
                        self.noStarTimeLabel.text = [NSString stringWithFormat:@"%@%@",liveData.showDate,liveData.showTime];
                    }
                    else if ([serversDate timeIntervalSinceDate:todayDate] < 0)
                    {
                        self.noStarTimeLabel.text = liveData.startTime;
                    }
                    else
                    {
                        self.noStarTimeLabel.text = [NSString stringWithFormat:@"明天%@",liveData.startTime];
                    }
                }
            }
            else if (index == 2)
            {
                _starIconImg3.image = [UIImage imageNamed:@"NoStar"];
                self.LastStarTitleLabel.text = liveData.liveName;
                
                if (liveData.starTimeInMillis < dTime && dTime <  liveData.endTimeInMillis)
                {
                    self.lastStarTimeLabel.text = liveData.startTime;
                    
                    self.LastStarTitleLabel.textColor = [CommonFuction colorFromHexRGB:@"f47f7f"];
                    self.lastStarTimeLabel.textColor = [CommonFuction colorFromHexRGB:@"f47f7f"];
                    ;
                    
                    _starIconImg3.image = [UIImage imageNamed:@"star"];
                }
                else
                {
                    self.LastStarTitleLabel.textColor = [CommonFuction colorFromHexRGB:@"979595"];
                    self.lastStarTimeLabel.textColor = [CommonFuction colorFromHexRGB:@"979595"];
                    
                    _starIconImg3.image = [UIImage imageNamed:@"NoStar"];
                    
                     NSDate *serversDate=[formatter dateFromString:liveData.date];
                    if ([serversDate timeIntervalSinceDate:tomorrowDate] > 0)
                    {
                        self.lastStarTimeLabel.text = [NSString stringWithFormat:@"%@%@",liveData.showDate,liveData.showTime];
                    }
                    else if ([serversDate timeIntervalSinceDate:todayDate] < 0)
                    {
                        self.lastStarTimeLabel.text = liveData.startTime;
                    }
                    else
                    {
                        self.lastStarTimeLabel.text = [NSString stringWithFormat:@"明天%@",liveData.startTime];
                    }
                }
            }

        }
    }
        
}


- (void)layoutSubviews
{
    self.contentView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
    _headStarImgView.frame = CGRectMake(0, 0, self.frame.size.width, 85);
    
    _starTitleLabel.frame = CGRectMake(15, 12, 90, 20);
    _noStarTitleLabel.frame = CGRectMake(115, 12, 90, 20);
    _LastStarTitleLabel.frame = CGRectMake(215, 12, 90, 20);
    
    _starTimeLabel.frame = CGRectMake(20, 60, 80, 15);
    _noStarTimeLabel.frame = CGRectMake(118, 60, 80, 15);
    _lastStarTimeLabel.frame = CGRectMake(220, 60, 80, 15);
    
    
    _lineImgView.frame = CGRectMake(0, 47, self.frame.size.width, 2);
    
    _starIconImg.frame = CGRectMake(49, (self.frame.size.height - _starIconImg.image.size.height)/2 + 5, _starIconImg.image.size.width, _starIconImg.image.size.height);
    _starIconImg2.frame = CGRectMake(155, (self.frame.size.height - _starIconImg2.image.size.height)/2 + 5, _starIconImg2.image.size.width, _starIconImg2.image.size.height);
    _starIconImg3.frame = CGRectMake(256, (self.frame.size.height - _starIconImg3.image.size.height)/2 + 5, _starIconImg3.image.size.width, _starIconImg3.image.size.height);
    
}


-(void)recomendListStar
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didShowPre)])
    {
        [self.delegate didShowPre];
    }
}


+ (CGFloat)height
{
    return 85;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
