//
//  RegisterSuccessViewController.m
//  BoXiu
//
//  Created by andy on 14-4-28.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "RegisterSuccessViewController.h"
#import "EWPRadioButton.h"
#import "UserInfoManager.h"
#import "UpdataPersonInfoModel.h"

@interface RegisterSuccessViewController ()<EWPRadioButtonDelegate,UITextFieldDelegate>

@property (nonatomic,strong) UITextField *userName;
@property (nonatomic,strong) EWPRadioButton *manRadio;
@property (nonatomic,strong) EWPRadioButton *womanRadio;
@property (nonatomic,strong) EWPRadioButton *secretRadio;
@property (nonatomic,assign) NSInteger sex;
//@property (nonatomic,strong) UIImageView* imageViewSel;
//@property (nonatomic,strong) UIImageView* imageViewSel;
//@property (nonatomic,strong) UIImageView* imageViewSel;
@end

@implementation RegisterSuccessViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationController.navigationBarHidden = YES;
    
    UIControl * control = [[UIControl alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 68)];
    control.backgroundColor = [CommonFuction colorFromHexRGB:@"ffffff"];
    [self.view addSubview:control];
    
    
    UIView* viewLine = [CommonUtils CommonViewLineWithFrame:CGRectMake(0, 67, SCREEN_WIDTH, 1)];
    viewLine.backgroundColor = [CommonFuction colorFromHexRGB:@"cbcbcb"];
    [self.view addSubview:viewLine];
    
    CGFloat alignX = 12;
    CGFloat YOffset1 = 35;
    CGFloat YSpace = 10;
    
    __weak typeof(self) weakSelf1 = self;
    
    EWPButton *backBtn = [EWPButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(10, YOffset1, 30, 24);
    [backBtn setImage:[UIImage imageNamed:@"navBack_normal"] forState:UIControlStateNormal];
    backBtn.buttonBlock = ^(id sender)
    {
        __strong typeof(self) StrongSelf = weakSelf1;
 
        
        
        NSString *className = NSStringFromClass([self class]);
        NSDictionary *param = [NSDictionary dictionaryWithObject:className forKey:@"className"];
        if ( ![AppDelegate shareAppDelegate].isNeedReturnLiveRoom )
        {
            [StrongSelf popToRootCanvasWithArgment:param];
        }
        else
        {
            [StrongSelf popToCanvas:LiveRoom_CanVas withArgument:param];
        }
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"ReLogin" object:self];

    };
    
    [self.view addSubview:backBtn];
    
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, 40, 100, 15)];
    titleLabel.text = @"完善资料";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textColor = [CommonFuction colorFromHexRGB:@"454a4d"];
    [self.view addSubview:titleLabel];

    
    int YOffset = 15+68;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10, YOffset, SCREEN_WIDTH-20, 43)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    UILabel *userIdLable = [[UILabel alloc] initWithFrame:CGRectMake(24, YOffset + 13, 80, 20)];
    userIdLable.textColor = [CommonFuction colorFromHexRGB:@"575757"];
    userIdLable.text = @"您的用户ID";
    userIdLable.font = [UIFont systemFontOfSize:14.0f];
    [self.view addSubview:userIdLable];
    
    userIdLable = [[UILabel alloc] initWithFrame:CGRectMake(105, YOffset + 13, 80, 20)];
    userIdLable.textColor = [CommonFuction colorFromHexRGB:@"f7c250"];
    userIdLable.text = [NSString stringWithFormat:@"%ld",(long)[UserInfoManager shareUserInfoManager].currentUserInfo.userId];
    userIdLable.font = [UIFont boldSystemFontOfSize:14.0f];
    [self.view addSubview:userIdLable];
    
    
    YOffset += 47;
    
    view = [[UIView alloc] initWithFrame:CGRectMake(10, YOffset, SCREEN_WIDTH-20, 43)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    UILabel *nickLable = [[UILabel alloc] initWithFrame:CGRectMake(24, YOffset + 13, 50, 20)];
    nickLable.textColor = [CommonFuction colorFromHexRGB:@"575757"];
    nickLable.text = @"昵称";
    nickLable.font = [UIFont systemFontOfSize:14.0f];
    [self.view addSubview:nickLable];
    
    _userName = [[UITextField alloc] initWithFrame:CGRectMake(63, YOffset + 8, 245, 30)];
    _userName.text = [UserInfoManager shareUserInfoManager].currentUserInfo.nick;
    _userName.placeholder = @"输入昵称";
    _userName.font = [UIFont systemFontOfSize:14.0f];
    _userName.textColor = [CommonFuction colorFromHexRGB:@"575757"];
    _userName.delegate = self;
    _userName.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_userName];
  
    YOffset += 47;
    
    view = [[UIView alloc] initWithFrame:CGRectMake(10, YOffset, SCREEN_WIDTH-20, 43)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    UILabel *sexLable = [[UILabel alloc] initWithFrame:CGRectMake(24, YOffset + 11, 50, 20)];
    sexLable.textColor = [CommonFuction colorFromHexRGB:@"575757"];
    sexLable.text = @"性别";
    sexLable.font = [UIFont systemFontOfSize:14.0f];
    [self.view addSubview:sexLable];
    
    
//    self.view.backgroundColor = [UIColor grayColor];
    
    _manRadio = [[EWPRadioButton alloc] initWithDelegate:self groupId:@"0"];
    _manRadio.frame = CGRectMake(70, YOffset + 12, 60, 20);
    [_manRadio setTitleColor:[CommonFuction colorFromHexRGB:@"aaaaaa"] forState:UIControlStateNormal];
    [_manRadio setTitle:@"帅哥" forState:UIControlStateNormal];
    _manRadio.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [self.view addSubview:_manRadio];
    
    _womanRadio = [[EWPRadioButton alloc] initWithDelegate:self groupId:@"0"];
    _womanRadio.frame = CGRectMake(135, YOffset + 12, 60, 20);
    [_womanRadio setTitleColor:[CommonFuction colorFromHexRGB:@"aaaaaa"] forState:UIControlStateNormal];
    [_womanRadio setTitle:@"美女" forState:UIControlStateNormal];
    _womanRadio.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [self.view addSubview:_womanRadio];
    
    _secretRadio = [[EWPRadioButton alloc] initWithDelegate:self groupId:@"0"];
    _secretRadio.frame = CGRectMake(203, YOffset + 12, 60, 20);
    [_secretRadio setTitleColor:[CommonFuction colorFromHexRGB:@"aaaaaa"] forState:UIControlStateNormal];
    [_secretRadio setTitle:@"保密" forState:UIControlStateNormal];
    _secretRadio.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    _secretRadio.checked = YES;
    [self.view addSubview:_secretRadio];
    YOffset += 70;
    
   
    
    
    
     __weak typeof(self) weakSelf = self;
    
    UIImage *normalImg = [CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"d14c49"] size:CGSizeMake(240, 32)];
    UIImage *img = [CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"ffffff"] size:CGSizeMake(240, 32)];
    EWPButton *finishBtn = [[EWPButton alloc] initWithFrame:CGRectMake(40, YOffset, 240, 32)];
    [finishBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [finishBtn setBackgroundImage:normalImg forState:UIControlStateNormal];
    [finishBtn setBackgroundImage:img forState:UIControlStateHighlighted];
    [finishBtn setTitle:@"完成" forState:UIControlStateNormal];
    [finishBtn setTitleColor:[CommonFuction colorFromHexRGB:@"ffffff"] forState:UIControlStateNormal];
    [finishBtn setTitleColor:[CommonFuction colorFromHexRGB:@"d14c49"] forState:UIControlStateHighlighted];
    finishBtn.layer.masksToBounds = YES;
    finishBtn.layer.cornerRadius = 16.0f;
    finishBtn.layer.borderWidth = 1.0f;
    finishBtn.layer.borderColor = [CommonFuction colorFromHexRGB:@"d14c49"].CGColor;
    [self.view addSubview:finishBtn];
    finishBtn.buttonBlock = ^(id sender)
    {
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf performSelector:@selector(OnModifyInfo) withObject:nil];
    };
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    self.navigationItem.leftBarButtonItem = nil;
//    self.navigationItem.hidesBackButton = YES;
}



