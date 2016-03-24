//
//  RegisterViewController.m
//  BoXiu
//
//  Created by andy on 14-4-25.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "RegisterViewController.h"
#import "RegisterSuccessViewController.h"
#import "RegisterModel.h"
#import "AppInfo.h"
#import "UserInfoManager.h"
#import "RegexKitLite.h"
#import "EWPCheckBox.h"
#import "BindVerifyCodeModel.h"
#import "NSString+DES.h"
#import "UMessage.h"
#import "WXApi.h"
#import "UMessage.h"
#import "UMSocial.h"

@interface RegisterViewController ()<UITextFieldDelegate>

@property (nonatomic,strong) UITextField *accountTextField;
@property (nonatomic,strong) UITextField *passwordTextField;
@property (nonatomic,strong) UITextField *mobileTextField;
@property (nonatomic,strong) UITextField *VerifyCodeTextField;
@property (nonatomic,strong) EWPButton *getVeryfyCodeBtn;
@property (nonatomic,strong) EWPButton *reginsterBtn;
@property (nonatomic,assign) BOOL bindingMobile;
@property (nonatomic,strong) UIView *verifyBackView;
@property (nonatomic,strong) UIView *passwordBKView;
@property (nonatomic,strong) UIView *protocolBKView;


@property (nonatomic, strong) UILabel *registTimeLable;
@property (nonatomic, strong) NSTimer *registConnectionTimer; //触发定时器


@property (nonatomic,strong) EWPButton *phoneBtn;
@property (nonatomic,strong) EWPButton *userBtn;
@property (nonatomic,strong) UIImageView *lineImge;
@property (nonatomic,strong) UISegmentedControl* segment;
@property (nonatomic,strong)  UIControl* viewBK ;

@end

@implementation RegisterViewController

 int registTimess = 60; //获取验证码60秒后才可以显示

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
//    self.title = @"注册";
   
    
//    if (SCREEN_HEIGHT == 480)
//    {
//        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"login4Bg"]];
//    }
//    else
//    {
//        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"loginBg"]];
//    }
    self.view.backgroundColor = [CommonFuction colorFromHexRGB:@"f6f6f6"];
    
    
    UIControl * control = [[UIControl alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 68)];
    control.backgroundColor = [CommonFuction colorFromHexRGB:@"ffffff"];
    [self.view addSubview:control];
    
  
    UIView* viewLine = [CommonUtils CommonViewLineWithFrame:CGRectMake(0, 67, SCREEN_WIDTH, 1)];
    viewLine.backgroundColor = [CommonFuction colorFromHexRGB:@"cbcbcb"];
    [self.view addSubview:viewLine];
    
    CGFloat alignX = 12;
    CGFloat YOffset = 35;
    CGFloat YSpace = 10;
    
    __weak typeof(self) weakSelf = self;
  
    EWPButton *backBtn = [EWPButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(10, YOffset, 30, 24);
    [backBtn setImage:[UIImage imageNamed:@"navBack_normal"] forState:UIControlStateNormal];
    backBtn.buttonBlock = ^(id sender)
    {
        __strong typeof(self) StrongSelf = weakSelf;
        [StrongSelf popCanvasWithArgment:nil];
    };
    
    [self.view addSubview:backBtn];
    
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-20, 40, 50, 15)];
    titleLabel.text = @"注册";
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textColor = [CommonFuction colorFromHexRGB:@"454a4d"];
    [self.view addSubview:titleLabel];

    YOffset += 47;
    
//    UIImageView *bgImg = [[UIImageView alloc] initWithFrame:CGRectMake(48, YOffset, 227, 26)];
//    bgImg.image = [UIImage imageNamed:@"registBg"];
//    [self.scrollView addSubview:bgImg];

    self.bindingMobile = YES;
    
    _viewBK = [[UIControl alloc]initWithFrame:CGRectMake(0, 121, SCREEN_WIDTH, 43*3+5)];
    _viewBK.backgroundColor = [CommonFuction colorFromHexRGB:@"ffffff"];
    [self.scrollView addSubview:_viewBK];
    
    _segment = [[UISegmentedControl alloc]initWithFrame:CGRectMake(13, YOffset-2, SCREEN_WIDTH-26, 30)];
    
    [_segment insertSegmentWithTitle:@"手机号" atIndex:0 animated:YES];
       [_segment insertSegmentWithTitle:@"用户名" atIndex:1 animated:YES];
    _segment.tintColor =[CommonFuction colorFromHexRGB:@"d14c49"];
    _segment.selectedSegmentIndex = 0;
    [_segment addTarget:self action:@selector(accountOrSwitch:) forControlEvents:UIControlEventValueChanged];
    [self.scrollView addSubview:_segment];
    
