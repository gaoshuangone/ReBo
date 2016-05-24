//
//  PersonInfoViewController.m
//  BoXiu
//
//  Created by andy on 14-4-25.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "PersonInfoViewController.h"
#import "UIImageView+WebCache.h"
#import "IconButton.h"
#import "GetUserInfoModel.h"
#import "AddAttentModel.h"
#import "DelAttentionModel.h"
#import "AppInfo.h"
#import "UserInfoManager.h"
#import "JEProgressView.h"
#import "GetUserCarModel.h"
#import "PropView.h"
#import "AppDelegate.h"
#import "EWPDialog.h"
#import "BeanTocoinModel.h"
#import "UMSocial.h"
#import "NavbarBack.h"
#import "PersonItemView.h"
#import "PersonNick.h"
#import <Accelerate/Accelerate.h>
#import "UIImage+Blur.h"
#import "updateCurrUserModel.h"
#import "CustomBadge.h"
#import <AVFoundation/AVFoundation.h>
#define  DISTANCE 4

@interface PersonInfoViewController ()<PropViewDelegate,UMSocialUIDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>
@property (nonatomic,strong) UIImageView *headImageView;
@property (nonatomic,strong) UIButton *statusView;
@property (nonatomic,strong) UILabel *placeLable;
@property (nonatomic,strong) UILabel *userIdLabel;
@property (nonatomic,strong) UILabel *fanCountLable;
@property (nonatomic,strong) UILabel *coinCountLable;
@property (nonatomic,strong) UILabel *beanCountLable;

@property (nonatomic,strong) UILabel *coinUnitLabel;
@property (nonatomic,strong) UIImageView *consumGrade;
@property (nonatomic,strong) JEProgressView *consumProgressView;
@property (nonatomic,strong) UILabel *consumNeedCoinLable;
@property (nonatomic,strong) UIImageView *consumNextGrade;
@property (nonatomic,strong) UIImageView *userGrade;
@property (nonatomic,strong) JEProgressView *userProgressView;
@property (nonatomic,strong) UILabel *userNeedCoinLable;
@property (nonatomic,strong) UIImageView *userNextGrade;
@property (nonatomic,strong) UIView *coinView;

@property (nonatomic,strong) UILabel *focusCountLable;

@property (nonatomic,strong) UILabel *introductionLabel;
@property (nonatomic,strong) PropView *propView;
@property (nonatomic,strong) BeanTocoinModel *beanTocoinModel;

@property (nonatomic,strong) UIImageView *starLevelidImgView;
@property (nonatomic,strong) UIImageView *consumptionLevelImgView;

@property (nonatomic,strong) UIView *userView;
@property (nonatomic,strong) UIView *starView;
@property (nonatomic,strong) UIImageView *vertImgView;
@property (nonatomic,strong) UIImageView *redouImgView;
@property (nonatomic,strong) UILabel *getCoinTitle;

@property (atomic,strong) GetUserInfoModel *getUserInfoModel;
@property (nonatomic) NSInteger userId;
@property (nonatomic,assign) BOOL isUserSelf;
@property (nonatomic,strong) NSMutableArray *propMArray;

@property (nonatomic,strong) EWPButton *materialBtn;
@property (nonatomic,strong) UIImageView *VertImgView;
@property (nonatomic,strong) NavbarBack *navBack;

@property (nonatomic,strong) PersonItemView *starItemView;  //明星等级
@property (nonatomic,strong) PersonItemView *consumptionItemView;   //财富等级

@property (nonatomic,strong) PersonItemView *singatureItemView;
@property (nonatomic,strong) PersonItemView *propItemView;
@property (nonatomic,strong) PersonItemView *rebiItemView;
@property (nonatomic,strong) PersonNick *personNick;
@property (nonatomic,strong) CustomBadge *msgBadge;

@property (nonatomic,strong) UIButton* buttonBack;
@property (nonatomic,strong) UIButton* buttonMsg;
@property (nonatomic,strong) UIButton* buttonSet;

@property (nonatomic,strong) UIButton* buttonAtt;
@property (nonatomic,strong) UIButton* buttonZhiBo;
@property (nonatomic,strong) UIButton* buttonHead;
@property (nonatomic,strong) UIImageView* backImageView;
@property (nonatomic,strong) UILabel* fanCountTitle;
@property (nonatomic,strong) UILabel* shuLabel;
@property (nonatomic,strong) UIImageView* imageVidewAlpha;
@property (nonatomic,strong) UIImageView* iamgeViewRoung;
@property (nonatomic,copy) void (^personalBlock)(void);
@property (nonatomic,strong)UIView* bgView;
@property (nonatomic,assign) BOOL  isNeedHidLiveIn;


@property (nonatomic,strong) UIButton* propBtn;
@end


@implementation PersonInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.baseViewType = kbaseScroolViewType;
        _isUserSelf = YES;
        _userId = [UserInfoManager shareUserInfoManager].currentUserInfo.userId;
    }
    return self;
}
- (void)dealloc
{
    //        [[MessageCenter shareMessageCenter] removeObserver:self forKeyPath:@"unReadCount" context:nil];
}

