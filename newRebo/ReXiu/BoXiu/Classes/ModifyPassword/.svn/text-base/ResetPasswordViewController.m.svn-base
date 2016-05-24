//
//  ResetPasswordViewController.m
//  BoXiu
//
//  Created by andy on 14-8-4.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "ResetPasswordViewController.h"
#import "ResetPasswordModel.h"
#import "RegexKitLite.h"
#import "ResetVerifyCodeModel.h"
#import "NavbarBack.h"

@interface ResetPasswordViewController ()<UITextFieldDelegate>
@property (nonatomic,strong) UITextField *mobileTextField;
@property (nonatomic,strong) UITextField *VerifyCodeTextField;
@property (nonatomic,strong) EWPButton *getVeryfyCodeBtn;

@property (nonatomic,strong) UITextField *password;
@property (nonatomic,strong) UITextField *confirmPassword;
@end

@implementation ResetPasswordViewController

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
    self.view.backgroundColor = [CommonFuction colorFromHexRGB:@"f6f6f6"];
//    if (SCREEN_HEIGHT == 480)
//    {
//        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"login4Bg"]];
//    }
//    else
//    {
//        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"loginBg"]];
//    }
    
    UIControl * control1 = [[UIControl alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 68)];
    control1.backgroundColor = [CommonFuction colorFromHexRGB:@"ffffff"];
    [self.view addSubview:control1];
    
    
    UIView* viewLine = [CommonUtils CommonViewLineWithFrame:CGRectMake(0, 67, SCREEN_WIDTH, 1)];
    viewLine.backgroundColor = [CommonFuction colorFromHexRGB:@"cbcbcb"];
    [self.view addSubview:viewLine];
    NavbarBack *navBack = [[NavbarBack alloc] initWithFrame:CGRectMake(0, 30, SCREEN_WIDTH, 40) showInView:self.view];
    navBack.title = @"找回密码";
    __weak typeof(self) weakSelf = self;
    navBack.backButtonBlock = ^(id sender)
    {
        __strong typeof(self) strongself = weakSelf;
        if (strongself)
        {
            [strongself popCanvasWithArgment:nil];
        }
        
    };
    [self.view addSubview:navBack];
    

    
    CGFloat alignX = 15;
    CGFloat YOffset = 90;
    
    
    UIControl* control = [[UIControl alloc]initWithFrame:CGRectMake(0, 90, SCREEN_WIDTH, 42*4+7.5)];
    control.backgroundColor = [CommonFuction colorFromHexRGB:@"ffffff"];
    [self.scrollView addSubview:control];
    //真实手机号
    _mobileTextField = [[UITextField alloc] initWithFrame:CGRectMake(alignX + 12, YOffset, 260, 42)];
    _mobileTextField.delegate = self;
    _mobileTextField.borderStyle = UITextBorderStyleNone;
    _mobileTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    _mobileTextField.keyboardType = UIKeyboardTypeNumberPad;
    _mobileTextField.placeholder = @"请输入绑定的手机号码";
    _mobileTextField.font = [UIFont systemFontOfSize:14];;
    _mobileTextField.textColor = [CommonFuction colorFromHexRGB:@"959596"];
    [_mobileTextField setValue:[CommonFuction colorFromHexRGB:@"959596"] forKeyPath:@"_placeholderLabel.textColor"];
    [self.scrollView addSubview:_mobileTextField];
    
    YOffset += 45;
    
    UIView *textFieldBK = [[UIView alloc] initWithFrame:CGRectMake(12, YOffset-4, SCREEN_WIDTH-24, 0.5)];
    textFieldBK.backgroundColor =[CommonFuction colorFromHexRGB:@"cbcbcb"];
    [self.scrollView addSubview:textFieldBK];
    
    //验证码
    _VerifyCodeTextField = [[UITextField alloc] initWithFrame:CGRectMake(alignX + 12, YOffset, 200, 42)];
    _VerifyCodeTextField.delegate = self;
    _VerifyCodeTextField.borderStyle = UITextBorderStyleNone;
    _VerifyCodeTextField.keyboardType = UIKeyboardTypeNumberPad;
    _VerifyCodeTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    _VerifyCodeTextField.placeholder = @"请输入短信验证码";
    _VerifyCodeTextField.font = [UIFont systemFontOfSize:14];
    _VerifyCodeTextField.textColor = [CommonFuction colorFromHexRGB:@"959596"];
    [_VerifyCodeTextField setValue:[CommonFuction colorFromHexRGB:@"959596"] forKeyPath:@"_placeholderLabel.textColor"];
    [self.scrollView addSubview:_VerifyCodeTextField];
    
    //获取验证码按钮
