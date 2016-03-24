//
//  ChangeBeanViewController.m
//  BoXiu
//
//  Created by andy on 15/12/2.
//  Copyright © 2015年 rexiu. All rights reserved.
//

#import "ChangeBeanViewController.h"


#import "RechargeViewController.h"
#import "AppInfo.h"
#import "UserInfoManager.h"
#import "Recharge.h"
#import "RechargeModel.h"
#import "GetUpPayOrderIDModel.h"
#import "UPPayPlugin.h"
#import "UPPayPluginDelegate.h"
//#import "AlixPayOrder.h"
#import "DataVerifier.h"
//#import "AlixPayResult.h"
#import "DataSigner.h"
//#import "AlixLibService.h"
#import "NSData+DES.h"
#import "NSString+DES.h"
#import "JSONKit.h"
#import "WeixinPayModel.h"
#import "WXApi.h"

#import "BeanTocoinModel.h"

@interface ChangeBeanViewController ()<UITextFieldDelegate>
@property (nonatomic,strong) UIImageView *headImg;
@property (nonatomic,strong) UILabel *nickLable;
@property (nonatomic,strong) UILabel *coinLable;
@property (nonatomic,strong) UITextField *coinTextField;
@property (nonatomic,strong) UILabel *getCoinLable;

@property (nonatomic,strong) UIButton *selectedButton;
@property (nonatomic,assign) NSInteger rechargeType;//1是支付宝，2是银联 3 微信
@property (nonatomic,strong) NSString *viewTitle;

@property (nonatomic,assign) SEL result;//这里声明为属性方便在于外部传入。
@property (nonatomic,strong) UIButton* buttonBack;
@property (nonatomic,assign) BOOL enterFromChatRoom;//如果从直播间进入，充值成功返回直播间

@property (nonatomic,strong) NSString* strBean;
@end

@implementation ChangeBeanViewController


