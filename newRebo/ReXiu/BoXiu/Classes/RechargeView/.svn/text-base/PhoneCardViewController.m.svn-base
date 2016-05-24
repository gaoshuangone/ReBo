//
//  PhoneCardViewController.m
//  BoXiu
//
//  Created by tongmingyu on 15-3-20.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import "PhoneCardViewController.h"
#import "UserInfoManager.h"
#import "PhoneCardPayModel.h"
#import "NSString+DES.h"
#import "Recharge.h"

@interface PhoneCardViewController ()<UITextFieldDelegate>

@property (nonatomic,strong) UIImageView *headImg;
@property (nonatomic,strong) UILabel *nickLable;
@property (nonatomic,strong) UILabel *coinLable;

@property (nonatomic,strong) UIButton *mobileBtn;
@property (nonatomic,strong) UIButton *unicomBtn;
@property (nonatomic,strong) UIButton *telecomBtn;
@property (nonatomic,strong) UIButton *selectedButton;

@property (nonatomic,strong) UITextField *cardTextField;
@property (nonatomic,strong) UITextField *pwdTextField;
@property (nonatomic,strong) UIView *cardView;
@property (nonatomic,strong) UIView *bgView;

@property (nonatomic,assign) BOOL enterFromChatRoom;
@end

@implementation PhoneCardViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.baseViewType = kbaseScroolViewType;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"手机卡充值";
    
    int YOffset = 15;
    
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT - 64 + 100);
    
//    UIImageView *bgImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, YOffset, 50, 50)];
//    bgImg.image = [UIImage imageNamed:@"rechageDefault"];
//    [self.scrollView addSubview:bgImg];
   
