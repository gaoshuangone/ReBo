//
//  LoginViewController.m
//  BoXiu
//
//  Created by andy on 14-4-25.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginModel.h"
#import "AppInfo.h"
#import "UserInfoManager.h"
#import "ResetPasswordViewController.h"
#import "UMSocial.h"
#import "BThirdLoginModel.h"
#import "ThirdLoginModel.h"
#import "NSString+DES.h"
#import "EWPIconButtonView.h"
#import "UMessage.h"
#import "WXApi.h"
#import "LeftMenuViewController.h"
#import "UIPopoverListView.h"
#import "RightMenuCell.h"
#import "LiveRoomHelper.h"
@interface LoginViewController ()<UITextFieldDelegate,UIPopoverListViewDataSource,UIPopoverListViewDelegate>

@property (nonatomic,strong) UITextField *accountTextField;
@property (nonatomic,strong) UITextField *passwordTextField;
@property (nonatomic,strong) EWPButton *loginBtn;
@property (nonatomic,assign) BOOL enterFromSetting;

@property (nonatomic,strong) UIPopoverListView *poplistview;
@property (strong, nonatomic) NSMutableArray* plistArray;

@end



@implementation LoginViewController

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
//    self.title = @"登录";
    
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
    
    
  
    
    CGFloat alignX = 8;
    CGFloat YOffset = 68+33;
    CGFloat YSpace = 20;
    
    __weak typeof(self) weakSelf = self;
    
    EWPButton *backBtn = [EWPButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(10, 32, 30, 24);
    [backBtn setImage:[UIImage imageNamed:@"navBack_normal"] forState:UIControlStateNormal];
    backBtn.buttonBlock = ^(id sender)
    {
        __strong typeof(self) strongSelf = weakSelf;
        if (strongSelf)
        {  NSString *className = NSStringFromClass([strongSelf class]);
            NSDictionary *param = [NSDictionary dictionaryWithObject:className forKey:@"className"];
            
            
    
//            [AppInfo shareInstance].lastFromeClass = @"PersonInfoViewController";
        
            
            if ([AppInfo shareInstance].isNeedReturnMain && [[AppInfo shareInstance].shouldPushToClass isEqualToString:@"MainViewController"]) {
                [AppInfo shareInstance].isNeedReturnMain = NO;
                [strongSelf popToRootCanvasWithArgment:param];
            }else{
            
          
            [strongSelf popCanvasWithArgment:param];
            }
        }

    };

    [self.view addSubview:backBtn];

    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-20, 40-3, 50, 15)];
    titleLabel.text = @"登录";
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textColor = [CommonFuction colorFromHexRGB:@"454a4d"];
    [self.view addSubview:titleLabel];
    
    
    UIControl* viewBK = [[UIControl alloc]initWithFrame:CGRectMake(0, 68+33, SCREEN_WIDTH, 43*2)];
    viewBK.backgroundColor = [CommonFuction colorFromHexRGB:@"ffffff"];
    [self.scrollView addSubview:viewBK];
    
    
    UIImageView *userImge = [[UIImageView alloc] initWithFrame:CGRectMake(alignX + 16, YOffset + 10, 22, 22)];
    userImge.image = [UIImage imageNamed:@"shoujiLog"];
    [self.scrollView addSubview:userImge];
    
    _accountTextField = [[UITextField alloc] initWithFrame:CGRectMake(alignX + 45, YOffset+3, 224, 39)];
    _accountTextField.delegate = self;
    _accountTextField.borderStyle = UITextBorderStyleNone;
    _accountTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    _accountTextField.placeholder = @"用户名/手机号码";
    _accountTextField.font = [UIFont systemFontOfSize:13.0f];
    _accountTextField.textColor = [CommonFuction colorFromHexRGB:@"959595"];
    [_accountTextField setValue:[CommonFuction colorFromHexRGB:@"959595"] forKeyPath:@"_placeholderLabel.textColor"];
    if([[AppInfo shareInstance] getSavedLoginName])
    {
        _accountTextField.text = [[AppInfo shareInstance] getSavedLoginName];
    }

    
    [self.scrollView addSubview:_accountTextField];
    YOffset += 44.5;

    UIImageView *lineImge = [[UIImageView alloc] initWithFrame:CGRectMake(12, YOffset, SCREEN_WIDTH-24, 0.5)];
    lineImge.backgroundColor = [CommonFuction colorFromHexRGB:@"cbcbcb"];
    [self.scrollView addSubview:lineImge];
    YOffset += 1;
    
    UIImageView *pwdImge = [[UIImageView alloc] initWithFrame:CGRectMake(alignX + 16, YOffset  +5, 22, 22)];
    pwdImge.image = [UIImage imageNamed:@"suoLog"];
    [self.scrollView addSubview:pwdImge];
    
    _passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(alignX + 45, YOffset, 224, 39)];
    _passwordTextField.delegate = self;
    _passwordTextField.borderStyle = UITextBorderStyleNone;
    _passwordTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    _passwordTextField.placeholder = @"密码";
    _passwordTextField.font = [UIFont systemFontOfSize:13.0f];
    _passwordTextField.textColor = [CommonFuction colorFromHexRGB:@"959595"];
    [_passwordTextField setValue:[CommonFuction colorFromHexRGB:@"959595"] forKeyPath:@"_placeholderLabel.textColor"];
    _passwordTextField.secureTextEntry = YES;
    [self.scrollView addSubview:_passwordTextField];
    
    YOffset += 39;
    
    lineImge = [[UIImageView alloc] initWithFrame:CGRectMake(alignX + 17, YOffset, 264, 0.5)];
    lineImge.backgroundColor = [CommonFuction colorFromHexRGB:@"ffffff"];
    [self.scrollView addSubview:lineImge];
    YOffset += 1;
    
  
    YOffset += YSpace;
    
    EWPButton *forgetPasswordBtn = [EWPButton buttonWithType:UIButtonTypeCustom];
    forgetPasswordBtn.frame = CGRectMake(self.view.frame.size.width - alignX - 85-10, YOffset-1, 80, 20);
    [forgetPasswordBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    forgetPasswordBtn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    [forgetPasswordBtn setTitleColor:[CommonFuction colorFromHexRGB:@"454a4d"]forState:UIControlStateNormal];
//    [forgetPasswordBtn setTitleColor:[CommonFuction colorFromHexRGB:@"ffffff"] forState:UIControlStateNormal];
    [self.scrollView addSubview:forgetPasswordBtn];
    YOffset += 20;
    YOffset += YSpace;
    forgetPasswordBtn.buttonBlock = ^(id sender)
    {
      //跳转到手机找回密码界面
        [self pushCanvas:NSStringFromClass([ResetPasswordViewController class]) withArgument:nil];
    };
    
    lineImge = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width - alignX - 76-10, YOffset-19, 62, 0.5)];
    lineImge.backgroundColor = [CommonFuction colorFromHexRGB:@"454a4d"];
    [self.scrollView addSubview:lineImge];
    

    _loginBtn = [[EWPButton alloc] initWithFrame:CGRectMake(alignX + 17, YOffset, 264, 40)];
    [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
       _loginBtn.titleLabel.textColor = [CommonFuction colorFromHexRGB:@"ffffff"];
    [_loginBtn setBackgroundImage:IMAGE_SUBJECT_NOR(264, 40) forState:UIControlStateNormal];
    [_loginBtn setBackgroundImage:IMAGE_SUBJECT_SEL(264, 40) forState:UIControlStateHighlighted];
    _loginBtn.layer.masksToBounds = YES;
    _loginBtn.titleLabel.font = [UIFont systemFontOfSize:17.0f];
//    _loginBtn.layer.borderColor = [CommonFuction colorFromHexRGB:@"d14c49"].CGColor;
//    _loginBtn.layer.borderWidth=1;
    _loginBtn.layer.cornerRadius = 20.0f;
    [self.scrollView addSubview:_loginBtn];
    YOffset += 40;
    YOffset += 12.5;
    
    [_loginBtn setButtonBlock:^(id sender)
     {
         __strong typeof(self) strongSelf = weakSelf;
         [strongSelf performSelector:@selector(loginWithLoginName) withObject:nil];
     }];

    EWPButton *registBtn = [[EWPButton alloc] initWithFrame:CGRectMake(alignX + 17, YOffset, 264, 40)];
    [registBtn setTitle:@"注册" forState:UIControlStateNormal];

    [registBtn setTitleColor:COLOR_SUBJECT_White forState:UIControlStateHighlighted];
    [registBtn setTitleColor:COLOR_SUBJECTCOLOR forState:UIControlStateNormal];
    [registBtn setBackgroundImage:IMAGE_WHITE(264, 40) forState:UIControlStateNormal];
    [registBtn setBackgroundImage:IMAGE_SUBJECT_NOR(264, 40) forState:UIControlStateHighlighted];
    registBtn.backgroundColor =[CommonFuction colorFromHexRGB:@"d14c49"];
    registBtn.titleLabel.font = [UIFont systemFontOfSize:17.0f];
    registBtn.layer.masksToBounds = YES;
    registBtn.layer.cornerRadius = 20.0f;
    registBtn.layer.borderWidth=1;
    registBtn.layer.borderColor = COLOR_SUBJECTCOLOR.CGColor;
    [self.scrollView addSubview:registBtn];
    YOffset += 42;
    [registBtn setButtonBlock:^(id sender)
     {
         __strong typeof(self) strongSelf = weakSelf;
         [strongSelf pushCanvas:Register_Canvas withArgument:nil];
     }];
    
    
    YOffset += 70;
    
    CGFloat dis =10;
    
    UIImageView *lineImg = [[UIImageView alloc] initWithFrame:CGRectMake(28, self.view.bounds.size.height - 83+dis+5, 70, 0.5)];
    lineImg.image = [CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"cbcbcb"] size:CGSizeMake(65, 0.5)];
    
    NSInteger hideSwitch = [[[AppInfo shareInstance].hideSwitch substringToIndex:1] integerValue];
    if (hideSwitch != 1)
    {
       [self.view addSubview:lineImg]; 
    }
    
    UILabel *thirdAccount = [[UILabel alloc] initWithFrame:CGRectMake(113, self.view.bounds.size.height - 93+dis+5, 120, 20)];
    thirdAccount.textColor =[CommonFuction colorFromHexRGB:@"454a4d"];
    thirdAccount.text = @"第三方账号登录";
    thirdAccount.font = [UIFont systemFontOfSize:13.0f];
    if (hideSwitch != 1)
    {
        [self.view addSubview:thirdAccount];
    }

    UIImageView *lineImg2 = [[UIImageView alloc] initWithFrame:CGRectMake(215, self.view.bounds.size.height - 83+dis+5, 70, 0.5)];
    lineImg2.image = [CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"cbcbcb"] size:CGSizeMake(65, 0.5)];
    if (hideSwitch != 1)
    {
        [self.view addSubview:lineImg2];
    }
    
    YOffset += 26;
    
    
    EWPButton *qqBtn = [EWPButton buttonWithType:UIButtonTypeCustom];
    qqBtn.isSoonCliCKLimit = YES;
    qqBtn.frame = CGRectMake(SCREEN_WIDTH/2 - 100, self.view.bounds.size.height - 50+dis-5, 40, 40);
    [qqBtn setBackgroundImage:[UIImage imageNamed:@"QQlogED.png"] forState:UIControlStateNormal];
     [qqBtn setBackgroundImage:[UIImage imageNamed:@"QQlog.png"] forState:UIControlStateHighlighted];
    [qqBtn addTarget:self action:@selector(loginWithQQ) forControlEvents:UIControlEventTouchUpInside];
    if (hideSwitch != 1)
    {
        [self.view addSubview:qqBtn];
    }
    
    
    EWPButton *weixinBtn = [EWPButton buttonWithType:UIButtonTypeCustom];
        qqBtn.isSoonCliCKLimit = YES;
    weixinBtn.frame = CGRectMake(SCREEN_WIDTH/2 - 24, self.view.bounds.size.height - 50+dis-5, 40, 40);
    [weixinBtn setBackgroundImage:[UIImage imageNamed:@"WeiXinLogED.png"] forState:UIControlStateNormal];
     [weixinBtn setBackgroundImage:[UIImage imageNamed:@"WeiXinLog.png"] forState:UIControlStateHighlighted];
    [weixinBtn addTarget:self action:@selector(loginWithWx) forControlEvents:UIControlEventTouchUpInside];
    if (hideSwitch != 1)
    {
        [self.view addSubview:weixinBtn];
    }

    
    
    EWPButton *sinaWeiboBtn = [EWPButton buttonWithType:UIButtonTypeCustom];
        qqBtn.isSoonCliCKLimit = YES;
    sinaWeiboBtn.frame = CGRectMake(SCREEN_WIDTH/2 + 55, self.view.bounds.size.height - 50+dis-5, 40, 40);
    [sinaWeiboBtn setBackgroundImage:[UIImage imageNamed:@"weiBoLogED.png"] forState:UIControlStateNormal];
     [sinaWeiboBtn setBackgroundImage:[UIImage imageNamed:@"weiBoLog.png"] forState:UIControlStateHighlighted];
    [sinaWeiboBtn addTarget:self action:@selector(loginWithSina) forControlEvents:UIControlEventTouchUpInside];
    if (hideSwitch != 1)
    {
        [self.view addSubview:sinaWeiboBtn];
    }
    
    BOOL isTestVersion = [[[NSBundle mainBundle] objectForInfoDictionaryKey:@"Test_Version"] boolValue];
    if (isTestVersion)
    {
             __weak typeof(self) weakSelf = self;
        
        EWPButton *backBtn = [EWPButton buttonWithType:UIButtonTypeCustom];
        backBtn.frame = CGRectMake(SCREEN_WIDTH-10-50, 32, 50, 24);
//        [backBtn setImage:[UIImage imageNamed:@"navBack_normal"] forState:UIControlStateNormal];
        [backBtn setTitle:@"切换" forState:UIControlStateNormal];
        [backBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        backBtn.buttonBlock = ^(id sender)
        {
       
            if (_poplistview !=nil) {
                [_poplistview dismiss];
                _poplistview = nil;
                return ;
            }
            
            _poplistview = [[UIPopoverListView alloc] initWithFrame:CGRectMake(10, 64, SCREEN_WIDTH-20, SCREEN_HEIGHT-200)];
            _poplistview.listView.separatorStyle = UITableViewCellSeparatorStyleNone;
            _poplistview.layer.cornerRadius = 8.0f;
            _poplistview.backgroundColor = [UIColor colorWithWhite:0 alpha:0.35];
            _poplistview.delegate = self;
            _poplistview.datasource = self;
            [weakSelf.view addSubview:_poplistview];
            
            
            
            NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Test_User_Property List" ofType:@"plist"];
            NSMutableArray *data = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
            NSLog(@"%@", data);//直接打印数据。
            
            
            NSLog(@"%ld",[AppInfo shareInstance].serverType);
            
            
            
            if ( [AppInfo shareInstance].serverType==5) {
                weakSelf.plistArray = [NSMutableArray arrayWithArray:[data objectAtIndex:1]];
            }else{
                weakSelf.plistArray = [NSMutableArray arrayWithArray:[data objectAtIndex:0]];
            }

            
        };
        
        [self.view addSubview:backBtn];

        
        
        
    
       
    }
}