- (void)viewDidLoad
{
    
    
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
    // Do any additional setup after loading the view.
    // [[MessageCenter shareMessageCenter] addObserver:self forKeyPath:@"unReadCount" options:NSKeyValueObservingOptionNew context:nil];
    
    
    self.scrollView.frame = CGRectMake(0, 208+8, SCREEN_WIDTH, SCREEN_HEIGHT - 208);
    
    
    
    
    
    _backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 208)];
    _backImageView.userInteractionEnabled = YES;
    _backImageView.contentMode = UIViewContentModeScaleAspectFill;
    [_backImageView.layer setMasksToBounds:YES];
    [self.view addSubview:_backImageView];
    
    _imageVidewAlpha = [[UIImageView alloc]initWithFrame:_backImageView.frame];
    _imageVidewAlpha.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    _imageVidewAlpha.userInteractionEnabled = YES;
    [_backImageView addSubview:_imageVidewAlpha];
    
    UIImageView *defaultHead = [[UIImageView alloc] initWithFrame:CGRectMake(15,  (208 - 66)/2, 66, 66)];
    //    defaultHead.image = [UIImage imageNamed:@"head_default"];
    defaultHead.image = [UIImage imageNamed:@"morenHead"];
    defaultHead.layer.cornerRadius = 33;
    [defaultHead setClipsToBounds:YES];
    [_backImageView addSubview:defaultHead];
    defaultHead.userInteractionEnabled = YES;
    
    _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake((_backImageView.frame.size.width-667)/2, (208 - 66)/2, 66, 66)];
    _headImageView.layer.cornerRadius = 33;
    _headImageView.center = defaultHead.center;
    _headImageView.layer.borderWidth=1;
    _headImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    [_headImageView setClipsToBounds:YES];
    [_backImageView addSubview:_headImageView];
    _headImageView.userInteractionEnabled = YES;
    
    
    
    _buttonHead = [CommonUtils commonButtonWithFrame:_headImageView.frame withTarget:self withAction:@selector(buttonPres:)];
    _buttonHead.tag = 104;
    [_backImageView addSubview:_buttonHead];
    
    if (self.isUserSelf) {
        
        UIImageView* imageViewXJ = [[UIImageView alloc]initWithFrame:CGRectMake(defaultHead.center.x+66/4-4, defaultHead.center.y+66/4-4, 21, 21)];
        imageViewXJ.image =[UIImage imageNamed:@"ca.png"];
        [_backImageView addSubview:imageViewXJ];
    }
    
    if([UserInfoManager shareUserInfoManager].tempHederImage!= nil) {
        _headImageView.image = [UserInfoManager shareUserInfoManager].tempHederImage;
        _backImageView.image =[UserInfoManager shareUserInfoManager].tempHederImage;

    }else{
      _backImageView.image = [UIImage imageNamed:@"morenBG"];
    }
    
    
    
    
    CGFloat disLeft = 15;
    CGFloat disXia = 3+5+2;
    
    UILabel *focusCountLable = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_headImageView.frame)+disLeft, _headImageView.center.y+disXia, 153, 15)];
    focusCountLable.text = @"关注 :";
    focusCountLable.textColor = [CommonFuction colorFromHexRGB:@"ffffff"];
    focusCountLable.font = [UIFont systemFontOfSize:13];
    focusCountLable.textAlignment = NSTextAlignmentLeft;
    [_backImageView addSubview:focusCountLable];
    
    _focusCountLable = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_headImageView.frame)+disLeft+40-DISTANCE, _headImageView.center.y+disXia, 120, 15)];
    _focusCountLable.textColor = [CommonFuction colorFromHexRGB:@"ffffff"];
    _focusCountLable.font = [UIFont systemFontOfSize:16];
    _focusCountLable.text = [NSString stringWithFormat:@"0"];
    _focusCountLable.textAlignment = NSTextAlignmentLeft;
    [_backImageView addSubview:_focusCountLable];
    
    
    
    
    _vertImgView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_headImageView.frame)+disLeft+65-DISTANCE, _headImageView.center.y+disXia, 1, 15)];
    _vertImgView.backgroundColor = [CommonFuction colorFromHexRGB:@"ffffff"];
    [_backImageView addSubview:_vertImgView];
    
    _fanCountTitle = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_headImageView.frame)+disLeft+80-DISTANCE, _headImageView.center.y+disXia, 153, 15)];
    _fanCountTitle.text = @"粉丝 :";
    _fanCountTitle.textColor = [CommonFuction colorFromHexRGB:@"ffffff"];
    _fanCountTitle.font = [UIFont systemFontOfSize:12];
    _fanCountTitle.textAlignment = NSTextAlignmentLeft;
    [_backImageView addSubview:_fanCountTitle];
    
    _fanCountLable = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_headImageView.frame)+disLeft+80+40-DISTANCE, _headImageView.center.y+disXia, 80, 15)];
    _fanCountLable.textColor = [CommonFuction colorFromHexRGB:@"ffffff"];
    _fanCountLable.text = @"0";
    _fanCountLable.font = [UIFont systemFontOfSize:16];
    _fanCountLable.textAlignment = NSTextAlignmentLeft;
    [_backImageView addSubview:_fanCountLable];
    
    
    _buttonBack = [UIButton buttonWithType:UIButtonTypeCustom];
    [_buttonBack setImage:[UIImage imageNamed:@"navB_Nor.png"] forState:UIControlStateNormal];
    _buttonBack.frame = CGRectMake(0, 20, 50, 40);
    _buttonBack.tag = 101;
    [_buttonBack addTarget:self action:@selector(buttonPres:) forControlEvents:UIControlEventTouchUpInside];
    [_backImageView addSubview:_buttonBack];
    
    
    _iamgeViewRoung = [[UIImageView alloc] init];
    _iamgeViewRoung. frame = CGRectMake(SCREEN_WIDTH-40-40-10+18+16+1+2, 22+5+2.5,4, 4);
    _iamgeViewRoung.backgroundColor = [UIColor redColor];
    _iamgeViewRoung.layer.cornerRadius =2;
    [_iamgeViewRoung.layer setMasksToBounds:YES];
    [_backImageView addSubview:_iamgeViewRoung];
    
    _msgBadge = [CustomBadge customBadgeWithString:@"" withStringColor:[UIColor whiteColor] withInsetColor:[CommonFuction colorFromHexRGB:@"ff6666"] withBadgeFrame:YES withBadgeFrameColor:[CommonFuction colorFromHexRGB:@"ff6666"] withScale:0.1 withShining:NO];
    _msgBadge.userInteractionEnabled = NO;
    _msgBadge.backgroundColor = [UIColor clearColor];
    
    _msgBadge.layer.cornerRadius = 2;
    _msgBadge.frame = CGRectMake(SCREEN_WIDTH-40-40-10+18+16+1, 22+1,4, 4);
    NSInteger unreadMsgCount = [[MessageCenter shareMessageCenter] unReadCount];
    if (unreadMsgCount == 0 || !self.isUserSelf)
    {
        _msgBadge.hidden = YES;
        
        _iamgeViewRoung.hidden = YES;
    }
    else
    {
        _msgBadge.hidden = NO;
        _iamgeViewRoung.hidden = NO;
        //        _msgBadge.badgeText = [NSString stringWithFormat:@"%ld",(long)unreadMsgCount];
    }
    
    //    if ([MessageCenter shareMessageCenter].isHaveUnReadCount ) {
    //            _msgBadge.hidden = NO;
    //
    //           _iamgeViewRoung.hidden = NO;
    //        [MessageCenter shareMessageCenter].unReadCount = 1;
    //
    //    }
    //    [_backImageView addSubview:_msgBadge];
    
    _buttonMsg = [UIButton buttonWithType:UIButtonTypeCustom];
    [_buttonMsg setImage:[UIImage imageNamed:@"xiaoMsg"] forState:UIControlStateNormal];
    _buttonMsg.frame = CGRectMake( SCREEN_WIDTH-40-40,20, 40, 40);
    _buttonMsg.tag = 102;
    [_buttonMsg addTarget:self action:@selector(buttonPres:) forControlEvents:UIControlEventTouchUpInside];
    
    
    _buttonSet = [UIButton buttonWithType:UIButtonTypeCustom];
    [_buttonSet setImage:[UIImage imageNamed:@"sheSet"] forState:UIControlStateNormal];
    
    //    [_buttonSet setBackgroundImage:[UIImage imageNamed:@"sheSet.png"] forState:UIControlStateNormal];
    _buttonSet.frame = CGRectMake(SCREEN_WIDTH-41,20 , 40, 40);
    _buttonSet.tag = 103;
    
    [_buttonSet addTarget:self action:@selector(buttonPres:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    _personNick = [[PersonNick alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_headImageView.frame)+disLeft,  _headImageView.center.y-37+5+2, SCREEN_WIDTH, 40) showInView:self.view];
    __weak typeof(self) weakSelf = self;
    
    if (self.isUserSelf) {
        [_backImageView addSubview:_buttonSet];
        [_backImageView addSubview:_buttonMsg];
    }
    _personNick.isSelfUser = self.isUserSelf;
    _personNick.userInteractionEnabled = YES;
    __weak PersonNick* personNick =_personNick;
    _personNick.backButtonBlock = ^(id sender){
        __strong typeof(self) strongself = weakSelf;
        if (strongself)
        {
            [UserInfoManager shareUserInfoManager].tempHederImage = nil;
            personNick.title =@"";
            [weakSelf OnModifyInfo];//修改个人中心
        }
        
    };
    
    [self.view addSubview:_personNick];
    
    
    CGFloat wide = (SCREEN_WIDTH-CGRectGetMaxX(_headImageView.frame)-20-20-18)/2;
    
    _buttonAtt = [UIButton buttonWithType:UIButtonTypeCustom];
    [_buttonAtt setBackgroundImage:[UIImage imageNamed:@"buttonAtt.ng"] forState:UIControlStateNormal];
    _buttonAtt.frame = CGRectMake(CGRectGetMaxX(_headImageView.frame)+disLeft, _headImageView.center.y+5+15+10+6+4, wide, 29);
    [_buttonAtt setTitle:@"+ 关注" forState:UIControlStateNormal];
    _buttonAtt.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    _buttonAtt.hidden = YES;
    _buttonAtt.tag=105;
    [_buttonAtt addTarget:self action:@selector(buttonPres:) forControlEvents:UIControlEventTouchUpInside];
    [_backImageView addSubview:_buttonAtt];
    
    _buttonZhiBo = [UIButton buttonWithType:UIButtonTypeCustom];
    [_buttonZhiBo setBackgroundImage:[UIImage imageNamed:@"buttonAtt.ng"] forState:UIControlStateNormal];
    _buttonZhiBo.frame = CGRectMake(CGRectGetMaxX(_headImageView.frame)+disLeft+wide+10, _headImageView.center.y+5+15+10+6+4, wide, 29);
    [_buttonZhiBo setTitle:@"Ta的直播间" forState:UIControlStateNormal];
    _buttonZhiBo.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    _buttonZhiBo.tag = 106;
    _buttonZhiBo.hidden = YES;
    [_buttonZhiBo addTarget:self action:@selector(buttonPres:) forControlEvents:UIControlEventTouchUpInside];
    [_backImageView addSubview:_buttonZhiBo];
    
   
    
    
    
    //    _navBack = [[NavbarBack alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_headImageView.frame)+10, 20, SCREEN_WIDTH, 40) showInView:self.view];
    //
    //    __weak typeof(self) weakSelf = self;
    //    _navBack.backButtonBlock = ^(id sender)
    //    {
    //        __strong typeof(self) strongself = weakSelf;
    //        if (strongself)
    //        {
    //            NSString *className = NSStringFromClass([strongself class]);
    //            NSDictionary *param = [NSDictionary dictionaryWithObject:className forKey:@"className"];
    //            [strongself popCanvasWithArgment:param];
    //        }
    //
    //    };
    //
    //    [self.view addSubview:_navBack];
    //
    
    
    PersonItemView *liangIdItemView = [[PersonItemView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 43) title:@"靓号:" smallImg:[UIImage imageNamed:@"userIdxcode"]];
    [self.scrollView addSubview:liangIdItemView];
    [liangIdItemView setViewLine];
    _userIdLabel = [[UILabel alloc] initWithFrame:CGRectMake(88, 14, 100, 15)];
    _userIdLabel.textColor = [CommonFuction colorFromHexRGB:@"575757"];
    _userIdLabel.font = [UIFont systemFontOfSize:15];
    _userIdLabel.textAlignment = NSTextAlignmentLeft;
    [liangIdItemView addSubview:_userIdLabel];
    
    _placeLable = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-127-10, 13, 127, 15)];
    //    _placeLable.text = @"浙江 杭州";
    _placeLable.text = @"        ";
    //    _placeLable.textColor = [CommonFuction colorFromHexRGB:@"f9f9f9"];
    _placeLable.textColor = [UIColor grayColor];
    _placeLable.font = [UIFont systemFontOfSize:12];
    _placeLable.textAlignment = NSTextAlignmentRight;
    [liangIdItemView addSubview:_placeLable];
    
    //    YOffset += 43;
    
    _starItemView = [[PersonItemView alloc] initWithFrame:CGRectMake(0, 43, SCREEN_WIDTH, 43) title:@"明星:" smallImg:[UIImage imageNamed:@"starSmall"]];
    [self.scrollView addSubview:_starItemView];
    [_starItemView setViewLine];
    _userProgressView=[[JEProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
    //    _userProgressView.frame = CGRectMake(88, 30, 197, 8);
    _userProgressView.frame = CGRectMake(88, 26, 240-83, 8);
    _userProgressView.backgroundColor = [UIColor clearColor];
    //    _userProgressView.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
    
    
    UIImage *img = [CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"e8e8e8"] size:CGSizeMake(180, 3)];
    img = [img resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
    _userProgressView.trackImage = img;
    img = [CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"50d2f7"] size:CGSizeMake(180, 3)];
    img = [img resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
    _userProgressView.progressImage = img;
    [_starItemView addSubview:_userProgressView];
    
    UILabel *userGradeTitle = [[UILabel alloc] initWithFrame:CGRectMake(88, 6, 100, 15)];
    userGradeTitle.text = @"获赠礼物升级";
    userGradeTitle.font = [UIFont systemFontOfSize:11];
    //    userGradeTitle.textColor = [CommonFuction colorFromHexRGB:@"f9f9f9"];
    userGradeTitle.textColor = [UIColor grayColor];
    [_starItemView addSubview:userGradeTitle];
    
    //    经验百分比
    _userNeedCoinLable = [[UILabel alloc] initWithFrame:CGRectMake(140, 7, 100, 20)];
    _userNeedCoinLable.font = [UIFont systemFontOfSize:11];
    _userNeedCoinLable.textColor = [CommonFuction colorFromHexRGB:@"50d2f7"];
    _userNeedCoinLable.textAlignment = NSTextAlignmentRight;
    //    [starItemView addSubview:_userNeedCoinLable];
    
    //    //明星等级
    UserInfo *userInfo = [UserInfoManager shareUserInfoManager].currentUserInfo;
    //    UIImageView *vipImageView = [[UIImageView alloc] initWithFrame:CGRectMake(240+68/2-12.5-5, 15,33, 15)];
    ////    vipImageView.image = [[UserInfoManager shareUserInfoManager] imageOfStar:userInfo.privlevelweight];
    //    [_starItemView addSubview:vipImageView];
    
    
    //    YOffset += 47;
    //    YOffsett += 94 +47;
    //    //    //明星登记
    _consumptionItemView = [[PersonItemView alloc] initWithFrame:CGRectMake(0, 86, SCREEN_WIDTH, 43) title:@"财富:" smallImg:[UIImage imageNamed:@"money"]];
    [self.scrollView  addSubview:_consumptionItemView];
    
    //    197 - 50
    _consumProgressView = [[JEProgressView alloc] initWithFrame:CGRectMake(88, 28, 240-83, 8)];
    //    _consumProgressView.transform = CGAffineTransformMakeScale(1.0f, 1.5f);;
    img = [CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"e8e8e8"] size:CGSizeMake(180, 3)];
    img = [img resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
    _consumProgressView.trackImage = img;
    img = [CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"f7c250"] size:CGSizeMake(180, 3)];
    img = [img resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
    _consumProgressView.progressImage = img;
    [_consumptionItemView addSubview:_consumProgressView];
    
    //  150 - 50
    UILabel *consumGradeTitle = [[UILabel alloc] initWithFrame:CGRectMake(88, 6, 100, 20)];
    consumGradeTitle.text = @"消耗热币升级";
    consumGradeTitle.font = [UIFont systemFontOfSize:11];
    //    consumGradeTitle.textColor = [CommonFuction colorFromHexRGB:@"f9f9f9"];
    consumGradeTitle.textColor =[UIColor grayColor];
    [_consumptionItemView addSubview:consumGradeTitle];
    
    //    经验百分比
    _consumNeedCoinLable = [[UILabel alloc] initWithFrame:CGRectMake(160, 7, 100, 20)];
    _consumNeedCoinLable.font = [UIFont systemFontOfSize:11];
    _consumNeedCoinLable.textColor = [CommonFuction colorFromHexRGB:@"f7c250"];
    _consumNeedCoinLable.textAlignment = NSTextAlignmentRight;
    //    [consumptionItemView addSubview:_consumNeedCoinLable];
    
    //    //财富登记
    //    UIImageView *consumImageView = [[UIImageView alloc] initWithFrame:CGRectMake(240+68/2-12.5-5+1.5, 15,33, 15)];
    ////    consumImageView.image = [[UserInfoManager shareUserInfoManager] imageOfconsumerlevelweight:userInfo.consumerlevelweight];
    //    [_consumptionItemView addSubview:consumImageView];
    
    
    _starLevelidImgView = [[UIImageView alloc] initWithFrame:CGRectMake(240+68/2-12.5-5, 15, 33, 15)];
    _consumptionLevelImgView = [[UIImageView alloc] initWithFrame:CGRectMake(240+68/2-12.5-5, 15, 33, 15)];
    
    _starLevelidImgView.image =[[UserInfoManager shareUserInfoManager] imageOfStar:userInfo.privlevelweight];
    _consumptionLevelImgView.image =[[UserInfoManager shareUserInfoManager] imageOfconsumerlevelweight:userInfo.consumerlevelweight];
    [_starItemView addSubview:_starLevelidImgView];
    [_consumptionItemView addSubview:_consumptionLevelImgView];
    
    
    
    int YOffset = 86+43+8;
    int YOffsett = 0;
    
    _bgView = [[UIView alloc] init];
    _bgView.backgroundColor = [UIColor clearColor];
    [self.scrollView addSubview:_bgView];
    
    _rebiItemView = [[PersonItemView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 43) title:nil smallImg:[UIImage imageNamed:@"rechageIcon"]];
    [_bgView addSubview:_rebiItemView];
    
    _coinCountLable = [[UILabel alloc] initWithFrame:CGRectMake(45, 15, 180, 15)];
    _coinCountLable.text = @"热币：";
    _coinCountLable.textColor = [CommonFuction colorFromHexRGB:@"454a4d"];
    _coinCountLable.font = [UIFont systemFontOfSize:14];
    [_rebiItemView addSubview:_coinCountLable];
    [_rebiItemView setViewLine];
    
    UIImage *narmalImg = [CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"ffffff"] size:CGSizeMake(68, 25)];
    UIImage *selectImg = [CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"d14c49"] size:CGSizeMake(68, 25)];
    
    UIButton *rechargeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rechargeBtn.frame = CGRectMake(240, 8.5, 68, 25);
    [rechargeBtn setTitle:@"充值" forState:UIControlStateNormal];
    [rechargeBtn setTitleColor:[CommonFuction colorFromHexRGB:@"d14c49"] forState:UIControlStateNormal];
    [rechargeBtn setTitleColor:[CommonFuction colorFromHexRGB:@"ffffff"] forState:UIControlStateHighlighted];
    [rechargeBtn setBackgroundImage:narmalImg forState:UIControlStateNormal];
    [rechargeBtn setBackgroundImage:selectImg forState:UIControlStateHighlighted];
    rechargeBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    rechargeBtn.layer.cornerRadius = 12.5f;
    rechargeBtn.layer.masksToBounds = YES;
    rechargeBtn.layer.borderWidth = 0.5;
    rechargeBtn.layer.borderColor = [CommonFuction colorFromHexRGB:@"d14c49"].CGColor;
    [rechargeBtn addTarget:self action:@selector(rechargeRebi) forControlEvents:UIControlEventTouchUpInside];
    [_rebiItemView addSubview:rechargeBtn];
    
    
    
    
    PersonItemView *redouItemView = [[PersonItemView alloc] initWithFrame:CGRectMake(0, 43, SCREEN_WIDTH, 43) title:nil smallImg:[UIImage imageNamed:@"dou"]];
    [_bgView addSubview:redouItemView];
    
    _beanCountLable = [[UILabel alloc] initWithFrame:CGRectMake(45, 15, 180, 15)];
    _beanCountLable.text = @"热豆：";
    _beanCountLable.textColor = [CommonFuction colorFromHexRGB:@"454a4d"];
    _beanCountLable.font = [UIFont systemFontOfSize:14];
    [redouItemView addSubview:_beanCountLable];
    
    UIButton *douchargeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    douchargeBtn.frame = CGRectMake(240, 8.5, 68, 25);
    [douchargeBtn setTitle:@"提现" forState:UIControlStateNormal];
    [douchargeBtn setTitleColor:[CommonFuction colorFromHexRGB:@"d14c49"] forState:UIControlStateNormal];
    [douchargeBtn setTitleColor:[CommonFuction colorFromHexRGB:@"ffffff"] forState:UIControlStateHighlighted];
    [douchargeBtn setBackgroundImage:narmalImg forState:UIControlStateNormal];
    [douchargeBtn setBackgroundImage:selectImg forState:UIControlStateHighlighted];
    douchargeBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    douchargeBtn.layer.cornerRadius = 12.5f;
    douchargeBtn.layer.masksToBounds = YES;
    douchargeBtn.layer.borderWidth = 0.5;
    douchargeBtn.layer.borderColor = [CommonFuction colorFromHexRGB:@"d14c49"].CGColor;
    [douchargeBtn addTarget:self action:@selector(rechargeRedou) forControlEvents:UIControlEventTouchUpInside];
    [redouItemView addSubview:douchargeBtn];
    
    
    
    _propBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    
    
    
    if (_isUserSelf)
    {
        _rebiItemView.hidden = NO;
        redouItemView.hidden = NO;
        _propBtn.hidden = NO;
        
        if ([[[AppInfo shareInstance].hideSwitch substringFromIndex:1] integerValue]==1) {
            
            [_rebiItemView setViewLineHid];
            _bgView.frame = CGRectMake(0, YOffset, SCREEN_WIDTH, 137);
            YOffset += 43+8;
        }else if (![[UserInfoManager shareUserInfoManager].getUserInfoModel.userInfo.isbeantomoneydisplay isEqualToString:@"1"]){
            douchargeBtn.hidden = YES;
            _bgView.frame = CGRectMake(0, YOffset, SCREEN_WIDTH, 137);
            YOffset += 43*2+8;
            [_rebiItemView setViewLine];
        }else{
            douchargeBtn.hidden = NO;
            _bgView.frame = CGRectMake(0, YOffset, SCREEN_WIDTH, 137);
            YOffset += 43*2+8;
            [_rebiItemView setViewLine];
        }
        
        
        //        if ( || ) {
        //            redouItemView.hidden = YES;
        //
        //        }else{
        //
        //        }
        
        
    }
    else
    {
        _rebiItemView.hidden = YES;
        redouItemView.hidden = YES;
        _propBtn.hidden = YES;
        _bgView.frame = CGRectMake(0, YOffset - 47, SCREEN_WIDTH, 137);
        
    }
    
    
    
    
    _singatureItemView = [[PersonItemView alloc] initWithFrame:CGRectMake(0, YOffset, SCREEN_WIDTH, 43) title:@"签名:" smallImg:[UIImage imageNamed:@"signatureStar"]];
    [_singatureItemView setViewLine];
    [self.scrollView addSubview:_singatureItemView];
    _singatureItemView.hidden = NO;
    YOffset += 43;
    
    
    
    _introductionLabel = [[UILabel alloc] initWithFrame:CGRectMake(88, 1, 200, 40)];
    _introductionLabel.textColor = [CommonFuction colorFromHexRGB:@"575757"];
    _introductionLabel.font = [UIFont systemFontOfSize:12];
    _introductionLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    _introductionLabel.numberOfLines = 2;
    [_singatureItemView addSubview:_introductionLabel];
    
    //246
    //    YOffset += 47;
    NSInteger hideSwitch = [[[AppInfo shareInstance].hideSwitch substringFromIndex:1] integerValue];
    if (hideSwitch != 1)
    {
        if(_isUserSelf)
        {
            _propItemView = [[PersonItemView alloc] initWithFrame:CGRectMake(0, YOffset, SCREEN_WIDTH, 43) title:@"道具：" smallImg:[UIImage imageNamed:@"prop"]];
            [self.scrollView addSubview:_propItemView];
        }
        else
        {
            _propItemView = [[PersonItemView alloc] initWithFrame:CGRectMake(0, 86+43+43+8, SCREEN_WIDTH, 43) title:@"道具：" smallImg:[UIImage imageNamed:@"prop"]];
            [self.scrollView addSubview:_propItemView];
        }
        
        UIImage *narmalImg = [CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"ffffff"] size:CGSizeMake(68, 25)];
        UIImage *selectImg = [CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"d14c49"] size:CGSizeMake(68, 25)];
        
        _propBtn.frame = CGRectMake(240, YOffset + 8.5, 68, 25);
        [_propBtn setTitle:@"添加" forState:UIControlStateNormal];
        [_propBtn setTitleColor:[CommonFuction colorFromHexRGB:@"d14c49"] forState:UIControlStateNormal];
        [_propBtn setTitleColor:[CommonFuction colorFromHexRGB:@"ffffff"] forState:UIControlStateHighlighted];
        [_propBtn setBackgroundImage:narmalImg forState:UIControlStateNormal];
        [_propBtn setBackgroundImage:selectImg forState:UIControlStateHighlighted];
        _propBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        _propBtn.layer.cornerRadius = 12.5f;
        _propBtn.layer.masksToBounds = YES;
        _propBtn.layer.borderWidth = 0.5;
        _propBtn.layer.borderColor = [CommonFuction colorFromHexRGB:@"d14c49"].CGColor;
        [_propBtn addTarget:self action:@selector(buyVip) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:_propBtn];;
        
        YOffset += 47;
        YOffsett +=47;
    }
    
    
    _materialBtn = [EWPButton buttonWithType:UIButtonTypeCustom];
    _materialBtn.frame = CGRectMake(100, 8, 30, 20);
    [_materialBtn setTitle:@"有料" forState:UIControlStateNormal];
    [_materialBtn setTitleColor:[CommonFuction colorFromHexRGB:@"d14c49"] forState:UIControlStateNormal];
    _materialBtn.titleLabel.font = [UIFont boldSystemFontOfSize:13.0f];
    _materialBtn.buttonBlock = ^(id sender)
    {
        __strong typeof(self) strongSelf = weakSelf;
        NSString *link = strongSelf.getUserInfoModel.userInfo.mylink;
        if (![link hasPrefix:@"http://"])
        {
            link = [NSString stringWithFormat:@"http://%@",link];
        }
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:link]];
    };
    [self.starView addSubview:_materialBtn];
    
    //    判断道具显示位置
    if (_isUserSelf) {
        YOffset += 10;
        _propView = [[PropView alloc] initWithFrame:CGRectMake(0, YOffset-12, SCREEN_WIDTH, 60) showInView:self.view];
        
    }
    else
    {
        YOffsett += 10;
        _propView = [[PropView alloc] initWithFrame:CGRectMake(0, 86+43+47+47-4, SCREEN_WIDTH, 60) showInView:self.view];
        
    }
    
    _propView.delegate = self;
    [self.scrollView addSubview:_propView];
    

  

    
    self.personalBlock = ^(){
        
        __strong typeof(self) strongSelf = weakSelf;
        CGFloat offset = 137;
        
        
        if ([[[AppInfo shareInstance].hideSwitch substringFromIndex:1] integerValue]==1) {
            
            redouItemView.hidden = YES;
            strongSelf.bgView.frame = CGRectMake(0, offset, SCREEN_WIDTH, 137);
            offset += 43+8;
        }else if (![[UserInfoManager shareUserInfoManager].getUserInfoModel.userInfo.isbeantomoneydisplay isEqualToString:@"1"]){
            douchargeBtn.hidden = YES;
            redouItemView.hidden = NO;
            strongSelf.bgView.frame = CGRectMake(0, offset, SCREEN_WIDTH, 137);
            offset += 43*2+8;
        }else{
            douchargeBtn.hidden = NO;
            redouItemView.hidden = NO;
            strongSelf.bgView.frame = CGRectMake(0, offset, SCREEN_WIDTH, 137);
            offset += 43*2+8;
        }
        
        
        
        //        if (![[UserInfoManager shareUserInfoManager].getUserInfoModel.userInfo.isbeantomoneydisplay isEqualToString:@"1"]||[[[AppInfo shareInstance].hideSwitch substringFromIndex:1] integerValue]==1) {
        //            redouItemView.hidden = YES;
        //            strongSelf.bgView.frame = CGRectMake(0, offset, SCREEN_WIDTH, 137);
        //            offset += 43+8;
        //        }else{
        //            redouItemView.hidden = NO;
        //            strongSelf.bgView.frame = CGRectMake(0, offset, SCREEN_WIDTH, 137);
        //            offset += 43*2+8;
        //        }
        strongSelf.singatureItemView.frame = CGRectMake(0, offset, SCREEN_WIDTH, 43);
        offset += 43;
        strongSelf.propItemView.frame = CGRectMake(0, offset, SCREEN_WIDTH, 43);
        strongSelf.propBtn.frame = CGRectMake(240, offset + 8.5, 68, 25);
        offset += 47;
        
        
        
        strongSelf.propView.frame =CGRectMake(0, offset, SCREEN_WIDTH, 60);
        
        
        
    };
}
#pragma mark -argument
-(void)argumentForCanvas:(id)argumentData
{
      _isNeedHidLiveIn = NO;
    if (argumentData && [argumentData isKindOfClass:[NSDictionary class]])
    {
        
        NSDictionary *param = (NSDictionary *)argumentData;
        
        if ([[[argumentData valueForKey:@"className"] toString]isEqualToString:@"SearchViewController"] || [[[argumentData valueForKey:@"className"] toString]isEqualToString:@"SettingViewController"] || [[[argumentData valueForKey:@"className"] toString]isEqualToString:@"MessageCenterViewController"] ||[[[argumentData valueForKey:@"className"] toString]isEqualToString:@"LoginViewController"] ) {
            return;
        }
        if ([[[argumentData valueForKey:@"className"] toString]isEqualToString:Rank_Canvas]){
            [AppInfo shareInstance].pushType = 3;
        }else if ([[[argumentData valueForKey:@"className"] toString]isEqualToString:@"LiveRoomViewController"]){
            _isNeedHidLiveIn = YES;
        }
       
        NSString *tempUserId = [param objectForKey:@"userid"];
        if ([tempUserId integerValue] !=  [UserInfoManager shareUserInfoManager].currentUserInfo.userId && tempUserId)
        {
            _userId = [tempUserId integerValue];
            _isUserSelf = NO;
        }
        else
        {
            _userId = [UserInfoManager shareUserInfoManager].currentUserInfo.userId;
            _isUserSelf = YES;
        }
    }
    else
    {
        _isUserSelf = YES;
        _userId = [UserInfoManager shareUserInfoManager].currentUserInfo.userId;
        
        
        
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    
    [AppInfo shareInstance].neName = NULL;
    
    self.navigationController.navigationBarHidden = YES;
    
    if ([AppInfo shareInstance].bLoginSuccess) {
        //请求同时进行，
        
        
        [self getUserInfo];
    }else{
        if (!self.isUserSelf) {
            [self getUserInfo];
            
        }
    }
    
    if ([UserInfoManager shareUserInfoManager].tempHederImage != nil) {
        _headImageView.image =[UserInfoManager shareUserInfoManager].tempHederImage;
    }
    
    
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    
}
-(void)viewDidDisappear:(BOOL)animated
{
    
}

-(void)changeHeadImageWithIamge:(UIImage*)image with:(NSData*)data{
    
    
    UIImage* imageChange = nil;
    
    float blurred = .2f;
    if (image) {
        float quality = .00001f;
        
        NSData *imageData = UIImageJPEGRepresentation(image, quality);
        imageChange = [[UIImage imageWithData:imageData] blurredImage:blurred];
    }
    if (data) {
        imageChange = [[UIImage imageWithData:data] blurredImage:blurred];
    }
    
    if (imageChange) {
        _backImageView.image = imageChange;
    }
//
}

#pragma  mark-进行赋值
- (void)showPersonInfo
{
    
//    没网络要缓存头像的话[UserInfoManager shareUserInfoManager].tempHederImage需要设置
    NSURL* headUrl = nil;
    if (self.isUserSelf) {
        headUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[AppInfo shareInstance].res_server,[UserInfoManager shareUserInfoManager].currentUserInfo.photo]];
    }else {
        headUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[AppInfo shareInstance].res_server,_getUserInfoModel.userInfo.photo]];
    }
    
    if (_headImageView.image==nil) {
        [_headImageView sd_setImageWithURL:headUrl];
    }


    if (_headImageView.image==nil) {

   
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSData* data = [[NSData alloc]initWithContentsOfURL:headUrl];
            [self changeHeadImageWithIamge:nil with:data];
            
        });

    }else{
        
        
        
        [self changeHeadImageWithIamge:_headImageView.image with:nil];

        [[NSNotificationCenter defaultCenter]postNotificationName:@"ShowLiveBtnOnMain" object:self userInfo:nil];
        

    }
    
    
    _personNick.title =_getUserInfoModel.userInfo.nick;
    //    _navBack.title = _getUserInfoModel.userInfo.nick;
    if(_getUserInfoModel.userInfo.sex == 1)
    {
        _personNick.sexImg = [UIImage imageNamed:@"person_female"];
    }
    else if(_getUserInfoModel.userInfo.sex == 2)
    {
        _personNick.sexImg = [UIImage imageNamed:@"person_male"];
    }
    else
    {
        _personNick.sexImg = nil;
    }
    
    if (_getUserInfoModel.userInfo.provincename == nil && _getUserInfoModel.userInfo.cityname == nil)
    {
        _placeLable.text = @"";
    }
    else
    {
        _placeLable.text = [NSString stringWithFormat:@"%@ %@",_getUserInfoModel.userInfo.provincename?_getUserInfoModel.userInfo.provincename:@"",_getUserInfoModel.userInfo.cityname?_getUserInfoModel.userInfo.cityname:@""];
    }
    
    _userIdLabel.text = [NSString stringWithFormat:@"%ld",(long)_getUserInfoModel.userInfo.idxcode];
    _fanCountLable.text = [NSString stringWithFormat:@"%ld",(long)_getUserInfoModel.userInfo.fansnum];
    _focusCountLable.text = [NSString stringWithFormat:@"%ld",(long)_getUserInfoModel.userInfo.attentionnum];
    
    
    
    CGSize nickSize1 = [CommonFuction sizeOfString:[NSString stringWithFormat:@"%ld",(long)_getUserInfoModel.userInfo.attentionnum] maxWidth:200 maxHeight:20 withFontSize:16.0f];
    
    _shuLabel.frame = CGRectMake(CGRectGetMaxX(_headImageView.frame)+20+nickSize1.width+43-DISTANCE, _headImageView.center.y+3+5+2, 153, 15);
    self.fanCountTitle.frame = CGRectMake(CGRectGetMaxX(_headImageView.frame)+20+nickSize1.width+50-DISTANCE, _headImageView.center.y+3+5+2, 153, 15);
    _fanCountLable.frame = CGRectMake(CGRectGetMaxX(_headImageView.frame)+20+nickSize1.width+40+50-DISTANCE-6, _headImageView.center.y+3+5+2, 153, 15);
    _vertImgView.frame = CGRectMake(CGRectGetMaxX(_headImageView.frame)+20+nickSize1.width+40+2-DISTANCE, _headImageView.center.y+3+5+2, 1, 15);
    
    
    //    _isUserSelf = _getUserInfoModel.userInfo.userId == [UserInfoManager shareUserInfoManager].currentUserInfo.userId;
    if (_getUserInfoModel.userInfo.introduction && [_getUserInfoModel.userInfo.introduction toString].length != 0)
    {
        _introductionLabel.text = _getUserInfoModel.userInfo.introduction;
    }
    else
    {
        _introductionLabel.text = @"全民星直播互动平台，娱乐你的生活";
    }
    
    
    
    _starLevelidImgView.image = [[UserInfoManager shareUserInfoManager] imageOfStar:_getUserInfoModel.userInfo.starlevelid];
    _consumptionLevelImgView.image = [[UserInfoManager shareUserInfoManager] imageOfconsumerlevelweight:_getUserInfoModel.userInfo.consumerlevelweight];
    
    
    if(_isUserSelf)
    {
        
        _buttonHead.userInteractionEnabled = YES;
        _personNick.userInteractionEnabled = YES;
        self.scrollView.contentSize = CGSizeMake(self.scrollView.bounds.size.width, 255);
    }
    else
    {
        _buttonHead.userInteractionEnabled = NO;
        _personNick.userInteractionEnabled = NO;
        _buttonAtt.hidden = NO;
        _buttonZhiBo.hidden = NO;
        _buttonZhiBo.hidden = _isNeedHidLiveIn;
        if(!self.getUserInfoModel.userInfo.attentionflag)
        {
            //            _navBack.rightImg = [UIImage imageNamed:@"person_attenNormal"];
            [_buttonAtt setTitle:@"+ 关注" forState:UIControlStateNormal];
        }
        else
        {
            [_buttonAtt setTitle:@"取消关注" forState:UIControlStateNormal];
            //              _navBack.rightImg = [UIImage imageNamed:@"person_attenSelect"];
        }
        self.scrollView.contentSize = CGSizeMake(self.scrollView.bounds.size.width, 215);
        
    }
    if (self.getUserInfoModel.userInfo.isstar)
    {
        self.statusView.hidden = NO;
        if(self.getUserInfoModel.userInfo.onlineflag)
        {
            [self.statusView setTitle:@"正在直播" forState:UIControlStateNormal];
        }
        else
        {
            [self.statusView setTitle:@"未开播" forState:UIControlStateNormal];
        }
    }
    else
    {
        self.statusView.hidden = YES;
    }
    
    _coinCountLable.text = [NSString stringWithFormat:@"热币：%lld",[UserInfoManager shareUserInfoManager].currentUserInfo.coin];
    
    _beanCountLable.text = [NSString stringWithFormat:@"热豆：%lld",[UserInfoManager shareUserInfoManager].currentUserInfo.bean];
    
    _userGrade.image = [[UserInfoManager shareUserInfoManager] imageOfStar:_getUserInfoModel.userInfo.starlevelid];
    
    _userProgressView.progress = [self progressOfStarLevel];
    if (_getUserInfoModel.userInfo.starlevelid >= 20)
    {
        _userNextGrade.hidden = YES;
        _userNeedCoinLable.hidden = YES;
    }
    else
    {
        _userNextGrade.hidden = NO;
        _userNextGrade.image = [[UserInfoManager shareUserInfoManager] imageOfStar:_getUserInfoModel.userInfo.starlevelnextid];
        _userNeedCoinLable.hidden = NO;
        _userNeedCoinLable.text = [NSString stringWithFormat:@"%lld/%lld",_getUserInfoModel.userInfo.getcoin,_getUserInfoModel.userInfo.starlevelnextcoin];
    }
    
    _consumGrade.image = [[UserInfoManager shareUserInfoManager] imageOfconsumerlevelweight:_getUserInfoModel.userInfo.consumerlevelweight];
    _consumProgressView.progress = [self progressOfConsumLevel];
    if (_getUserInfoModel.userInfo.consumerlevelweight >= 24)
    {
        _consumNextGrade.hidden = YES;
        _consumNeedCoinLable.hidden = YES;
    }
    else
    {
        _consumNextGrade.hidden = NO;
        _consumNextGrade.image = [[UserInfoManager shareUserInfoManager] imageOfconsumerlevelweight:_getUserInfoModel.userInfo.clevelnextweight];
        _consumNeedCoinLable.hidden = NO;
        _consumNeedCoinLable.text = [NSString stringWithFormat:@"%lld/%lld", _getUserInfoModel.userInfo.costcoin,_getUserInfoModel.userInfo.clevelnextweightcoin];
        
    }
    
    if (self.getUserInfoModel.userInfo.mylink && [self.getUserInfoModel.userInfo.mylink length])
    {
        self.materialBtn.hidden = NO;
        _VertImgView.hidden = NO;
    }
    else
    {
        self.materialBtn.hidden = YES;
        _VertImgView.hidden = YES;
    }
    
    NSInteger hideSwitch = [[[AppInfo shareInstance].hideSwitch substringFromIndex:1] integerValue];
    if (hideSwitch != 1)
    {
        if (_propView)
        {
            
            
            _propView.isFromPersonInfo = YES;
            NSMutableArray *dataMArray = [NSMutableArray array];
            
            if (_getUserInfoModel.userInfo.isPurpleVip)
            {
                PropData *propData = [[PropData alloc] init];
                propData.type = 0;
                propData.imgUrl = @"14";//紫色vip得privlevelweight为14
                propData.useflag = 1;
                [dataMArray addObject:propData];
            }
            
            if (_getUserInfoModel.userInfo.isYellowVip)
            {
                PropData *propData = [[PropData alloc] init];
                propData.type = 0;
                propData.imgUrl = @"10";//黄色vip得privlevelweight为10
                propData.useflag = 1;
                [dataMArray addObject:propData];
            }
            
            NSInteger index = [dataMArray count] - 1;
            for (int nIndex = 0; nIndex < [self.propMArray count]; nIndex++)
            {
                UserCarData *userCarData = [self.propMArray objectAtIndex:nIndex];
                PropData *propData = [[PropData alloc] init];
                propData.type = 1;
                propData.imgUrl = userCarData.carimgsmall;
                propData.useflag = userCarData.useflag;
                propData.carID = userCarData.carid;
                if (propData.useflag == 1) {
                    
                    if (index == [dataMArray count] - 1) {
                        [dataMArray addObject:propData];
                    } else {
                        //                        [dataMArray insertObject:propData atIndex:index];
                        [dataMArray addObject:propData];
                    }
                    index++;
                } else {
                    [dataMArray addObject:propData];
                }
            }
            if (_isUserSelf) {
                _propView.isSelfUserInfo = YES;
            }
            _propView.dataMArray = dataMArray;
            
            CGRect rect = _propView.frame;
            NSInteger nRow = [dataMArray count] / 4 + ((dataMArray.count % 4)? 1 : 0);
            CGFloat nHeight = 75 * nRow;
            rect.size.height += nHeight;
            _propView.frame = rect;
            
            CGSize size = self.scrollView.contentSize;
            size.height += nHeight+30;
            size.height += 50
            ;
            self.scrollView.contentSize = size;
        }
        
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)OnAttend
{
    if ([ self showLoginDialog])
    {
        return;
    }
    
    if(!self.getUserInfoModel.userInfo.attentionflag)
    {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:[NSNumber numberWithInteger:_getUserInfoModel.userInfo.userId] forKey:@"staruserid"];
        
        __weak typeof(self) weakSelf = self;
        AddAttentModel *attentModel = [[AddAttentModel alloc] init];
        [attentModel requestDataWithMethod:AddAttention_Method params:dict success:^(id object)
         {
             /*成功返回数据*/
             if (attentModel.result == 0)
             {
                 weakSelf.getUserInfoModel.userInfo.attentionflag = YES;
                 
                 //                 weakSelf.navBack.rightImg = [UIImage imageNamed:@"person_attenSelect"];
                 
                 [_buttonAtt setTitle:@"取消关注" forState:UIControlStateNormal];
                 
                 [self showNoticeInWindow:@"添加关注成功"];
                 weakSelf.getUserInfoModel.userInfo.fansnum += 1;
                 _fanCountLable.text = [NSString stringWithFormat:@"%ld",(long)_getUserInfoModel.userInfo.fansnum];
             }
             else
             {
                 if (attentModel.code == 403)
                 {
                     [[AppInfo shareInstance] loginOut];
                     if ([AppInfo shareInstance].pushType==0) {
                         self.isShouldReturnMain = YES;
                     }
                  
                     [AppInfo shareInstance].lastFromeClass = @"PersonInfoViewController";
                     [AppInfo shareInstance].shouldPushToClass = @"MainViewController";
                     [self showOherTerminalLoggedDialog];
                     
                     return ;
                 }else{
                     
                     
                     [self showNoticeInWindow:attentModel.title];
                 }
             }
         }
                                      fail:^(id object)
         {
             /*失败返回数据*/
         }];
    }
    else
    {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:[NSNumber numberWithInteger:_getUserInfoModel.userInfo.userId] forKey:@"staruserid"];
        
        __weak typeof(self) weakSelf = self;
        DelAttentionModel *delAttentionModel = [[DelAttentionModel alloc] init];
        [delAttentionModel requestDataWithParams:dict success:^(id object)
         {
             /*成功返回数据*/
             if (delAttentionModel.result == 0)
             {
                 weakSelf.getUserInfoModel.userInfo.attentionflag = NO;
                 //                 weakSelf.navBack.rightImg = [UIImage imageNamed:@"person_attenNormal"];
                 [_buttonAtt setTitle:@"+ 关注" forState:UIControlStateNormal];
                 [self showNoticeInWindow:@"取消关注成功"];
                 
                 weakSelf.getUserInfoModel.userInfo.fansnum -= 1;
                 _fanCountLable.text = [NSString stringWithFormat:@"%ld",(long)_getUserInfoModel.userInfo.fansnum];
             }
             else
             {
                 if (delAttentionModel.code == 403)
                 {
                     [[AppInfo shareInstance] loginOut];
                     if ([AppInfo shareInstance].pushType==0) {
                         self.isShouldReturnMain = YES;
                     }
                     
                     [AppInfo shareInstance].lastFromeClass = @"PersonInfoViewController";
                     [AppInfo shareInstance].shouldPushToClass = @"MainViewController";
                     [self showOherTerminalLoggedDialog];
                     
                     return ;
                 }else{
                     
                     
                     [self showNoticeInWindow:delAttentionModel.title];
                 }

             }
         }
                                            fail:^(id object)
         {
             /*失败返回数据*/
         }];
    }
    
}

