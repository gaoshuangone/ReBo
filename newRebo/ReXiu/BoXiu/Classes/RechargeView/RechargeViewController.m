//
//  RechargeViewController.m
//  BoXiu
//
//  Created by tongmingyu on 14-5-26.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

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

@interface RechargeViewController ()<UITextFieldDelegate>
@property (nonatomic,strong) UIImageView *headImg;
@property (nonatomic,strong) UILabel *nickLable;
@property (nonatomic,strong) UILabel *coinLable;
@property (nonatomic,strong) UITextField *coinTextField;
@property (nonatomic,strong) UILabel *getCoinLable;

@property (nonatomic,strong) UIButton *selectedButton;
@property (nonatomic,assign) NSInteger rechargeType;//1是支付宝，2是银联 3 微信
@property (nonatomic,strong) NSString *viewTitle;

@property (nonatomic,assign) SEL result;//这里声明为属性方便在于外部传入。

@property (nonatomic,assign) BOOL enterFromChatRoom;//如果从直播间进入，充值成功返回直播间

-(void)paymentResult:(NSString *)result;

@end

@implementation RechargeViewController

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
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = [NSString stringWithFormat:@"%@充值",self.viewTitle];
    self.scrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64);
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
    coinTitle.text = @"余额 :";
    [self.scrollView addSubview:coinTitle];
    
    _coinLable = [[UILabel alloc] initWithFrame:CGRectMake(coinTitle.frame.origin.x + coinTitle.frame.size.width + 5, coinTitle.frame.origin.y, 150, 15)];
    _coinLable.textColor = [CommonFuction colorFromHexRGB:@"f7c250"];
    _coinLable.font = [UIFont boldSystemFontOfSize:16.0f];
    _coinLable.textAlignment = NSTextAlignmentLeft;
    [self.scrollView addSubview:_coinLable];
    
    YOffset += 75;
    
    UILabel *selectTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, YOffset, 90, 15)];
    selectTitle.font = [UIFont systemFontOfSize:14.0f];
    selectTitle.text = @"选择充值金额";
    selectTitle.textColor = [CommonFuction colorFromHexRGB:@"454a4d"];
    [self.scrollView addSubview:selectTitle];
    
     YOffset += 31;

    
  
    NSArray *array = @[@"× 1000",@"× 5000",@"× 10000",@"× 20000",@"× 50000",@"× 100000"];
    NSArray *money = @[@"￥10",@"￥50",@"￥100",@"￥200",@"￥500",@" ￥1000 "];
    for (int nIndex = 0; nIndex < [money count]; nIndex++)
    {
        NSInteger tag = 0;
        if (nIndex == 0)
        {
            tag = 10;
        }
        else if (nIndex == 1)
        {
            tag = 50;
        }
        else if (nIndex == 2)
        {
            tag = 100;
        }
        else if (nIndex == 3)
        {
            tag = 200;
        }
        else if(nIndex == 4)
        {
            tag = 500;
        }
        else
        {
            tag = 1000;
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
        
        UIImage *img = [CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"f7c250"] size:CGSizeMake(68, 25)];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = tag;
        btn.frame = CGRectMake( 230+15, y + 10, 68, 25);
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
    YOffset += 267;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, YOffset, SCREEN_WIDTH , 43)];
    view.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:view];
    
    _coinTextField = [[UITextField alloc] initWithFrame:CGRectMake(6, YOffset + 8, 150, 28)];
    _coinTextField.placeholder = @"自定义充值金额";
    _coinTextField.font = [UIFont systemFontOfSize:14.0f];
    _coinTextField.textColor = [CommonFuction colorFromHexRGB:@"d5d5d5"];
    _coinTextField.backgroundColor = [UIColor clearColor];
    _coinTextField.keyboardType = UIKeyboardTypeNumberPad;
    _coinTextField.delegate = self;
    _coinTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    _coinTextField.leftViewMode = UITextFieldViewModeAlways;
    [_coinTextField addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.scrollView addSubview:_coinTextField];
   
    
    
    UIImage *rechargeImg = [CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"d14c49"] size:CGSizeMake(68, 25)];
        UIImage *rechargeImgNOR = [CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"c34845"] size:CGSizeMake(68, 25)];
    UIButton *rechargeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rechargeBtn.frame = CGRectMake(230+15, YOffset + 10, 68, 25);
    [rechargeBtn setTitle:@"充值" forState:UIControlStateNormal];
    [rechargeBtn setTitleColor:[CommonFuction colorFromHexRGB:@"ffffff"] forState:UIControlStateHighlighted];
    [rechargeBtn setTitleColor:[CommonFuction colorFromHexRGB:@"ffffff"] forState:UIControlStateNormal];
    rechargeBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    rechargeBtn.layer.cornerRadius = 12.5f;
    rechargeBtn.layer.masksToBounds = YES;
    rechargeBtn.layer.borderWidth = 0.5;
    rechargeBtn.layer.borderColor = [CommonFuction colorFromHexRGB:@"d14c49"].CGColor;
    [rechargeBtn setBackgroundImage:rechargeImg forState:UIControlStateNormal];
     [rechargeBtn setBackgroundImage:rechargeImgNOR forState:UIControlStateHighlighted];
    [rechargeBtn addTarget:self action:@selector(OnRecharge:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:rechargeBtn];
    
    YOffset += 59;
    
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(10, YOffset, 300, 20)];
    titleLable.text = @"温馨提示：人民币和热币兑换比例为1:100";
    titleLable.textColor = [CommonFuction colorFromHexRGB:@"454a4d"];
    titleLable.font = [UIFont systemFontOfSize:12.0f];
    [self.scrollView addSubview:titleLable];

    
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT );
    [self addNotifyKeyBoard];
    
    [self.scrollView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnHideKeyBoard:)]];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self showUserInfo];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self showUserInfo];
}
- (void)argumentForCanvas:(id)argumentData
{
    if (argumentData && [argumentData isKindOfClass:[NSDictionary class]])
    {
        NSDictionary *param = (NSDictionary *)argumentData;
        self.enterFromChatRoom = [[param objectForKey:@"enterFromChatRoom"] boolValue];
        
        self.viewTitle = [param objectForKey:@"title"];
        self.rechargeType = [[param objectForKey:@"rechargeType"] integerValue];
    }
}

