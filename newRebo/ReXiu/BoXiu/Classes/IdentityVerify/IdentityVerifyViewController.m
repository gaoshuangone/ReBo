//
//  IdentityVerifyViewController.m
//  BoXiu
//
//  Created by andy on 15/5/14.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import "IdentityVerifyViewController.h"
#import "IdentityVerifyModel.h"
#import "UserInfoManager.h"

@interface IdentityVerifyViewController ()<UITextFieldDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UITextField *nameTextField;
@property (nonatomic,strong) UITextField *idNumberTextField;
@property (nonatomic,strong) UITextField *phoneTextField;

@property (nonatomic,strong) NSString *imageFileUrl;

@end

@implementation IdentityVerifyViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.baseViewType = kbaseScroolViewType;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"实名认证";
    
    CGFloat nYOffset = 25;
    UIView *imageViewBK = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 276)/2, nYOffset, 276, 171)];
    [imageViewBK addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnSelectPhoto:)]];
    [self.scrollView addSubview:imageViewBK];
    nYOffset += 171;
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, imageViewBK.frame.size.width, imageViewBK.frame.size.height)];
    _imageView.image = [UIImage imageNamed:@"IdentityVerifyDefault"];
    [imageViewBK addSubview:_imageView];
    
    
    nYOffset += 25;
    _nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, nYOffset, 300, 44)];
    _nameTextField.placeholder = @"  真实姓名";
    _nameTextField.delegate = self;
    _nameTextField.backgroundColor = [UIColor whiteColor];
    _nameTextField.font = [UIFont systemFontOfSize:14.0f];
    _nameTextField.textColor = [CommonFuction colorFromHexRGB:@"d5d5d5"];
    [self.scrollView addSubview:_nameTextField];
    nYOffset += 44;
    
    nYOffset += 4;
    _idNumberTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, nYOffset, 300, 44)];
    _idNumberTextField.placeholder = @"  身份证号码";
    _idNumberTextField.delegate = self;
    _idNumberTextField.backgroundColor = [UIColor whiteColor];
    _idNumberTextField.font = [UIFont systemFontOfSize:14.0f];
    _idNumberTextField.textColor = [CommonFuction colorFromHexRGB:@"d5d5d5"];
    [self.scrollView addSubview:_idNumberTextField];
    nYOffset += 44;
    
    nYOffset += 4;
    _phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, nYOffset, 300, 44)];
    _phoneTextField.placeholder = @"  手机号码";
    _phoneTextField.delegate = self;
    _phoneTextField.backgroundColor = [UIColor whiteColor];
    _phoneTextField.font = [UIFont systemFontOfSize:14.0f];
    _phoneTextField.textColor = [CommonFuction colorFromHexRGB:@"d5d5d5"];
    [self.scrollView addSubview:_phoneTextField];
    nYOffset += 44;
    
    nYOffset += 17;
    UIButton *commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    commitBtn.frame = CGRectMake(40, nYOffset, 240, 32);
    commitBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    commitBtn.layer.cornerRadius = 16.0f;
    [commitBtn setTitle:@"提交申请" forState:UIControlStateNormal];
    [commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [commitBtn setBackgroundColor:[CommonFuction colorFromHexRGB:@"f7c250"]];
    [commitBtn addTarget:self action:@selector(OnCommit:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:commitBtn];
    nYOffset += 32;
    
    nYOffset += 30;
    UILabel *notice0 = [[UILabel alloc] initWithFrame:CGRectMake(10, nYOffset, 300, 15)];
    notice0.font = [UIFont boldSystemFontOfSize:12.0f];
    notice0.textColor = [CommonFuction colorFromHexRGB:@"575757"];
    notice0.text = @"提醒:";
    [self.scrollView addSubview:notice0];
    nYOffset += 15;
    
    nYOffset += 5;
    UILabel *notice1 = [[UILabel alloc] initWithFrame:CGRectMake(10, nYOffset, 300, 15)];
    notice1.font = [UIFont systemFontOfSize:12.0f];
    notice1.textColor = [CommonFuction colorFromHexRGB:@"575757"];
    notice1.text = @"1.认证后可开通手机直播、录播功能;";
    [self.scrollView addSubview:notice1];
    nYOffset += 15;
    
    nYOffset += 3;
    UILabel *notice2 = [[UILabel alloc] initWithFrame:CGRectMake(10, nYOffset, 300, 15)];
    notice2.font = [UIFont systemFontOfSize:12.0f];
    notice2.textColor = [CommonFuction colorFromHexRGB:@"575757"];
    notice2.text = @"2.请确保填写有效真实的资料便于通过审核。";
    [self.scrollView addSubview:notice2];
    nYOffset += 80;
    
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, nYOffset);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    [UIView animateWithDuration:animationDuration delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, self.scrollView.frame.size.height + keyboardHeight);
    } completion:^(BOOL finished) {
    }];
    
}
#pragma mark - 上传图片
- (void)OnSelectPhoto:(UITapGestureRecognizer *)gestureRecognizer
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"头像修改" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"立即拍照",@"本地相册", nil];
    sheet.tag = 80;
    [sheet showInView:self.view];
}