- (void)OnModifyInfo
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInteger:_getUserInfoModel.userInfo.attentionnum] forKey:@"attentionnum"];
    [dict setObject:[NSNumber numberWithInteger:_getUserInfoModel.userInfo.fansnum] forKey:@"fansnum"];
    [self pushCanvas:InfoChange_Canvas withArgument:dict];
}

- (void)buyVip
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    //    [dic setObject:[NSNumber numberWithInteger:1] forKey:@"marketType"];
    
    [dic setObject:NSStringFromClass([self class]) forKey:@"className"];
    [self pushCanvas:Mall_Canvas withArgument:dic];
}

- (void)propDidTouch:(NSString*)propData
{
    if ([propData isEqualToString:@"1"]) {
        [self showNotice:@"使用道具成功"];
    }else if([propData isEqualToString:@"2"]){
        [self showNotice:@"使用道具失败"];
    }else{
        if ([AppInfo shareInstance].pushType==0) {
            self.isShouldReturnMain = YES;
        }
         [AppInfo shareInstance].isNeedReturnMain = YES;
        [[AppInfo shareInstance] loginOut];
        [AppInfo shareInstance].lastFromeClass = @"PersonInfoViewController";
        [AppInfo shareInstance].shouldPushToClass = @"MainViewController";
        [self showOherTerminalLoggedDialog];
    }
    // ...Bob 需要调用“使用中”和“未使用”的API
}