//    UIImage *normalImg = [CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"ffffff" alpha:0.5] size:CGSizeMake(99, 35)];
//    UIImage *img = [CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"959596"] size:CGSizeMake(99, 35)];
    _getVeryfyCodeBtn = [EWPButton buttonWithType:UIButtonTypeCustom];
    _getVeryfyCodeBtn.tag = 2;
    _getVeryfyCodeBtn.frame = CGRectMake(alignX + 188, YOffset+8, 91, 23);
    [_getVeryfyCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    _getVeryfyCodeBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
 [_getVeryfyCodeBtn setTitleColor:[CommonFuction colorFromHexRGB:@"959596"] forState:UIControlStateNormal];
//    _getVeryfyCodeBtn.layer.masksToBounds = YES;
    _getVeryfyCodeBtn.layer.cornerRadius = 11.5;
    _getVeryfyCodeBtn.layer.borderWidth = 1;
//    [_getVeryfyCodeBtn setBackgroundImage:normalImg forState:UIControlStateNormal];
//    [_getVeryfyCodeBtn setBackgroundImage:img forState:UIControlStateSelected];
    _getVeryfyCodeBtn.layer.borderColor =[CommonFuction colorFromHexRGB:@"dbdbdb"].CGColor;
//    [_getVeryfyCodeBtn setBackgroundImage:[CommonFuction imageWithColor:[UIColor grayColor] size:CGSizeMake(99, 42)] forState:UIControlStateDisabled];
    [self.scrollView addSubview:_getVeryfyCodeBtn];
    
    _getVeryfyCodeBtn.buttonBlock = ^(id sender)
    {
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf performSelector:@selector(getFindpwdCode) withObject:nil];
    };

    
    YOffset += 42;
    
    textFieldBK = [[UIView alloc] initWithFrame:CGRectMake(12, YOffset, SCREEN_WIDTH-24, 0.5)];
    textFieldBK.backgroundColor = [CommonFuction colorFromHexRGB:@"cbcbcb"];
    [self.scrollView addSubview:textFieldBK];
    
    _password = [[UITextField alloc] initWithFrame:CGRectMake(alignX + 12, YOffset+3, 260, 40)];
    _password.secureTextEntry = YES;
    _password.delegate = self;
    _password.layer.borderWidth = 0;
    _password.placeholder = @"设置新密码";
    _password.font = [UIFont systemFontOfSize:14];
    _password.textColor = [CommonFuction colorFromHexRGB:@"959596"];
    [_password setValue:[CommonFuction colorFromHexRGB:@"959596"] forKeyPath:@"_placeholderLabel.textColor"];
    [self.scrollView addSubview:_password];

    YOffset += 45;
    
    textFieldBK = [[UIView alloc] initWithFrame:CGRectMake(12, YOffset, SCREEN_WIDTH-24, 0.5)];
    textFieldBK.backgroundColor = [CommonFuction colorFromHexRGB:@"cbcbcb"];
    [self.scrollView addSubview:textFieldBK];
    
    _confirmPassword = [[UITextField alloc] initWithFrame:CGRectMake(alignX + 12,YOffset+3, 260, 40)];
    _confirmPassword.secureTextEntry = YES;
    _confirmPassword.delegate = self;
    _confirmPassword.layer.borderWidth = 0;
    _confirmPassword.placeholder = @"请再次输入新密码";
    _confirmPassword.font = [UIFont systemFontOfSize:14];
    _confirmPassword.textColor = [CommonFuction colorFromHexRGB:@"959596"];
    [_confirmPassword setValue:[CommonFuction colorFromHexRGB:@"959596"] forKeyPath:@"_placeholderLabel.textColor"];
    [self.scrollView addSubview:_confirmPassword];
    
    YOffset += 45;
    
//    textFieldBK = [[UIView alloc] initWithFrame:CGRectMake(alignX + 10, YOffset, 264, 0.5)];
//    textFieldBK.backgroundColor = [CommonFuction colorFromHexRGB:@"cbcbcb"];
//    [self.scrollView addSubview:textFieldBK];
    
    
    YOffset += 40;
    
    EWPButton *submitBtn = [EWPButton buttonWithType:UIButtonTypeCustom];
    [submitBtn setTitle:@"提交" forState:UIControlStateNormal];

    submitBtn.frame = CGRectMake(alignX + 10, YOffset, 264+8, 40);
    [submitBtn setTitleColor:COLOR_SUBJECT_White forState:UIControlStateNormal];
//    [submitBtn setTitleColor:COLOR_SUBJECTCOLOR forState:UIControlStateHighlighted];
    [submitBtn setBackgroundImage:IMAGE_SUBJECT_SEL(264, 40) forState:UIControlStateHighlighted];
    [submitBtn setBackgroundImage:IMAGE_SUBJECT_NOR(264, 40) forState:UIControlStateNormal];
    submitBtn.titleLabel.font = [UIFont systemFontOfSize:17.0f];
    submitBtn.layer.masksToBounds = YES;
    submitBtn.layer.cornerRadius = 20.0f;
    submitBtn.layer.borderWidth=1;
    submitBtn.layer.borderColor = COLOR_SUBJECTCOLOR.CGColor;
    submitBtn.buttonBlock = ^(id sender)
    {
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf performSelector:@selector(resetPassword) withObject:nil];
    };
    [self.scrollView addSubview:submitBtn];
    
    
     YOffset += 40;
    YOffset += 20;
    