//    _phoneBtn = [EWPButton buttonWithType:UIButtonTypeCustom];
//    _phoneBtn.frame = CGRectMake(50, YOffset + 2, 110, 22);
//    _phoneBtn.tag = 55;
//    [_phoneBtn setTitle:@"手机号" forState:UIControlStateNormal];
//    _phoneBtn.layer.masksToBounds = YES;
//    _phoneBtn.layer.cornerRadius = 11;
//    _phoneBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
//    [_phoneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    _phoneBtn.backgroundColor = [UIColor colorWithWhite:1 alpha:0.3];
//    [_phoneBtn addTarget:self action:@selector(accountOrSwitch:) forControlEvents:UIControlEventTouchUpInside];
//    [self.scrollView addSubview:_phoneBtn];
//    
//    
//    _userBtn = [EWPButton buttonWithType:UIButtonTypeCustom];
//    _userBtn.frame = CGRectMake(162, YOffset + 2, 110, 22);
//    _userBtn.tag = 66;
//    [_userBtn setTitle:@"用户名" forState:UIControlStateNormal];
//    _userBtn.layer.masksToBounds = YES;
//    _userBtn.layer.cornerRadius = 11;
//    _userBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
//    [_userBtn addTarget:self action:@selector(accountOrSwitch:) forControlEvents:UIControlEventTouchUpInside];
//    [self.scrollView addSubview:_userBtn];

    YOffset += 40+3;
    
    //用户名
    _accountTextField = [[UITextField alloc] initWithFrame:CGRectMake(alignX + 10, YOffset-3, 264, 43)];
    _accountTextField.delegate = self;
    _accountTextField.borderStyle = UITextBorderStyleNone;
    _accountTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    _accountTextField.placeholder = @"用户名  (4-16位字符)";
    _accountTextField.font = [UIFont systemFontOfSize:14];
    _accountTextField.textColor = [CommonFuction colorFromHexRGB:@"959596"];
    [_accountTextField setValue:[CommonFuction colorFromHexRGB:@"959596"] forKeyPath:@"_placeholderLabel.textColor"];
    [self.scrollView addSubview:_accountTextField];
    
    YOffset += 43;
    
    _lineImge = [[UIImageView alloc] initWithFrame:CGRectMake(alignX , YOffset-3, SCREEN_WIDTH-24, 0.5)];
    _lineImge.backgroundColor = [CommonFuction colorFromHexRGB:@"cbcbcb"];
    [self.scrollView addSubview:_lineImge];
    
    YOffset += 15;
    
    _verifyBackView = [[UIView alloc] initWithFrame:CGRectMake(0, YOffset, 320, 90)];
    _verifyBackView.backgroundColor = [UIColor clearColor];
    [self.scrollView addSubview:_verifyBackView];
    YOffset += 105+3;
    
    //手机号
    UIView *textFieldBK = [[UIView alloc] initWithFrame:CGRectMake(alignX , 2, 244, 43)];
    _mobileTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, 244, 43)];
    _mobileTextField.delegate = self;
    _mobileTextField.borderStyle = UITextBorderStyleNone;
    _mobileTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    _mobileTextField.keyboardType = UIKeyboardTypeNumberPad;
    _mobileTextField.placeholder = @"请输入手机号码";
    _mobileTextField.font = [UIFont systemFontOfSize:14];
    _mobileTextField.textColor = [CommonFuction colorFromHexRGB:@"959596"];
    [_mobileTextField setValue:[CommonFuction colorFromHexRGB:@"959596"] forKeyPath:@"_placeholderLabel.textColor"];
    [textFieldBK addSubview:_mobileTextField];
    [self.verifyBackView addSubview:textFieldBK];
    
    
    
   
    UIImageView *phonelineImge = [[UIImageView alloc] initWithFrame:CGRectMake(alignX , 42+3, SCREEN_WIDTH-24, 0.5)];
    phonelineImge.backgroundColor = [CommonFuction colorFromHexRGB:@"cbcbcb"];
    [self.verifyBackView addSubview:phonelineImge];
    
    //验证码
    textFieldBK = [[UIView alloc] initWithFrame:CGRectMake(alignX, 36 + YSpace, 140, 43)];
    _VerifyCodeTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, 140, 43)];
    _VerifyCodeTextField.delegate = self;
    _VerifyCodeTextField.borderStyle = UITextBorderStyleNone;
    _VerifyCodeTextField.keyboardType = UIKeyboardTypeNumberPad;
    _VerifyCodeTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    _VerifyCodeTextField.placeholder = @"请输入短信验证码";
    _VerifyCodeTextField.font = [UIFont systemFontOfSize:14];
    _VerifyCodeTextField.textColor = [CommonFuction colorFromHexRGB:@"959596"];
    
    
    [_VerifyCodeTextField setValue:[CommonFuction colorFromHexRGB:@"959596"] forKeyPath:@"_placeholderLabel.textColor"];
    [textFieldBK addSubview:_VerifyCodeTextField];
    [self.verifyBackView addSubview:textFieldBK];
    
    phonelineImge = [[UIImageView alloc] initWithFrame:CGRectMake(alignX , 88.5, SCREEN_WIDTH-24, 0.5)];
    phonelineImge.backgroundColor = [CommonFuction colorFromHexRGB:@"cbcbcb"];
    [self.verifyBackView addSubview:phonelineImge];
    
    //获取验证码按钮
    _getVeryfyCodeBtn = [EWPButton buttonWithType:UIButtonTypeCustom];
    _getVeryfyCodeBtn.tag = 2;
    _getVeryfyCodeBtn.frame = CGRectMake(alignX + 188+2, 43 + YSpace+2.5, 91, 23);
    [_getVeryfyCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    _getVeryfyCodeBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [_getVeryfyCodeBtn setTitleColor:[CommonFuction colorFromHexRGB:@"959596"] forState:UIControlStateNormal];
//    _getVeryfyCodeBtn.backgroundColor = [UIColor colorWithWhite:1 alpha:1];
//    _getVeryfyCodeBtn.layer.masksToBounds = YES;
    _getVeryfyCodeBtn.layer.cornerRadius = 11.5;
    _getVeryfyCodeBtn.layer.borderWidth = 1;
    _getVeryfyCodeBtn.layer.borderColor =[CommonFuction colorFromHexRGB:@"dbdbdb"].CGColor;
//    [_getVeryfyCodeBtn setBackgroundImage:[CommonFuction imageWithColor:[UIColor grayColor] size:CGSizeMake(110, 40)] forState:UIControlStateDisabled];
    [self.verifyBackView addSubview:_getVeryfyCodeBtn];

    _getVeryfyCodeBtn.buttonBlock = ^(id senddΩer)
    {
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf.mobileTextField resignFirstResponder];
        [strongSelf.VerifyCodeTextField resignFirstResponder];
        [strongSelf.passwordTextField resignFirstResponder];
        
        [strongSelf performSelector:@selector(getRegistCode) withObject:nil];
    };
    
    YOffset += 25;
    
    //密码
    _passwordBKView = [[UIView alloc] initWithFrame:CGRectMake(alignX + 6, YOffset-3, 264, 43)];
    _passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(5, 0, 264, 43)];
    _passwordTextField.delegate = self;
    _passwordTextField.borderStyle = UITextBorderStyleNone;
    _passwordTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    _passwordTextField.secureTextEntry = YES;
    _passwordTextField.placeholder = @"密码  (4-16位字符)";
    _passwordTextField.font = [UIFont systemFontOfSize:14];
    _passwordTextField.textColor = [CommonFuction colorFromHexRGB:@"959596"];
    [_passwordTextField setValue:[CommonFuction colorFromHexRGB:@"959596"] forKeyPath:@"_placeholderLabel.textColor"];
    [_passwordBKView addSubview:_passwordTextField];
    