//    _headImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, YOffset + 5, 40, 40)];
    _headImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, YOffset, 50, 50)];
    _headImg.layer.cornerRadius = 25.0f;
    _headImg.layer.masksToBounds = YES;
    [self.scrollView addSubview:_headImg];
    
    _nickLable = [[UILabel alloc] initWithFrame:CGRectMake(_headImg.frame.origin.x + _headImg.frame.size.width + 15, 22, 150, 15)];
    _nickLable.font = [UIFont systemFontOfSize:15.0f];
    _nickLable.textColor = [CommonFuction colorFromHexRGB:@"000000"];
    _nickLable.textAlignment = NSTextAlignmentLeft;
    [self.scrollView addSubview:_nickLable];
    
    UILabel *coinTitle = [[UILabel alloc] initWithFrame:CGRectMake(_nickLable.frame.origin.x, 44, 35, 15)];
    coinTitle.font = [UIFont systemFontOfSize:13.0f];
    coinTitle.textColor = [CommonFuction colorFromHexRGB:@"454a4d"];
    coinTitle.text = @"余额 :";
    [self.scrollView addSubview:coinTitle];
    
    _coinLable = [[UILabel alloc] initWithFrame:CGRectMake(coinTitle.frame.origin.x + coinTitle.frame.size.width + 5, coinTitle.frame.origin.y, 150, 15)];
    _coinLable.textColor = [CommonFuction colorFromHexRGB:@"f7c250"];
    _coinLable.font = [UIFont boldSystemFontOfSize:15.0f];
    _coinLable.textAlignment = NSTextAlignmentLeft;
    [self.scrollView addSubview:_coinLable];
    
    YOffset += 65;
    
    UILabel *selectTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, YOffset, 90, 15)];
    selectTitle.font = [UIFont systemFontOfSize:14.0f];
    selectTitle.text = @"选择运营商";
    selectTitle.textColor = [CommonFuction colorFromHexRGB:@"454a4d"];
    [self.scrollView addSubview:selectTitle];
    
    YOffset += 31;
    
    UIImage *normalImg = [CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"ffffff"] size:CGSizeMake(97, 43)];
    UIImage *selectImg = [CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"d14c49"] size:CGSizeMake(97, 43)];
    
    _mobileBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _mobileBtn.frame = CGRectMake(10, YOffset, 97, 43);
    _mobileBtn.tag = 6;
    [_mobileBtn setTitle:@"移动" forState:UIControlStateNormal];
    _mobileBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_mobileBtn setTitleColor:[CommonFuction colorFromHexRGB:@"959596"] forState:UIControlStateNormal];
    [_mobileBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [_mobileBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [_mobileBtn setBackgroundImage:selectImg forState:UIControlStateSelected];
    [_mobileBtn setBackgroundImage:selectImg forState:UIControlStateHighlighted];
    [_mobileBtn setBackgroundImage:normalImg forState:UIControlStateNormal];
    _mobileBtn.selected = YES;
    [_mobileBtn addTarget:self action:@selector(selectPhoneCardType:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:_mobileBtn];

    
    _unicomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _unicomBtn.frame = CGRectMake(10 + _mobileBtn.frame.size.width + 4, YOffset, 97, 43);
    _unicomBtn.tag = 7;
    [_unicomBtn setTitle:@"联通" forState:UIControlStateNormal];
    _unicomBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_unicomBtn setTitleColor:[CommonFuction colorFromHexRGB:@"959596"] forState:UIControlStateNormal];
    [_unicomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [_unicomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [_unicomBtn setBackgroundImage:selectImg forState:UIControlStateSelected];
    [_unicomBtn setBackgroundImage:selectImg forState:UIControlStateHighlighted];
    [_unicomBtn setBackgroundImage:normalImg forState:UIControlStateNormal];
    [_unicomBtn addTarget:self action:@selector(selectPhoneCardType:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:_unicomBtn];
    
    _telecomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _telecomBtn.frame = CGRectMake(10 + _mobileBtn.frame.size.width * 2 + 8, YOffset, 97, 43);
    _telecomBtn.tag = 8;
    [_telecomBtn setTitle:@"电信" forState:UIControlStateNormal];
    _telecomBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_telecomBtn setTitleColor:[CommonFuction colorFromHexRGB:@"959596"] forState:UIControlStateNormal];
    [_telecomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [_telecomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [_telecomBtn setBackgroundImage:selectImg forState:UIControlStateSelected];
    [_telecomBtn setBackgroundImage:selectImg forState:UIControlStateHighlighted];
    [_telecomBtn setBackgroundImage:normalImg forState:UIControlStateNormal];
    [_telecomBtn addTarget:self action:@selector(selectPhoneCardType:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:_telecomBtn];
    
    YOffset += 63;
    
    UILabel *selectMoneyTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, YOffset, 90, 15)];
    selectMoneyTitle.font = [UIFont systemFontOfSize:14.0f];
    selectMoneyTitle.text = @"选择充值金额";
    selectMoneyTitle.textColor = [CommonFuction colorFromHexRGB:@"454a4d"];
    [self.scrollView addSubview:selectMoneyTitle];
    
    YOffset += 31;
    
    NSArray *money = @[@"￥10",@"￥20",@"￥30",@"￥50",@"￥100",@"￥300",@"￥500"];
    for (int nIndex = 0; nIndex < [money count]; nIndex++)
    {
        NSInteger tag = 0;
        if (nIndex == 0)
        {
            tag = 10;
        }
        else if (nIndex == 1)
        {
            tag = 20;
        }
        else if (nIndex == 2)
        {
            tag = 30;
        }
        else if (nIndex == 3)
        {
            tag = 50;
        }
        else if(nIndex == 4)
        {
            tag = 100;
        }
        else if(nIndex == 5)
        {
            tag = 300;
        }
        else
        {
            tag = 500;
        }
        
        CGFloat x =  10 + (nIndex % 3) * (90 + 11);
        CGFloat y = selectMoneyTitle.frame.origin.y + 15 + 15 + (nIndex / 3) * (41 + 6);
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = tag;
        btn.frame = CGRectMake( x, y, 97, 43);
        btn.titleEdgeInsets = UIEdgeInsetsMake(15, 0, 12, 0);
        [btn setTitle:[money objectAtIndex:nIndex] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [btn setTitleColor:[CommonFuction colorFromHexRGB:@"959596"] forState:UIControlStateNormal];
        [btn setTitleColor:[CommonFuction colorFromHexRGB:@"ffffff"] forState:UIControlStateSelected];
        [btn setTitleColor:[CommonFuction colorFromHexRGB:@"ffffff"] forState:UIControlStateHighlighted];

        [btn setBackgroundImage:selectImg forState:UIControlStateHighlighted];
        [btn setBackgroundImage:normalImg forState:UIControlStateNormal];
        [btn setBackgroundImage:selectImg forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(OnSelect:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:btn];
    }
    
    YOffset += 166-50;
    
    _cardView = [[UIView alloc] initWithFrame:CGRectMake(10, YOffset, SCREEN_WIDTH - 20, 160)];
    _cardView.backgroundColor = [UIColor clearColor];
    _cardView.hidden = YES;
    [self.scrollView addSubview:_cardView];
    
    UILabel *cardLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 15)];
    cardLabel.text = @"输入充值卡序列号与密码";
    cardLabel.textColor = [CommonFuction colorFromHexRGB:@"454a4d"];
    cardLabel.font = [UIFont systemFontOfSize:14];
    [_cardView addSubview:cardLabel];
    
    UIView *textBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 28, SCREEN_WIDTH - 20, 43)];
    textBgView.backgroundColor = [UIColor whiteColor];
    [_cardView addSubview:textBgView];
    
    UIView *pwdBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 75, SCREEN_WIDTH - 20, 43)];
    pwdBgView.backgroundColor = [UIColor whiteColor];
    [_cardView addSubview:pwdBgView];

    _cardTextField = [[UITextField alloc] initWithFrame:CGRectMake(12, 36, 270, 28)];
    _cardTextField.placeholder = @"请输入充值卡序列号";
    _cardTextField.font = [UIFont systemFontOfSize:14.0f];
    _cardTextField.textColor = [CommonFuction colorFromHexRGB:@"959596"];
    _cardTextField.textAlignment = NSTextAlignmentLeft;
    _cardTextField.keyboardType = UIKeyboardTypeNumberPad;
    _cardTextField.delegate = self;
    [_cardView addSubview:_cardTextField];
    
    _pwdTextField = [[UITextField alloc] initWithFrame:CGRectMake(12, 83, 270, 28)];
    _pwdTextField.placeholder = @"请输入充值卡密码";
    _pwdTextField.font = [UIFont systemFontOfSize:14.0f];
    _pwdTextField.textColor = [CommonFuction colorFromHexRGB:@"959596"];
    _pwdTextField.textAlignment = NSTextAlignmentLeft;
    _pwdTextField.delegate = self;
    [_cardView addSubview:_pwdTextField];
    
    YOffset +=0;
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(10, YOffset, SCREEN_WIDTH - 20, 70)];
    _bgView.backgroundColor = [UIColor clearColor];
    [self.scrollView addSubview:_bgView];
    
    
    normalImg = [CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"f6f6f6"] size:CGSizeMake(240, 32)];
    selectImg = [CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"d14c49"] size:CGSizeMake(240, 32)];
    
    UIButton *rechargeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rechargeBtn.frame = CGRectMake(30, 4, 240, 37);
    [rechargeBtn setTitle:@"充值" forState:UIControlStateNormal];
    [rechargeBtn setTitleColor:[CommonFuction colorFromHexRGB:@"d14c49"] forState:UIControlStateNormal];
    [rechargeBtn setTitleColor:[CommonFuction colorFromHexRGB:@"ffffff"] forState:UIControlStateHighlighted];
    [rechargeBtn setBackgroundImage:normalImg forState:UIControlStateNormal];
    [rechargeBtn setBackgroundImage:selectImg forState:UIControlStateHighlighted];
    rechargeBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    rechargeBtn.layer.cornerRadius = 18.5;
    rechargeBtn.layer.masksToBounds = YES;
    rechargeBtn.layer.borderWidth = 1.0;
    rechargeBtn.layer.borderColor = [CommonFuction colorFromHexRGB:@"d14c49"].CGColor;
    [rechargeBtn addTarget:self action:@selector(phoneRecharge) forControlEvents:UIControlEventTouchUpInside];
    [_bgView addSubview:rechargeBtn];
    
    CGFloat disY =rechargeBtn.frame.size.height+35;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 4+disY, 90, 15)];
    label.text = @"重要提醒 :";
    label.textColor = [CommonFuction colorFromHexRGB:@"454a4d"];
    label.font = [UIFont boldSystemFontOfSize:12];
    [_bgView addSubview:label];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(0, 28+disY, 300, 15)];
    label.text = @"1. 请务必选择与您手中充值卡一样的面额";
    label.textColor = [CommonFuction colorFromHexRGB:@"959596"];
    label.font = [UIFont systemFontOfSize:12];
    [_bgView addSubview:label];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(0, 48+disY, 300, 15)];
    label.text = @"2. 充值提交后需要1-5分钟处理时间，请耐心等待";
    label.textColor = [CommonFuction colorFromHexRGB:@"959596"];
    label.font = [UIFont systemFontOfSize:12];
    [_bgView addSubview:label];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(0, 68+disY, 300, 15)];
    label.text = @"3. 人民币和热币兑换比例为1:100";
    label.textColor = [CommonFuction colorFromHexRGB:@"959596"];
    label.font = [UIFont systemFontOfSize:12];
    [_bgView addSubview:label];
    
    [self.scrollView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyBoard:)]];
    
    [self addNotifyKeyBoard];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self showUserInfo];
}

