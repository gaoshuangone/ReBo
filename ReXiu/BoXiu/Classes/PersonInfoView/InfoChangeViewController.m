//
//  InfoChangeViewController.m
//  BoXiu
//
//  Created by tongmingyu on 5/14/14.
//  Copyright (c) 2014 rexiu. All rights reserved.
//

#import "InfoChangeViewController.h"
#import "UserInfo.h"
#import "AppInfo.h"
#import "updateCurrUserModel.h"
 #import <MobileCoreServices/UTCoreTypes.h>
#import "UserInfoManager.h"
#import "EWPHMenu.h"
#import "NavbarBack.h"
#import "SettingItemView.h"
#import <Accelerate/Accelerate.h>
#import "UIImage+Blur.h"

#import <AVFoundation/AVFoundation.h>

#import "UpdataPersonInfoModel.h"
#import "UpdateIntroductionmodel.h"
#define kMaxLength 18
@interface ChangeInfoCell : UITableViewCell

@end

@implementation ChangeInfoCell

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(self.bounds.size.width -80,20,40,40);
    if(self.imageView.image!=nil){
        CGRect rect = self.textLabel.frame;
        //rect.origin.x = self.imageView.frame.origin.x + self.imageView.frame.size.width + 15;
        rect.origin.x = 15;
        self.textLabel.frame = rect;
    }
}

@end

@interface InfoChangeViewController ()<UITextFieldDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>
@property (nonatomic,strong) UserInfo *userInfo;
@property (nonatomic,strong) UIImage *selectedImg;//重新设置照片成功后保存照片，不用从网络再获取了。
@property (nonatomic,strong) UIImageView* backImageView;
@property (nonatomic,strong) UIImageView *headImgView;
@property (nonatomic,strong) UITextField *nickField;
@property (nonatomic,strong) UITextField *qianMingField;
@property (nonatomic,strong) UILabel *sexLable;
@property (nonatomic,strong) UILabel *placeLable;

@property (nonatomic,strong) NavbarBack *navBack;

@property (nonatomic,assign) NSInteger fansNum;
@property (nonatomic,assign) NSInteger attensNum;

@end

@implementation InfoChangeViewController

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
    // Do any additional setup after loading the view.
    self.title = @"修改个人资料";
 
    self.userInfo = [UserInfoManager shareUserInfoManager].currentUserInfo;
    
    self.view.backgroundColor = [CommonFuction colorFromHexRGB:@"f8f8f8"];
    
//    _navBack = [[NavbarBack alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 40) showInView:self.view];
    __weak typeof(self) weakSelf = self;
//    _navBack.backButtonBlock = ^(id sender)
//    {
//        __strong typeof(self) strongSelf = weakSelf;
//        [strongSelf popCanvasWithArgment:nil];
//    };
//    [self.view addSubview:_navBack];
    
    CGFloat nYOffset = 208;
    

    
    _backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 208)];
    _backImageView.image = [UIImage imageNamed:@"morenBG"];
    _backImageView.contentMode = UIViewContentModeScaleAspectFill;
    [_backImageView.layer setMasksToBounds:YES];
    [self.view addSubview:_backImageView];
    [self.view sendSubviewToBack:_backImageView];
    
    UIImageView* imageVidewAlpha = [[UIImageView alloc]initWithFrame:_backImageView.frame];
    imageVidewAlpha.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    imageVidewAlpha.userInteractionEnabled = YES;
    [_backImageView addSubview:imageVidewAlpha];
    
    
    
    
    UIButton* buttonBack = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonBack setImage:[UIImage imageNamed:@"navB_Nor.png"] forState:UIControlStateNormal];
    buttonBack.frame = CGRectMake(0, 20, 50, 40);
    buttonBack.tag = 101;
        [buttonBack addTarget:self action:@selector(buttonPres) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonBack];
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-106)/2, (208-92)/2, 106, 92)];
    headView.tag = 1;

//    headView.backgroundColor=[UIColor redColor];
    [headView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnClick:)]];
    [self.view addSubview:headView];
    
    UIImageView *defaultHead = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 92, 92)];