#pragma mark -提交申请

- (void)OnCommit:(id)sender
{
    if (self.imageFileUrl == nil)
    {
        [self showNoticeInWindow:@"请上传手持身份证件照片"];
        return;
    }
    
    if (_nameTextField.text && [_nameTextField.text length] == 0)
    {
        [self showNoticeInWindow:@"请输入真实姓名"];
        return;
    }
    if (_idNumberTextField.text && [_idNumberTextField.text length] != 18)
    {
        [self showNoticeInWindow:@"请输入正确身份证号码"];
        return;
    }
    if (_phoneTextField.text && [_phoneTextField.text length] != 11)
    {
        [self showNoticeInWindow:@"请输入正确手机号码"];
        return;
    }

    [self performSelector:@selector(commitUserInfo) withObject:nil];
}

- (void)commitUserInfo
{
    MBProgressHUD *mbProgressHud = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:mbProgressHud];
    [mbProgressHud show:YES];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:_nameTextField.text forKey:@"name"];
    [params setObject:_phoneTextField.text forKey:@"phone"];
    [params setObject:_idNumberTextField.text forKey:@"idcard"];
    
    IdentityVerifyModel *model = [[IdentityVerifyModel alloc] init];
    [model uploadDataWithFileUrl:self.imageFileUrl params:params success:^(id object) {
        if (model.result == 0)
        {
            UserInfo *userInfo = [UserInfoManager shareUserInfoManager].currentUserInfo;
            if (userInfo)
            {
                userInfo.authstatus = 1;
                [UserInfoManager shareUserInfoManager].currentUserInfo = userInfo;
            }
            [self pushCanvas:VerifyResult_Canvas withArgument:nil];
        }
        else
        {
            [self showNoticeInWindow:model.msg];
        }
        [mbProgressHud hide:YES];

    } fail:^(id object) {
        [mbProgressHud hide:YES];
    }];
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == actionSheet.cancelButtonIndex)
    {
        return;
    }
    
    UIImagePickerControllerSourceType sourceType;
    switch (buttonIndex)
    {
        case 0:
            sourceType = UIImagePickerControllerSourceTypeCamera;
            if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
            {
                sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            }
            break;
        default:
            sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
            break;
    }
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = sourceType;
    picker.mediaTypes = @[(NSString *) kUTTypeImage];
    [[AppDelegate shareAppDelegate].lrSliderMenuViewController presentViewController:picker animated:YES completion:nil];

}

#pragma mark UIImagePickerController Delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    if ([mediaType isEqualToString:@"public.image"])
    {
        NSString *tempDir = NSTemporaryDirectory ();
        NSString *tempFile = [NSString stringWithFormat:@"%@/avatar.png",tempDir];
        UIImage *avatar = [info objectForKey:@"UIImagePickerControllerEditedImage"];
        
        
        float scale = MAX(avatar.size.width/150,avatar.size.height/150);
        avatar = [UIImage imageWithCGImage:avatar.CGImage scale:scale orientation:UIImageOrientationUp];
        [UIImagePNGRepresentation(avatar) writeToFile:tempFile atomically:YES];
        self.imageView.image = avatar;
        self.imageFileUrl = tempFile;
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == _nameTextField)
    {
        self.scrollView.contentInset = UIEdgeInsetsMake(-60, 0, 0, 0);
    }
    else if (textField == _idNumberTextField)
    {
        self.scrollView.contentInset = UIEdgeInsetsMake(-100, 0, 0, 0);
    }
    else if (textField == _phoneTextField)
    {
        self.scrollView.contentInset = UIEdgeInsetsMake(-140, 0, 0, 0);
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.scrollView.contentInset = UIEdgeInsetsZero;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
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
