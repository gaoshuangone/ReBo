//
//  ModifyPasswordViewController.m
//  BoXiu
//
//  Created by andy on 14-4-25.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "ModifyPasswordViewController.h"
#import "EWPCheckBox.h"
#import "EWPTextField.h"
#import "ModifyPasswordModel.h"
#import "UserInfoManager.h"
#import "RegexKitLite.h"
#import "NSString+DES.h"

@interface ModifyPasswordViewController ()<EWPCheckBoxDelegate,UITextFieldDelegate>

@property (nonatomic,strong) UITextField *oldPassword;
@property (nonatomic,strong) UITextField *password;
@property (nonatomic,strong) UITextField *passwordAgain;
@property (nonatomic,strong) EWPCheckBox *showPassword;
@property (nonatomic,strong) UIButton *showPasswordButton;
@property (nonatomic,strong) UIButton *checkPassword;
@property (nonatomic,strong) UIButton *checkPasswordAgain;

@end

@implementation ModifyPasswordViewController

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
    self.title = @"修改密码";
    
    _oldPassword = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 40)];
    _oldPassword.secureTextEntry = YES;
    _oldPassword.delegate = self;
    CAShapeLayer *shape = [[CAShapeLayer alloc] init];
    shape.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, _oldPassword.bounds.size.width, _oldPassword.bounds.size.height) byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(0, 0)].CGPath;
    shape.lineWidth = 0.5;
    shape.fillColor = [UIColor whiteColor].CGColor;
    shape.strokeColor = [UIColor colorWithRed:214.0f/255.0f green:214.0f/255.0f blue:214.0f/255.0f alpha:1].CGColor;
    [_oldPassword.layer insertSublayer:shape atIndex:0];
    _oldPassword.placeholder = @"原始密码";
    _oldPassword.font = [UIFont systemFontOfSize:14];
    _oldPassword.leftView = [[UIView alloc] initWithFrame:CGRectMake(0,0,10,_oldPassword.bounds.size.height)];
    _oldPassword.leftViewMode = UITextFieldViewModeAlways;
    [self.scrollView addSubview:_oldPassword];
    
    _password = [[UITextField alloc] initWithFrame:CGRectMake(10, 10+40+4, SCREEN_WIDTH-20, 40)];
    _password.secureTextEntry = YES;
    _password.delegate = self;
    shape = [[CAShapeLayer alloc] init];
    shape.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, _password.bounds.size.width, _password.bounds.size.height) byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(0, 0)].CGPath;
    shape.lineWidth = 0.5;
    shape.fillColor = [UIColor whiteColor].CGColor;
    shape.strokeColor = [UIColor colorWithRed:214.0f/255.0f green:214.0f/255.0f blue:214.0f/255.0f alpha:1].CGColor;
    [_password.layer insertSublayer:shape atIndex:0];
    _password.placeholder = @"设置新密码";
    _password.font = [UIFont systemFontOfSize:14];
    _password.leftView = [[UIView alloc] initWithFrame:CGRectMake(0,0,10,_oldPassword.bounds.size.height)];
    _password.leftViewMode = UITextFieldViewModeAlways;
    [self.scrollView addSubview:_password];
    
    _checkPassword = [UIButton buttonWithType:UIButtonTypeCustom];
    _checkPassword.frame = CGRectMake(_password.bounds.size.width - 100 -5, 0, 100, _password.bounds.size.height);
    _checkPassword.hidden = YES;
    [_checkPassword setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    _checkPassword.titleLabel.font = [UIFont systemFontOfSize:14];
    _checkPassword.backgroundColor = [UIColor whiteColor];
    _checkPassword.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [_password addSubview:_checkPassword];
    
    _passwordAgain = [[UITextField alloc] initWithFrame:CGRectMake(10, 10+40+4+40+4, SCREEN_WIDTH-20, 40)];
    _passwordAgain.secureTextEntry = YES;
    _passwordAgain.delegate = self;
    _passwordAgain.layer.borderWidth = 0;
    shape = [[CAShapeLayer alloc] init];
    shape.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, _passwordAgain.bounds.size.width, _passwordAgain.bounds.size.height) byRoundingCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(0, 0)].CGPath;
    shape.lineWidth = 0.5;
    shape.fillColor = [UIColor whiteColor].CGColor;
    shape.strokeColor = [UIColor colorWithRed:214.0f/255.0f green:214.0f/255.0f blue:214.0f/255.0f alpha:1].CGColor;
    [_passwordAgain.layer insertSublayer:shape atIndex:0];
    _passwordAgain.placeholder = @"请再次输入新密码";
    _passwordAgain.font = [UIFont systemFontOfSize:14];
    _passwordAgain.leftView = [[UIView alloc] initWithFrame:CGRectMake(0,0,10,_oldPassword.bounds.size.height)];
    _passwordAgain.leftViewMode = UITextFieldViewModeAlways;
    [self.scrollView addSubview:_passwordAgain];
    
    _checkPasswordAgain = [UIButton buttonWithType:UIButtonTypeCustom];
    _checkPasswordAgain.frame = CGRectMake(_passwordAgain.bounds.size.width - 100 -5, 0, 100, _passwordAgain.bounds.size.height);
    _checkPasswordAgain.hidden = YES;
    [_checkPasswordAgain setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    _checkPasswordAgain.titleLabel.font = [UIFont systemFontOfSize:14];
    _checkPasswordAgain.backgroundColor = [UIColor whiteColor];
    _checkPasswordAgain.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [_passwordAgain addSubview:_checkPasswordAgain];
    
    
//    UIImage *normalImg = [CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"f6f6f6"] size:CGSizeMake(264, 40)];
    UIImage *img = [CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"d14c49"] size:CGSizeMake(264, 40)];
    UIButton *confimBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    confimBtn.frame = CGRectMake(28, 180, 264, 40);
    [confimBtn setTitle:@"提交" forState:UIControlStateNormal];
    [confimBtn setBackgroundImage:img forState:UIControlStateNormal];
    [confimBtn setBackgroundImage:IMAGE_SUBJECT_SEL(264, 40) forState:UIControlStateHighlighted];
    confimBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    confimBtn.layer.masksToBounds = YES;
    confimBtn.layer.cornerRadius = 20;
    confimBtn.layer.borderWidth = 1.0f;
    confimBtn.layer.borderColor = [CommonFuction colorFromHexRGB:@"d14c49"].CGColor;
    [confimBtn setTitleColor:[CommonFuction colorFromHexRGB:@"ffffff"] forState:UIControlStateNormal];