- (void)OnHideKeyBoard:(UITapGestureRecognizer *)tapGestureRecognizer
{
    [_coinTextField resignFirstResponder];
}

- (void)textFieldDidChanged:(id)sender
{
    [self modifyNeedCoinTipLable];
}

- (void)modifyNeedCoinTipLable
{
    long long getCoin = [_coinTextField.text longLongValue] * 100;
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lld 热币",getCoin]];
    [str addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16.0f] range:NSMakeRange(0,[str length] - 2)];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13.0f] range:NSMakeRange([str length] - 2,2)];
    _getCoinLable.attributedText = str;
}

- (void)OnRecharge:(id)sender
{
    [_coinTextField resignFirstResponder];
    if (_coinTextField.text && [_coinTextField.text length])
    {
        long long coin = [_coinTextField.text longLongValue];
        if (coin > 100000)
        {
            [self showNoticeInWindow:@"输入金额不能超过100,000元"];
            return;
        }
        if (self.rechargeType == 11)
        {
            [self alipayCharge];
        }
        else if (self.rechargeType == 12)
        {
            [self uniBankCharge];
        }
        else if (self.rechargeType == 13)
        {
            [self wxpayRecharge];
        }
    }
    else
    {
        [self showNoticeInWindow:@"请选择充值金额"];
    }
}

/**
 *  支付宝支付
 */
- (void)alipayCharge
{
    if (![AppInfo shareInstance].bLoginSuccess)
    {
        if ([self showLoginDialog])
        {
            return;
        }
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject: @"热秀会员充值" forKey:@"subject"];
    [params setObject:[NSString stringWithFormat:@"热秀会员充值%@",_coinTextField.text] forKey:@"body"];
    [params setObject:[NSNumber numberWithFloat:[_coinTextField.text floatValue]] forKey:@"price"];
    
    __weak typeof(self) weakSelf = self;
    [self requestDataWithAnalyseModel:[RechargeModel class] params:params success:^(id object) {
        __strong typeof(self) strongSelf = weakSelf;
        if (strongSelf)
        {
            RechargeModel *model = (RechargeModel *)object;
            if (model.dataSign == nil) {
                if (model.code==403) {
                    [strongSelf showOherTerminalLoggedDialog];
                    [[AppInfo shareInstance] loginOut];
                    return ;
                }
            }

            [[Recharge shareRechargeInstance] alipayWithDataSign:model.dataSign payResult:^(NSInteger resultCode,NSString *resultMsg) {
                if(resultCode == 0)
                {
                    [strongSelf showUserInfo];
                    [strongSelf showNoticeInWindow:@"充值处理中，请稍后刷新查看" duration:2];
                    if (strongSelf.enterFromChatRoom)
                    {
                        NSString *className = NSStringFromClass([self class]);
                        NSDictionary *param = [NSDictionary dictionaryWithObject:className forKey:@"className"];
                        [strongSelf popToCanvas:LiveRoom_CanVas withArgument:param];
                    }
                }
                else
                {
                    [strongSelf showNoticeInWindow:resultMsg];
                }

            }];
        }
    } fail:^(id object) {
        
    }];
}

/**
 *  银联卡支付
 */
- (void)uniBankCharge
{
    NSDictionary *param = [NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:[_coinTextField.text floatValue]] forKey:@"costmoney"];
    __weak typeof(self) weakSelf = self;
    [self requestDataWithAnalyseModel:[GetUpPayOrderIDModel class] params:param success:^(id object) {
        __strong typeof(self) strongSelf = weakSelf;
        if (strongSelf)
        {
            GetUpPayOrderIDModel *model = (GetUpPayOrderIDModel *)object;
            if (model && model.result == 0)
            {
                NSString *mode = @"00";
                [[Recharge shareRechargeInstance] uppayWithOrderId:model.orderId mode:mode PayResult:^(NSInteger resultCode,NSString *resultMsg) {
                    if (resultCode == 0)
                    {
                        [strongSelf showUserInfo];
                        [strongSelf showNoticeInWindow:@"充值处理中，请稍后刷新查看" duration:2];
                        if (strongSelf.enterFromChatRoom)
                        {
                            [strongSelf popToCanvas:LiveRoom_CanVas withArgument:nil];
                        }
                    }
                    else
                    {
                        [strongSelf showNoticeInWindow:resultMsg];
                    }
                }];
            }
            else
            {
                [strongSelf showNoticeInWindow:model.msg];
            }
        }

    } fail:^(id object) {
        
    }];

}

