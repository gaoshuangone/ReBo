//
//  HotStarsView.m
//  BoXiu
//
//  Created by tongmingyu on 14-10-28.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "HotStarsView.h"
#import "QueryHotStarsModel.h"
#import "UIButton+WebCache.h"
#import "UserInfoManager.h"

@interface HotStarsView()

@property (nonatomic,strong) UILabel *titleLable;
@property (nonatomic,strong) UILabel *messageLable;

@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *message;

@property (nonatomic,strong) UIButton *starImgBtn;
@property (nonatomic,strong) UIButton *star2ImgBtn;
@property (nonatomic, strong) UIView *bkView;
@property (nonatomic, strong) UILabel *personCountLabel;
@property (nonatomic, strong) UILabel *nickLabel;
@property (nonatomic, strong) UIImageView *wealthLevelImg;

@property (nonatomic, strong) UIView *bkView2;
@property (nonatomic, strong) UILabel *personCountLabel2;
@property (nonatomic, strong) UILabel *nickLabel2;
@property (nonatomic, strong) UIImageView *wealthLevelImg2;

@property (nonatomic, strong) NSMutableArray *cellMAry;

@property (nonatomic,assign) CGSize headImgSize;
@property (nonatomic,strong) UIImageView *defaultImg;
@property (nonatomic,strong) UIImageView *default2Img;
@property (nonatomic,strong) UIImageView *vertLineImg;

@end

@implementation HotStarsView


- (id)initNoHotStarWithFrame:(CGRect)frame title:(NSString *)title message:(NSString *)message
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor clearColor]; //[UIColor colorWithPatternImage:[UIImage imageNamed:@"defaultVideoImg"]];
        self.title = title;
        self.message = message;
    }
    return self;
}

-(void)ininWithView
{
    _defaultImg = [[UIImageView alloc] initWithFrame:CGRectZero];
    _defaultImg.image = [UIImage imageNamed:@"rankNoOnline"];
    [self addSubview:_defaultImg];
    
    _default2Img = [[UIImageView alloc] initWithFrame:CGRectZero];
    _default2Img.image = [UIImage imageNamed:@"rankNoOnline"];
    [self addSubview:_default2Img];
    
    _starImgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _starImgBtn.layer.masksToBounds = YES;
    _starImgBtn.layer.cornerRadius = 20;
    [_starImgBtn setImage:[UIImage imageNamed:@"bofang.png"] forState:UIControlStateNormal];
    [_starImgBtn addTarget:self action:@selector(OnClickStar:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_starImgBtn];
    
    _vertLineImg = [[UIImageView alloc] initWithFrame:CGRectZero];
    _vertLineImg.image = [UIImage imageNamed:@"vertLine"];
    [self addSubview:_vertLineImg];
    
    _star2ImgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_star2ImgBtn setImage:[UIImage imageNamed:@"bofang.png"] forState:UIControlStateNormal];
    _star2ImgBtn.layer.masksToBounds = YES;
    _star2ImgBtn.layer.cornerRadius = 20;
    [_star2ImgBtn addTarget:self action:@selector(OnClickStar:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_star2ImgBtn];
    
    _personCountLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _personCountLabel.textAlignment = NSTextAlignmentCenter;
    _personCountLabel.font = [UIFont systemFontOfSize:11.0f];
    _personCountLabel.textColor = [CommonFuction colorFromHexRGB:@"ffffff"];
    _personCountLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:_personCountLabel];
    
    _nickLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _nickLabel.textAlignment = NSTextAlignmentRight;
    _nickLabel.font = [UIFont systemFontOfSize:12.0f];
    _nickLabel.textColor = [CommonFuction colorFromHexRGB:@"ffffff"];
    _nickLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:_nickLabel];
    
    _wealthLevelImg = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self addSubview:_wealthLevelImg];
    
    _personCountLabel2 = [[UILabel alloc] initWithFrame:CGRectZero];
    _personCountLabel2.textAlignment = NSTextAlignmentCenter;
    _personCountLabel2.font = [UIFont systemFontOfSize:11.0f];
    _personCountLabel2.textColor = [CommonFuction colorFromHexRGB:@"ffffff"];
    _personCountLabel2.backgroundColor = [UIColor clearColor];
    [self addSubview:_personCountLabel2];
    
    _nickLabel2 = [[UILabel alloc] initWithFrame:CGRectZero];
    _nickLabel2.textAlignment = NSTextAlignmentRight;
    _nickLabel2.font = [UIFont systemFontOfSize:12.0f];
    _nickLabel2.textColor = [CommonFuction colorFromHexRGB:@"ffffff"];
    _nickLabel2.backgroundColor = [UIColor clearColor];
    [self addSubview:_nickLabel2];
    
    _wealthLevelImg2 = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self addSubview:_wealthLevelImg2];
}


- (void)setTitle:(NSString *)title
{
    _title = title;
    if (title)
    {
        if (_titleLable == nil)
        {
            _titleLable = [[UILabel alloc] initWithFrame:CGRectZero];
            _titleLable.font = [UIFont boldSystemFontOfSize:14.0f];
            _titleLable.textColor = [CommonFuction colorFromHexRGB:@"ffffff"];
            _titleLable.textAlignment = NSTextAlignmentCenter;
            [self addSubview:_titleLable];
        }
        _titleLable.text = title;
    }
}