#pragma mark-getUserInfo
- (void)getUserInfo
{
    GetUserInfoModel *model = [[GetUserInfoModel alloc] init];
    if (!_isUserSelf) {
        model.isNotUseToken = YES;
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInteger:_userId] forKey:@"userid"];
    [dict setObject:[NSNumber numberWithBool:YES] forKey:@"calcOtherInfo"];
    
    __weak typeof(self) weakSelf = self;
    [model requestDataWithParams:dict success:^(id object) {
        /*成功返回数据*/
        __strong typeof(self) strongSelf = weakSelf;
        GetUserInfoModel *userInfoModel = object;
        if (userInfoModel.result == 0)
        {
            strongSelf.getUserInfoModel = userInfoModel;
            
            
            if (userInfoModel.userInfo.userId == [UserInfoManager shareUserInfoManager].currentUserInfo.userId)
            {
                [UserInfoManager shareUserInfoManager].currentUserInfo = userInfoModel.userInfo;
                
                [UserInfoManager shareUserInfoManager].getUserInfoModel =userInfoModel;
            }
            
            if (_isUserSelf) {
                self.personalBlock();
            }
            
            [weakSelf performSelector:@selector(getUserCar) withObject:nil];
        }else  if (userInfoModel.code == 403)
        {
            [[AppInfo shareInstance] loginOut];
            self.isShouldReturnMain = YES;
            
            if ([AppInfo shareInstance].pushType==0) {
                self.isShouldReturnMain = YES;
            }
            [AppInfo shareInstance].lastFromeClass = @"PersonInfoViewController";
            [AppInfo shareInstance].shouldPushToClass = @"MainViewController";
            [self showOherTerminalLoggedDialog];
            
            return ;
        }
        
        
        [self stopAnimating];
    } fail:^(id object) {
        /*失败返回数据*/
        [self stopAnimating];
        
        _getUserInfoModel = model;
        
        if (_isUserSelf) {
            _getUserInfoModel= [UserInfoManager shareUserInfoManager].getUserInfoModel;
        }else{
            _getUserInfoModel.userInfo =[UserInfoManager shareUserInfoManager].tempStarInfo;
            
            
        }
        [self showPersonInfo];
        //        [self stopLoadProgram];
        
    }];
}