//    UILabel *warnlaber = [[UILabel alloc] initWithFrame:CGRectMake(21, 512/2, 30, 15)];
//    warnlaber.text = @"注:";
//    warnlaber.font = [UIFont systemFontOfSize:12.0f];
//    [self.view addSubview:warnlaber];
    
    
    UILabel *warncontent = [[UILabel alloc] initWithFrame:CGRectMake(21,YOffset+5 , SCREEN_WIDTH - 21 -10 , 60)];
//    warncontent.text = @"注: 只有通过了手机号认证或使用手机号注册的用户才能使用手机号找回密码";
    warncontent.font = [UIFont systemFontOfSize:12.0f];
    warncontent.textColor = [CommonFuction colorFromHexRGB:@"454a4d"];
    warncontent.numberOfLines = 0;
    warncontent.lineBreakMode = NSLineBreakByWordWrapping;
    
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:@"注: 只有通过了手机号认证或使用手机号注册的用户才能使用手机号找回密码"];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:3];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [@"注: 只有通过了手机号认证或使用手机号注册的用户才能使用手机号找回密码" length])];
    [warncontent setAttributedText:attributedString];
    [warncontent sizeToFit];
    
    [self.view addSubview:warncontent];

    
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
    
    self.navigationController.navigationBarHidden = YES;
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
- (void)getFindpwdCode
{
    [_mobileTextField resignFirstResponder];
    [_VerifyCodeTextField resignFirstResponder];
    [_password resignFirstResponder];
    [_confirmPassword resignFirstResponder];
    
    if (![_mobileTextField.text hasPrefix:@"1"] || [_mobileTextField.text length] != 11)
    {
        [self showNoticeInWindow:@"请输入正确的手机号"];
        
        return;
    }

    _getVeryfyCodeBtn.enabled = NO;
    ResetVerifyCodeModel *model = [[ResetVerifyCodeModel alloc] init];
    NSDictionary *param = [NSDictionary dictionaryWithObject:_mobileTextField.text forKey:@"mobile"];
    [model requestDataWithParams:param success:^(id object) {
        _getVeryfyCodeBtn.enabled = YES;
        if (model.result == 0)
        {
            CGRect rect = CGRectMake(175 + 18, 137, 99, 33);
            [self buttonPressed:rect];
            
            [self showNoticeInWindow:@"验证码发送成功"];
        }
        else
        {
            [self showNoticeInWindow:model.msg];
        }
    } fail:^(id object) {
        _getVeryfyCodeBtn.enabled = YES;
        [self showNoticeInWindow:model.msg];
    }];
    
}


#pragma mark UITextFieldDelegate

#pragma mark UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@" "])
    {
        return NO;
    }
    
    
    NSInteger nLimitCount = 6;
    if (textField == _password || textField == _confirmPassword)
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

- (void)resetPassword
{
    //修改成功后，跳转到主页，将登陆状态记录
    [_mobileTextField resignFirstResponder];
    [_VerifyCodeTextField resignFirstResponder];
    [_password resignFirstResponder];
    [_confirmPassword resignFirstResponder];
    
    if ([_mobileTextField.text length] == 0)
    {
        [self showNoticeInWindow:@"请输入手机号"];
        return;
    }
    if (![_mobileTextField.text hasPrefix:@"1"] || [_mobileTextField.text length] != 11)
    {
        [self showNoticeInWindow:@"请输入正确的手机号"];
        
        return;
    }
    
    if ([_VerifyCodeTextField.text length] == 0)
    {
        [self showNoticeInWindow:@"请输入验证码"];
        
        return;
    }

    if ([_password.text length] == 0)
    {
        [self showNoticeInWindow:@"请输入新密码"];
        
        return;
    }
    
    if ([_confirmPassword.text length] == 0)
    {
        [self showNoticeInWindow:@"请输入确认密码"];
        return;
    }
    
    if (![_confirmPassword.text isEqualToString:_password.text])
    {
        [self showNoticeInWindow:@"两次输入密码不正确"];
        
        return;

    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:_mobileTextField.text forKey:@"phone"];
    [params setObject:_VerifyCodeTextField.text forKey:@"smsCode"];
    [params setObject:_password.text forKey:@"password"];

    [self requestDataWithAnalyseModel:[ResetPasswordModel class] params:params success:^(id object) {
        ResetPasswordModel *model = (ResetPasswordModel *)object;
        if (model.result == 0)
        {
            [self showNoticeInWindow:model.msg];
            [self popCanvasWithArgment:nil];
        }
        else
        {
            [self showNoticeInWindow:model.msg];

        }
    } fail:^(id object) {
        
    }];
}
@end
