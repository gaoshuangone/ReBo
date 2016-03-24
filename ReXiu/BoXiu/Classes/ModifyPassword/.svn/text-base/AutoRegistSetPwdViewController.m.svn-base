//
//  AutoRegistSetPwdViewController.m
//  BoXiu
//
//  Created by tongmingyu on 14-12-5.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "AutoRegistSetPwdViewController.h"
#import "SetAutoRegistPwdModel.h"
#import "NSString+DES.h"
#import "UserInfoManager.h"

@interface AutoRegistSetPwdViewController ()<UITextFieldDelegate>

@property (nonatomic,strong) UITextField *setNewPwdTextfield;
@property (nonatomic,strong) UITextField *confirmPwdTextfield;

@end

@implementation AutoRegistSetPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"设置密码";
    
    _setNewPwdTextfield = [[UITextField alloc] initWithFrame:CGRectMake(15, 15, SCREEN_WIDTH - 30, 40)];
    _setNewPwdTextfield.placeholder = @"请输入新密码";
    _setNewPwdTextfield.delegate = self;
    _setNewPwdTextfield.font = [UIFont systemFontOfSize:15.0f];
    _setNewPwdTextfield.secureTextEntry = YES;
    _setNewPwdTextfield.backgroundColor = [UIColor whiteColor];
    _setNewPwdTextfield.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _setNewPwdTextfield.leftView = [[UIView alloc] initWithFrame:CGRectMake(0,0,10,_setNewPwdTextfield.bounds.size.height)];
    _setNewPwdTextfield.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:_setNewPwdTextfield];
    
    _confirmPwdTextfield = [[UITextField alloc] initWithFrame:CGRectMake(15 , 65, SCREEN_WIDTH - 30, 40)];
    _confirmPwdTextfield.placeholder = @"确认新密码";
    _confirmPwdTextfield.delegate = self;
    _confirmPwdTextfield.font = [UIFont systemFontOfSize:15.0f];
    _confirmPwdTextfield.secureTextEntry = YES;
    _confirmPwdTextfield.backgroundColor = [UIColor whiteColor];
    _confirmPwdTextfield.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _confirmPwdTextfield.leftView = [[UIView alloc] initWithFrame:CGRectMake(0,0,10,_confirmPwdTextfield.bounds.size.height)];
    _confirmPwdTextfield.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:_confirmPwdTextfield];
    
    UIButton *commitBtn = [[UIButton alloc] initWithFrame:CGRectMake(28, 130, 264, 40)];
    [commitBtn setTitle:@"提交" forState:UIControlStateNormal];
    commitBtn.layer.masksToBounds = YES;
    commitBtn.layer.cornerRadius = 20;
    commitBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    commitBtn.backgroundColor = [CommonFuction colorFromHexRGB:@"d14c49"];
    [commitBtn addTarget:self action:@selector(comitPassword) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:commitBtn];
}

-(void)comitPassword
{
    [self.setNewPwdTextfield resignFirstResponder];
    [self.confirmPwdTextfield resignFirstResponder];
    
    if ([_setNewPwdTextfield.text length] < 4 || [_setNewPwdTextfield.text length] > 16)
    {
        [self showNoticeInWindow:@"密码长度4-16位,请重新输入"];
        return;
    }
    else if (![_setNewPwdTextfield.text isEqualToString:_confirmPwdTextfield.text])
    {
        [self showNoticeInWindow:@"密码不一致,请重新输入"];
        return;
    }
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[[ReXiuLib shareInstance] DESEncryptWithKey:self.confirmPwdTextfield.text] forKey:@"newPwd"];
    
    __weak typeof(self) weakSelf = self;
    [self requestDataWithAnalyseModel:[SetAutoRegistPwdModel class] params:dict success:^(id object)
     {
         /*成功返回数据*/
         __strong typeof(self) strongSelf = weakSelf;
         SetAutoRegistPwdModel *model = object;
         if (model.result == 0)
         {
             [self showNoticeInWindow:@"密码设置成功"];
             
             [UserInfoManager shareUserInfoManager].currentUserInfo.passwordnotset = 0;
             [strongSelf performSelector:@selector(popCanvasWithArgment:) withObject:nil afterDelay:2];
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


#pragma _mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.setNewPwdTextfield resignFirstResponder];
    [self.confirmPwdTextfield resignFirstResponder];
    return YES;
}

#pragma mark UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@" "])
    {
        return NO;
    }
    
    if (textField == _setNewPwdTextfield || textField == _confirmPwdTextfield)
    {
        if (range.location >= 16)
        {
            return NO;
        }
    }
    
    return YES;
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