//    UIImageView *userlineImge = [[UIImageView alloc] initWithFrame:CGRectMake(0, 41, 264, 0.5)];
//    userlineImge.backgroundColor = [CommonFuction colorFromHexRGB:@"cbcbcb"];
//    [_passwordBKView addSubview:userlineImge];
    [self.scrollView addSubview:_passwordBKView];
    YOffset += 43;
    
    YOffset += YSpace;
    
    _protocolBKView = [[UIView alloc] initWithFrame:CGRectMake(0, YOffset, SCREEN_WIDTH - 59, 20)];
    _protocolBKView.backgroundColor = [UIColor clearColor];
    [self.scrollView addSubview:_protocolBKView];
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(alignX+100+11, 1+3, 100, 20)];
    lable.text = @"同意";
    lable.textColor = [CommonFuction colorFromHexRGB:@"454a4d"];
    lable.font = [UIFont systemFontOfSize:12.0f];
    lable.textAlignment = NSTextAlignmentCenter;
    [_protocolBKView addSubview:lable];
    
    EWPButton *serverProtocolBtn = [EWPButton buttonWithType:UIButtonTypeCustom];
    serverProtocolBtn.frame = CGRectMake(alignX + 143+11, 1+3, 130, 20);
    [serverProtocolBtn setTitle:@"《热秀服务协议》" forState:UIControlStateNormal];
    serverProtocolBtn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    [serverProtocolBtn setTitleColor:[CommonFuction colorFromHexRGB:@"454a4d"] forState:UIControlStateNormal];
    [_protocolBKView addSubview:serverProtocolBtn];