//    defaultHead.image = [UIImage imageNamed:@"head_default"];
    [headView addSubview:defaultHead];
    
    _headImgView = [[UIImageView alloc] initWithFrame:CGRectMake((106-66)/2, 7.5, 66, 66)];
    _headImgView.image = [UIImage imageNamed:@"morenHead"];
    _headImgView.layer.masksToBounds = YES;
    _headImgView.layer.cornerRadius = 33;
    _headImgView.layer.borderWidth=1;
    _headImgView.layer.borderColor = [UIColor whiteColor].CGColor;
    _headImgView.userInteractionEnabled = YES;
    [headView addSubview:_headImgView];
    
    
     UIImageView* imageViewXJ = [[UIImageView alloc]initWithFrame:CGRectMake(defaultHead.center.x+66/4, defaultHead.center.y+66/4-4, 21, 21)];
    imageViewXJ.image =[UIImage imageNamed:@"ca.png"];
    [headView addSubview:imageViewXJ];
    
    UILabel *focusCountTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, (208-92)/2+92, 15)];
        focusCountTitle.text = @"点击修改头像";
        focusCountTitle.textColor = [CommonFuction colorFromHexRGB:@"ffffff"];
        focusCountTitle.font = [UIFont systemFontOfSize:14];
        focusCountTitle.textAlignment = NSTextAlignmentCenter;
    [focusCountTitle sizeToFit];
    focusCountTitle.center = CGPointMake(self.view.center.x, (208-92)/2+92+5+3);
        [self.view addSubview:focusCountTitle];
    
//    UIImageView *editImg = [[UIImageView alloc] initWithFrame:CGRectMake(90, 0, 16, 16)];
//    editImg.image = [UIImage imageNamed:@"person_edithead"];
//    [headView addSubview:editImg];

    
//    UILabel *focusCountTitle = [[UILabel alloc] initWithFrame:CGRectMake(30, 185, 130, 15)];
//    focusCountTitle.text = [NSString stringWithFormat:@"关注 ：%ld",(long)_attensNum];
//    focusCountTitle.textColor = [CommonFuction colorFromHexRGB:@"ffffff"];
//    focusCountTitle.font = [UIFont boldSystemFontOfSize:13];
//    focusCountTitle.textAlignment = NSTextAlignmentRight;
//    [self.view addSubview:focusCountTitle];
//    
//    
//    UIImageView *vertImgView = [[UIImageView alloc] initWithFrame:CGRectMake(165, 185, 1, 15)];
//    vertImgView.backgroundColor = [CommonFuction colorFromHexRGB:@"ffffff"];
//    [self.view addSubview:vertImgView];
//    
//    UILabel *fanCountTitle = [[UILabel alloc] initWithFrame:CGRectMake(170, 185, 140, 15)];
//    fanCountTitle.text = [NSString stringWithFormat:@"粉丝 ：%ld",(long)_fansNum];
//    fanCountTitle.textColor = [CommonFuction colorFromHexRGB:@"ffffff"];
//    fanCountTitle.font = [UIFont boldSystemFontOfSize:13];
//    [self.view addSubview:fanCountTitle];


    nYOffset += 15;
    
    SettingItemView *nickItemView = [[SettingItemView alloc] initWithFrame:CGRectMake(0, nYOffset, SCREEN_WIDTH, 43) title:@"昵称" content:nil];
//    nickItemView.arrowImg = [UIImage imageNamed:@"rightArrow.png"];
    [self.view addSubview:nickItemView];
    [nickItemView setViewLine];

    _nickField = [[UITextField alloc] initWithFrame:CGRectMake(50, 2.3, 230, 40)];
    _nickField.textColor = [CommonFuction colorFromHexRGB:@"aaaaaa"];
    _nickField.font = [UIFont systemFontOfSize:14.0f];
    _nickField.placeholder = @"请输入昵称";
    _nickField.autocorrectionType = UITextAutocorrectionTypeNo;
    _nickField.keyboardType = UIKeyboardTypeDefault;
    _nickField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _nickField.delegate = self;
    [nickItemView addSubview:_nickField];

    nYOffset += 43;
    
    SettingItemView *sexItemView = [[SettingItemView alloc] initWithFrame:CGRectMake(0, nYOffset, SCREEN_WIDTH, 43) title:@"性别" content:nil];
    sexItemView.tag = 3;
    [sexItemView setViewLine];
//    sexItemView.arrowImg = [UIImage imageNamed:@"rightArrow.png"];
    _sexLable = [[UILabel alloc] initWithFrame:CGRectMake(50, 1.5, 100, 40)];
    _sexLable.textColor = [CommonFuction colorFromHexRGB:@"aaaaaa"];
    _sexLable.font = [UIFont systemFontOfSize:14.0f];
    [sexItemView addSubview:_sexLable];
    [self.view addSubview:sexItemView];
    
    [sexItemView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnClick:)]];
    nYOffset += 43;
    
    SettingItemView *placeItemView = [[SettingItemView alloc] initWithFrame:CGRectMake(0, nYOffset, SCREEN_WIDTH, 43) title:@"地区" content:nil];
    placeItemView.tag = 4;