- (void)setMessage:(NSString *)message
{
    _message = message;
    if (message)
    {
        if (_messageLable == nil)
        {
            _messageLable = [[UILabel alloc] initWithFrame:CGRectZero];
            _messageLable.font = [UIFont systemFontOfSize:12.0f];
            _messageLable.textColor = [CommonFuction colorFromHexRGB:@"ffffff"];
            _messageLable.lineBreakMode = NSLineBreakByWordWrapping;
            _messageLable.numberOfLines = 0;
            [self addSubview:_messageLable];
        }
        _messageLable.text = message;
    }
}

- (void)setHotStarViewMary:(NSMutableArray *)hotStarViewMary
{
    _hotStarViewMary = hotStarViewMary;
    if (hotStarViewMary && [hotStarViewMary count])
    {
        if (_nickLabel == nil)
        {
             [self ininWithView];
        }
        for (int nIndex =  0 ; nIndex < [hotStarViewMary count]; nIndex++)
        {
            HotStarsData *hotData = [hotStarViewMary objectAtIndex:nIndex];
            
            if (nIndex == 0)
            {
                NSString *url = [NSString stringWithFormat:@"%@%@",[AppInfo shareInstance].res_server,hotData.adphoto];
                [self.starImgBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:url] forState:UIControlStateNormal placeholderImage:nil];
                _starImgBtn.tag = 0;
                if (hotData.onlineflag)
                {
                    [_starImgBtn setImage:[UIImage imageNamed:@"starIcon"] forState:UIControlStateNormal];
                }
                _personCountLabel.text = [NSString stringWithFormat:@"%ld 人正在观看",hotData.count];
                _nickLabel.text = hotData.nick;
                _wealthLevelImg.image = [[UserInfoManager shareUserInfoManager] imageOfStar:hotData.starlevelid];
            }
            else if (nIndex == 1)
            {
                NSString *url = [NSString stringWithFormat:@"%@%@",[AppInfo shareInstance].res_server,hotData.adphoto];
                [self.star2ImgBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:url] forState:UIControlStateNormal placeholderImage:nil];
                _star2ImgBtn.tag = 1;//hotData.userId;
                if (hotData.onlineflag)
                {
                    [_star2ImgBtn setImage:[UIImage imageNamed:@"starIcon.png"] forState:UIControlStateNormal];
                }
                _personCountLabel2.text = [NSString stringWithFormat:@"%ld 人正在观看",hotData.count];
                _nickLabel2.text = hotData.nick;
                _wealthLevelImg2.image = [[UserInfoManager shareUserInfoManager] imageOfStar:hotData.starlevelid];
            }
        }
    }
    [self setNeedsLayout];

}


- (void)layoutSubviews
{
    CGFloat nYOffset = 0;
    if (_titleLable)
    {
        _titleLable.frame = CGRectMake(0, 70, self.frame.size.width, 20);
        nYOffset = _titleLable.frame.origin.y + _titleLable.frame.size.height;
        nYOffset += 6;//间距
    }
    
    if (_messageLable)
    {
        CGSize messageSize = [CommonFuction sizeOfString:self.message maxWidth:self.frame.size.width - 34 * 2 maxHeight:self.frame.size.height withFontSize:13.0f];
        _messageLable.frame = CGRectMake((self.frame.size.width  - messageSize.width)/2+12, nYOffset, messageSize.width, messageSize.height);
        nYOffset += messageSize.height;
        nYOffset += 20;//间距
    }
    
    _defaultImg.frame = CGRectMake(77, nYOffset, 50, 50);
    _starImgBtn.frame = CGRectMake(82, nYOffset + 5, 40, 40);
    _vertLineImg.frame = CGRectMake((self.frame.size.width - 0.5)/2, 126, 0.5, 116);
    _default2Img.frame = CGRectMake(185, nYOffset, 50, 50);
    _star2ImgBtn.frame = CGRectMake(190, nYOffset + 5, 40, 40);
    
    nYOffset += 58;
    
    _nickLabel.frame = CGRectMake(20, nYOffset, 85, 20);
    _wealthLevelImg.frame = CGRectMake(113, nYOffset, 33, 15);
    
    _personCountLabel.frame = CGRectMake(50, nYOffset + 20, 100, 19);

    _personCountLabel2.frame = CGRectMake(170, nYOffset + 20, 100, 19);
    
//    CGSize nickSizeLabel = [CommonFuction sizeOfString:_nickLabel2.text maxWidth:67 maxHeight:20 withFontSize:12.0f];
    _nickLabel2.frame = CGRectMake(165, nYOffset, 55, 20);
    _wealthLevelImg2.frame = CGRectMake(170 + 52, nYOffset, 33, 15);
}

- (void)OnClickStar:(id)sender
{
    UIButton *button = (UIButton *)sender;
    if (self.delegate && [self.delegate respondsToSelector:@selector(didHotStarUserIdData:)])
    {
        HotStarsData *data = [self.hotStarViewMary objectAtIndex:button.tag];
        [self.delegate didHotStarUserIdData:data];
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