/**
 *  微信支付
 */
- (void)wxpayRecharge
{
    if([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi])
    {
        [self wxpayCharge];
    }
    else
    {
        EWPAlertView *alertView = [[EWPAlertView alloc] initWithTitle:@"提示" message:@"未检测到微信客户端,是否现在安装" leftBtnTitle:@"暂不安装" rightBtnTitle:@"马上安装" clickBtnBlock:^(NSInteger nIndex) {
            if (nIndex == 0)
            {
                
            }
            else if(nIndex == 1)
            {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[WXApi getWXAppInstallUrl]]];
            }
        }];
        [alertView show];
    }
}
- (void)wxpayCharge
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject: @"商品名称" forKey:@"subject"];
    [params setObject:[NSString stringWithFormat:@"微信支付%@元",_coinTextField.text] forKey:@"body"];
    [params setObject:[NSNumber numberWithFloat:[_coinTextField.text floatValue]] forKey:@"price"];

    __weak typeof(self) weakSelf = self;
    [self requestDataWithAnalyseModel:[WeixinPayModel class] params:params success:^(id object)
    {
        __strong typeof(self) strongSelf = weakSelf;
        if (strongSelf)
        {
            WeixinPayModel *model = (WeixinPayModel *)object;
            
            if (model.result == 0)
            {
                NSMutableDictionary *param = [NSMutableDictionary dictionary];
                [param setObject:model.appid forKey:@"appid"];
                [param setObject:model.partnerid forKey:@"partnerid"];
                [param setObject:model.prepayid forKey:@"prepayid"];
                [param setObject:model.noncestr forKey:@"noncestr"];
                [param setObject:model.timestamp forKey:@"timestamp"];
                [param setObject:model.package forKey:@"package"];
                [param setObject:model.sign forKey:@"sign"];

                [[Recharge shareRechargeInstance] weixinpayWithparam:param PayResult:^(NSInteger resultCode,NSString *resultMsg) {
                    if (resultCode == 0)
                    {
                        [strongSelf showUserInfo];
                        [strongSelf showNoticeInWindow:@"充值处理中，请稍后刷新查看" duration:2];
                        if (strongSelf.enterFromChatRoom)
                        {
                            [strongSelf popToCanvas:LiveRoom_CanVas withArgument:nil];
                        }

                    }
                    else
                    {
                        [strongSelf showNoticeInWindow:resultMsg];
                    }
                }];
            }
            else
            {
                [strongSelf showNoticeInWindow:model.msg];
            }

        }
    }
    fail:^(id object) {
        
    }];
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
        
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lld 热币",userInfo.coin]];
        [str addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16.0f] range:NSMakeRange(0,[str length] - 2)];
        [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13.0f] range:NSMakeRange([str length] - 2,2)];
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
    [_coinTextField resignFirstResponder];
    
    UIButton *button = (UIButton *)sender;
    if (self.selectedButton)
    {
        self.selectedButton.selected = NO;
    }
    self.selectedButton = button;
    button.selected = YES;
    _coinTextField.text = [NSString stringWithFormat:@"%ld",(long)button.tag];
    
    [self OnRecharge:nil];
//    [self modifyNeedCoinTipLable];
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (_selectedButton)
    {
        _selectedButton.selected = NO;
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    long long coin = [string longLongValue];
    if (textField.text && [textField.text length] == 0)
    {
        if (coin == 0 && range.location == 0)
        {
            return NO;
        }
    }
    
    if (range.length > 0)
    {
        if ([string length] > 0)
        {
            if (([textField.text length] - range.length + [string length]) > 6)
            {
                return NO;
            }
        }
        else
        {
            if (([textField.text length] - range.length) > 6)
            {

                return NO;
            }
            
        }
        return YES;
    }
    if ([string isEqualToString:@"\n"])
    {
        [textField resignFirstResponder];
        return NO;
    }
    else if(range.location >= 6)
    {
        return NO;
    }
    if ([textField.text length] + [string length]> 0)
    {
        if (([textField.text length] + [string length]) > 6)
        {
            return NO;
        }
    }

    return YES;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}


#pragma mark -KeyBoardObderver

/*当键盘快要显示时调用*/
- (void)notifyShowKeyBoard:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    self.scrollView.contentInset = UIEdgeInsetsMake(0,0,keyboardRect.size.height,0);
}

- (void)notifyHideKeyBoard:(NSNotification *)notification
{
    self.scrollView.contentInset = UIEdgeInsetsZero;
}



@end