//    [placeItemView setViewLine];
//    placeItemView.arrowImg = [UIImage imageNamed:@"rightArrow.png"];
    _placeLable = [[UILabel alloc] initWithFrame:CGRectMake(50, 1.5, 160, 40)];
    _placeLable.textColor = [CommonFuction colorFromHexRGB:@"aaaaaa"];
    _placeLable.font = [UIFont systemFontOfSize:14.0f];
    [placeItemView addSubview:_placeLable];
    [self.view addSubview:placeItemView];

    [placeItemView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnClick:)]];
    nYOffset += 43;
    
    
    nYOffset+=8;
    
    SettingItemView *QianMingItemView = [[SettingItemView alloc] initWithFrame:CGRectMake(0, nYOffset, SCREEN_WIDTH, 43) title:@"签名" content:nil];
    //    nickItemView.arrowImg = [UIImage imageNamed:@"rightArrow.png"];
    [self.view addSubview:QianMingItemView];
//    [QianMingItemView setViewLine];

    _qianMingField = [[UITextField alloc] initWithFrame:CGRectMake(50, 2.3, 320-50-10, 40)];
    _qianMingField.textColor = [CommonFuction colorFromHexRGB:@"aaaaaa"];
    _qianMingField.font = [UIFont systemFontOfSize:14.0f];
    _qianMingField.placeholder = @"请输入签名";
    _qianMingField.autocorrectionType = UITextAutocorrectionTypeNo;
    _qianMingField.keyboardType = UIKeyboardTypeDefault;
    _qianMingField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _qianMingField.delegate = self;
    [QianMingItemView addSubview:_qianMingField];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFiledEditChanged:)
                                                name:@"UITextFieldTextDidChangeNotification"
                                              object:_qianMingField];
    
    
    //使用NSNotificationCenter 鍵盤出現時
//      [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillAppear:) name:UIKeyboardWillShowNotification object:nil];
    
    
    nYOffset += 43;
    
    
    nYOffset += 20;
    UIImage *normalImg = [CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"ffffff"] size:CGSizeMake(200, 38)];
    UIImage *highImg = [CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"d14c49"] size:CGSizeMake(200, 38)];
    EWPButton *savePersonBtn = [[EWPButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-200)/2, nYOffset, 200, 38)];
    [savePersonBtn setTitle:@"保存" forState:UIControlStateNormal];
    [savePersonBtn setTitleColor:[CommonFuction colorFromHexRGB:@"ffffff"] forState:UIControlStateNormal];
//    [savePersonBtn setTitleColor:[CommonFuction colorFromHexRGB:@"d14c49"] forState:UIControlStateHighlighted];
    savePersonBtn.layer.masksToBounds = YES;
    savePersonBtn.layer.cornerRadius = 19.0f;
    savePersonBtn.layer.borderWidth = 1.0;
    savePersonBtn.layer.borderColor = [CommonFuction colorFromHexRGB:@"d14c49"].CGColor;
    [savePersonBtn setBackgroundImage:highImg forState:UIControlStateNormal];
    [savePersonBtn setBackgroundImage:IMAGE_SUBJECT_SEL(200, 38) forState:UIControlStateHighlighted];
    savePersonBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    [self.view addSubview:savePersonBtn];

    [savePersonBtn setButtonBlock:^(id sender)
     {
         __strong typeof(self) strongSelf = weakSelf;
         [strongSelf performSelector:@selector(savePerson) withObject:nil];
     }];
    
    

}


