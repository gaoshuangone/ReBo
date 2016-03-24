//
//  StartView.m
//  BoXiu
//
//  Created by andy on 15/8/6.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import "StartView.h"
#import "UserInfo.h"
#import "EWPScrollLable.h"
#import "UserInfoManager.h"
@interface StartView()
@property (nonatomic,strong) UILabel *nick;
@property (nonatomic,strong) UIImageView *headImg;

@property (nonatomic,strong) UILabel *introductionLabel;
@property (nonatomic,strong) UIImageView *imageheart;
@property (nonatomic,strong) UILabel* labelLike;


@property (nonatomic,strong) UILabel* labelGuanZHuLabel;
@property (nonatomic,strong) UILabel* labelFansLabel;
@property (nonatomic,strong) UIImageView* imageViewLine;
@property (nonatomic,strong) UIButton* buttonColose;
@property (nonatomic,strong) UIImageView* imageViewColose;


@property (nonatomic,strong) EWPScrollLable* labelWelcome;
@property (nonatomic,strong) UIImageView *detailedImg;
@property (nonatomic,strong) UIImageView *starlevelGrade;
@property (nonatomic,strong) EWPButton *starBtn;
@property (nonatomic,strong) UIButton *attentionBtn;
@property (nonatomic,strong) EWPButton *shareBtn;
@property (nonatomic,strong) EWPButton *reportBtn;
@property (nonatomic,strong) NSString *CommonFuction;
@property (nonatomic, strong)UIControl* viewContent;


@end
@implementation StartView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
}