- (void)dealloc
{
    [self removeNotifyKeyBoard];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.baseViewType = kbaseScroolViewType;
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        self.result = @selector(paymentResult:);
        [Recharge shareRechargeInstance].viewController = self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];    // Do any additional setup after loading the view from its nib.
    UIControl* controlBG = [[UIControl alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    controlBG.backgroundColor = [CommonUtils colorFromHexRGB:@"f6f6f6"];
    [self.view addSubview:controlBG];
    
    _buttonBack = [UIButton buttonWithType:UIButtonTypeCustom];
    [_buttonBack setImage:[UIImage imageNamed:@"navB_Nor.png"] forState:UIControlStateHighlighted];
    [_buttonBack setImage:[UIImage imageNamed:@"backNew.png"] forState:UIControlStateNormal];
    _buttonBack.frame = CGRectMake(0, 20, 50, 40);
    _buttonBack.tag = 11;
    [_buttonBack addTarget:self action:@selector(buttonPres:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_buttonBack];
    
    UILabel* labelTitle = [CommonUtils commonSignleLabelWithText:@"兑换" withFontSize:18 withOriginX:self.view.center.x withOriginY:20+21 isRelativeCoordinate:NO];
    labelTitle.textColor = [CommonUtils colorFromHexRGB:@"454a4d"];
    [self.view addSubview:labelTitle];
    

    UIView* viewLine = [CommonUtils CommonViewLineWithFrame:CGRectMake(0, 63.5, SCREEN_WIDTH, 0.5)];
    viewLine.backgroundColor = [UIColor grayColor];
    [self.view addSubview:viewLine];

    self.scrollView.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT );
    self.scrollView.backgroundColor = [CommonFuction colorFromHexRGB:@"f6f6f6"];
    
    int YOffset = 10;
    UIImageView *bgImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, YOffset, SCREEN_WIDTH, 65)];
    bgImg.backgroundColor =[UIColor whiteColor];
    [self.scrollView addSubview:bgImg];
   
    
    //    UIImageView *bgImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, YOffset, 50, 50)];
    //    bgImg.image = [UIImage imageNamed:@"rechageDefault"];
    //    [self.scrollView addSubview:bgImg];
    
    _headImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, YOffset+7, 50, 50)];
    _headImg.layer.cornerRadius = 25.0f;
    _headImg.layer.masksToBounds = YES;
    [self.scrollView addSubview:_headImg];
    
     YOffset+=5;
    
    _nickLable = [[UILabel alloc] initWithFrame:CGRectMake(_headImg.frame.origin.x + _headImg.frame.size.width + 15, 20+5, 150, 15)];
    _nickLable.font = [UIFont boldSystemFontOfSize:16.0f];
    _nickLable.textColor = [CommonFuction colorFromHexRGB:@"454a4d"];
    _nickLable.textAlignment = NSTextAlignmentLeft;
    [self.scrollView addSubview:_nickLable];
    
    UILabel *coinTitle = [[UILabel alloc] initWithFrame:CGRectMake(_nickLable.frame.origin.x, 43+4, 35, 15)];
    coinTitle.font = [UIFont systemFontOfSize:13.0f];
    coinTitle.textColor = [CommonFuction colorFromHexRGB:@"454a4d"];
    coinTitle.text = @"热豆 :";
    [self.scrollView addSubview:coinTitle];
    
    _coinLable = [[UILabel alloc] initWithFrame:CGRectMake(coinTitle.frame.origin.x + coinTitle.frame.size.width + 5, coinTitle.frame.origin.y, 150, 15)];
    _coinLable.textColor = [CommonFuction colorFromHexRGB:@"f7c250"];
    _coinLable.font = [UIFont boldSystemFontOfSize:16.0f];
    _coinLable.textAlignment = NSTextAlignmentLeft;
    [self.scrollView addSubview:_coinLable];
    
    YOffset += 75;
    
    UILabel *selectTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, YOffset, 90, 15)];
    selectTitle.font = [UIFont systemFontOfSize:14.0f];
    selectTitle.text = @"兑换热币";
    selectTitle.textColor = [CommonFuction colorFromHexRGB:@"454a4d"];
    [self.scrollView addSubview:selectTitle];
    
    YOffset += 31;
    
    
    
    NSArray *array = @[@"× 100",@"× 300",@"× 500",@"× 1000",@"× 2000",@"× 5000"];
    NSArray *money = @[@"100 热豆",@"300 热豆",@"500 热豆",@"1000 热豆",@"2000 热豆",@"5000 热豆"];
    for (int nIndex = 0; nIndex < [money count]; nIndex++)
    {
        NSInteger tag = 0;
        if (nIndex == 0)
        {
            tag = 100;
        }
        else if (nIndex == 1)
        {
            tag = 300;
        }
        else if (nIndex == 2)
        {
            tag = 500;
        }
        else if (nIndex == 3)
        {
            tag =1000;
        }
        else if(nIndex == 4)
        {
            tag = 2000;
        }
        else
        {
            tag = 5000;
        }
        UIView *bgview = [[UIView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 43)];
        bgview.backgroundColor = [CommonFuction colorFromHexRGB:@"ffffff"];
        [self.scrollView addSubview:bgview];
        
        CGFloat y = selectTitle.frame.origin.y + 30 + nIndex * 43;
        
        bgview.frame = CGRectMake(0, y, SCREEN_WIDTH, 43);
        
        
        UIImageView *biImgview = [[UIImageView alloc] initWithFrame:CGRectMake(10, y + 10, 25, 25)];
        biImgview.image = [UIImage imageNamed:@"rechageIcon"];
        [self.scrollView addSubview:biImgview];
        
        UILabel *coinLabel = [[UILabel alloc] initWithFrame:CGRectMake(53-9, y + 15, 90, 15)];
        coinLabel.font = [UIFont systemFontOfSize:13.0f];
        coinLabel.text = [array objectAtIndex:nIndex];
        coinLabel.textColor = [CommonFuction colorFromHexRGB:@"959596"];
        [self.scrollView addSubview:coinLabel];
        
        UIImage *img = [CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"f7c250"] size:CGSizeMake(90, 25)];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = tag;
        btn.frame = CGRectMake( 230+15-90+58, y + 10, 90, 25);
        btn.titleEdgeInsets = UIEdgeInsetsMake(15, 0, 15, 0);
        [btn setTitle:[money objectAtIndex:nIndex] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [btn setTitleColor:[CommonFuction colorFromHexRGB:@"f7c250"] forState:UIControlStateNormal];
        [btn setTitleColor:[CommonFuction colorFromHexRGB:@"ffffff"] forState:UIControlStateHighlighted];
        btn.layer.cornerRadius = 12.5f;
        btn.layer.masksToBounds = YES;
        btn.layer.borderWidth = 0.5;
        btn.layer.borderColor = [CommonFuction colorFromHexRGB:@"f7c250"].CGColor;
        [btn setBackgroundImage:img forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(OnSelect:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:btn];
        
        UIView* viewLine1 = [CommonUtils CommonViewLineWithFrame:CGRectMake(0, y+42, SCREEN_WIDTH, 0.5)];
        viewLine1.backgroundColor = [CommonFuction colorFromHexRGB:@"cbcbcb"];
        [self.scrollView addSubview:viewLine1];
        
        if (nIndex+1== [money count]) {
            viewLine1.hidden = YES;
        }
        
    }
    YOffset += 250;
    YOffset += 17;
    

    
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(10, YOffset, 300, 20)];
    titleLable.text = @"温馨提示：";
    titleLable.textColor = [CommonFuction colorFromHexRGB:@"454a4d"];
    titleLable.font = [UIFont systemFontOfSize:12.0f];
    [self.scrollView addSubview:titleLable];
    
    YOffset +=20;
    
    UILabel *titleLable1 = [[UILabel alloc] initWithFrame:CGRectMake(10, YOffset, 300, 20)];
    titleLable1.text = @"1.热豆可以重新兑换为热币";
    titleLable1.textColor = [CommonFuction colorFromHexRGB:@"454a4d"];
    titleLable1.font = [UIFont systemFontOfSize:12.0f];
    [self.scrollView addSubview:titleLable1];
       YOffset +=20;
    UILabel *titleLable2 = [[UILabel alloc] initWithFrame:CGRectMake(10, YOffset, 300, 20)];
    titleLable2.text = @"2.人民币和热币兑换比例为1:100";
    titleLable2.textColor = [CommonFuction colorFromHexRGB:@"454a4d"];
    titleLable2.font = [UIFont systemFontOfSize:12.0f];
    [self.scrollView addSubview:titleLable2];
    
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT );

    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self showUserInfo];
     self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self showUserInfo];
    self.navigationController.navigationBarHidden = NO;
}
- (void)argumentForCanvas:(id)argumentData
{
    self.strBean = [argumentData toString];
}


