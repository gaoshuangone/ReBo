//
//  MobileCertifyViewController.m
//  BoXiu
//
//  Created by andy on 14-8-21.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "MobileCertifyViewController.h"
#import "BindVerifyCodeModel.h"
#import "RegexKitLite.h"
#import "BindMobileModel.h"
#import "UserInfoManager.h"

@interface MobileCertifyViewController ()<UITextFieldDelegate>
@property (nonatomic,strong) UITextField *mobileTextField;
@property (nonatomic,strong) UITextField *VerifyCodeTextField;
@property (nonatomic,strong) UIButton *getVeryfyCodeBtn;

@end

@implementation MobileCertifyViewController

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
    self.title = @"手机绑定";
    
    
    CGFloat alignX = 18;
    CGFloat YOffset = 200;
    CGFloat YSpace = 8;
    
//    点击空白区域隐藏键盘
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tap1.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap1];
    
    self.scrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT + 23);
    
    UIImageView *phone=[[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 196 )/2, (YOffset - 167)/2, 196 , 167)];
    [phone setImage:[UIImage imageNamed:@"NoTied"]];
    [self.scrollView addSubview:phone];
    
    //真实手机号
    UIView *textFieldBK = [[UIView alloc] initWithFrame:CGRectMake(alignX, YOffset, 284, 40)];
    textFieldBK.backgroundColor = [UIColor whiteColor];
    _mobileTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, 274, 40)];
    _mobileTextField.delegate = self;
    _mobileTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    _mobileTextField.keyboardType = UIKeyboardTypeNumberPad;
    _mobileTextField.placeholder = @"请输入真实的手机号";
    _mobileTextField.font = [UIFont systemFontOfSize:14.0f];
    _mobileTextField.textColor = [CommonFuction colorFromHexRGB:@"575757"];
    [textFieldBK addSubview:_mobileTextField];
    [self.scrollView addSubview:textFieldBK];
    YOffset += 42;
    YOffset += YSpace;
    
    //验证码
    textFieldBK = [[UIView alloc] initWithFrame:CGRectMake(alignX, YOffset, 180+25, 40)];
    textFieldBK.backgroundColor = [UIColor whiteColor];
    _VerifyCodeTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, 170, 40)];
    _VerifyCodeTextField.delegate = self;
    _VerifyCodeTextField.keyboardType = UIKeyboardTypeASCIICapable;
    _VerifyCodeTextField.autocorrectionType = UIKeyboardTypeNumberPad;
    _VerifyCodeTextField.placeholder = @"请输入短信验证码";
    _VerifyCodeTextField.font = [UIFont systemFontOfSize:14.0f];
    _VerifyCodeTextField.textColor = [CommonFuction colorFromHexRGB:@"575757"];
    [textFieldBK addSubview:_VerifyCodeTextField];
    [self.scrollView addSubview:textFieldBK];
    
    UIImage *normalImg = [CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"d14c49"] size:CGSizeMake(99, 40)];
    UIImage *selectImg = [CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"ffffff"] size:CGSizeMake(99, 40)];
    //获取验证码按钮 18 + 180 + 5 , 250 , 99, 40
    _getVeryfyCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _getVeryfyCodeBtn.tag = 2;
    _getVeryfyCodeBtn.frame = CGRectMake(alignX + 180+25 + 5, YOffset, 99-25, 40);
    [_getVeryfyCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    _getVeryfyCodeBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [_getVeryfyCodeBtn setBackgroundImage:normalImg forState:UIControlStateNormal];
    [_getVeryfyCodeBtn setBackgroundImage:selectImg forState:UIControlStateSelected];
    [_getVeryfyCodeBtn setTitleColor:[CommonFuction colorFromHexRGB:@"ffffff"] forState:UIControlStateNormal];
    [_getVeryfyCodeBtn setTitleColor:[CommonFuction colorFromHexRGB:@"d14c49"] forState:UIControlStateHighlighted];
    [self.scrollView addSubview:_getVeryfyCodeBtn];
    [_getVeryfyCodeBtn addTarget:self action:@selector(getCode) forControlEvents:UIControlEventTouchUpInside];
    YOffset += 40;
    YOffset += 20;
    
    normalImg = [CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"f7c250"] size:CGSizeMake(264, 40)];
    selectImg = [CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"ffffff"] size:CGSizeMake(264, 40)];
    
    __weak typeof(self) weakSelf = self;
    EWPButton *submitBtn = [EWPButton buttonWithType:UIButtonTypeCustom];
    [submitBtn setTitle:@"立即绑定" forState:UIControlStateNormal];
    [submitBtn setTitleColor:[CommonFuction colorFromHexRGB:@"ffffff"] forState:UIControlStateNormal];
    [submitBtn setTitleColor:[CommonFuction colorFromHexRGB:@"f7c250"] forState:UIControlStateSelected];
    [submitBtn setBackgroundImage:normalImg forState:UIControlStateNormal];
    [submitBtn setBackgroundImage:selectImg forState:UIControlStateSelected];
    submitBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    submitBtn.layer.masksToBounds = YES;
    submitBtn.layer.cornerRadius = 20;
    submitBtn.layer.borderWidth = 1.1f;
    submitBtn.layer.borderColor = [CommonFuction colorFromHexRGB:@"f7c250"].CGColor;
    submitBtn.frame = CGRectMake(alignX + 10, YOffset , 264, 40);
    submitBtn.buttonBlock = ^(id sender)
    {
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf performSelector:@selector(OnCertify) withObject:nil];
    };
    [self.scrollView addSubview:submitBtn];
    
    UILabel *warnlaber = [[UILabel alloc] initWithFrame:CGRectMake(21, YOffset + 50+8,  45, 13)];
    warnlaber.font = [UIFont systemFontOfSize:12.f];
    warnlaber.textColor = [CommonFuction colorFromHexRGB:@"454a4d"];
    warnlaber.text = @"说明:";
    [self.scrollView addSubview:warnlaber];
    NSString* str =@"绑定后你可以直接使用手机号登录热波间以保障账号安全。你的手机号将严格保密，不会泄露给第三方！";
    UILabel *warncontent = [[UILabel alloc] initWithFrame:CGRectMake(21, YOffset + 45 + 12+13+7, SCREEN_WIDTH - 21 - 10, 43)];
    warncontent.font = [UIFont systemFontOfSize:12.0f];
    warncontent.textColor = [CommonFuction colorFromHexRGB:@"575757"];
    warncontent.numberOfLines = 0;
    warncontent.lineBreakMode = NSLineBreakByWordWrapping;