- (void)initView:(CGRect)frame
{
        
    _viewContent = [[UIControl alloc]initWithFrame:CGRectMake(22.5, (SCREEN_HEIGHT-415)/2, 280, 415)];
    _viewContent.backgroundColor = [CommonFuction colorFromHexRGB:@"FFFFFF"];
    [self addSubview:_viewContent];
    _viewContent.layer.cornerRadius = 5;
    
 
    
    
    _imageViewColose = [[UIImageView alloc] initWithFrame:CGRectMake(275-14-16, 14, 16, 16)];
    _imageViewColose.image =[UIImage imageNamed:@"close.png"];
    [_viewContent addSubview:_imageViewColose];
    
    
    _buttonColose = [UIButton buttonWithType:UIButtonTypeCustom];
  
    _buttonColose.frame = CGRectMake(275-35, 0, 35, 35);
    _buttonColose.tag=2;
    [_buttonColose addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [_viewContent addSubview:_buttonColose];
    
    
    
    UIImageView* imageViewSound = [[UIImageView alloc]initWithFrame:CGRectMake(20, 21, 22, 20)];
    imageViewSound.image = [UIImage imageNamed:@"iconsound.png"];
    [_viewContent addSubview:imageViewSound];
    
    _labelWelcome = [[EWPScrollLable alloc]initWithFrame:CGRectMake(52, 24, 180, 20)];
    _labelWelcome.textColor = [CommonFuction colorFromHexRGB:@"a4a4a4"];
    _labelWelcome.font = [UIFont systemFontOfSize:14.0f];
    _labelWelcome.backgroundColor = [UIColor clearColor];
    [_viewContent addSubview:_labelWelcome];
    _labelWelcome.center = CGPointMake(_labelWelcome.center.x, imageViewSound.center.y);
    
    _headImg = [[UIImageView alloc] initWithFrame:CGRectZero];
    _headImg.layer.cornerRadius = 74/2;
    [_headImg setClipsToBounds:YES];
    [_viewContent addSubview:_headImg];
    
//   昵称
    _nick = [[UILabel alloc] initWithFrame:CGRectZero];
    _nick.textColor = [CommonFuction colorFromHexRGB:@"454a4d"];
    _nick.font = [UIFont systemFontOfSize:14.0f];
    [_viewContent addSubview:_nick];
    
//    ❤️心
    _imageheart = [[UIImageView alloc]initWithFrame:CGRectZero];
    _imageheart.image = [UIImage imageNamed:@"rHeart"];
    [_viewContent addSubview:_imageheart];
    
//    ❤️数量
    _labelLike = [[UILabel alloc]initWithFrame:CGRectZero];
    _labelLike.font = [UIFont systemFontOfSize:12];
    [_viewContent addSubview:_labelLike];
    
    _labelGuanZHuLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    _labelGuanZHuLabel.text = @"关注";
    _labelGuanZHuLabel.font = [UIFont systemFontOfSize:13];
    _labelGuanZHuLabel.textColor = [CommonFuction colorFromHexRGB:@"454a4d"];
    [_viewContent addSubview:_labelGuanZHuLabel];
    
    _labelFansLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    _labelFansLabel.text = @"粉丝";
    _labelFansLabel.font = [UIFont systemFontOfSize:13];
    _labelFansLabel.textColor = [CommonFuction colorFromHexRGB:@"454a4d"];
    [_viewContent addSubview:_labelFansLabel];
    
    _labelGuanZHu = [[UILabel alloc]initWithFrame:CGRectZero];
    _labelGuanZHu.text = @"0";
    _labelGuanZHu.font = [UIFont systemFontOfSize:15.0f];
    _labelGuanZHu.textColor = [CommonFuction colorFromHexRGB:@"f7c250"];
    [_viewContent addSubview:_labelGuanZHu];
    
    _labelFans = [[UILabel alloc]initWithFrame:CGRectZero];
    _labelFans.text = @"0";
    _labelFans.font = [UIFont systemFontOfSize:15.0f];
    _labelFans.textColor = [CommonFuction colorFromHexRGB:@"f7c250"];
    [_viewContent addSubview:_labelFans];
    
    _imageViewLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 1, 38)];
    _imageViewLine.backgroundColor = [CommonFuction colorFromHexRGB:@"e2e2e2"];
    [_viewContent addSubview:_imageViewLine];
    
    
    
    StarInfo *starInfo = [UserInfoManager shareUserInfoManager].currentStarInfo;
    if (!starInfo.introduction) {
        starInfo.introduction = @"全民星直播互动平台，娱乐你的生活";
    }
    if (!starInfo.starmonthpraisecount) {
        starInfo.starmonthpraisecount = 0;
    }
    
    _labelGuanZHu.text = [NSString stringWithFormat:@"%ld",(long)starInfo.attentionnum];
    _labelFans.text = [NSString stringWithFormat:@"%ld",(long)starInfo.fansnum];
    _labelLike.text = [NSString stringWithFormat:@"%ld",(long)starInfo.starmonthpraisecount];
    
    _introductionLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _introductionLabel.textColor = [CommonFuction colorFromHexRGB:@"a4a4a4"];
    _introductionLabel.backgroundColor = [UIColor clearColor];
    _introductionLabel.textAlignment = NSTextAlignmentCenter;
    _introductionLabel.numberOfLines = 2;
    _introductionLabel.bounds = CGRectMake(0, 0, 200, 70);
    _introductionLabel.font = [UIFont systemFontOfSize:12.f];
  
    [_viewContent addSubview:_introductionLabel];
    
    UIImage *normalImg = [CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"d14c49"] size:CGSizeMake(51, 21)];
    UIImage *selectImg = [CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"c34845"] size:CGSizeMake(51, 21)];

     _buttonGuanZhu = [UIButton buttonWithType:UIButtonTypeCustom];
    [_buttonGuanZhu setTitleColor:[CommonFuction colorFromHexRGB:@"ffffff"] forState:UIControlStateNormal];
    [_buttonGuanZhu setTitleColor:[CommonFuction colorFromHexRGB:@"ffffff"] forState:UIControlStateHighlighted];
    [_buttonGuanZhu setBackgroundImage:normalImg forState:UIControlStateNormal];
    [_buttonGuanZhu setBackgroundImage:selectImg forState:UIControlStateHighlighted];
    _buttonGuanZhu.titleLabel.font = [UIFont systemFontOfSize:14];


    _buttonGuanZhu.layer.masksToBounds = YES;
    _buttonGuanZhu.layer.cornerRadius = 16.5;
    _buttonGuanZhu.layer.borderWidth = 1.0f;
    _buttonGuanZhu.layer.borderColor = [CommonFuction colorFromHexRGB:@"d14c49"].CGColor;
    _buttonGuanZhu.tag =1;
    if ([AppInfo shareInstance].isGuanZhu)
    {
        [_buttonGuanZhu setTitle:@"取消关注" forState:UIControlStateNormal];
    }
    else
    {
        [_buttonGuanZhu setTitle:@"+     关注     " forState:UIControlStateNormal];
    }
    [_buttonGuanZhu addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [_viewContent addSubview:_buttonGuanZhu];
    

    
    NSArray* btnName = [NSArray arrayWithObjects:@"踢人",@"禁言",@"举报" ,nil];
    for (int nIndex = 0; nIndex <=2 ;nIndex++)
    {
        NSString *title = [btnName objectAtIndex:nIndex];
        UIButton *btn = [[UIButton alloc] init];
      
        UIImage *normalImg = [CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"ffffff"] size:CGSizeMake(43, 43)];
        UIImage *selectImg = [CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"f1f1f1"] size:CGSizeMake(43, 43)];
        
 
        
        [btn setTitleColor:[CommonFuction colorFromHexRGB:@"a4a4a4"] forState:UIControlStateNormal];
        [btn setBackgroundImage:normalImg forState:UIControlStateNormal];
        [btn setBackgroundImage:selectImg forState:UIControlStateHighlighted];
        btn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTag:nIndex+100];
        btn.frame = CGRectMake(23+(43+50)*nIndex, _viewContent.bounds.size.height-65, 43, 43);
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 43 / 2;
        btn.layer.borderWidth = 1;
     
        btn.layer.borderColor = [CommonFuction colorFromHexRGB:@"E2E2E2"].CGColor;
        [btn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        [_viewContent addSubview:btn];
        
    }

}