#pragma mark - UIPopoverListViewDataSource

- (UITableViewCell *)popoverListView:(UIPopoverListView *)popoverListView
                    cellForIndexPath:(NSIndexPath *)indexPath
{
    static NSString *menuCellIdentifier = @"menuCell";
    RightMenuCell *cell = [popoverListView.listView dequeueReusableCellWithIdentifier:menuCellIdentifier];
    if (cell == nil)
    {
        cell = [[RightMenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:menuCellIdentifier];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    cell.textLabel.text = [[self.plistArray objectAtIndex:indexPath.row] valueForKey:@"name"];
    UIView *selectedBKView = [[UIView alloc] initWithFrame:cell.bounds];
    selectedBKView.backgroundColor = [CommonFuction colorFromHexRGB:@"f7c250"];
    cell.selectedBackgroundView = selectedBKView;
    

    cell.backgroundColor = [UIColor colorWithWhite:0 alpha:0.35];
    return cell;
}

- (NSInteger)popoverListView:(UIPopoverListView *)popoverListView
       numberOfRowsInSection:(NSInteger)section
{
    return [self.plistArray count];
 
}

#pragma mark - UIPopoverListViewDelegate
- (void)popoverListView:(UIPopoverListView *)popoverListView
     didSelectIndexPath:(NSIndexPath *)indexPath
{
 
 
    self.accountTextField.text = [[self.plistArray objectAtIndex:indexPath.row] valueForKey:@"name"];
    self.passwordTextField.text = [[self.plistArray objectAtIndex:indexPath.row] valueForKey:@"psd"];

}

- (CGFloat)popoverListView:(UIPopoverListView *)popoverListView
   heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return 38.0f;
    }
    return 33.0f;
}