- (void)getUserCar
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInteger:self.userId] forKey:@"userid"];
    
    __weak typeof(self) weakSelf = self;
    [self requestDataWithAnalyseModel:[GetUserCarModel class] params:dict success:^(id object) {
        __strong typeof(self) strongSelf = weakSelf;
        GetUserCarModel *model = (GetUserCarModel *)object;
        if (model.result == 0)
        {
            if (_propMArray == nil)
            {
                _propMArray = [NSMutableArray array];
            }
            [_propMArray removeAllObjects];
            [_propMArray addObjectsFromArray:model.dataMArray];
            [strongSelf showPersonInfo];
        }
        else
        {
            [strongSelf showNoticeInWindow:@"获取道具失败"];
        }
    } fail:^(id object) {
        
    }];
}


- (void)OnChatRomm:(id)sender
{
    [AppDelegate shareAppDelegate].isSelfWillLive = NO;
    Class viewControllerType = NSClassFromString(LiveRoom_CanVas);
    BOOL isChatRoomOpened = NO;
    UIViewController *chatroomViewController = nil;
    for(chatroomViewController in self.navigationController.viewControllers)
    {
        if([chatroomViewController isKindOfClass:viewControllerType])
        {
            isChatRoomOpened = YES;
            break;
        }
    }
    if(isChatRoomOpened)
    {
        [self.navigationController popToViewController:chatroomViewController animated:YES];
    }
    else
    {
         NSString *className = NSStringFromClass([self class]);
        NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:self.getUserInfoModel.userInfo.userId],@"staruserid",className,@"className",nil];
        

        
        [self pushCanvas:LiveRoom_CanVas withArgument:param];
    }
}