//    [confimBtn setTitleColor:[CommonFuction colorFromHexRGB:@"d14c49"] forState:UIControlStateNormal];
    
    [confimBtn addTarget:self action:@selector(confimPwd) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:confimBtn];
}

- (void)viewWillAppear:(BOOL)animated
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
    [self moveInputBarWithKeyboardHeight:100 withDuration:animationDuration];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    NSDictionary* userInfo = [notification userInfo];
    
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    [self moveInputBarWithKeyboardHeight:-100 withDuration:animationDuration];
}

- (void)moveInputBarWithKeyboardHeight:(float)keyboardHeight withDuration:(NSTimeInterval)animationDuration
{
    [UIView animateWithDuration:animationDuration delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, self.scrollView.frame.size.height + keyboardHeight);
    } completion:^(BOOL finished) {
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - EWPCheckBoxDelegate

- (void)didSelectedCheckBox:(EWPCheckBox *)checkbox checked:(BOOL)checked
{
    self.passwordAgain.hidden = checked;
    self.password.secureTextEntry = !checked;

}

- (void)showPasswordSwitch:(id)sender
{
    self.showPasswordButton.selected = !self.showPasswordButton.selected;
    BOOL checked=self.showPasswordButton.selected;
    self.passwordAgain.hidden = checked;
    self.password.secureTextEntry = !checked;
    self.oldPassword.secureTextEntry = !checked;
    if(checked)
    {
        CAShapeLayer *shape = [[CAShapeLayer alloc] init];
        shape.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, _password.bounds.size.width, _password.bounds.size.height) byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(5, 5)].CGPath;
        shape.lineWidth = 0.5;
        shape.fillColor = [UIColor whiteColor].CGColor;
        shape.strokeColor = [UIColor colorWithRed:214.0f/255.0f green:214.0f/255.0f blue:214.0f/255.0f alpha:1].CGColor;
        [_password.layer replaceSublayer:[_password.layer.sublayers objectAtIndex:0] with:shape];
    }else{
        CAShapeLayer *shape = [[CAShapeLayer alloc] init];
        shape.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, _password.bounds.size.width, _password.bounds.size.height) byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)].CGPath;
        shape.lineWidth = 0.5;
        shape.fillColor = [UIColor whiteColor].CGColor;
        shape.strokeColor = [UIColor colorWithRed:214.0f/255.0f green:214.0f/255.0f blue:214.0f/255.0f alpha:1].CGColor;
        [_password.layer replaceSublayer:[_password.layer.sublayers objectAtIndex:0] with:shape];
    }
}