-(void)changeHeadImageWithIamge:(UIImage*)image with:(NSData*)data{
    
    
    UIImage* imageChange = nil;
    
    float blurred = .2f;
    if (image) {
        float quality = .00001f;
        
        NSData *imageData = UIImageJPEGRepresentation(image, quality);
        imageChange = [[UIImage imageWithData:imageData] blurredImage:blurred];
    }
    if (data) {
        imageChange = [[UIImage imageWithData:data] blurredImage:blurred];
    }
    
    if (imageChange) {
        _backImageView.image = imageChange;
    }
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    self.navigationController.navigationBarHidden = YES;
    
    if (self.selectedImg)
    {
        self.headImgView.image = self.selectedImg;
    }
    else
    {
        NSURL *headUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[AppInfo shareInstance].res_server,_userInfo.photo]];
        [self.headImgView sd_setImageWithURL:headUrl ];
        
        
        
        if (self.headImgView.image==nil) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSData* data = [[NSData alloc]initWithContentsOfURL:headUrl];
                [self changeHeadImageWithIamge:nil with:data];
                
            });
       
        }else{
            [self changeHeadImageWithIamge:self.headImgView.image with:nil];
        }

        
        
        
 

    }
    
    if (_userInfo)
    {
        if ([AppInfo shareInstance].neName) {
            _nickField.text = [AppInfo shareInstance].neName;
        }
        else
        {
            self.nickField.text = _userInfo.nick;
        }
        _navBack.title = _userInfo.nick;
        if (_userInfo.sex == 1)
        {
            self.sexLable.text = @"男";
            _navBack.sexImg = [UIImage imageNamed:@"person_female"];
        }
        else if (_userInfo.sex == 2)
        {
            self.sexLable.text = @"女";
            _navBack.sexImg = [UIImage imageNamed:@"person_male"];
        }
        else
        {
            self.sexLable.text = @"保密";
            _navBack.sexImg = nil;
        }
        
        if (_userInfo.provincename && _userInfo.cityname)
        {
            NSString *place = [NSString stringWithFormat:@"%@ %@",_userInfo.provincename,_userInfo.cityname];
            self.placeLable.text = place;
        }
        if (_userInfo.introduction.length!=0) {
            self.qianMingField.text =_userInfo.introduction;
        }else{
           self.qianMingField.text=  @"全民星直播互动平台，娱乐你的生活";
        }
    }
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBarHidden = NO;
}

-(void)argumentForCanvas:(id)argumentData
{
    if (argumentData)
    {
        NSDictionary *dict = (NSDictionary *)argumentData;
        _attensNum = [[dict objectForKey:@"attentionnum"] integerValue];
        _fansNum = [[dict objectForKey:@"fansnum"] integerValue];
        UserInfo *userInfo = [dict objectForKey:@"userinfo"];
        if (userInfo)
        {
            self.userInfo = userInfo;
        }
    }

}

- (void)OnClick:(UITapGestureRecognizer *)gestureRecognizer
{
    [_nickField resignFirstResponder];
    
    UIView *menu = gestureRecognizer.view;
    switch (menu.tag)
    {
        case 1:
        {
            
            [self.nickField resignFirstResponder];
            [self.qianMingField resignFirstResponder];
            UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"头像修改" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"立即拍照",@"本地相册", nil];
            sheet.tag = 80;
            [sheet showInView:self.view];
        }
            break;
        case 3:
        {
            [self.nickField resignFirstResponder];
            [self.qianMingField resignFirstResponder];
            UIActionSheet *sexSheet = [[UIActionSheet alloc] initWithTitle:@"性别修改" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"男",@"女", nil];
            sexSheet.tag = 100;
            [sexSheet showInView:self.view];
        }
            break;
        case 4:
        {
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            [dict setObject:_userInfo forKey:@"userinfo"];
            [self pushCanvas:RegionChange_Canvas withArgument:dict];
        }
            break;
        default:
            break;
    }
}