- (void)argumentForCanvas:(id)argumentData
{
    if (argumentData && [argumentData isKindOfClass:[NSDictionary class]])
    {
        NSDictionary *param = (NSDictionary *)argumentData;
        self.enterFromChatRoom = [[param objectForKey:@"enterFromChatRoom"] boolValue];
    }
}

- (void)selectPhoneCardType:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    if (btn.tag == 6)
    {
        _mobileBtn.selected = YES;
        _unicomBtn.selected = NO;
        _telecomBtn.selected = NO;
    }
    else if(btn.tag == 7)
    {
        _mobileBtn.selected = NO;
        _unicomBtn.selected = YES;
        _telecomBtn.selected = NO;
    }
    else
    {
        _mobileBtn.selected = NO;
        _unicomBtn.selected = NO;
        _telecomBtn.selected = YES;
    }
}

- (void)OnSelect:(id)sender
{
    [_cardTextField resignFirstResponder];
    [_pwdTextField resignFirstResponder];
    
    UIButton *button = (UIButton *)sender;
    if (self.selectedButton)
    {
        self.selectedButton.selected = NO;
    }
    self.selectedButton = button;
    button.selected = YES;
    
    _cardView.hidden = NO;
    
    [self.view setNeedsLayout];
}


- (void)phoneRecharge
{
    [_cardTextField resignFirstResponder];
    [_pwdTextField resignFirstResponder];
    
    if (self.selectedButton==nil) {
            [self showNotice:@"请输入充值金额"];
        return;
    }
    
    if (_cardTextField.text == nil || [_cardTextField.text length] == 0)
    {
        [self showNotice:@"请输入充值卡序列号"];
        return;
    }
    
    if (_pwdTextField.text == nil || [_pwdTextField.text length] == 0)
    {
        [self showNotice:@"请输入充值卡密码"];
        return;
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[[ReXiuLib shareInstance] DESEncryptWithKey:_cardTextField.text] forKey:@"cardnum1"];
    [params setObject:[[ReXiuLib shareInstance] DESEncryptWithKey:_pwdTextField.text] forKey:@"cardnum2"];
    [params setObject:[NSNumber numberWithInteger:self.selectedButton.tag] forKey:@"costmoney"];
    
    __weak typeof(self) weakSelf = self;
    [[Recharge shareRechargeInstance] phonepayWithParam:params PayResult:^(NSInteger resultCode,NSString *resultMsg) {
        __strong typeof(self) strongSelf = weakSelf;
        if (resultCode == 0)
        {
            if (strongSelf)
            {
                [strongSelf showUserInfo];
                [strongSelf showNoticeInWindow:@"充值处理中，请稍后刷新查看" duration:5];
                if (strongSelf.enterFromChatRoom)
                {
                    [strongSelf popToCanvas:LiveRoom_CanVas withArgument:nil];
                }

            }
        }
        else
        {
            [strongSelf showNoticeInWindow:resultMsg];
        }
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
        [str addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:14.0f] range:NSMakeRange(0,[str length] - 2)];
        [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:11.0f] range:NSMakeRange([str length] - 2,2)];
        
        _coinLable.attributedText = str;
        
    }
    else
    {
        _nickLable.hidden = YES;
        _coinLable.hidden = YES;
    }
    [self.view setNeedsDisplay];
}


