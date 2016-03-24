//
//  SettingViewController.m
//  BoXiu
//
//  Created by andy on 14-4-25.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "SettingViewController.h"
#import "AppInfo.h"
#import "NewestVersionModel.h"
#import "EWPDialog.h"
#import "ModifyPasswordModel.h"
#import "UserInfoManager.h"
#import "ModifyServerUrlViewController.h"
#import "UMSocial.h"
#import "SettingItemView.h"
#import "MobClick.h"
#import "SetAutoRegistPwdModel.h"
#import "NSString+DES.h"
#import "SystemConfig.h"
#import "SheetButton.h"
#import "LiveRoomViewController.h"

@interface SettingViewController ()<UITextFieldDelegate>

@property (nonatomic,strong) SettingItemView *modifyPasswordItem;
@property (nonatomic,strong) SettingItemView *setStateItm;
@property (nonatomic,strong) SettingItemView *verifyMobileItem;
@property (nonatomic,strong) SettingItemView *identityVerifyItem;
@property (nonatomic,strong) SettingItemView *feedBackItem;
@property (nonatomic,strong) SettingItemView *updateVersionItem;
@property (nonatomic,strong) EWPButton *loginAndExitBtn;

@property (nonatomic,strong) SheetButton *hidesButton;
@property (nonatomic,strong) NewestVersionModel *newestVersionModel;
@property (nonatomic,strong) SettingItemView *userItem;
@property (nonatomic,assign) id hidden;
@property (nonatomic,strong) UISwitch *swi1;
@property (nonatomic,assign) NSUserDefaults *accountDefaults;

@property (nonatomic,strong) EWPSimpleDialog *setPasswordDialog;
@property (nonatomic,strong) UITextField *passwordTextField;

@property (nonatomic,assign) NSInteger hiddenNumber;
@property (nonatomic,strong) UIButton *setbutton;

@property (assign, nonatomic) BOOL setclicked;

@end