#pragma mark 点击弹出菜单选项
- (void)popupMenuIndex:(NSInteger)index userInfo:(UserInfo *)userInfo
{
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

- (void)argumentForCanvas:(id)argumentData
{
    if (argumentData && [argumentData isKindOfClass:[NSDictionary class]])
    {
        NSDictionary *param = (NSDictionary *)argumentData;
        NSString *className = [param objectForKey:@"className"];
        if (className && [className isEqualToString:Setting_Canvas])
        {
            self.enterFromSetting = YES;
        }
    }
}

- (void)loginWithLoginName
{
    // [weakSelf.rootViewController popCanvasWithArgment:nil];
    [_accountTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
    
    if (_accountTextField.text == nil || [_accountTextField.text length] == 0)
    {
        [self showNoticeInWindow:@"请输入用户名/手机号"];
        return;
    }
    
    if (_passwordTextField.text == nil || [_passwordTextField.text length] == 0)
    {
        [self showNoticeInWindow:@"请输入密码"];
        return;
    }
    
    //登录等待动画
    [self startAnimating];
    __weak typeof(self) weakSelf = self;
    [[AppInfo shareInstance] loginWithUserName:_accountTextField.text password:_passwordTextField.text success:^{
        [self stopAnimating];
        __strong typeof(self) strongSelf = weakSelf;
        if (strongSelf)
        {
//            登录后跳转
//            [ self .navigationController popToRootViewControllerAnimated: YES ];
            
            
            
         
            NSString *canvasName = NSStringFromClass([self class]);
            NSDictionary *param = [NSDictionary dictionaryWithObject:canvasName forKey:@"className"];
            [strongSelf popCanvasWithArgment:param];
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"ReLogin" object:self];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"ShowLiveBtnOnMain" object:self userInfo:nil];

        }
    } fail:^(NSString *erroMessage) {
        
        __strong typeof(self) strongSelf = weakSelf;
        if (strongSelf)
        {
            [strongSelf stopAnimating];
            if (erroMessage)
            {
                [strongSelf showNoticeInWindow:erroMessage];
            }
        }

        
    }];
}