//    warncontent.text = @"说明: 绑定后你可以直接使用手机号登陆热波ST以保障账号安全。你的手机号将严格保密，不会泄露给第三方！";
    
    
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:str];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:3];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [str length])];
    [warncontent setAttributedText:attributedString];
    [warncontent sizeToFit];
    warncontent.lineBreakMode = NSLineBreakByWordWrapping;
    
    [self.scrollView addSubview:warncontent];
    
}

-(void)viewTapped:(UITapGestureRecognizer*)tap1
{
    self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.view endEditing:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillShow:(NSNotification *)notification {
    
    NSDictionary *userInfo = [notification userInfo];
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    //键盘的大小
    CGSize keyboardRect = [aValue CGRectValue].size;
    [self moveInputBarWithKeyboardHeight:keyboardRect.height withDuration:animationDuration];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    NSDictionary* userInfo = [notification userInfo];
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    //键盘的大小
    CGSize keyboardRect = [aValue CGRectValue].size;
    
    [self moveInputBarWithKeyboardHeight:-keyboardRect.height withDuration:animationDuration];
}

- (void)moveInputBarWithKeyboardHeight:(float)keyboardHeight withDuration:(NSTimeInterval)animationDuration
{
    
//    [UIView animateWithDuration:animationDuration delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, self.scrollView.frame.size.height + keyboardHeight);
//    } completion:^(BOOL finished) {
//    }];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(CGFloat)keyboardEndingFrameHeight:(NSDictionary *)userInfo//计算键盘的高度

{
    
    CGRect keyboardEndingUncorrectedFrame = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue];
    
    CGRect keyboardEndingFrame = [self.view convertRect:keyboardEndingUncorrectedFrame fromView:nil];
    
    return keyboardEndingFrame.size.height;
    
}


- (void)OnCertify
{
    [_mobileTextField resignFirstResponder];
    [_VerifyCodeTextField resignFirstResponder];
    
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
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    [parmas setObject:_mobileTextField.text forKey:@"phone"];
    [parmas setObject:_VerifyCodeTextField.text forKey:@"smsCode"];
    __weak typeof(self) weakSelf = self;
    [self requestDataWithAnalyseModel:[BindMobileModel class] params:parmas success:^(id object) {
        __strong typeof(self) strongSelf = weakSelf;
        BindMobileModel *model = (BindMobileModel *)object;
        if (model.result == 0)
        {
            [strongSelf showNoticeInWindow:@"手机号认证成功"];
            
            [UserInfoManager shareUserInfoManager].currentUserInfo.phone = _mobileTextField.text;
            
//            [strongSelf performSelector:@selector(popCanvasWithArgment:) withObject:nil afterDelay:0];
            [self pushCanvas:Mobile_Certify_Yes_Canvas withArgument:nil];

        }
        else
        {
            if (model.code == 403) {
                [[AppInfo shareInstance] loginOut];
                [self showOherTerminalLoggedDialog];
            }else{
            
           
            [strongSelf showNoticeInWindow:model.msg];
            }
        }
    } fail:^(id object){
        
    }];
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

- (void)getCode
{
    [_mobileTextField resignFirstResponder];
    [_VerifyCodeTextField resignFirstResponder];
    self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    
    if (![_mobileTextField.text hasPrefix:@"1"] || [_mobileTextField.text length] != 11)
    {
        [self showNoticeInWindow:@"请输入正确的手机号"];
        
        return;
    }
    
    _getVeryfyCodeBtn.enabled = NO;
    BindVerifyCodeModel *model = [[BindVerifyCodeModel alloc] init];
    NSDictionary *param = [NSDictionary dictionaryWithObject:_mobileTextField.text forKey:@"mobile"];
    [model requestDataWithParams:param success:^(id object) {
        _getVeryfyCodeBtn.enabled = YES;
        if (model.result == 0)
        {
            [self showNoticeInWindow:@"验证码发送成功"];
            
            CGRect rect = CGRectMake(13 + 180 + 10, 250, 99, 42);
            [self buttonPressed:rect];
        }
        else
        {
            [self showNoticeInWindow:model.msg];
        }
    } fail:^(id object) {
        _getVeryfyCodeBtn.enabled = YES;
    }];
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
        self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == _mobileTextField)
    {
        self.scrollView.contentInset = UIEdgeInsetsMake(-100, 0, 0, 0);
    }
    else if (textField == _VerifyCodeTextField)
    {
        self.scrollView.contentInset = UIEdgeInsetsMake(-140, 0, 0, 0);
    }
}

#pragma mark UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@" "])
    {
        return NO;
    }
    
    if (textField == _mobileTextField)
    {
        if (range.location >= 11)
        {
            [_mobileTextField resignFirstResponder];
            return NO;
        }
    }
    else if (textField == _VerifyCodeTextField)
    {
        if (range.location >= 6)
        {
            [_VerifyCodeTextField resignFirstResponder];
            return NO;
        }
    }
    
    return YES;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    [textField resignFirstResponder];
    return NO;
}

@end