//    YOffset += 20;
//    YOffset += 30;
    serverProtocolBtn.buttonBlock = ^(id sender)
    {
        __strong typeof(self) strongSelf = weakSelf;
       //跳转到服务协议界面
        [strongSelf pushCanvas:ServerProctol_Canvas withArgument:nil];
    };
    
    UIImageView *lineImg = [[UIImageView alloc] initWithFrame:CGRectMake(alignX + 165+11, 17+3, 84, 0.5)];
    lineImg.backgroundColor =[CommonFuction colorFromHexRGB:@"454a4d"];
    [_protocolBKView addSubview:lineImg];
    
    
    _reginsterBtn = [[EWPButton alloc] initWithFrame:CGRectMake(alignX + 17-2, YOffset-50, 264, 43)];
    [_reginsterBtn setTitle:@"注册" forState:UIControlStateNormal];
    
    [_reginsterBtn setTitleColor:COLOR_SUBJECT_White forState:UIControlStateHighlighted];
    [_reginsterBtn setTitleColor:COLOR_SUBJECTCOLOR forState:UIControlStateNormal];
    [_reginsterBtn setBackgroundImage:IMAGE_WHITE(264, 40) forState:UIControlStateNormal];
    [_reginsterBtn setBackgroundImage:IMAGE_SUBJECT_NOR(264, 40) forState:UIControlStateHighlighted];
    _reginsterBtn.titleLabel.font = [UIFont systemFontOfSize:17.0f];
    _reginsterBtn.layer.masksToBounds = YES;
    _reginsterBtn.layer.cornerRadius = 21.5f;
    _reginsterBtn.layer.borderWidth=1;
    _reginsterBtn.layer.borderColor = COLOR_SUBJECTCOLOR.CGColor;
    
    [self.scrollView addSubview:_reginsterBtn];
    
 

    
    [_reginsterBtn setButtonBlock:^(id sender)
     {
         _reginsterBtn.userInteractionEnabled = NO;
         [weakSelf performSelector:@selector(Onregister) withObject:weakSelf];
     }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBarHidden = NO;
}

- (void)accountOrSwitch:(id)sender
{
    UISegmentedControl *btn = (UISegmentedControl *)sender;

    if (btn.selectedSegmentIndex == 0)
    {
        _phoneBtn.backgroundColor = [UIColor colorWithWhite:1 alpha:0.3];
        _userBtn.backgroundColor = [UIColor clearColor];
        self.bindingMobile = YES;
    }
    else
    {

        
        _phoneBtn.backgroundColor = [UIColor clearColor];
        _userBtn.backgroundColor = [UIColor colorWithWhite:1 alpha:0.3];
        self.bindingMobile = NO;
    }
    [self.view setNeedsLayout];
}