- (void)loginWithQQ
{
    [LiveRoomHelper canleOauthsWithType:@[UMShareToQQ]];
  
    BOOL isOauth = [UMSocialAccountManager isOauthWithPlatform:UMShareToQQ];
    if (isOauth)
    {
        [[UMSocialDataService defaultDataService] requestSocialAccountWithCompletion:^(UMSocialResponseEntity *response){
            if (response.responseCode == UMSResponseCodeSuccess)
            {
                NSDictionary *snsAccountDic = [UMSocialAccountManager socialAccountDictionary];
                UMSocialAccountEntity *qqAccount = [snsAccountDic valueForKey:UMShareToQQ];
                
                if (qqAccount)
                {
                    [self startAnimating];
                    __weak typeof(self) weakSelf = self;
                    [[AppInfo shareInstance] loginWithAccount:qqAccount.usid nick:qqAccount.userName withHeadUrl:qqAccount.iconURL  token:qqAccount.accessToken type:1 success:^{
                        [self stopAnimating];
                        __strong typeof(self) strongSelf = weakSelf;
                        if (strongSelf)
                        {
                            NSString *className = NSStringFromClass([strongSelf class]);
                            NSDictionary *param = [NSDictionary dictionaryWithObject:className forKey:@"className"];
                            [strongSelf popCanvasWithArgment:param];
                            
                                  [[NSNotificationCenter defaultCenter]postNotificationName:@"ReLogin" object:self];
                            
           
                        }
                        
                    } fail:^(NSString *erroMessage) {
                        [self stopAnimating];
                        [self showNoticeInWindow:@"登录失败"];
                    }];
                }
                
                
            }
        }];
    }
    else
    {
        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
        if (snsPlatform == nil)
        {
            return;
        }
        snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response)
                                      {
                                          [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToQQ completion:^(UMSocialResponseEntity *respose){
                                              if (response.responseCode == UMSResponseCodeSuccess)
                                              {
                                                  NSDictionary *snsAccountDic = [UMSocialAccountManager socialAccountDictionary];
                                                  UMSocialAccountEntity *qqAccount = [snsAccountDic valueForKey:UMShareToQQ];
                                                  
                                                  if (qqAccount)
                                                  {
                                                      [self startAnimating];
                                                      __weak typeof(self) weakSelf = self;
                                                
//                                                      
                                                      [[AppInfo shareInstance] loginWithAccount:qqAccount.usid nick:qqAccount.userName withHeadUrl:qqAccount.iconURL token:qqAccount.accessToken type:1 success:^{
                                                          [self stopAnimating];
                                                          __strong typeof(self) strongSelf = weakSelf;
                                                          if (strongSelf)
                                                          {
                                                            
                                                              NSString *className = NSStringFromClass([strongSelf class]);
                                                              NSDictionary *param = [NSDictionary dictionaryWithObject:className forKey:@"className"];
                                                              [strongSelf popCanvasWithArgment:param];
                                                                    [[NSNotificationCenter defaultCenter]postNotificationName:@"ReLogin" object:self];
                                                          }
                                                      } fail:^(NSString *erroMessage) {
                                                          [self stopAnimating];
                                                          [self showNoticeInWindow:@"登录失败"];
                                                      }];
                                                  }
                                                  
                                              }
                                          }];
                                          
                                      });
    }
    
}