- (CGFloat)progressOfStarLevel
{
    CGFloat progress = 0.0f;
    
    if (_getUserInfoModel.userInfo.starlevelnextcoin > 0)
    {
        
        progress = ((_getUserInfoModel.userInfo.getcoin - _getUserInfoModel.userInfo.starlevelcoin) * 1000 / (_getUserInfoModel.userInfo.starlevelnextcoin - _getUserInfoModel.userInfo.starlevelcoin));
    }
    else
    {
        progress = 1000.0f;
    }
    return progress/1000;
}

- (CGFloat)progressOfConsumLevel
{
    CGFloat progress = 0.0f;
    if (_getUserInfoModel.userInfo.clevelnextweightcoin > 0)
    {
        progress = ((_getUserInfoModel.userInfo.costcoin - _getUserInfoModel.userInfo.clevelweightcoin) * 1000/ (_getUserInfoModel.userInfo.clevelnextweightcoin - _getUserInfoModel.userInfo.clevelweightcoin));
    }
    else
    {
        progress = 1000.0f;
    }
    return progress/1000;
}

- (void) rechargeRebi
{
    NSInteger hideSwitch = [[[AppInfo shareInstance].hideSwitch substringToIndex:1] integerValue];
    if (hideSwitch == 1)
    {
        [self pushCanvas:AppStore_Recharge_Canvas withArgument:nil];
    }
    else
    {
        [self pushCanvas:SelectModePay_Canvas withArgument:nil];
    }
}