-(void)buttonPres:(UIButton*)sener{
    switch (sener.tag) {
        case 11://返回
            [self popCanvasWithArgment:nil];
            break;
            
        default:
            break;
    }
}

- (void)modifyNeedCoinTipLable
{
    long long getCoin = [_coinTextField.text longLongValue] * 100;
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lld 热币",getCoin]];
    [str addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16.0f] range:NSMakeRange(0,[str length] - 2)];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13.0f] range:NSMakeRange([str length] - 2,2)];
    _getCoinLable.attributedText = str;
}


- (void)showUserInfo
{
    if ([AppInfo shareInstance].bLoginSuccess)
    {
        _nickLable.hidden = NO;
        _coinLable.hidden = NO;
        
        UserInfo *userInfo = [UserInfoManager shareUserInfoManager].currentUserInfo;
        NSString *url = [NSString stringWithFormat:@"%@%@",[AppInfo shareInstance].res_server,userInfo.photo];
        [_headImg sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil];
        
        _nickLable.text = userInfo.nick;
        
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",self.strBean]];
//        [str addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16.0f] range:NSMakeRange(0,[str length] - 2)];
//        [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13.0f] range:NSMakeRange([str length] - 2,2)];
        _coinLable.attributedText = str;
    }
    else
    {
        _nickLable.hidden = YES;
        _coinLable.hidden = YES;
        _headImg.image = [UIImage imageNamed:@"headDefault"];
    }
    [self.view setNeedsDisplay];
}


- (void)OnSelect:(id)sender
{

    
    UIButton *button = (UIButton *)sender;
    if (self.selectedButton)
    {
        self.selectedButton.selected = NO;
    }
    self.selectedButton = button;
    button.selected = YES;
//    _coinTextField.text = [NSString stringWithFormat:@"%ld",(long)button.tag];
    [self rechargeRedou:[NSString stringWithFormat:@"%ld",(long)button.tag]];
   

}
-(void)rechargeRedou:(NSString*)bean
{
    //     当热豆为0的时候
    if ([self.strBean intValue]<[bean intValue]) {
        [self showNoticeInWindow:@"热豆数量不足" duration:1.5];
    }
    else
    {
        
                NSString *message = [NSString stringWithFormat:@"是否将热豆兑换为%@热币?",bean];
                EWPAlertView *alertView = [[EWPAlertView alloc] initWithTitle:@"兑换" message:message leftBtnTitle:@"取消" rightBtnTitle:@"确认" clickBtnBlock:^(NSInteger nIndex) {
                    if (nIndex == 0) {
                        //            兑换点击取消执行的代码
                    }
                    if (nIndex == 1) {
                        //              点击兑换执行代码
                        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
                        [dict setObject:[NSNumber numberWithInteger:[bean integerValue]] forKey:@"bean"];
                        [self requestDataWithAnalyseModel:[BeanTocoinModel class] params:dict success:^(id object)
                         {
                             /*成功返回数据*/
                             BeanTocoinModel *model = object;
                             if (model.result == 0)
                             {
                                 self.strBean =[NSString stringWithFormat:@"%lld",model.bean];
                                 
                                 [UserInfoManager shareUserInfoManager].currentUserInfo.bean =  [self.strBean intValue];
                              
                                 [self showNotice:@"兑换成功"  duration:2];
                                 [self showUserInfo];
                             }
                             else
                             {
                                 if (model.code == 403) {
                                    [self popToCanvas:PersonInfo_Canvas withArgument:nil];
                                 }else{
                                     [self showNotice:model.msg  duration:2];
                                     
                                     
                                 }
                                
                             }
                          
                         }
                         fail:^(id object)
                         {
                                    [self showNoticeInWindow:@"连接网络失败"];
                             /*失败返回数据*/
                         }];
                    }
                }];
                [alertView show];
   
    }
    return;
    
}


@end