-(void)setPersonData:(PersonData *)personData{
    _personData = personData;
    if (personData) {
        //头像
        [self.headImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",[AppInfo shareInstance].res_server,personData.userImg]] placeholderImage:[UIImage imageNamed:@"headDefault.png"]];
        
        //    签名
        self.nick.text = personData.nick;
        _CommonFuction=personData.nick;
        if (personData.nick)
        {
            self.nick.text = [NSString stringWithFormat:@"%@",personData.nick];
        }
        
        
        
        //房间公告
        _labelWelcome.text = personData.notice ? personData.notice :@"暂无公告";

        
        //个人简介
        StarInfo *starInfo = [UserInfoManager shareUserInfoManager].currentStarInfo;
        if (!starInfo.introduction) {
            starInfo.introduction = @"全民星直播互动平台，娱乐你的生活";
        }
        _introductionLabel.text = starInfo.introduction;
        
        
        //等级
        UIImage *image = [[UserInfoManager shareUserInfoManager] imageOfStar:personData.starlevelid];
        if (image)
        {
            self.starlevelGrade.image = image;
        }
        
        //关注
        self.attentionBtn.selected = personData.attented;

    }
}
- (void)viewWillAppear
{
    [super viewWillAppear];
}


- (void)viewwillDisappear
{
    [super viewwillDisappear];
}
- (void)layoutSubviews
{
  
    
    NSString *MachineName = [AppInfo getMachineName];
    if([MachineName isEqualToString :@"iPhone 6 Plus (A1522/A1524)" ])
    {
        
        _introductionLabel.font = [UIFont systemFontOfSize:12.0f];

        
        float left = 22.5;
        float shang =(SCREEN_HEIGHT-415)/2;
        
        self.headImg.frame = CGRectMake(20.7, 33,74, 74);
        
        self.headImg.center = CGPointMake(_viewContent.center.x-left, CGRectGetMaxY(self.labelWelcome.frame) + 16 + 74/2);
        
        _labelWelcome.frame = CGRectMake(52, 22, 180, 20);
        
        CGSize nickSize = [CommonFuction sizeOfString:_CommonFuction maxWidth:300 maxHeight:15 withFontSize:14.0f];
        self.nick.frame = CGRectMake(75, 0, nickSize.width, nickSize.height);
        self.nick.center = CGPointMake(_viewContent.center.x-left, 160);
        //    self.starBtn.frame = CGRectMake(0, 24, SCREEN_WIDTH, 55);
        
        self.imageheart.frame = CGRectMake(0, 0, 15, 13);
        self.imageheart.center = CGPointMake(self.headImg.center.x - 15 + 7, self.nick.center.y + 35/2 + 5);
        
        
        [self.labelLike sizeToFit];
        self.labelLike.center = CGPointMake(self.headImg.center.x + self.labelLike.bounds.size.width/2 + 3 , self.imageheart.center.y);
        
        
        [_introductionLabel sizeToFit];
        CGSize introductionLabelSize = [CommonFuction sizeOfString:self.introductionLabel.text maxWidth:200 maxHeight:32 withFontSize:14.0f];
        self.introductionLabel.center = CGPointMake(self.headImg.center.x, self.imageheart.center.y+introductionLabelSize.height/2 + 25);
        
        self.imageViewLine.center = CGPointMake(self.headImg.center.x, CGRectGetMaxY(self.introductionLabel.frame) + 35/2 + 15);
        
        [self.labelGuanZHu sizeToFit];
        self.labelGuanZHu.center = CGPointMake(self.headImg.center.x-40-self.labelGuanZHu.bounds.size.width/2,  CGRectGetMaxY(self.introductionLabel.frame) + 15 +self.labelGuanZHu.bounds.size.height/2);
        
        [self.labelFans sizeToFit];
        self.labelFans.center = CGPointMake(self.headImg.center.x + 40 + self.labelFans.bounds.size.width/2, self.labelGuanZHu.center.y);
        
        [self.labelGuanZHuLabel sizeToFit];
        self.labelGuanZHuLabel.center = CGPointMake(self.labelGuanZHu.center.x, self.labelFans.center.y+self.labelGuanZHuLabel.bounds.size.height/2 + 13);
        
        [self.labelFansLabel sizeToFit];
        self.labelFansLabel.center = CGPointMake(self.labelFans.center.x, self.labelGuanZHuLabel.center.y);
        
        
        
        
        //    self.starlevelGrade.frame = CGRectMake(80 + nickSize.width, 35, 33, 15);
        //
        //
        //
        //    self.detailedImg.frame = CGRectMake(75+225, 43, 10, 20);
        //
        //    self.attentionBtn.frame = CGRectMake(38, 10, 56, 23);
        //    self.shareBtn.frame = CGRectMake(131, 165, 56, 23);
        //    self.reportBtn.frame = CGRectMake(225, 165, 56, 23);
        
        _buttonGuanZhu.frame = CGRectMake(0, 0, 150, 32);
        _buttonGuanZhu.center = CGPointMake(self.headImg.center.x, self.viewContent.bounds.size.height-100);
        
        

    }
    else
    {

        float left = 22.5;
        float shang =(SCREEN_HEIGHT-415)/2;
        
        self.headImg.frame = CGRectMake(20.7, 35,74, 74);
        self.headImg.center = CGPointMake(_viewContent.center.x-left, CGRectGetMaxY(self.labelWelcome.frame) + 16+ 74/2);
        
        _labelWelcome.frame = CGRectMake(50, 22, 182, 20);
        
        _introductionLabel.font = [UIFont systemFontOfSize:12.0f];
        
        CGSize nickSize = [CommonFuction sizeOfString:_CommonFuction maxWidth:300 maxHeight:15 withFontSize:14.0f];
        self.nick.frame = CGRectMake(75, 35, nickSize.width, nickSize.height);
        self.nick.center = CGPointMake(_viewContent.center.x-left, 150+35/2-12);
        //    self.starBtn.frame = CGRectMake(0, 24, SCREEN_WIDTH, 55);
        
        self.imageheart.frame = CGRectMake(0, 0, 15, 13);
        self.imageheart.center = CGPointMake(self.headImg.center.x - 15 - 1, self.nick.center.y+35/2+5);
        //    self.imageheart.center = CGPointMake(self.headImg.center.x - 15 + 4, self.nick.center.y+35/2+5);
        
        
        [self.labelLike sizeToFit];
        self.labelLike.center = CGPointMake(self.headImg.center.x+self.labelLike.bounds.size.width/2 , self.imageheart.center.y);
        //    self.labelLike.center = CGPointMake(self.headImg.center.x+self.labelLike.bounds.size.width/2  - 3, self.imageheart.center.y);
        
        
        [_introductionLabel sizeToFit];
        CGSize introductionLabelSize = [CommonFuction sizeOfString:self.introductionLabel.text maxWidth:200 maxHeight:100 withFontSize:14.0f];
        
        if (introductionLabelSize.height<=30) {
            self.viewContent.frame=  CGRectMake(22.5, (SCREEN_HEIGHT-415)/2, 275, 415-12);
            
           
            for (int i = 0; i<=2; i++) {
            
                    UIButton* button = (UIButton*)[self.viewContent viewWithTag:100+i];
                     button.frame = CGRectMake(23+(43+50)*i, _viewContent.bounds.size.height-60-7, 43, 43);
             
            }

                   self.introductionLabel.center = CGPointMake(self.headImg.center.x, self.imageheart.center.y+introductionLabelSize.height/2+18);
        }else {
                  self.introductionLabel.center = CGPointMake(self.headImg.center.x, self.imageheart.center.y+33/2+18);
        }
        
        
        self.imageViewLine.center = CGPointMake(self.headImg.center.x, CGRectGetMaxY(self.introductionLabel.frame) + 37/2 + 18);
        
        [self.labelGuanZHu sizeToFit];
        self.labelGuanZHu.center = CGPointMake(self.headImg.center.x - 40 - self.labelGuanZHu.bounds.size.width/2,  CGRectGetMaxY(self.introductionLabel.frame) + 15 + self.labelGuanZHu.bounds.size.height/2);
        
        [self.labelFans sizeToFit];
        self.labelFans.center = CGPointMake(self.headImg.center.x+40+self.labelFans.bounds.size.width/2, self.labelGuanZHu.center.y);
        
        [self.labelGuanZHuLabel sizeToFit];
        self.labelGuanZHuLabel.center = CGPointMake(self.labelGuanZHu.center.x, self.labelFans.center.y+self.labelGuanZHuLabel.bounds.size.height/2 + 13);
        
        [self.labelFansLabel sizeToFit];
        self.labelFansLabel.center = CGPointMake(self.labelFans.center.x, self.labelGuanZHuLabel.center.y);
        
        
        
        
        //    self.starlevelGrade.frame = CGRectMake(80 + nickSize.width, 35, 33, 15);
        //
        //
        //
        //    self.detailedImg.frame = CGRectMake(75+225, 43, 10, 20);
        //
        //    self.attentionBtn.frame = CGRectMake(38, 10, 56, 23);
        //    self.shareBtn.frame = CGRectMake(131, 165, 56, 23);
        //    self.reportBtn.frame = CGRectMake(225, 165, 56, 23);
        
        _buttonGuanZhu.frame = CGRectMake(0, 0, 150, 33);
        _buttonGuanZhu.center = CGPointMake(self.headImg.center.x, self.viewContent.bounds.size.height-100);
        
        
        
    }
}
-(void)buttonPressed:(UIButton*)sender
{
    
    if (sender.tag==1) {
        //点击关注调用方法
        [[NSNotificationCenter defaultCenter]postNotificationName:@"butonGuanZhuPressed" object:self];
        if (self.isGuanZhuEd)
        {
          self.isGuanZhuEd = NO;
            
        }else
        {
             self.isGuanZhuEd = YES;
        }
        return;
    }
    
    if (sender.tag==2) {//点击关注调用方法
        [self removeFromSuperview];
    }
    
    UIButton *btn = (UIButton *)sender;//点击item方法
    for (int i = 0; i<=2; i++) {
        if (100+i == btn.tag) {
//            [btn setBackgroundColor:[CommonFuction colorFromHexRGB:@"f1f1f1"]];
            
        }else {
            UIButton* button = (UIButton*)[self.viewContent viewWithTag:100+i];
            [button setBackgroundColor:[UIColor clearColor]];
        }
    }
    
    StarInfo *starInfo = [UserInfoManager shareUserInfoManager].currentStarInfo;

    switch (btn.tag-100)
    {
        case 0:
        {
            
            //踢出房间
            if (self.delegate && [self.delegate respondsToSelector:@selector(kickPersonLeft:)])
            {
                [self.delegate  kickPersonLeft:starInfo];
            }
        }
            break;
        case 1:
        {
            //禁言5分钟
            if (self.delegate && [self.delegate respondsToSelector:@selector(forbidSpeakLeft:)])
            {
                [self.delegate  forbidSpeakLeft:starInfo];
            }
            
        }
            break;
  
        case 2:
        {
            //举报TA
            if (self.delegate && [self.delegate respondsToSelector:@selector(reportLeft:)])
            {
                [self.delegate  reportLeft:starInfo];
            }
        }
            break;
        default:
            break;
    }


    
}

@end