- (void)viewWillLayoutSubviews
{
    if (_cardView.hidden == NO)
    {
        _cardView.frame = CGRectMake(10, 360, SCREEN_WIDTH - 20, 180);
        _bgView.frame = CGRectMake(10, 520-26, SCREEN_WIDTH - 20, 70);
        self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT - 64 + 230);
    }
    else
    {
        _bgView.frame = CGRectMake(10, 365, SCREEN_WIDTH - 23, 70);
        self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT - 64 + 50+50);
    }
}

#pragma mark UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@" "])
    {
        return NO;
    }
    
    NSInteger nLimitCount = 30;
    
    if (textField)
    {
        if (range.length > 0)
        {
            if ([string length] > 0)
            {
                if (([textField.text length] - range.length + [string length]) > nLimitCount)
                {
                    return NO;
                }
            }
            else
            {
                if (([textField.text length] - range.length) > nLimitCount)
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
        else if(range.location >= nLimitCount)
        {
            return NO;
        }
        if ([textField.text length] + [string length]> 0)
        {
            if (([textField.text length] + [string length]) > nLimitCount)
            {
                return NO;
            }
        }
        return YES;
    }
    return YES;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}

- (void)hideKeyBoard:(UITapGestureRecognizer *)tapGestureRecognizer
{
    [_cardTextField resignFirstResponder];
    [_pwdTextField resignFirstResponder];
}


#pragma mark -KeyBoardObderver

/*当键盘快要显示时调用*/
- (void)notifyShowKeyBoard:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    self.scrollView.contentInset = UIEdgeInsetsMake(0,0,keyboardRect.size.height + 40,0);
}

- (void)notifyHideKeyBoard:(NSNotification *)notification
{
    self.scrollView.contentInset = UIEdgeInsetsZero;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