#pragma mark - ERadioButtonDelegate

- (void)didSelectedRadioButton:(EWPRadioButton *)radio groupId:(NSString *)groupId
{
    if (radio == self.manRadio)
    {
        self.sex = 1;
    }
    else if (radio == self.womanRadio)
    {
        self.sex = 2;
    }
    else
    {
        self.sex = 0;
    }
}

- (void)OnModifyInfo
{
    [_userName resignFirstResponder];
    
    if ([_userName.text length] < 2 || [_userName.text length] > 10)
    {
        [self showNoticeInWindow:@"昵称长度2-10位,请重新输入"];
        return;
    }
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[_userName.text  stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] forKey:@"nick"];
    [dict setObject:[NSNumber numberWithInteger:self.sex] forKey:@"sex"];
    
    [self requestDataWithAnalyseModel:[UpdataPersonInfoModel class] params:dict success:^(id object)
     {
         /*成功返回数据*/
         UpdataPersonInfoModel *updataPersonInfoModel = object;
         if (updataPersonInfoModel.result == 0)
         {
             UserInfo *userInfo = [UserInfoManager shareUserInfoManager].currentUserInfo;
             userInfo.nick = _userName.text;
             userInfo.sex = self.sex;
             [UserInfoManager shareUserInfoManager].currentUserInfo = userInfo;
             NSString *className = NSStringFromClass([self class]);
             NSDictionary *param = [NSDictionary dictionaryWithObject:className forKey:@"className"];
             if ( ![AppDelegate shareAppDelegate].isNeedReturnLiveRoom )
             {
                 [self popToRootCanvasWithArgment:param];
             }
             else
             {
                 [self popToCanvas:LiveRoom_CanVas withArgument:param];
             }
             
              [[NSNotificationCenter defaultCenter]postNotificationName:@"ReLogin" object:self];
             
         }else if (updataPersonInfoModel.code == 403){
             [self showOherTerminalLoggedDialog];
         }
         else
         {
             [self showNotice:updataPersonInfoModel.msg];
         }
     }
                                 fail:^(id object)
     {
         /*失败返回数据*/
     }];
}

#pragma mark - UITextFieldDelegate


#pragma mark UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@" "])
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