@implementation SettingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)setse{
    [[AppInfo shareInstance]refreshCurrentUserInfo:^{
        _hidesButton.hid = YES;

        if ([[UserInfoManager shareUserInfoManager] currentUserInfo].isPurpleVip)
        {
            if([[UserInfoManager shareUserInfoManager] currentUserInfo].hidden == 2)
            {
                [_hidesButton loadFrame];
                _hiddenNumber = 1;
                [_accountDefaults setBool:NO forKey:@"number"];
                [_accountDefaults setBool:YES forKey:@"select"];

            }
            else
            {
                [_accountDefaults setBool:NO forKey:@"select"];
                [_hidesButton initButtonState];
            }
        }

    }];
}
- (void)viewDidLoad
{

    _accountDefaults = [NSUserDefaults standardUserDefaults];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"设置";
    self.view.backgroundColor = [CommonFuction colorFromHexRGB:@"f8f8f8"];
    
    CGFloat nYOffset = 10;
    
    _userItem = [[SettingItemView alloc] initWithFrame:CGRectMake(0, nYOffset, self.view.frame.size.width, 43) title:@"用户名" content:nil];
      [_userItem setViewLine];
    _userItem.isChangeCountFrame = YES;
    [self.view addSubview:_userItem];

//    
//     NSInteger hideSwitch = [[[AppInfo shareInstance].hideSwitch substringFromIndex:1] integerValue];
//    if (hideSwitch != 1) {
//            if ([AppInfo shareInstance].bLoginSuccess)
//            {
//        
//                    nYOffset += 47;
//        
//                    _setStateItm = [[SettingItemView alloc] initWithFrame:CGRectMake(0, nYOffset, self.view.frame.size.width, 43) title:@"隐身设置" content:nil];
//                    _setStateItm.tag = 11;
//                    [_setStateItm setViewLine];
//        //            封装的UISwitch 控件
//                    _hidesButton= [[SheetButton alloc]initWithFrame:CGRectMake(235, 0, 100, 40)];
//                    [_hidesButton addTarget:self action:@selector(hideButtonTypeAudio:)  forControlEvents:UIControlEventTouchUpInside];
//                    _hidesButton.backgroundColor = [UIColor clearColor];
//                    _hidesButton.hid = YES;
//                    [_hidesButton initButtonState];
//                    [self setse];
//        
//                    [_setStateItm addSubview:_hidesButton];
//        
//                    [self.view addSubview:_setStateItm];
//                    [_setStateItm addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnClick:)]];
//                
//            }
//    }else{
//         nYOffset += 3;
//    }
//    
//    


    
    nYOffset += 43;
    _modifyPasswordItem = [[SettingItemView alloc] initWithFrame:CGRectMake(0, nYOffset, self.view.frame.size.width, 43) title:@"修改密码" content:nil];
    [_modifyPasswordItem setViewLine];
    _modifyPasswordItem.tag = 1;
    _modifyPasswordItem.arrowImg = [UIImage imageNamed:@"rightArrow"];
    [self.view addSubview:_modifyPasswordItem];
    [_modifyPasswordItem addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnClick:)]];
    nYOffset += 43;
    
    _verifyMobileItem = [[SettingItemView alloc] initWithFrame:CGRectMake(0, nYOffset, self.view.frame.size.width, 43) title:@"手机绑定" content:nil];
    _verifyMobileItem.tag = 2;
    //        [_verifyMobileItem setViewLine];
    _verifyMobileItem.arrowImg = [UIImage imageNamed:@"rightArrow"];
    [self.view addSubview:_verifyMobileItem];
    [_verifyMobileItem addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnClick:)]];
    //    nYOffset += 47;
    
    _identityVerifyItem = [[SettingItemView alloc] initWithFrame:CGRectMake(0, nYOffset, self.view.frame.size.width, 43) title:@"实名认证" content:nil];
    _identityVerifyItem.tag = 3;
    _identityVerifyItem.arrowImg = [UIImage imageNamed:@"rightArrow"];
    //    [self.view addSubview:_identityVerifyItem];
    [_identityVerifyItem addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnClick:)]];
    nYOffset += 47;
    
    _feedBackItem = [[SettingItemView alloc] initWithFrame:CGRectMake(0, nYOffset, self.view.frame.size.width, 43) title:@"意见反馈" content:nil];
    _feedBackItem.tag = 4;
    [_feedBackItem setViewLine];
    _feedBackItem.arrowImg = [UIImage imageNamed:@"rightArrow"];
    [self.view addSubview:_feedBackItem];
    [_feedBackItem addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnClick:)]];
    nYOffset += 43;
    
    _updateVersionItem = [[SettingItemView alloc] initWithFrame:CGRectMake(0, nYOffset, self.view.frame.size.width, 43) title:@"检测更新" content:nil];
    _updateVersionItem.tag = 5;
    [_updateVersionItem setViewLine];
    _updateVersionItem.arrowImg = [UIImage imageNamed:@"rightArrow"];
    //    [self.view addSubview:_updateVersionItem];
    [_updateVersionItem addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnClick:)]];
    //    nYOffset += 47;
    
    SettingItemView *itemView = [[SettingItemView alloc] initWithFrame:CGRectMake(0, nYOffset, self.view.frame.size.width, 43) title:@"关于我们" content:nil];
    itemView.tag = 6;
    itemView.arrowImg = [UIImage imageNamed:@"rightArrow"];
    [self.view addSubview:itemView];
    [itemView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnClick:)]];
    nYOffset += 43;
    
    nYOffset += 28;
    //登录退出按钮
    UIImage *normalImg = [CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"f6f6f6"] size:CGSizeMake(200, 38)];
    UIImage *highImg = [CommonFuction imageWithColor:COLOR_SUBJECTCOLOR size:CGSizeMake(200, 38)];
    
    _loginAndExitBtn = [EWPButton buttonWithType:UIButtonTypeCustom];
    _loginAndExitBtn.frame = CGRectMake((SCREEN_WIDTH-200)/2, nYOffset, 200, 38);
    [_loginAndExitBtn.layer setMasksToBounds:YES];
    _loginAndExitBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    _loginAndExitBtn.layer.cornerRadius = 19;
    _loginAndExitBtn.layer.masksToBounds = YES;
    _loginAndExitBtn.layer.borderWidth = 1;
    _loginAndExitBtn.layer.borderColor = COLOR_SUBJECTCOLOR.CGColor;
    
    [_loginAndExitBtn setTitleColor:[CommonFuction colorFromHexRGB:@"ffffff"] forState:UIControlStateHighlighted];
    [_loginAndExitBtn setTitleColor:COLOR_SUBJECTCOLOR forState:UIControlStateNormal];
    [_loginAndExitBtn setBackgroundImage:highImg forState:UIControlStateHighlighted];
    [_loginAndExitBtn setBackgroundImage:normalImg forState:UIControlStateNormal];
    [self.view addSubview:_loginAndExitBtn];
    __weak typeof(self) weakSelf = self;
    _loginAndExitBtn.buttonBlock = ^(id sender)
    {
        __strong typeof(self) strongSelf = weakSelf;
        if ([AppInfo shareInstance].bLoginSuccess)
        {
            //要根据第三方登录类型解绑
            if ([AppInfo shareInstance].loginType == 1)
            {
                //qq登录
                [[UMSocialDataService defaultDataService] requestUnOauthWithType:UMShareToQzone  completion:^(UMSocialResponseEntity *response){
                    EWPLog(@"response is %@",response);
                }];
            }
            else if ([AppInfo shareInstance].loginType == 2)
            {
                //sina登录
                [[UMSocialDataService defaultDataService] requestUnOauthWithType:UMShareToSina  completion:^(UMSocialResponseEntity *response){
                    EWPLog(@"response is %@",response);
                }];
            }
            else if([AppInfo shareInstance].loginType == 4)
            {
                //微信登录
                
            }
            
            //退出登录
            if ([UserInfoManager shareUserInfoManager].currentUserInfo.passwordnotset == 1)
            {
                [strongSelf showSetPwdDialog];
            }
            else
            {
                [strongSelf logOut];
            }
        }
        else
        {
            //登录
            NSString *className = NSStringFromClass([strongSelf class]);
            NSDictionary *param = [NSDictionary dictionaryWithObject:className forKey:@"className"];
            [strongSelf pushCanvas:Login_Canvas withArgument:param];
            
        }
    };
    
    __weak typeof(self) weakself = self;
    [self setNavigationBarLeftItem:nil itemNormalImg:[UIImage imageNamed:@"navBack_normal"] itemHighlightImg:nil withBlock:^(id sender) {
        __strong typeof(self) strongself = weakself;
        if (strongself)
        {
            NSString *className = NSStringFromClass([strongself class]);
            NSDictionary *param = [NSDictionary dictionaryWithObject:className forKey:@"className"];
            [strongself popCanvasWithArgment:param];
        }
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    BOOL isTestVersion = [[[NSBundle mainBundle] objectForInfoDictionaryKey:@"Test_Version"] boolValue];
    if (isTestVersion)
    {
        __weak typeof(self) weakSelf = self;
        [self setNavigationBarRightItem:nil itemNormalImg:[UIImage imageNamed:@"right_setting_normal"] itemHighlightImg:[UIImage imageNamed:@"right_setting_high"] withBlock:^(id sender) {
            __strong typeof(self) strongSelf = weakSelf;
            [strongSelf pushCanvas:ChangeServer_Canvas withArgument:nil];
            
        }];
    }
    
    
    if ([AppInfo shareInstance].bLoginSuccess)
    {
        UserInfo *userInfo = [UserInfoManager shareUserInfoManager].currentUserInfo;
        if ([AppInfo shareInstance].loginType == 3)
        {
            _modifyPasswordItem.enable = YES;
            _verifyMobileItem.enable = YES;
            
            NSString *tipStr = @"未绑定";
            if (userInfo.phone && [userInfo.phone length])
            {
                NSMutableString *phoneStr = [NSMutableString stringWithString:[UserInfoManager shareUserInfoManager].currentUserInfo.phone];
                [phoneStr replaceCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
                tipStr = phoneStr;
                [_verifyMobileItem setContentColor:nil];
            } else {
                [_verifyMobileItem setContentColor:[UIColor grayColor]];
            }
            _verifyMobileItem.content = tipStr;
            
        }
        else
        {
            _modifyPasswordItem.enable = NO;
            _verifyMobileItem.enable = NO;
        }
        if (userInfo.authstatus == 0)
        {
            //未认证
            _identityVerifyItem.content = @"未认证";
            [_identityVerifyItem setContentColor:[UIColor redColor]];
        }
        else if (userInfo.authstatus == 1)
        {
            //待审核
            _identityVerifyItem.content = @"正在审核";
            [_identityVerifyItem setContentColor:[UIColor redColor]];
        }
        else if (userInfo.authstatus == 2)
        {
            //审核通过
            _identityVerifyItem.content = @"审核通过";
            [_identityVerifyItem setContentColor:nil];
            
        }
        else if (userInfo.authstatus == 3)
        {
            //审核不通过
            _identityVerifyItem.content = @"审核失败";
            [_identityVerifyItem setContentColor:[UIColor redColor]];
        }
        _identityVerifyItem.enable = YES;
        _feedBackItem.enable = YES;
        [_loginAndExitBtn setTitle:@"退出当前账号" forState:UIControlStateNormal];
        if ([AppInfo shareInstance].loginType == 3)
        {
            _userItem.content = userInfo.loginname;
            
        }
        else
        {
            _userItem.content = @"第三方账号登录";
            
        }
    }
    else
    {
        _identityVerifyItem.enable = NO;
        _feedBackItem.enable = NO;
        _verifyMobileItem.content = nil;
        _verifyMobileItem.enable = NO;
        _modifyPasswordItem.enable = NO;
        
        [_loginAndExitBtn setTitle:@"登录" forState:UIControlStateNormal];
        _userItem.content = @"您还未登录";
    }
    
    NSString *strCurrentVersion = [NSString stringWithFormat:@"当前版本%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
    _updateVersionItem.content = strCurrentVersion;
    
    
    if ([UserInfoManager shareUserInfoManager].currentUserInfo.passwordnotset == 1)
    {
        _modifyPasswordItem.title = @"设置密码";
    }
    else
    {
        _modifyPasswordItem.title = @"修改密码";
    }
    
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 点击隐藏设置按钮
-(void)hideButtonTypeAudio:(SheetButton *)button
{
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    if([[_accountDefaults objectForKey:@"select"] boolValue])
    {
        _hidden = @(1);
        [_accountDefaults setBool:NO forKey:@"select"];
    }
    else
    {
        [_accountDefaults setBool:YES forKey:@"select"];
        _hidden = @(2);
    }
    //    拼接入参
    BaseHttpModel *model = [[BaseHttpModel alloc] init];
    [dict setObject:_hidden forKey:@"hidden"];
    
    [model requestDataWithMethod:InvisibleState_Method params:dict success:^(id object)
     {
         if (model.result == 0)
         {
             button.clicked = !button.clicked;
             if (_hiddenNumber ==1)
             {
                 button.clicked = !button.clicked;
                 _hiddenNumber = 0;
             }
             if([[_accountDefaults objectForKey:@"select"] boolValue ])
             {
                 [[AppInfo shareInstance] showNoticeInWindow:@"隐身设置已开启" duration:1.2];
                 [_accountDefaults setBool:YES forKey:@"select"];
                 NSLog(@"%@",[_accountDefaults objectForKey:@"select"]);
                 
             }
             else
             {
                 
                 [[AppInfo shareInstance] showNoticeInWindow:@"隐身设置已关闭" duration:1.2];
                 [UserInfoManager shareUserInfoManager].hidden = 1;
                 
                 [_accountDefaults setBool:NO forKey:@"select"];
                 NSLog(@"%@",[_accountDefaults objectForKey:@"select"]);
                 
             }
         }
         else
         {
             EWPAlertView *alertView = [[EWPAlertView alloc] initWithTitle:model.title message:model.msg leftBtnTitle:@"确定" rightBtnTitle:@"取消" clickBtnBlock:^(NSInteger nIndex) {
                 if (nIndex == 0)
                 {
                     [self pushCanvas:Mall_Canvas withArgument:nil];
                 }
                 else if(nIndex == 1)
                 {
                     //                  取消不做操作
                 }
             }];
             [alertView show];
         }
     } fail:^(id object)
     {
         [self showNoticeInWindow:@"网络连接失败，请重试" duration:1.5];
     }];
    
}


- (void)OnClick:(UITapGestureRecognizer *)tapGestureRecognizer
{
    SettingItemView *itemView = (SettingItemView *)tapGestureRecognizer.view;
    if (!itemView.enable)
    {
        return;
    }
    
    switch (itemView.tag)
    {
        case 1:
        {
            if ([AppInfo shareInstance].bLoginSuccess)
            {
                //修改密码
                if ([UserInfoManager shareUserInfoManager].currentUserInfo.passwordnotset == 1)
                {
                    [self pushCanvas:AutoRegistSetPwd_Canvas withArgument:nil];
                }
                else
                {
                    [self pushCanvas:Modify_Password_Canvas withArgument:nil];
                }
            }
        }
            break;
        case 2:
        {
            UserInfo *userInfo = [UserInfoManager shareUserInfoManager].currentUserInfo;
            if (userInfo.phone && [userInfo.phone length])
            {
                //[self showNoticeInWindow:@"您的手机号已绑定"];
                [self pushCanvas:Mobile_Certify_Yes_Canvas withArgument:nil];
            }
            else
            {
                //手机号认证
                [self pushCanvas:Mobile_Certify_No_Canvas withArgument:nil];
            }
            
        }
            break;
        case 3:
        {
            //判断是否实名认证，如果未认证，则跳转到到认证页面
            UserInfo *currentUserInfo = [UserInfoManager shareUserInfoManager].currentUserInfo;
            if (currentUserInfo)
            {
                if (currentUserInfo.authstatus == 0 || currentUserInfo.authstatus == 3)
                {
                    //未认证或者审核失败
                    [self pushCanvas:IdentityVerify_Canvas withArgument:nil];
                }
                else
                {
                    //正在审核或者审核成功
                    [self pushCanvas:VerifyResult_Canvas withArgument:nil];
                }
                
            }
            
        }
            break;
        case 4:
        {
            if ([AppInfo shareInstance].bLoginSuccess)
            {
                //意见反馈
                [self pushCanvas:FeedBack_Canvas withArgument:nil];
            }
        }
            break;
        case 5:
        {
            //检测更新
            [self checkUpdate];
        }
            break;
        case 6:
        {
            //关于软件
            [self pushCanvas:About_Canvas withArgument:nil];
        }
        case 11:
        {
            //隐身设置   处理信息
            
            
        }
            break;
        default:
            break;
    }
}

- (void)checkUpdate
{
    [SystemConfig checkUpdate:^(BOOL isNew)
     {
         if (isNew) {
             //trackViewURL = [releaseInfo objectForKey:@"trackVireUrl"];
             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"更新" message:@"有新的版本更新，是否前往更新？" delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:@"更新", nil];
             alert.tag = 10000;
             [alert show];
         }
         else
         {
             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"更新" message:@"此版本为最新版本" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
             alert.tag = 10001;
             [alert show];
         }
     } failed:^{
         
     }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==10000) {
        if (buttonIndex==1) {
            NSURL *url = [NSURL URLWithString:@"https://itunes.apple.com/cn/app/re-boshowtime/id910432518?mt=8"];
            [[UIApplication sharedApplication]openURL:url];
        }
    }
}

#pragma mark __自动注册时推出设置密码提示
-(void)showSetPwdDialog
{
    _setPasswordDialog = [[EWPSimpleDialog alloc] initWithFrame:CGRectMake(0, 0, 271, 194)];
    _setPasswordDialog.layer.borderColor = [UIColor whiteColor].CGColor;
    _setPasswordDialog.backgroundColor = [UIColor whiteColor];
    _setPasswordDialog.layer.cornerRadius = 4.0f;
    _setPasswordDialog.layer.borderWidth = 1.0f;
    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(225, 5, 40, 40)];
    [closeBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeDialog) forControlEvents:UIControlEventTouchUpInside];
    [_setPasswordDialog addSubview:closeBtn];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(19, 31, 200, 40)];
    titleLabel.text = @"亲，为了保障您的账号资金安全，赶紧设置密码吧！";
    
    titleLabel.numberOfLines = 0;
    titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    titleLabel.textColor = [CommonFuction colorFromHexRGB:@"575757"];
    titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    [_setPasswordDialog addSubview:titleLabel];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(5, 0, 8, 35)];
    _passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(19, 80, 232, 35)];
    _passwordTextField.placeholder = @"密码4-16位字符";
    _passwordTextField.delegate = self;
    _passwordTextField.font = [UIFont systemFontOfSize:15.0f];
    _passwordTextField.secureTextEntry = YES;
    _passwordTextField.layer.borderWidth = 0.5;
    _passwordTextField.layer.borderColor = [CommonFuction colorFromHexRGB:@"cbcbcb"].CGColor;
    _passwordTextField.backgroundColor = [UIColor whiteColor];
    _passwordTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _passwordTextField.leftViewMode = UITextFieldViewModeAlways;
    _passwordTextField.leftView = view;
    [_setPasswordDialog addSubview:_passwordTextField];
    
    UIImage *normalImg = [CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"d14c49"] size:CGSizeMake(232, 41)];
    //    UIImage *selectImg = [CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"ffffff"] size:CGSizeMake(232, 41)];
    UIButton *commitBtn = [[UIButton alloc] initWithFrame:CGRectMake(19, 130, 232, 41)];
    [commitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [commitBtn setTitleColor:[CommonFuction colorFromHexRGB:@"ffffff"] forState:UIControlStateNormal];
    [commitBtn setTitleColor:[CommonFuction colorFromHexRGB:@"d14c49"] forState:UIControlStateHighlighted];
    [commitBtn setBackgroundImage:normalImg forState:UIControlStateNormal];
    [commitBtn setBackgroundImage:IMAGE_SUBJECT_SEL(232, 14) forState:UIControlStateHighlighted];
    commitBtn.layer.masksToBounds = YES;
    commitBtn.layer.borderWidth = 1.0;
    commitBtn.layer.cornerRadius = 20.5f;
    commitBtn.layer.borderColor = [CommonFuction colorFromHexRGB:@"d14c49"].CGColor;
    [commitBtn addTarget:self action:@selector(commitPassword) forControlEvents:UIControlEventTouchUpInside];
    [_setPasswordDialog addSubview:commitBtn];
    
    [_setPasswordDialog showInWindow];
}