#pragma mark _提交修改的密码
- (void) confimPwd
{
    [self.oldPassword resignFirstResponder];
    [self.password resignFirstResponder];
    [self.passwordAgain resignFirstResponder];
    
    if ([_oldPassword.text length] == 0)
    {
        [self showNoticeInWindow:@"请输入原始密码"];
        return;
    }
    
    if ([_password.text length] == 0)
    {
        [self showNoticeInWindow:@"请输入新密码"];
        return;
    }
    
    if ([_passwordAgain.text length] == 0)
    {
        [self showNoticeInWindow:@"请再次输入新密码"];
        return;
    }
    
    if(![self.password.text isMatchedByRegex:@"^[\\x{21}-\\x{ff}]{4,16}$"])
    {
        self.checkPassword.hidden = NO;
        [self.checkPassword setImage:[UIImage imageNamed:@"check_error"] forState:UIControlStateNormal];
        [self.checkPassword setTitle:@"4-16位密码" forState:UIControlStateNormal];
        return;
    }
    else
    {
        self.checkPassword.hidden = YES;
    }
    
    if([self.password.text isEqualToString:self.passwordAgain.text])
    {
        [self.checkPasswordAgain setImage:[UIImage imageNamed:@"check_right"] forState:UIControlStateNormal];
        [self.checkPasswordAgain setTitle:nil forState:UIControlStateNormal];
    }
    else
    {
        [self.checkPasswordAgain setImage:[UIImage imageNamed:@"check_error"] forState:UIControlStateNormal];
        [self.checkPasswordAgain setTitle:@"密码不一致" forState:UIControlStateNormal];
        return;
    }
    
    
    if ([self.oldPassword.text isEqualToString:self.password.text])
    {
        [self showNoticeInWindow:@"新密码不能与原密码相同"];
        return;
    }
    //提交
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[UserInfoManager shareUserInfoManager].currentUserInfo.loginname forKey:@"loginname"];
    
    [dict setObject:[[ReXiuLib shareInstance] DESEncryptWithKey:self.oldPassword.text] forKey:@"password"];
    [dict setObject:[[ReXiuLib shareInstance] DESEncryptWithKey:self.password.text] forKey:@"newPwd"];
    
    __weak typeof(self) weakSelf = self;
    
    [self requestDataWithAnalyseModel:[ModifyPasswordModel class] params:dict success:^(id object)
     {
         /*成功返回数据*/
         __strong typeof(self) StrongSelf = weakSelf;
         
         ModifyPasswordModel *model = object;
         if (model.result == 0)
         {
             [self showNoticeInWindow:@"密码修改成功"];
             
             [StrongSelf performSelector:@selector(popCanvasWithArgment:) withObject:nil afterDelay:2];
         }
         else
         {
             if (![model.msg isEqualToString:@""])
             {
                 [self showNoticeInWindow:model.msg];
             }
             
         }
     }
                                     fail:^(id object)
     {
         /*失败返回数据*/
     }];
}


#pragma _mark UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.passwordAgain resignFirstResponder];
    return YES;
}

#pragma mark UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@" "])
    {
        return NO;
    }

    NSInteger nLimitCount = 16;
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
            else
            {
                NSString *toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
                if (textField == _passwordAgain)
                {
                    if ([toBeString length] == 0)
                    {
                        self.checkPasswordAgain.hidden = YES;
                        return YES;
                    }
                    else
                    {
                        if ([_password.text hasPrefix:toBeString] )
                        {
                            if ([_password.text isEqualToString:toBeString])
                            {
                                self.checkPasswordAgain.hidden = NO;
                                [self.checkPasswordAgain setImage:[UIImage imageNamed:@"check_right"] forState:UIControlStateNormal];
                                [self.checkPasswordAgain setTitle:nil forState:UIControlStateNormal];
                            }
                            else
                            {
                                self.checkPasswordAgain.hidden = YES;
                            }
                        }
                        else
                        {
                            self.checkPasswordAgain.hidden = NO;
                            [self.checkPasswordAgain setImage:[UIImage imageNamed:@"check_error"] forState:UIControlStateNormal];
                            [self.checkPasswordAgain setTitle:@"密码不一致" forState:UIControlStateNormal];
                            
                        }
                    }
                    
                }

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
    
    NSString *toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
    
    if (textField == _passwordAgain)
    {
        if ([string length] == 0)
        {
            self.checkPasswordAgain.hidden = YES;
            return YES;
        }
        
        if (range.location >= 16)
        {
            return NO;
        }
        else
        {
            if ([_password.text hasPrefix:toBeString] )
            {
                if ([_password.text isEqualToString:toBeString])
                {
                    self.checkPasswordAgain.hidden = NO;
                    [self.checkPasswordAgain setImage:[UIImage imageNamed:@"check_right"] forState:UIControlStateNormal];
                    [self.checkPasswordAgain setTitle:nil forState:UIControlStateNormal];
                }
            }
            else
            {
                self.checkPasswordAgain.hidden = NO;
                [self.checkPasswordAgain setImage:[UIImage imageNamed:@"check_error"] forState:UIControlStateNormal];
                [self.checkPasswordAgain setTitle:@"密码不一致" forState:UIControlStateNormal];
                
            }
        }
        
    }
    return YES;

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