- (void)Onregister
{
    [_accountTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
    [_mobileTextField resignFirstResponder];
    [_VerifyCodeTextField resignFirstResponder];
    
    if (self.bindingMobile)
    {
        if (![_mobileTextField.text hasPrefix:@"1"] || [_mobileTextField.text length] != 11)
        {
            [self showNoticeInWindow:@"请输入正确的手机号"];
             _reginsterBtn.userInteractionEnabled = YES;
            return;
        }
        
        if ([_VerifyCodeTextField.text length] == 0)
        {
             _reginsterBtn.userInteractionEnabled = YES;
            [self showNoticeInWindow:@"请输入验证码"];
            
            return;
        }
    }
    else
    {
        if (_accountTextField.text && [_accountTextField.text length] == 0)
        {
            [self showNoticeInWindow:@"请输入用户名"];
             _reginsterBtn.userInteractionEnabled = YES;
            return;
        }
        if ([CommonFuction hasUnicodeString:_accountTextField.text])
        {
            [self showNoticeInWindow:@"用户名只能输入英文字母、数字或下划线"];
             _reginsterBtn.userInteractionEnabled = YES;
            return;
        }
        
        if(![_accountTextField.text isMatchedByRegex:@"^[(_)|[a-zA-Z]]"])
        {
            [self showNoticeInWindow:@"用户名第一个字符只允许英文字母或下划线"];
             _reginsterBtn.userInteractionEnabled = YES;
            return;
        }
        
        if(![_accountTextField.text isMatchedByRegex:@"\\w{4,12}$"])
        {
            [self showNoticeInWindow:@"用户名长度不足4位"];
             _reginsterBtn.userInteractionEnabled = YES;
            return;
        }
    }
    if ([_passwordTextField.text length] == 0)
    {
        [self showNoticeInWindow:@"请输入密码"];
         _reginsterBtn.userInteractionEnabled = YES;
        return;
    }
//    if(![_passwordTextField.text isMatchedByRegex:@"^[\\x{21}-\\x{ff}]{4,16}$"] || [_passwordTextField.text isMatchedByRegex:@"[<>&\\$\\^~]"])
//    {
//        [self showNoticeInWindow:@"请输入4-16位字符"];
//         _reginsterBtn.userInteractionEnabled = YES;
//        return;
//    }
    if(![_passwordTextField.text isMatchedByRegex:@"^[\\x{21}-\\x{ff}]{4,16}$"])
    {
        [self showNoticeInWindow:@"请输入4-16位字符"];
        _reginsterBtn.userInteractionEnabled = YES;
        return;
    }
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict setObject:_accountTextField.text forKey:@"loginname"];

    [dict setObject:[[ReXiuLib shareInstance] DESEncryptWithKey:_passwordTextField.text] forKey:@"password"];

    if (self.bindingMobile)
    {
        [dict setObject:[NSNumber numberWithBool:self.bindingMobile] forKey:@"isUsePhone"];
        [dict setObject:_mobileTextField.text forKey:@"phone"];
        [dict setObject:_VerifyCodeTextField.text forKey:@"code"];
    }
    
    __weak typeof(self) weakSelf = self;
    [self requestDataWithAnalyseModel:[RegisterModel class] params:dict success:^(id object)
     {
         __strong typeof(self) strongSelf = weakSelf;
         /*成功返回数据*/
         RegisterModel *registerModel = object;
         if (registerModel.result == 0)
         {
             [UserInfoManager shareUserInfoManager].currentUserInfo = registerModel.userInfo;
             if (self.bindingMobile)
             {
                 [[AppInfo shareInstance] saveLogin:[dict objectForKey:@"phone"] password:registerModel.userInfo.password];
             }
             else
             {
                 [[AppInfo shareInstance] saveLogin:[dict objectForKey:@"loginname"] password:registerModel.userInfo.password];
             }
             
             
             //根据umeng 后台需要绑定设备别名
             NSString *strUserId = [NSString stringWithFormat:@"%ld",(long)registerModel.userInfo.userId];
             
             [UMessage addAlias:strUserId type:@"userid" response:^(id responseObject, NSError *error) {
            }];
             
             [strongSelf pushCanvas:Register_Success_Canvas withArgument:nil];
         }
         else
         {
             [UserInfoManager shareUserInfoManager].currentUserInfo = nil;
             [self showNoticeInWindow:registerModel.msg];
         }
          _reginsterBtn.userInteractionEnabled = YES;
     }
    fail:^(id object)
     {
         [self showNoticeInWindow:@"网络连接失败"];
         /*失败返回数据*/
          _reginsterBtn.userInteractionEnabled = YES;
     }];

}