-(void)closeDialog
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    
    [_setPasswordDialog hide];
}

-(void)commitPassword
{
    EWPLog(@"提交密码");
    [_passwordTextField resignFirstResponder];
    
    if ([_passwordTextField.text length] < 4 || [_passwordTextField.text length] > 16)
    {
        [self showNoticeInWindow:@"密码长度4-16位,请重新输入"];
        return;
    }
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[[ReXiuLib shareInstance] DESEncryptWithKey:self.passwordTextField.text] forKey:@"newPwd"];
    
    __weak typeof(self) weakSelf = self;
    [self requestDataWithAnalyseModel:[SetAutoRegistPwdModel class] params:dict success:^(id object)
     {
         /*成功返回数据*/
         __strong typeof(self) strongSelf = weakSelf;
         SetAutoRegistPwdModel *model = object;
         if (model.result == 0)
         {
             [_setPasswordDialog hide];
             [strongSelf logOut];
         }else if (model.code == 403){
             [self showOherTerminalLoggedDialog];
         }
         else
         {
             [self showNoticeInWindow:model.msg];
         }
     }
                                 fail:^(id object)
     {
         /*失败返回数据*/
     }];
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@" "])
    {
        return NO;
    }
    
    if (range.location >= 16)
    {
        return NO;
    }
    
    return YES;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}

#pragma mark - 退出
- (void)logOut
{
    [[AppInfo shareInstance] loginOut];
    NSString *className = NSStringFromClass([self class]);
    NSDictionary *param = [NSDictionary dictionaryWithObject:className forKey:@"className"];
    //    [self popCanvasWithArgment:param];
    [self popToRootCanvasWithArgment:param];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"refashHead" object:nil];

}
@end