-(void) rechargeRedou
{
    
    [self pushCanvas:TakeBack_CanVas withArgument:nil];
    
}

-(void) shareBoxiu
{
    if (_getUserInfoModel.userInfo.idxcode != 0)
    {
        NSString *sharelink = [NSString stringWithFormat:@"%@/%ld",UMengShareText,(long)_getUserInfoModel.userInfo.idxcode];
        
        
        [UMSocialSnsService presentSnsIconSheetView:self
                                             appKey:nil
                                          shareText:sharelink
                                         shareImage:[UIImage imageNamed:@"reboLogo"]
                                    shareToSnsNames:@[UMShareToSina,UMShareToTencent,UMShareToQQ,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSms]
                                           delegate:self];
    }
}

- (void)didSelectSocialPlatform:(NSString *)platformName withSocialData:(UMSocialData *)socialData
{
    NSString *sharelink = [NSString stringWithFormat:@"http://www.51rebo.cn/%ld",(long)_getUserInfoModel.userInfo.idxcode];
    if ([platformName isEqualToString:UMShareToWechatSession])
    {
        [UMSocialData defaultData].extConfig.wechatSessionData.title = @"热波间";
        [UMSocialData defaultData].extConfig.wechatSessionData.url = sharelink;
    }
    else if ([platformName isEqualToString:UMShareToWechatTimeline])
    {
        [UMSocialData defaultData].extConfig.wechatTimelineData.url = sharelink;
    }
    else if ([platformName isEqualToString:UMShareToQQ])
    {
        [UMSocialData defaultData].extConfig.qqData.title = @"热波间";
        [UMSocialData defaultData].extConfig.qqData.url = sharelink;
    }
    else if ([platformName isEqualToString:UMShareToQzone])
    {
        [UMSocialData defaultData].extConfig.qzoneData.title = @"热波间";
        [UMSocialData defaultData].extConfig.qzoneData.url = sharelink;
    }
    else if ([platformName isEqualToString:UMShareToSina])
    {
        [UMSocialData defaultData].extConfig.sinaData.shareImage = [UIImage imageNamed:@"share"];
    }
    else if([platformName isEqualToString:UMShareToTencent])
    {
        [UMSocialData defaultData].extConfig.tencentData.shareImage = [UIImage imageNamed:@"share"];
    }
    else if ([platformName isEqualToString:UMShareToSms])
    {
        [UMSocialData defaultData].extConfig.smsData.shareImage = nil;
    }
    
}
-(void)timerUserInteraction{
    _buttonBack .userInteractionEnabled = YES;
}
#pragma mark -点击相应方法
-(void)buttonPres:(UIButton*)sender{
    switch (sender.tag) {
        case 101://返回
        {
            [AppInfo shareInstance].pushType=0;
            _buttonBack .userInteractionEnabled = NO;
            
            NSString *className = NSStringFromClass([self class]);
            NSDictionary *param = [NSDictionary dictionaryWithObject:className forKey:@"className"];
            [self popCanvasWithArgment:param];
            [self performSelector:@selector(timerUserInteraction) withObject:self afterDelay:0.5];
            
            [UserInfoManager shareUserInfoManager].tempHederImage = nil;
        }
            break;
        case 102://消息
        {
            self.iamgeViewRoung.hidden = YES;
            [MessageCenter shareMessageCenter].unReadCount = 0;
            [MessageCenter shareMessageCenter].isHaveUnReadCount  = NO;
            [self pushCanvas:MessageCenter_Canvas withArgument:nil];
        }
            break;
        case 103://设置
        {
            Class viewControllerType = NSClassFromString(Setting_Canvas);
            UIViewController *viewController = [[viewControllerType alloc] init];
            [[AppDelegate shareAppDelegate].navigationController pushViewController:viewController animated:YES];
            
        }
            break;
        case 104:{//修改个人中心
            {
                
                
                UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"头像修改" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"立即拍照",@"本地相册", nil];
                sheet.tag = 80;
                [sheet showInView:self.view];
            }
            
        }
            break;
        case 105:{//关注
            [self OnAttend];
        }
            break;
        case 106:{//Ta的直播间
            [self OnChatRomm:nil];
        }
            break;
        default:
            break;
    }
    
}
#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if(buttonIndex == actionSheet.cancelButtonIndex)
    {
        return;
    }
    
    
    UIImagePickerControllerSourceType sourceType;
    switch (buttonIndex)
    {
        case 0:
            
            sourceType = UIImagePickerControllerSourceTypeCamera;
            if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
            {
                sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            }
            break;
        default:
            sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
            break;
    }
    
    
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    
    if(authStatus ==AVAuthorizationStatusRestricted){//此应用程序没有被授权访问的照片数据。可能是家长控制权限。
        
    }else if(authStatus == AVAuthorizationStatusDenied){// 用户已经明确否认了这一照片数据的应用程序访问
        [self showAlertView:@"热波间需要访问你的相机" message:@"头像修改，热波间需要访问你的相机权限。点击“设置”前往系统设置允许热波间访问你的相机" confirm:^(id sender) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
            
        } cancel:^(id sender) {
            
        }];
        return;
    }
    else if(authStatus == AVAuthorizationStatusAuthorized){//用户已授权应用访问照片数据.
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        picker.mediaTypes = @[(NSString *) kUTTypeImage];
        [self presentViewController:picker animated:YES completion:nil];
        
    }else if(authStatus == AVAuthorizationStatusNotDetermined){// 用户尚未做出了选择这个应用程序的问候.一次一出现
        
        [AVCaptureDevice requestAccessForMediaType:mediaType completionHandler:^(BOOL granted) {//弹出授权弹框
            if(granted){//点击允许访问时调用
                UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                picker.delegate = self;
                picker.allowsEditing = YES;
                picker.sourceType = sourceType;
                picker.mediaTypes = @[(NSString *) kUTTypeImage];
                [self presentViewController:picker animated:YES completion:nil];
            }
            else {
                return ;
            }
            
        }];
    }else {
        NSLog(@"Unknown authorization status");
    }
    
    
}
#pragma mark -
#pragma mark UIImagePickerController Delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    if ([mediaType isEqualToString:@"public.image"])
    {
        MBProgressHUD *mbProgressHud = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:mbProgressHud];
        [mbProgressHud show:YES];
        
        //[info objectForKey:@"UIImagePickerControllerEditedImage"];
        NSString *tempDir = NSTemporaryDirectory ();
        NSString *tempFile = [NSString stringWithFormat:@"%@/avatar.png",tempDir];
        UIImage *avatar = [info objectForKey:@"UIImagePickerControllerEditedImage"];
        
        
        float scale = MAX(avatar.size.width/150,avatar.size.height/150);
        avatar = [UIImage imageWithCGImage:avatar.CGImage scale:scale orientation:UIImageOrientationUp];
        [UIImagePNGRepresentation(avatar) writeToFile:tempFile atomically:YES];
        
        __weak typeof(self) weakSelf = self;
        updateCurrUserModel *userModel = [[updateCurrUserModel alloc] init];
        [userModel uploadDataWithFileUrl:tempFile params:nil success:^(id object) {
            __strong typeof(self) strongSelf = weakSelf;
            if (strongSelf)
            {
                /*成功返回数据*/
                if (userModel.result == 0)
                {
                    //                    strongSelf.selectedImg = avatar;
                    strongSelf.headImageView.image = avatar;
                    //                    strongSelf.userInfo.photo = userModel.data;
                    float quality = .00001f;
                    float blurred = .2f;
                    NSData *imageData = UIImageJPEGRepresentation([_headImageView image], quality);
                    UIImage *blurredImage = [[UIImage imageWithData:imageData] blurredImage:blurred];
                    _backImageView.image = blurredImage;
                    
                    [UserInfoManager shareUserInfoManager].currentUserInfo.photo = userModel.data;

                    [[NSNotificationCenter defaultCenter]postNotificationName:@"ShowLiveBtnOnMain" object:self userInfo:nil];
                    

                    NSError *error;
                    [[NSFileManager defaultManager] removeItemAtPath:tempFile error:&error];
                }
            }
            [mbProgressHud hide:YES];
            
        } fail:^(id object) {
            /*失败返回数据*/
            [mbProgressHud hide:YES];
        }];
        
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - Observer
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"unReadCount"])
    {
        NSInteger unReadCount = [[change objectForKey:NSKeyValueChangeNewKey] integerValue];
        if (unReadCount == 0 || !self.isUserSelf)
        {
            _msgBadge.hidden = YES;
            _iamgeViewRoung.hidden = YES;
        }
        else
        {
            _msgBadge.hidden = NO;
            _iamgeViewRoung.hidden = NO;
            if (_msgBadge)
            {
                //                _msgBadge.badgeText = [NSString stringWithFormat:@"%ld",(long)unReadCount];
                [_msgBadge setNeedsDisplay];
            }
            
            //            if ([MessageCenter shareMessageCenter].isHaveUnReadCount ) {
            //                _msgBadge.hidden = NO;
            //        [_msgBadge setNeedsDisplay];
            //            }
            
        }
    }
    
    
}

@end