- (void)viewWillLayoutSubviews
{
    int xOffset = self.passwordBKView.frame.origin.x;
    int nStarYPos = self.verifyBackView.frame.size.height;
    
    if (self.bindingMobile)
    {
          _viewBK.frame =CGRectMake(0, 123, SCREEN_WIDTH, 43*3);
        self.accountTextField.hidden = YES;
        self.verifyBackView.hidden = NO;
        self.lineImge.hidden = YES;
        self.verifyBackView.frame = CGRectMake(0, 120, 320, 90);
        
        self.passwordBKView.frame = CGRectMake(xOffset, nStarYPos + 120, self.passwordBKView.frame.size.width, self.passwordBKView.frame.size.height);
        self.protocolBKView.frame = CGRectMake(xOffset, nStarYPos + 175, self.protocolBKView.frame.size.width, self.protocolBKView.frame.size.height);
        self.reginsterBtn.frame = CGRectMake(8+17, nStarYPos +  213, self.reginsterBtn.frame.size.width, self.reginsterBtn.frame.size.height);
    }
    else
    {
         _viewBK.frame =CGRectMake(0, 123, SCREEN_WIDTH, 43*2);
        self.accountTextField.hidden = NO;
        self.verifyBackView.hidden = YES;
        self.lineImge.hidden = NO;
        
        self.passwordBKView.frame = CGRectMake(xOffset, nStarYPos + 70+4+1, self.passwordBKView.frame.size.width, self.passwordBKView.frame.size.height);
        self.protocolBKView.frame = CGRectMake(xOffset, nStarYPos + self.passwordBKView.frame.size.height  + 85, self.protocolBKView.frame.size.width, self.protocolBKView.frame.size.height);
        self.reginsterBtn.frame = CGRectMake(8+17, nStarYPos + self.passwordBKView.frame.size.height + self.protocolBKView.frame.size.height  + 103, self.reginsterBtn.frame.size.width, self.reginsterBtn.frame.size.height);
    }
}

- (void)getRegistCode
{
    [_accountTextField resignFirstResponder];
    [_mobileTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];

    if (![_mobileTextField.text hasPrefix:@"1"] || [_mobileTextField.text length] != 11)
    {
        [self showNoticeInWindow:@"请输入正确的手机号"];
        
        return;
    }
    
    if ([AppInfo shareInstance].network ==0 || ![AppInfo IsEnableConnection])
    {
        [self.rootViewController showNoticeInWindow:@"您的网络有问题,请检查网络" duration:1.5];
        return;
    }
    _getVeryfyCodeBtn.enabled = NO;
    BindVerifyCodeModel *model = [[BindVerifyCodeModel alloc] init];
    NSDictionary *param = [NSDictionary dictionaryWithObject:_mobileTextField.text forKey:@"mobile"];
    [model requestDataWithParams:param success:^(id object) {
        _getVeryfyCodeBtn.enabled = YES;
        if (model.result == 0)
        {
            CGRect rect = CGRectMake(10 + 188, 38 + 10, 96, 35);
            [self buttonPressedTime:rect];
            
            [self showNoticeInWindow:@"验证码发送成功"];
        }
        else
        {
            [self showNoticeInWindow:model.msg];
        }
    } fail:^(id object) {
        _getVeryfyCodeBtn.enabled = YES;
    }];
    
}


//比如按下按钮 60秒后 才能继续点击。
- (void) buttonPressedTime:(CGRect)LabelFrame;
{
    UIButton *btn = (UIButton *)[self.view viewWithTag:2];;
    btn.hidden = YES;
    
    if (_registTimeLable != nil)
    {
        [_registTimeLable removeFromSuperview];
        _registTimeLable = nil;
    }
    _registTimeLable = [[UILabel alloc] initWithFrame:LabelFrame];
    _registTimeLable.font = [UIFont systemFontOfSize:12];
    _registTimeLable.backgroundColor = RGB(204, 204, 204, 1.0);
    _registTimeLable.text = @"60秒后重新获取";
    _registTimeLable.textColor = [UIColor whiteColor];
    _registTimeLable.textAlignment = NSTextAlignmentCenter;
    
    [self.verifyBackView addSubview:_registTimeLable];
    
    _registConnectionTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(buttonPressLabel:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:_registConnectionTimer forMode:NSDefaultRunLoopMode];
}

- (void) buttonPressLabel:(id)sender
{
    UIButton *presbtn = (UIButton *)[self.view viewWithTag:2];;
    
    _registTimeLable.text = [NSString stringWithFormat:@"%d秒后重新获取",registTimess];
    
    if (registTimess == 0)
    {
        registTimess = 60;
        [_registConnectionTimer invalidate];
        _registConnectionTimer = nil;
        presbtn.hidden = NO;
        [_registTimeLable removeFromSuperview];
        _registTimeLable = nil;
        
        [_getVeryfyCodeBtn setTitle:@"重新获取" forState:UIControlStateNormal];
    }
    else
    {
        registTimess--;
    }
}


#pragma mark UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
 
    if ([string isEqualToString:@" "])
    {
        return NO;
    }
    
    
    NSInteger nLimitCount = 6;
    if (textField == _accountTextField || textField == _passwordTextField)
    {
        nLimitCount = 16;
    }
    else if (textField == _VerifyCodeTextField)
    {
        nLimitCount = 6;
    }
    else if (textField == _mobileTextField)
    {
        nLimitCount = 11;
    }
    
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



@end