- (void)loginWithSina
{
    
      [LiveRoomHelper canleOauthsWithType:@[UMShareToSina]];
    BOOL isOauth = [UMSocialAccountManager isOauthWithPlatform:UMShareToSina];
    if (isOauth)
    {
        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
        if (snsPlatform == nil)
        {
            return;
        }
        snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
            if (response.responseCode == UMSResponseCodeSuccess)
            {
                NSDictionary *snsAccountDic = [UMSocialAccountManager socialAccountDictionary];
                UMSocialAccountEntity *sinaAccount = [snsAccountDic valueForKey:UMShareToSina];
                
                if (sinaAccount)
                {
                    [self startAnimating];
                    __weak typeof(self) weakSelf = self;
                    [[AppInfo shareInstance] loginWithAccount:sinaAccount.usid nick:sinaAccount.userName withHeadUrl:sinaAccount.iconURL token:sinaAccount.accessToken type:2 success:^{
                        [self stopAnimating];
                        __strong typeof(self) strongSelf = weakSelf;
                        if (strongSelf)
                        {
                            NSString *className = NSStringFromClass([strongSelf class]);
                            NSDictionary *param = [NSDictionary dictionaryWithObject:className forKey:@"className"];
                            [strongSelf popCanvasWithArgment:param];
                                  [[NSNotificationCenter defaultCenter]postNotificationName:@"ReLogin" object:self];
                        }
                    } fail:^(NSString *erroMessage) {
                        [self stopAnimating];
                        [self showNoticeInWindow:@"登录失败"];
                    }];
                }
                
            }
        });
    }
    else
    {
        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
        if (snsPlatform == nil)
        {
            return;
        }
        snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response)
                                      {
                                          [[UMSocialDataService defaultDataService] requestSocialAccountWithCompletion:^(UMSocialResponseEntity *accountResponse){
                                              if (accountResponse.responseCode == UMSResponseCodeSuccess)
                                              {
                                                  NSDictionary *snsAccountDic = [UMSocialAccountManager socialAccountDictionary];
                                                  UMSocialAccountEntity *sinaAccount = [snsAccountDic valueForKey:UMShareToSina];
                                                  
                                                  if (sinaAccount)
                                                  {
                                                      [self startAnimating];
                                                      __weak typeof(self) weakSelf = self;
                                                      [[AppInfo shareInstance] loginWithAccount:sinaAccount.usid nick:sinaAccount.userName withHeadUrl:sinaAccount.iconURL  token:sinaAccount.accessToken type:2 success:^{
                                                          [self stopAnimating];
                                                          __strong typeof(self) strongSelf = weakSelf;
                                                          if (strongSelf)
                                                          {
                                                              NSString *className = NSStringFromClass([strongSelf class]);
                                                              NSDictionary *param = [NSDictionary dictionaryWithObject:className forKey:@"className"];
                                                              [strongSelf popCanvasWithArgment:param];
                                                              [[NSNotificationCenter defaultCenter]postNotificationName:@"ReLogin" object:self];

                                                          }
                                                      } fail:^(NSString *erroMessage) {
                                                          [self stopAnimating];
                                                          [self showNoticeInWindow:@"登录失败"];
                                                      }];
                                                  }
                                                  
                                              }
                                          }];
                                          
                                      });
    }
    
}