- (void)savePerson
{
    
   
    [_nickField resignFirstResponder];
    [_qianMingField resignFirstResponder];
    

    
    
    if ([_nickField.text length] == 0)
    {
        [self showNoticeInWindow:@"请输入昵称"];
        return;
    }
    
    if ([_nickField.text length] < 2 || [_nickField.text length] > 10)
    {
        [self showNoticeInWindow:@"昵称长度2-10位,请重新输入"];
        return;
    }
    
    if([self.sexLable.text length] == 0)
    {
        [self showNoticeInWindow:@"请选择性别"];
        return;
    }
    
    if ([[_qianMingField.text toString] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length >18) {
        
        [self showNoticeInWindow:@"签名长度限制18位,请重新输入"];
        return;
    }
    if ([[_qianMingField.text toString] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length==0) {
        [self showNoticeInWindow:@"请输入签名内容"];
        return;
    }

    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:_nickField.text forKey:@"nick"];
    [dict setObject:[NSNumber numberWithInteger:_userInfo.sex] forKey:@"sex"];
    if (self.placeLable.text && [self.placeLable.text length])
    {
        [dict setObject:_userInfo.city forKey:@"city"];
    }

    
    
    __weak typeof(self) weakSelf = self;
    [self requestDataWithAnalyseModel:[updateCurrUserModel class] params:dict success:^(id object)
     {
         __strong typeof(self) strongSelf = weakSelf;
         /*成功返回数据*/
         updateCurrUserModel *userModel = object;
         if (userModel.result == 0)
         {
             strongSelf.userInfo.nick = _nickField.text;
             
             [UserInfoManager shareUserInfoManager].currentUserInfo = strongSelf.userInfo;
         
             
             [strongSelf performSelectorOnMainThread:@selector(updateNavBackBar) withObject:nil waitUntilDone:NO];
             
             
             [self saveQianMing];
             
             
             
            
         }
         else
         {
             [strongSelf showNoticeInWindow:userModel.msg];
         }
     }
                                 fail:^(id object)
     {
         /*失败返回数据*/
     }];
    
    
    
   
    
    
    
    

    


    
}

-(void) saveQianMing{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    UpdateIntroductionmodel *updateIntroductionmodel = [[UpdateIntroductionmodel alloc] init];
    
    if ([_qianMingField.text toString].length==0) {
        [param setObject:_qianMingField.placeholder forKey:@"introduction"];
        
    }else {
        [param setObject:[[_qianMingField.text toString] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] forKey:@"introduction"];
    }
    
    
    
    [updateIntroductionmodel requestDataWithParams:param success:^(id object) {
        if (updateIntroductionmodel.result == 0)
        {
            [self
             showNoticeInWindow:@"修改个人信息成功"];
        }
        if (updateIntroductionmodel.result==1) {
            [self showNoticeInWindow:@"保存失败，签名不能包含敏感词"];
        }
    } fail:^(id object) {
        [self showNoticeInWindow:@"修改个人签名失败"];
    }];
    

}

- (void)updateNavBackBar
{
    self.navBack.title = _nickField.text;
    if (self.userInfo.sex == 1)
    {
        self.navBack.sexImg = [UIImage imageNamed:@"person_female"];
    }
    else if (self.userInfo.sex == 2)
    {
        self.navBack.sexImg = [UIImage imageNamed:@"person_male"];
    }
    else
    {
        self.navBack.sexImg = nil;
    }
    [self.navBack setNeedsLayout];
    [self.navBack setNeedsDisplay];
}
-(AVCaptureDevice *)getCameraDeviceWithPosition:(AVCaptureDevicePosition )position{
    NSArray *cameras= [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *camera in cameras) {
        if ([camera position]==position) {
            return camera;
        }
    }
    return nil;
}
#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == actionSheet.cancelButtonIndex)
    {
        return;
    }
    
    if (actionSheet.tag == 80)
    {
        
        


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
        
    
        NSString *mediaType = AVMediaTypeVideo;
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
        
        if(authStatus ==AVAuthorizationStatusRestricted){//此应用程序没有被授权访问的照片数据。可能是家长控制权限。
         
        }else if(authStatus == AVAuthorizationStatusDenied){// 用户已经明确否认了这一照片数据的应用程序访问
            [self showAlertView:@"热波间需要访问你的相机" message:@"头像修改，热波间需要访问你的相机权限。点击“设置”前往系统设置允许热波间访问你的相机" confirm:^(id sender) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
           
            } cancel:^(id sender) {
        
            }];
            return;
        }
        else if(authStatus == AVAuthorizationStatusAuthorized){//用户已授权应用访问照片数据.

            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.allowsEditing = YES;
            picker.sourceType = sourceType;
            picker.mediaTypes = @[(NSString *) kUTTypeImage];
            [self presentViewController:picker animated:YES completion:nil];
            
        }else if(authStatus == AVAuthorizationStatusNotDetermined){// 用户尚未做出了选择这个应用程序的问候.一次一出现
           
            [AVCaptureDevice requestAccessForMediaType:mediaType completionHandler:^(BOOL granted) {//弹出授权弹框
                if(granted){//点击允许访问时调用
                            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                            picker.delegate = self;
                            picker.allowsEditing = YES;
                            picker.sourceType = sourceType;
                            picker.mediaTypes = @[(NSString *) kUTTypeImage];
                            [self presentViewController:picker animated:YES completion:nil];
                }
                else {
                    return ;
                }
                
            }];
        }else {
            NSLog(@"Unknown authorization status");
        }
        
        
        

    }
    else if (actionSheet.tag == 100)
    {
        if (buttonIndex == 0)
        {
            _userInfo.sex = 1;
            _sexLable.text = @"男";
        }
        else if(buttonIndex == 1)
        {
            _userInfo.sex = 2;
            _sexLable.text = @"女";
        }
        else
        {
            _userInfo.sex = 0;
            _sexLable.text = @"保密";
        }
    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{

    
    [textField resignFirstResponder];
    
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    self.view.frame = rect;
    [UIView commitAnimations];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if (textField== self.qianMingField) {
        return YES;
    }
    if ([string isEqualToString:@" "])  //按会车可以改变
    {
        return NO;
    }
    
    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [AppInfo shareInstance].neName = _nickField.text;
    return YES;
}
-(void)textFiledEditChanged:(NSNotification *)obj{
    
    
//    UITextField *textField = (UITextField *)obj.object;
//    
//    NSString *toBeString = textField.text;
    //    NSString *lang = [[[UITextInputMode activeInputModes] firstObject]primaryLanguage]; // 键盘输入模式
    UITextInputMode* input =(UITextInputMode*)[[UITextInputMode activeInputModes] firstObject];
//    NSString *lang = [input primaryLanguage];
//    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
//        UITextRange *selectedRange = [textField markedTextRange];
//        //获取高亮部分
//        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
//        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
//        if (!position) {
//            if (toBeString.length > kMaxLength) {
//                textField.text = [toBeString substringToIndex:kMaxLength];
//                
//                
//                if (textField==self.qianMingField) {
//                    
//            
//                  [self showNoticeInWindow:@"签名长度限制18位,请重新输入"];
//                    [self.qianMingField resignFirstResponder];
//                }
//            }
//        }
//        // 有高亮选择的字符串，则暂不对文字进行统计和限制
//        else{
//            
//            
//        }
//    }
//    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
//    else{
//        if (toBeString.length > kMaxLength) {
//            textField.text = [toBeString substringToIndex:kMaxLength];
//        }
//    }
    
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    if (textField == self.qianMingField) {
     
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    CGRect rect = CGRectMake(0, -120, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.view.frame = rect;
    NSLog(@"!!!~~%@",NSStringFromCGRect(self.view.frame));
    [UIView commitAnimations];
    }

}




#pragma mark -
#pragma mark UIImagePickerController Delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
	
	if ([mediaType isEqualToString:@"public.image"])
    {
        MBProgressHUD *mbProgressHud = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:mbProgressHud];
        [mbProgressHud show:YES];
        
        //[info objectForKey:@"UIImagePickerControllerEditedImage"];
        NSString *tempDir = NSTemporaryDirectory ();
        NSString *tempFile = [NSString stringWithFormat:@"%@/avatar.png",tempDir];
        UIImage *avatar = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    
        
        float scale = MAX(avatar.size.width/150,avatar.size.height/150);
        avatar = [UIImage imageWithCGImage:avatar.CGImage scale:scale orientation:UIImageOrientationUp];
        [UIImagePNGRepresentation(avatar) writeToFile:tempFile atomically:YES];
        [UserInfoManager shareUserInfoManager].tempHederImage = avatar;
        __weak typeof(self) weakSelf = self;
        updateCurrUserModel *userModel = [[updateCurrUserModel alloc] init];
        [userModel uploadDataWithFileUrl:tempFile params:nil success:^(id object) {
            __strong typeof(self) strongSelf = weakSelf;
            if (strongSelf)
            {
                /*成功返回数据*/
                if (userModel.result == 0)
                {
                    strongSelf.selectedImg = avatar;
                    strongSelf.headImgView.image = avatar;
                    strongSelf.userInfo.photo = userModel.data;
                    float quality = .00001f;
                    float blurred = .2f;
                    NSData *imageData = UIImageJPEGRepresentation([strongSelf.headImgView image], quality);
                    UIImage *blurredImage = [[UIImage imageWithData:imageData] blurredImage:blurred];
                    _backImageView.image = blurredImage;
                    
                    [UserInfoManager shareUserInfoManager].currentUserInfo.photo = userModel.data;
            
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"ShowLiveBtnOnMain" object:self userInfo:nil];

                    NSError *error;
                    [[NSFileManager defaultManager] removeItemAtPath:tempFile error:&error];
                }
            }
            [mbProgressHud hide:YES];

        } fail:^(id object) {
            /*失败返回数据*/
            [mbProgressHud hide:YES];
            [self showNoticeInWindow:@"网络连接失败，请重试" duration:1.5];
        }];
    
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}
-(void)buttonPres{
    [self popCanvasWithArgment:nil];
}

@end