- (void)loginWithWx
{
    if (![WXApi isWXAppInstalled])
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
 
        return;
    }
          [LiveRoomHelper canleOauthsWithType:@[UMShareToWechatSession]];
    
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession];
    if (snsPlatform == nil)
    {
        return;
    }
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response)
    {
        NSLog(@"login response is %@",response);
        //          获取微博用户名、uid、token等
        if (response.responseCode == UMSResponseCodeSuccess) {
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToWechatSession];
            NSLog(@"username is %@, uid is %@, token is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken);
            
            if (snsAccount)
            {
                [self startAnimating];
                __weak typeof(self) weakSelf = self;
                [[AppInfo shareInstance] loginWithAccount:snsAccount.usid nick:snsAccount.userName withHeadUrl:snsAccount.iconURL token:snsAccount.accessToken type:4 success:^{
                    [self stopAnimating];
                    __strong typeof(self) strongSelf = weakSelf;
                    if (strongSelf)
                    {
                        NSString *className = NSStringFromClass([strongSelf class]);
                        NSDictionary *param = [NSDictionary dictionaryWithObject:className forKey:@"className"];
                        [strongSelf popCanvasWithArgment:param];
                        [[NSNotificationCenter defaultCenter]postNotificationName:@"ReLogin" object:self];

                    }
                    
                } fail:^(NSString *erroMessage)
                {
                    [self stopAnimating];
                    [self showNoticeInWindow:@"登录失败"];
                }];
            }

        }
        //这里可以获取到腾讯微博openid,Qzone的token等
        /*
         if ([platformName isEqualToString:UMShareToTencent]) {
         [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToTencent completion:^(UMSocialResponseEntity *respose){
         NSLog(@"get openid  response is %@",respose);
         }];
         }
         */
    });
}


#pragma mark UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@" "])
    {
        return NO;
    }
    
    NSInteger nLimitCount = 16;
    
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
