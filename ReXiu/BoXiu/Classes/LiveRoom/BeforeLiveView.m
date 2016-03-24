//
//  BeforeLiveView.m
//  BoXiu
//
//  Created by andy on 15/10/29.
//  Copyright © 2015年 rexiu. All rights reserved.
//

typedef NS_ENUM(NSUInteger,Type) {
    TIAOGUO,
    NO_TIaoGuo
};
#import "BeforeLiveView.h"
#import "UpdateIntroductionmodel.h"
#import "LiveRoomViewController.h"
#import "LiveRoomHelper.h"

#define kMaxLength 18


typedef void(^PropertyChangeBlock)(AVCaptureDevice *captureDevice);typedef void(^PropertyChangeBlock)(AVCaptureDevice *captureDevice);
@interface BeforeLiveView()<UITextFieldDelegate,UMSocialUIDelegate>
@property (strong,nonatomic)UIImageView* imageViewJiao1;
@property (strong,nonatomic)UIImageView* imageViewJiao2;
@property (strong,nonatomic)UIImageView* imageViewJiao3;
@property (strong,nonatomic)UIImageView* imageViewJiao4;

@property (strong,nonatomic)UIButton* buttonCamera;
@property (strong,nonatomic)UIButton* buttonCameraDoing;
@property (strong, nonatomic)UIButton* buttonTiaoGuo;
@property (strong, nonatomic)UIButton* buttonCamerChange;

@property(strong, nonatomic)UILabel* labelNoti;
@property (strong, nonatomic)UIButton* buttonQQ;
@property (strong, nonatomic)UIButton* buttonWX;
@property (strong, nonatomic)UIButton* buttonWB;
@property (assign, nonatomic)Type type;
@property (strong, nonatomic) UITextField* testFieldLiveSigeCount;
@property (strong ,nonatomic) NSTimer* timer;
@property (strong, nonatomic) UIControl* controlRuond;

@property (strong, nonatomic)UIImage* imageTempUpload;

@property (assign, nonatomic)BOOL isEditEd;
@property (strong, nonatomic)UIImageView* imageViewLiveSige;

@property (strong, nonatomic)UIView* viewLine;


@property (strong,nonatomic) AVCaptureDeviceInput *captureDeviceInput;//负责从AVCaptureDevice获得输入数据
@property (strong,nonatomic) AVCaptureStillImageOutput *captureStillImageOutput;//照片输出流
@property (strong,nonatomic) AVCaptureVideoPreviewLayer *captureVideoPreviewLayer;//相机拍摄预览图层
@property (strong, nonatomic)  UIView *viewContainer;
@property (weak, nonatomic)  UIButton *takeButton;//拍照按钮
@property (weak, nonatomic)  UIButton *flashAutoButton;//自动闪光灯按钮
@property (weak, nonatomic)  UIButton *flashOnButton;//打开闪光灯按钮
@property (weak, nonatomic)  UIButton *flashOffButton;//关闭闪光灯按钮
@property (weak, nonatomic)  UIImageView *focusCursor; //聚焦光标
@property (strong , nonatomic) UIControl* controlProtocl;
@property (strong, nonatomic) UIButton* buttonProtocl;




@end
@implementation BeforeLiveView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
}
- (void)initView:(CGRect)frame
{
    
    self.type = NO_TIaoGuo;
    
    self.viewContainer  = [[UIView alloc]initWithFrame:self.frame];
    self.viewContainer.userInteractionEnabled = YES;
    [self addSubview:self.viewContainer];
    
    
    _imageViewlLiveBG = [[UIImageView alloc]initWithFrame:self.frame];
    _imageViewlLiveBG .userInteractionEnabled = YES;
    _imageViewlLiveBG.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_imageViewlLiveBG];
    
    
    //_controlTopViewPhoto*******************************
    _controlTopViewPhoto = [[UIControl alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 170/2)];
    _controlTopViewPhoto.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
    [self addSubview:_controlTopViewPhoto];
    
    
    _controlRuond = [[UIControl alloc]initWithFrame:CGRectMake(11+8, 11+(25-13)/2, 13, 13)];
    _controlRuond.backgroundColor = [UIColor redColor];
    _controlRuond.layer.cornerRadius=6.5;
    [_controlTopViewPhoto addSubview:_controlRuond];
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.65 target:self selector:@selector(timetMothod) userInfo:nil repeats:YES];
    
    
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame =CGRectMake(11, 11, 230/2, 25);
    [button setTitle:@"即将开始直播" forState:UIControlStateNormal];
    button.titleEdgeInsets =  UIEdgeInsetsMake(0, 0, 0, -18);
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    button.layer.masksToBounds = YES;
    button.layer.borderWidth = 0.75;
    button.layer.cornerRadius = 12.5f;
    button.layer.borderColor = [UIColor colorWithWhite:1 alpha:0.75].CGColor;
    [_controlTopViewPhoto addSubview:button];
    
    
    _buttonCamerChange = [UIButton buttonWithType:UIButtonTypeCustom];
    [_buttonCamerChange setImage:[UIImage imageNamed:@"LRcamearChange.png"] forState:UIControlStateNormal];
    _buttonCamerChange.frame = CGRectMake(474/2-4, 6,35, 35);
    _buttonCamerChange.tag =1;
    
    [_buttonCamerChange addTarget:self action:@selector(buttonTarget:) forControlEvents:UIControlEventTouchUpInside];
    [_controlTopViewPhoto addSubview:_buttonCamerChange];
    
    
    EWPButton *closeBtn = [EWPButton buttonWithType:UIButtonTypeCustom];
    closeBtn.frame = CGRectMake(SCREEN_WIDTH - 40, 2, 40, 40);
    [closeBtn setImage:[UIImage imageNamed:@"exitroom"] forState:UIControlStateNormal];
    [_controlTopViewPhoto addSubview:closeBtn];
    closeBtn.tag =2;
    [closeBtn addTarget:self action:@selector(buttonTarget:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel* labelCount = [CommonUtils commonSignleLabelWithText:@"拍一张好看的封面可以获得更多观众" withFontSize:12 withOriginX:SCREEN_WIDTH/2 withOriginY:116/2+6 isRelativeCoordinate:NO];
    labelCount.textColor = [CommonFuction colorFromHexRGB:@"ffffff"];
    [_controlTopViewPhoto addSubview:labelCount];
    
    
    
    
    
    
    
    
    //_controlTopViewLive*******************************
    
    _controlTopViewLive = [[UIControl alloc]initWithFrame:_controlTopViewPhoto.frame];
    _controlTopViewLive.hidden = YES;
    _controlTopViewLive.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
    [self addSubview:_controlTopViewLive];
    
    UIButton* buttonBack = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonBack setImage:[UIImage imageNamed:@"navB_Nor.png"] forState:UIControlStateNormal];
    buttonBack.frame = CGRectMake(0, 2, 50, 40);
    buttonBack.tag = 101;
    buttonBack.tag = 5;
    [buttonBack addTarget:self action:@selector(buttonTarget:) forControlEvents:UIControlEventTouchUpInside];
    [_controlTopViewLive addSubview:buttonBack];
    
    
    UIImageView* imageViewReCamper = [[UIImageView alloc]initWithFrame:CGRectMake(474/2-4+10+5, 12,35, 35)];
    imageViewReCamper.image = [UIImage imageNamed:@"LRcamear.png"];
    imageViewReCamper.contentMode = UIViewContentModeTop;
    [_controlTopViewLive addSubview:imageViewReCamper];
    
    
    UILabel* labelReCamper = [CommonUtils commonSignleLabelWithText:@"重拍" withFontSize:14 withOriginX:SCREEN_WIDTH-40 withOriginY:12 isRelativeCoordinate:YES];
    labelReCamper.textColor = [CommonFuction colorFromHexRGB:@"ffffff"];
    [_controlTopViewLive addSubview:labelReCamper];
    
    UIButton* buttonReCamper =[CommonUtils commonButtonWithFrame:CGRectMake(474/2-4-10, 12, 100, 40) withTarget:self withAction:@selector(buttonTarget:) ];
    buttonReCamper.tag = 6;
    [_controlTopViewLive addSubview:buttonReCamper];
    
    
    //    UILabel* labelLiveCount = [CommonUtils commonSignleLabelWithText:@"写一个好签名可以获得更多关注" withFontSize:11 withOriginX:15 withOriginY:111/2 isRelativeCoordinate:YES];
    //    labelLiveCount.textColor = [CommonFuction colorFromHexRGB:@"ffffff"];
    //    [_controlTopViewLive addSubview:labelLiveCount];
    
    
    _testFieldLiveSigeCount = [[UITextField alloc] initWithFrame:CGRectMake(15, 111/2, SCREEN_WIDTH - 30, 16)];
    _testFieldLiveSigeCount.placeholder = @"写一个好签名可以获得更多关注";
    _testFieldLiveSigeCount.delegate = self;
    _testFieldLiveSigeCount.font = [UIFont systemFontOfSize:14.0f];
    [_testFieldLiveSigeCount setValue:[CommonFuction colorFromHexRGB:@"ffffff"] forKeyPath:@"_placeholderLabel.textColor"];
    _testFieldLiveSigeCount.backgroundColor = [UIColor clearColor];
    _testFieldLiveSigeCount.textColor = [UIColor whiteColor];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFiledEditChanged:)
                                                name:@"UITextFieldTextDidChangeNotification"
                                              object:_testFieldLiveSigeCount];
    
    _testFieldLiveSigeCount.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _imageViewLiveSige = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 13, 13   )];
    _imageViewLiveSige.image = [UIImage imageNamed:@"person_edit_normal"];
    //    _testFieldLiveSigeCount
    //    _testFieldLiveSigeCount.rightView = imageViewLiveSige;
    //    _testFieldLiveSigeCount.rightViewMode = UITextFieldViewModeUnlessEditing;
    //    [_testFieldLiveSigeCount sizeToFit];
    
    [self setImageViewFrame];
    
    
    
    [_controlTopViewLive addSubview:_imageViewLiveSige];
    [_controlTopViewLive addSubview:_testFieldLiveSigeCount];
    
    
    
    
    _viewLine = [CommonUtils CommonViewLineWithFrame:CGRectMake(CGRectGetMinX(_testFieldLiveSigeCount.frame), CGRectGetMaxY(_testFieldLiveSigeCount.frame)+8+2, SCREEN_WIDTH-CGRectGetMinX(_testFieldLiveSigeCount.frame)*2, 1)];
    _viewLine.backgroundColor = [CommonFuction colorFromHexRGB:@"cbcbcb"];
    _viewLine.hidden = YES;
    [_controlTopViewLive addSubview:_viewLine];
    
    
    
    
    
    
    _controlMiddleView = [[UIControl alloc]initWithFrame:CGRectMake(0,170/2, SCREEN_WIDTH, 338/2)];
    [self addSubview:_controlMiddleView];
    
    UIImage* imageJiao1 = [UIImage imageNamed:@"LRjiao.png"];
    
    _imageViewJiao1 = [[UIImageView alloc]initWithFrame:CGRectMake(6, 6, 12, 12)];
    _imageViewJiao1.image = imageJiao1;
    [_controlMiddleView addSubview:_imageViewJiao1];
    
    _imageViewJiao2 = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-12-6, 6, 12, 12)];
    _imageViewJiao2.image = [self image:imageJiao1 rotation:UIImageOrientationRight];
    [_controlMiddleView addSubview:_imageViewJiao2];
    
    _imageViewJiao3 = [[UIImageView alloc]initWithFrame:CGRectMake(6, 338/2-12-6, 12, 12)];
    _imageViewJiao3.image = [self image:imageJiao1 rotation: UIImageOrientationLeft];
    [_controlMiddleView addSubview:_imageViewJiao3];
    
    _imageViewJiao4 = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-12-6, 338/2-12-6, 12, 12)];
    _imageViewJiao4.image = [self image:imageJiao1 rotation:UIImageOrientationDown];
    [_controlMiddleView addSubview:_imageViewJiao4];
    
    
    
    
    
    
    _controlBeloiew = [[UIControl alloc]initWithFrame:CGRectMake(0,170/2+338/2, SCREEN_WIDTH, SCREEN_HEIGHT-170/2-338/2)];
    _controlBeloiew.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
    [self addSubview:_controlBeloiew];
    
    _buttonCamera = [UIButton buttonWithType:UIButtonTypeCustom];
    _buttonCamera.frame = CGRectMake((SCREEN_WIDTH-261/2)/2, 684/2-CGRectGetMaxY(_controlMiddleView.frame), 261/2, 261/2);
    [_buttonCamera setImage:[UIImage imageNamed:@"LRbutton"] forState:UIControlStateNormal];
    [_controlBeloiew addSubview:_buttonCamera];
    
    _buttonCameraDoing = [UIButton buttonWithType:UIButtonTypeCustom];
    _buttonCameraDoing.frame = _buttonCamera.frame;
    _buttonCameraDoing.titleLabel.font = [UIFont systemFontOfSize:19];
    [_buttonCameraDoing setTitle:@"拍摄封面" forState:UIControlStateNormal];
    [_buttonCameraDoing setTitleColor:[CommonFuction colorFromHexRGB:@"ffffff"] forState:UIControlStateNormal];
    
    _buttonCameraDoing.tag =3;
    [_buttonCameraDoing addTarget:self action:@selector(buttonTarget:) forControlEvents:UIControlEventTouchUpInside];
    [_controlBeloiew addSubview:_buttonCameraDoing];
    
    
    _buttonTiaoGuo =[UIButton buttonWithType:UIButtonTypeCustom];
    _buttonTiaoGuo.frame = CGRectMake(SCREEN_WIDTH-22-43, SCREEN_HEIGHT-34-40-CGRectGetMaxY(_controlMiddleView.frame), 60, 40);
    _buttonTiaoGuo.titleLabel.font = [UIFont systemFontOfSize:15];
    [_buttonTiaoGuo setTitle:@"跳过" forState:UIControlStateNormal];
    [_buttonTiaoGuo setTitleColor:[CommonFuction colorFromHexRGB:@"a7a7a7a"] forState:UIControlStateNormal];
    _buttonTiaoGuo.tag =4;
    [_buttonTiaoGuo addTarget:self action:@selector(buttonTarget:) forControlEvents:UIControlEventTouchUpInside];
    [_controlBeloiew addSubview:_buttonTiaoGuo];
    
    
    NSString *adphoto=  [UserInfoManager shareUserInfoManager].getUserInfoModel.userInfo.adphoto;
    if (adphoto == nil) {
        _buttonTiaoGuo.hidden = YES;
    }else{
        _buttonTiaoGuo.hidden = NO;
    }
    
    
    
    
    
    //初始化会话
    
    CGFloat dis_ControlBeloiew_miny =170/2+338/2;
    
    _labelNoti =[CommonUtils commonSignleLabelWithText:@"通知好友来围观" withFontSize:12 withOriginX:SCREEN_WIDTH/2  withOriginY:660/2-5+2+3+2+1-dis_ControlBeloiew_miny isRelativeCoordinate:NO];
    _labelNoti.textColor = [CommonFuction colorFromHexRGB:@"ffffff"];
    [_controlBeloiew addSubview:_labelNoti];
    
    
    CGFloat distanceLfet =36;
    CGFloat distanceAnther = (SCREEN_WIDTH-distanceLfet*2-73*3)/2;
    
    
    NSInteger hideSwitch = [[[AppInfo shareInstance].hideSwitch substringFromIndex:1] integerValue];
    if(hideSwitch != 1)
    {
        _buttonQQ = [UIButton buttonWithType:UIButtonTypeCustom];
        _buttonQQ.frame =CGRectMake(distanceLfet, 728/2-dis_ControlBeloiew_miny, 73, 25);
        [_buttonQQ setImage:[UIImage imageNamed:@"LRqq.png"] forState:UIControlStateNormal];
        [_buttonQQ setTitle:@"QQ" forState:UIControlStateNormal];
        _buttonQQ.titleEdgeInsets =  UIEdgeInsetsMake(0, 0, 0, -8);
        _buttonQQ.imageEdgeInsets =  UIEdgeInsetsMake(0, 0, 0, 8);
        [_buttonQQ setTitleColor:[CommonFuction colorFromHexRGB:@"ffffff"] forState:UIControlStateNormal];
        _buttonQQ.titleLabel.font =[UIFont systemFontOfSize:12];
        [_buttonQQ.layer setMasksToBounds:YES];
        _buttonQQ.layer.borderWidth = 0.75;
        _buttonQQ.layer.borderColor= [UIColor colorWithWhite:1 alpha:0.2].CGColor;
        _buttonQQ.layer.cornerRadius = 12.5;
        _buttonQQ.tag = 7;
        [_buttonQQ addTarget:self action:@selector(buttonTarget:) forControlEvents:UIControlEventTouchUpInside];
        [_controlBeloiew addSubview:_buttonQQ];
        
        
        _buttonWX = [UIButton buttonWithType:UIButtonTypeCustom];
        _buttonWX.frame =CGRectMake(CGRectGetMaxX(_buttonQQ.frame)+distanceAnther, 728/2-dis_ControlBeloiew_miny, 73, 25);
        [_buttonWX setImage:[UIImage imageNamed:@"LRwx.png"] forState:UIControlStateNormal];
        [_buttonWX setTitle:@"微信" forState:UIControlStateNormal];
        _buttonWX.titleEdgeInsets =  UIEdgeInsetsMake(0, 0, 0, -8);
        _buttonWX.imageEdgeInsets =  UIEdgeInsetsMake(0, 0, 0, 8);
        [_buttonWX setTitleColor:[CommonFuction colorFromHexRGB:@"ffffff"] forState:UIControlStateNormal];
        _buttonWX.titleLabel.font =[UIFont systemFontOfSize:12];
        [_buttonWX.layer setMasksToBounds:YES];
        _buttonWX.layer.borderWidth = 0.75;
        _buttonWX.layer.borderColor= [UIColor colorWithWhite:1 alpha:0.2].CGColor;
        _buttonWX.layer.cornerRadius = 12.5;
        
        _buttonWX.tag = 8;
        [_buttonWX addTarget:self action:@selector(buttonTarget:) forControlEvents:UIControlEventTouchUpInside];
        [_controlBeloiew addSubview:_buttonWX];
        
        
        
        _buttonWB = [UIButton buttonWithType:UIButtonTypeCustom];
        _buttonWB.frame =CGRectMake(CGRectGetMaxX(_buttonWX.frame)+distanceAnther, 728/2-dis_ControlBeloiew_miny, 73, 25);
        [_buttonWB setImage:[UIImage imageNamed:@"LRwb.png"] forState:UIControlStateNormal];
        [_buttonWB setTitle:@"微博" forState:UIControlStateNormal];
        _buttonWB.titleEdgeInsets =  UIEdgeInsetsMake(0, 0, 0, -8);
        _buttonWB.imageEdgeInsets =  UIEdgeInsetsMake(0, 0, 0, 8);
        [_buttonWB setTitleColor:[CommonFuction colorFromHexRGB:@"ffffff"] forState:UIControlStateNormal];
        _buttonWB.titleLabel.font =[UIFont systemFontOfSize:12];
        [_buttonWB.layer setMasksToBounds:YES];
        _buttonWB.layer.borderWidth = 0.75;
        _buttonWB.layer.borderColor= [UIColor colorWithWhite:1 alpha:0.2].CGColor;
        _buttonWB.layer.cornerRadius = 12.5;
        _buttonWB.tag = 9;
        [_buttonWB addTarget:self action:@selector(buttonTarget:) forControlEvents:UIControlEventTouchUpInside];
        [_controlBeloiew addSubview:_buttonWB];
        
    }
    
    
    _buttonLiving = [EWPButton buttonWithType:UIButtonTypeCustom];
    _buttonLiving.frame = CGRectMake(0, 0, 528/2, 40);
    _buttonLiving.layer.cornerRadius = 20;
    _buttonLiving.center = CGPointMake(self.center.x, 850/2+20-dis_ControlBeloiew_miny);
    _buttonLiving.backgroundColor = [CommonFuction colorFromHexRGB:@"d14c49" alpha:0.7f];
    [_buttonLiving setTitle:@"开始直播" forState:UIControlStateNormal];
    _buttonLiving.tag = 10;
    [_buttonLiving addTarget:self action:@selector(buttonTarget:) forControlEvents:UIControlEventTouchUpInside];
    [_controlBeloiew addSubview:_buttonLiving];
    
    _controlProtocl = [[UIControl alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-45-13, SCREEN_WIDTH, 30)];
    _controlProtocl.hidden = YES;
    [self addSubview:_controlProtocl];
    UILabel* labelProtocl = [CommonUtils commonSignleLabelWithText:@"开播即视为同意开播协议" withFontSize:13 withOriginX:0 withOriginY:0 isRelativeCoordinate:NO];
    labelProtocl.textColor = [CommonUtils colorFromHexRGB:@"959596"];
    labelProtocl.center = CGPointMake(SCREEN_WIDTH/2+6+15, 15);
    [_controlProtocl addSubview:labelProtocl];
    
    
    _buttonProtocl = [UIButton buttonWithType:UIButtonTypeCustom];
    _buttonProtocl.frame =CGRectMake(labelProtocl.frameX-15-6-6, 0, 30, 30);
    [_buttonProtocl setImage:[UIImage imageNamed:@"LRxuan.png"] forState:UIControlStateNormal];
    [_buttonProtocl addTarget:self action:@selector(buttonTarget:) forControlEvents:UIControlEventTouchUpInside];
    _buttonProtocl.tag = 11;
    [_controlProtocl addSubview:_buttonProtocl];
    
    [self setHidd_controlBeloiewWith:YES];
    
    EWPButton* buttonProLabel  =[EWPButton buttonWithType:UIButtonTypeCustom];
    buttonProLabel.frame  = labelProtocl.frame ;
    buttonProLabel.isSoonCliCKLimit= YES;
    buttonProLabel.tag = 13;
    [buttonProLabel addTarget:self action:@selector(buttonTarget:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [_controlProtocl addSubview:buttonProLabel];
    
//    [self startCaptureSession];
    
}
//-(void)startCaptureSession{
//    _captureSession=[[AVCaptureSession alloc]init];
//    if ([_captureSession canSetSessionPreset:AVCaptureSessionPreset1280x720]) {//设置分辨率
//        _captureSession.sessionPreset=AVCaptureSessionPreset1280x720;
//    }
//    //获得输入设备
//    AVCaptureDevice *captureDevice=[self getCameraDeviceWithPosition:AVCaptureDevicePositionBack];//取得后置摄像头
//    if (!captureDevice) {
//        NSLog(@"取得后置摄像头时出现问题.");
//        return;
//    }
//    
//    
//}
//-(void)startCaptureSession{

    
    
    
    //    _captureSession=[[AVCaptureSession alloc]init];
    //    if ([_captureSession canSetSessionPreset:AVCaptureSessionPreset1280x720]) {//设置分辨率
    //        _captureSession.sessionPreset=AVCaptureSessionPreset1280x720;
    //    }
    //    //获得输入设备
    //    AVCaptureDevice *captureDevice=[self getCameraDeviceWithPosition:AVCaptureDevicePositionBack];//取得后置摄像头
    //    if (!captureDevice) {
    //        NSLog(@"取得后置摄像头时出现问题.");
    //        return;
    //    }
    //
    //    NSError *error=nil;
    //    //根据输入设备初始化设备输入对象，用于获得输入数据
    //    _captureDeviceInput=[[AVCaptureDeviceInput alloc]initWithDevice:captureDevice error:&error];
    //    if (error) {
    //        NSLog(@"取得设备输入对象时出错，错误原因：%@",error.localizedDescription);
    //        return;
    //    }
    //    //初始化设备输出对象，用于获得输出数据
    //    _captureStillImageOutput=[[AVCaptureStillImageOutput alloc]init];
    //    NSDictionary *outputSettings = @{AVVideoCodecKey:AVVideoCodecJPEG};
    //    [_captureStillImageOutput setOutputSettings:outputSettings];//输出设置
    //
    //    //将设备输入添加到会话中
    //    if ([_captureSession canAddInput:_captureDeviceInput]) {
    //        [_captureSession addInput:_captureDeviceInput];
    //    }
    //
    //    //将设备输出添加到会话中
    //    if ([_captureSession canAddOutput:_captureStillImageOutput]) {
    //        [_captureSession addOutput:_captureStillImageOutput];
    //    }
    //
    //    //创建视频预览层，用于实时展示摄像头状态
    //    _captureVideoPreviewLayer=[[AVCaptureVideoPreviewLayer alloc]initWithSession:self.captureSession];
    //
    //    CALayer *layer=self.viewContainer.layer;
    //    layer.masksToBounds=YES;
    //
    //    _captureVideoPreviewLayer.frame=layer.bounds;
    //    _captureVideoPreviewLayer.videoGravity=AVLayerVideoGravityResizeAspectFill;//填充模式
    //    //将视频预览层添加到界面中
    //    [layer addSublayer:_captureVideoPreviewLayer];
    //
    
    
    //
    //    [self.captureSession startRunning];
    
    //    _captureVideoPreviewLayer.frame=layer.bounds;
    //    _captureVideoPreviewLayer.videoGravity=AVLayerVideoGravityResizeAspectFill;//填充模式
    //    //将视频预览层添加到界面中
    //    [layer addSublayer:_captureVideoPreviewLayer];
    //
    //
    //
    //    [self.captureSession startRunning];
    
//}
#pragma mark-检查含有表情
- (BOOL)isContainsEmoji:(NSString *)string {
    __block BOOL isEomji = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        const unichar hs = [substring characterAtIndex:0];
        // surrogate pair
        if (0xd800 <= hs && hs <= 0xdbff) {
            if (substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                if (0x1d000 <= uc && uc <= 0x1f77f) {
                    isEomji = YES;
                }
            }
        } else {
            // non surrogate
            if (0x2100 <= hs && hs <= 0x27ff && hs != 0x263b) {
                isEomji = YES;
            } else if (0x2B05 <= hs && hs <= 0x2b07) {
                isEomji = YES;
            } else if (0x2934 <= hs && hs <= 0x2935) {
                isEomji = YES;
            } else if (0x3297 <= hs && hs <= 0x3299) {
                isEomji = YES;
            } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50|| hs == 0x231a ) {
                isEomji = YES;
            }
            if (!isEomji && substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                if (ls == 0x20e3) {
                    isEomji = YES;
                }
            }
        }
    }];
    return isEomji;
}
-(void)setImageViewFrame{
    
    CGSize size;
    
    if (_testFieldLiveSigeCount.text.length==0) {
        size = [CommonFuction sizeOfString:_testFieldLiveSigeCount.placeholder maxWidth:600 maxHeight:100 withFontSize:14.0f];
    }else{
        size = [CommonFuction sizeOfString:_testFieldLiveSigeCount.text maxWidth:600 maxHeight:100 withFontSize:14.0f];
        
    }
    
    
    
    
    
    
    _imageViewLiveSige.frame = CGRectMake(15+size.width+2+2+2+2, 111/2, 13, 13);
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    self.isEditEd = YES;
    _imageViewLiveSige.hidden = YES;
    //    _testFieldLiveSigeCount.rightViewMode = UITextFieldViewModeNever;
    //    _testFieldLiveSigeCount.frame = CGRectMake(15, 111/2, SCREEN_WIDTH - 30, 13);
    [self setImageViewFrame];
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    _imageViewLiveSige.hidden = NO;
    //    _testFieldLiveSigeCount.rightViewMode = UITextFieldViewModeUnlessEditing;
    //
    //
    //    if (textField.text.length!=0) {
    //        _testFieldLiveSigeCount.placeholder =[NSString stringWithFormat:@"   %@",textField.text];
    //    }
    //    [_testFieldLiveSigeCount sizeToFit];
    [self setImageViewFrame];
    [_testFieldLiveSigeCount resignFirstResponder];
    return YES;
}


-(void)textFiledEditChanged:(NSNotification *)obj{
    
    
    //    UITextField *textField = (UITextField *)obj.object;
    //
    //    NSString *toBeString = textField.text;
    //    //    NSString *lang = [[[UITextInputMode activeInputModes] firstObject]primaryLanguage]; // 键盘输入模式
    //    UITextInputMode* input =(UITextInputMode*)[[UITextInputMode activeInputModes] firstObject];
    //    NSString *lang = [input primaryLanguage];
    //    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
    //        UITextRange *selectedRange = [textField markedTextRange];
    //        //获取高亮部分
    //        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
    //        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
    //        if (!position) {
    //            if (toBeString.length > kMaxLength) {
    //                textField.text = [toBeString substringToIndex:kMaxLength];
    //            }
    //        }
    //        // 有高亮选择的字符串，则暂不对文字进行统计和限制
    //        else{
    //        }
    //    }
    //    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    //    else{
    //        if (toBeString.length > kMaxLength) {
    //            textField.text = [toBeString substringToIndex:kMaxLength];
    //        }
    //    }
    
}
-(void)setHidd_controlBeloiewWith:(BOOL)bol{
    
    
    _testFieldLiveSigeCount.placeholder = @"写一个好签名可以获得更多关注";
    _testFieldLiveSigeCount.text = @"";
    //    _testFieldLiveSigeCount.rightViewMode = UITextFieldViewModeUnlessEditing;
    //    [_testFieldLiveSigeCount sizeToFit];
    [self setImageViewFrame];
    [_testFieldLiveSigeCount resignFirstResponder];
    
    
    
    
    CGFloat dis_ControlBeloiew_miny =170/2+338/2  -18;
    if (bol) {
        
        
        
        _imageViewlLiveBG.image = nil;
        
        
        
        _controlBeloiew.frame =  CGRectMake(0,170/2+338/2, SCREEN_WIDTH, SCREEN_HEIGHT-170/2-338/2);
        if (self.type == TIAOGUO) {
            _labelNoti.center = CGPointMake(_labelNoti.center.x, _labelNoti.center.y+(121-(660/2-5-dis_ControlBeloiew_miny)));
            _buttonQQ.center =CGPointMake(_buttonQQ.center.x, _buttonQQ.center.y+(121-(660/2-5-dis_ControlBeloiew_miny)));
            _buttonWX.center =CGPointMake(_buttonWX.center.x, _buttonWX.center.y+(121-(660/2-5-dis_ControlBeloiew_miny)));
            _buttonWB.center =CGPointMake(_buttonWB.center.x, _buttonWB.center.y+(121-(660/2-5-dis_ControlBeloiew_miny)));
            _buttonLiving.center =CGPointMake(_buttonLiving.center.x, _buttonLiving.center.y+(121-(660/2-5-dis_ControlBeloiew_miny)));
            
        }
        
        
        //上
        self.type = NO_TIaoGuo;
        _controlTopViewLive.hidden = YES;
        _controlTopViewPhoto.hidden = NO;
        
        
        
        //        中
        _imageViewJiao1.hidden = NO;
        _imageViewJiao2.hidden = NO;
        _imageViewJiao3.hidden = NO;
        _imageViewJiao4.hidden = NO;
        
        
        //        下
        _buttonLiving.hidden = YES;
        _buttonCameraDoing.hidden = NO;
        _buttonCamera.hidden = NO;
        
        _labelNoti.hidden = YES;
        _buttonQQ.hidden = YES;
        _buttonWX.hidden = YES;
        _buttonWB.hidden = YES;
        _buttonLiving.hidden = YES;
        
        _viewLine.hidden = YES;
        
        _controlProtocl.hidden = YES;
        NSString *adphoto=  [UserInfoManager shareUserInfoManager].getUserInfoModel.userInfo.adphoto;
        
        if (adphoto == nil) {
            
        }else{
            _buttonTiaoGuo.hidden = NO;
        }
        
    }else{
        
        if (self.type == TIAOGUO) {
            _controlBeloiew.frame =  CGRectMake(0,170/2, SCREEN_WIDTH, SCREEN_HEIGHT-170/2);
            
            
            
            _labelNoti.center = CGPointMake(_labelNoti.center.x, _labelNoti.center.y-(121-(660/2-5-dis_ControlBeloiew_miny)));
            _buttonQQ.center =CGPointMake(_buttonQQ.center.x, _buttonQQ.center.y-(121-(660/2-5-dis_ControlBeloiew_miny)));
            _buttonWX.center =CGPointMake(_buttonWX.center.x, _buttonWX.center.y-(121-(660/2-5-dis_ControlBeloiew_miny)));
            _buttonWB.center =CGPointMake(_buttonWB.center.x, _buttonWB.center.y-(121-(660/2-5-dis_ControlBeloiew_miny)));
            _buttonLiving.center =CGPointMake(_buttonLiving.center.x, _buttonLiving.center.y-(121-(660/2-5-dis_ControlBeloiew_miny)));
            
            _viewLine.hidden = NO;
        }
        
        //上
        _controlTopViewLive.hidden = NO;
        _controlTopViewPhoto.hidden = YES;
        
        
        
        //        中
        _imageViewJiao1.hidden = YES;
        _imageViewJiao2.hidden = YES;
        _imageViewJiao3.hidden = YES;
        _imageViewJiao4.hidden = YES;
        
        
        //        下
        _buttonLiving.hidden = NO;
        
        _buttonCamera.hidden = YES;
        _buttonCameraDoing.hidden = YES;
        
        _labelNoti.hidden = NO;
        _buttonQQ.hidden = NO;
        _buttonWX.hidden = NO;
        _buttonWB.hidden = NO;
        
        
        
        _controlProtocl.hidden = NO;;
        self.imageViewLiveSige.hidden = NO;
        //        NSString *adphoto=  [UserInfoManager shareUserInfoManager].currentStarInfo.adphoto;
        //        if (adphoto == nil) {
        _buttonTiaoGuo.hidden = YES;
        //        }
    }
}
- (void)viewWillAppear
{
    [super viewWillAppear];
    
}


#pragma mark - 私有方法

/**
 *  取得指定位置的摄像头
 *
 *  @param position 摄像头位置
 *
 *  @return 摄像头设备
 */
-(AVCaptureDevice *)getCameraDeviceWithPosition:(AVCaptureDevicePosition )position{
    NSArray *cameras= [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *camera in cameras) {
        if ([camera position]==position) {
            return camera;
        }
    }
    return nil;
}


- (UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation
{
    long double rotate = 0.0;
    CGRect rect;
    float translateX = 0;
    float translateY = 0;
    float scaleX = 1.0;
    float scaleY = 1.0;
    
    switch (orientation) {
        case UIImageOrientationLeft:
            rotate = M_PI_2;
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = 0;
            translateY = -rect.size.width;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationRight:
            rotate = 3 * M_PI_2;
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = -rect.size.height;
            translateY = 0;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationDown:
            rotate = M_PI;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = -rect.size.width;
            translateY = -rect.size.height;
            break;
        default:
            rotate = 0.0;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = 0;
            translateY = 0;
            break;
    }
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //做CTM变换
    CGContextTranslateCTM(context, 0.0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextRotateCTM(context, rotate);
    CGContextTranslateCTM(context, translateX, translateY);
    
    CGContextScaleCTM(context, scaleX, scaleY);
    //绘制图片
    CGContextDrawImage(context, CGRectMake(0, 0, rect.size.width, rect.size.height), image.CGImage);
    
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    
    return newPic;
}

#pragma mark- targetPressed
-(void)buttonTarget:(UIButton*)sender{
    
    if (sender.tag==1) {
//        [self toggleButtonClick];//切换摄像头
              [self.deleate  beforeLiveViewDeleateWithIndex:sender.tag];//关闭
        return;
    }
    if (sender.tag==2 ) {
        
        
        
        [self.deleate  beforeLiveViewDeleateWithIndex:sender.tag];//关闭
        [self viewwillDisappear];
        return;
    }
    
    if (sender.tag==3) {//拍照
        
        [self.deleate  beforeLiveViewDeleateWithIndex:sender.tag];//关闭
        //        [self takePicture];
        
        [self setHidd_controlBeloiewWith:NO];
        return;
    }
    if (sender.tag==4) {//跳过
        
        
        //        NSString *adphoto=  [UserInfoManager shareUserInfoManager].currentStarInfo.adphoto;
        //        if (adphoto != nil) {
        self.type = TIAOGUO;
        
        [self setHidd_controlBeloiewWith:NO];
        //        }else{
        //            [self.rootViewController showNoticeInWindow:@"请先拍摄封面"];
        //        }
        
        
        return;
    }
    if (sender.tag==5) {//返回
           _buttonProtocl.tag = 12;
              [self buttonTarget:_buttonProtocl];
        
        [self setHidd_controlBeloiewWith:YES];
        
        
                [self.deleate  beforeLiveViewDeleateWithIndex:sender.tag];//关闭
        return;
    }
    if (sender.tag==6) {//重拍
        
        _buttonProtocl.tag = 12;
        [self buttonTarget:_buttonProtocl];
                [self.deleate  beforeLiveViewDeleateWithIndex:sender.tag];//关闭
        [self setHidd_controlBeloiewWith:YES];
        
        
        return;
    }
    if (sender.tag==7 || sender.tag==8||sender.tag==9) {//QQ
        

        
        
        
        UserInfo *userInfo = [UserInfoManager shareUserInfoManager].currentUserInfo;
        if (userInfo)
        {
            
            
            NSArray* array = nil;
            if (sender.tag ==  7) {
                array = @[UMShareToQQ];
            }
            if (sender.tag ==  8) {
                array = @[UMShareToWechatSession];
            }
            if (sender.tag ==  9) {
                array = @[UMShareToSina];
            }
            NSString* strQianMingCount =nil;
            
          
            
            
            NSString *sharelink = [NSString stringWithFormat:@"http://www.51rebo.cn/%ld",(long)[UserInfoManager shareUserInfoManager].currentStarInfo.idxcode];
            [UMSocialData defaultData].extConfig.wechatSessionData.url = sharelink;
            [UMSocialData defaultData].extConfig.wechatTimelineData.url = sharelink;
           
            [UMSocialData defaultData].extConfig.qqData.url = sharelink;
            [UMSocialData defaultData].extConfig.qzoneData.url = sharelink;
            [UMSocialData defaultData].extConfig.title = @"#热波间#最火的全民娱乐直播在线平台，潮人聚集地";
     
            if ([ [UserInfoManager shareUserInfoManager].currentUserInfo.introduction toString].length!=0 && [[_testFieldLiveSigeCount.text toString]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length==0) {//有签名，没有修改过的，用原来的
                strQianMingCount =[UserInfoManager shareUserInfoManager].currentUserInfo.introduction;
                
            }else if ([[_testFieldLiveSigeCount.text toString]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length==0){//没有签名，没有被修改过的，用默认的
                strQianMingCount = @"全民星直播互动平台，娱乐你的生活";
            }else{//没有签名，有修改过的
                strQianMingCount = _testFieldLiveSigeCount.text;
            }
            
            
            [UMSocialConfig setFinishToastIsHidden:YES position:nil];
            
            [UMSocialData defaultData].extConfig.wechatTimelineData.title = [NSString stringWithFormat:@"我正在#热波间#直播“%@”，快点来捧场吧！",strQianMingCount];
            
            NSString* strCountent  = nil;
            if (sender.tag==9) {
                strCountent =[NSString stringWithFormat:@"我正在#热波间#直播“%@”，快点来捧场吧！ %@",strQianMingCount,sharelink];
            }else{
                strCountent= [NSString stringWithFormat:@"我正在#热波间#直播“%@”，快点来捧场吧！",strQianMingCount];
            }
            
            
            [[UMSocialDataService defaultDataService]  postSNSWithTypes:array content:strCountent image:[UIImage imageNamed:@"reboLogo"] location:nil urlResource:nil presentedController:self.rootViewController completion:^(UMSocialResponseEntity *response){
                if (response.responseCode == UMSResponseCodeSuccess) {
                    
                    
                    //                    if ([[array objectAtIndex:0]isEqualToString:UMShareToSina]) {
                    [self.rootViewController showNoticeInWindow:@"分享成功"];
                    //                    }
                    
                }else{
                    //                    if ([[array objectAtIndex:0]isEqualToString:UMShareToSina]) {
                    
                    
                    [self.rootViewController showNoticeInWindow:@"分享失败"];
                    
                    
                    //                    }
                    
                }
            }];
            
            
            
            
        }
        
        return;
    }
    if (sender.tag==8) {//WX
        
        
        
        
        return;
    }
    if (sender.tag==9) {//WB
        
        
        
        
        return;
    }
    if (sender.tag==10) {//开始直播
        BOOL isHaveEjmail =  [self isContainsEmoji:self.testFieldLiveSigeCount.text];
        
        if (isHaveEjmail) {
            [self.rootViewController showNoticeInWindow:@"修改签名失败，签名不能包含特殊字符"];
            return;
        }
        
        if ([ [UserInfoManager shareUserInfoManager].currentUserInfo.introduction toString].length!=0 && [_testFieldLiveSigeCount.text toString].length==0) {
            
        }else{
            if ([[_testFieldLiveSigeCount.text toString] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length >18) {
                
                [self.rootViewController showNoticeInWindow:@"签名长度限制18位,请重新输入"];
                return;
            }
            
            
        }
        
        
        [self.deleate  beforeLiveViewDeleateWithIndex:sender.tag];//关闭
        
        
        return;
    }
    if (sender.tag ==11) {
        [_buttonProtocl setImage: [UIImage imageNamed:@"LRwei.png"] forState:UIControlStateNormal];
        sender.tag=12;
        //        _buttonLiving.enabled = NO;
        _buttonLiving.userInteractionEnabled = NO;
        _buttonLiving.backgroundColor = [CommonFuction colorFromHexRGB:@"959596" alpha:0.7f];
        
        return;
    }
    if (sender.tag==12) {
        [_buttonProtocl setImage: [UIImage imageNamed:@"LRxuan.png"] forState:UIControlStateNormal];
        
        sender.tag=11;
        //        _buttonLiving.enabled = YES;
        _buttonLiving.userInteractionEnabled = YES;
        _buttonLiving.backgroundColor = [CommonFuction colorFromHexRGB:@"d14c49" alpha:0.7f];
    }
    if (sender.tag==13) {
           [self.deleate  beforeLiveViewDeleateWithIndex:sender.tag];//关闭
    }


    
}
//-(void)takePicture{
//    //根据设备输出获得连接
//    AVCaptureConnection *captureConnection=[self.captureStillImageOutput connectionWithMediaType:AVMediaTypeVideo];
//    //根据连接取得设备输出的数据
//    [self.captureStillImageOutput captureStillImageAsynchronouslyFromConnection:captureConnection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
//        if (imageDataSampleBuffer) {
//            NSData *imageData=[AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
//            UIImage *image=[UIImage imageWithData:imageData];
//            _imageViewlLiveBG.image = image;
//            image = [self image:image scaledToSize:CGSizeMake(image.size.width, image.size.height)];
//            image = [ self cutImage:image];
//            self.imageTempUpload = image;
//            
//            NSString *tempDir = NSTemporaryDirectory ();
//            NSString *tempFile = [NSString stringWithFormat:@"%@/TempHaiB.png",tempDir];
//            
//            [UIImagePNGRepresentation(self.imageTempUpload) writeToFile:tempFile atomically:YES];
//            
//        }
//        
//    }];
//    
//}

////裁剪图片
//- (UIImage *)cutImage:(UIImage*)image
//{
//    //压缩图片
//    CGSize newSize;
//    CGImageRef imageRef = nil;
//    
//    if ((image.size.width / image.size.height) < (_controlMiddleView.frame.size.width / _controlMiddleView.frame.size.height)) {
//        newSize.width = image.size.width;
//        newSize.height = image.size.width * SCREEN_WIDTH*3/4 / _controlMiddleView.frame.size.width;
//        
//        imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(_controlMiddleView.frame.origin.x, _controlMiddleView.frame.origin.y+105, newSize.width, newSize.height));
//        
//    } else {
//        newSize.height = image.size.height;
//        newSize.width = image.size.height * _controlMiddleView.frame.size.width / _controlMiddleView.frame.size.height;
//        
//        imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(fabs(image.size.width - newSize.width) / 2, 0, newSize.width, newSize.height));
//        
//    }
//    
//    return [UIImage imageWithCGImage:imageRef];
//}
//- (UIImage *)image:(UIImage*)image scaledToSize:(CGSize)newSize
//{
//    // Create a graphics image context
//    UIGraphicsBeginImageContext(newSize);
//    // Tell the old image to draw in this new context, with the desired
//    // new size
//    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
//    // Get the new image from the context
//    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
//    // End the context
//    UIGraphicsEndImageContext();
//    // Return the new image.
//    return newImage;
//}
//#pragma mark 切换前后摄像头
//- (void)toggleButtonClick {
//    AVCaptureDevice *currentDevice=[self.captureDeviceInput device];
//    AVCaptureDevicePosition currentPosition=[currentDevice position];
//    AVCaptureDevice *toChangeDevice;
//    AVCaptureDevicePosition toChangePosition=AVCaptureDevicePositionFront;
//    if (currentPosition==AVCaptureDevicePositionUnspecified||currentPosition==AVCaptureDevicePositionFront) {
//        toChangePosition=AVCaptureDevicePositionBack;
//    }
//    toChangeDevice=[self getCameraDeviceWithPosition:toChangePosition];
//    
//    AVCaptureDeviceInput *toChangeDeviceInput=[[AVCaptureDeviceInput alloc]initWithDevice:toChangeDevice error:nil];
//    
//    //改变会话的配置前一定要先开启配置，配置完成后提交配置改变
//    [self.captureSession beginConfiguration];
//    //移除原有输入对象
//    [self.captureSession removeInput:self.captureDeviceInput];
//    //添加新的输入对象
//    if ([self.captureSession canAddInput:toChangeDeviceInput]) {
//        [self.captureSession addInput:toChangeDeviceInput];
//        self.captureDeviceInput=toChangeDeviceInput;
//    }
//    //提交会话配置
//    [self.captureSession commitConfiguration];
//    
//    [self setFlashModeButtonStatus];
//}
//-(void)setFlashModeButtonStatus{
//    AVCaptureDevice *captureDevice=[self.captureDeviceInput device];
//    if([captureDevice isFlashAvailable]){
//        //        [_buttonCamerChange setImage:[UIImage imageNamed:@"LRcamear"] forState:UIControlStateNormal];
//    }else{
//        //        [_buttonCamerChange setImage:[UIImage imageNamed:@"LRcamearChange"] forState:UIControlStateNormal];
//    }
//}
//
//-(UIImage*)getChangedImageWithImage:(UIImage*)image withRect:(CGRect)rect{
//    
//    image = [self image:image rotation:UIImageOrientationLeft];
//    
//    UIGraphicsBeginImageContext(rect.size);//根据size大小创建一个基于位图的图形上下文
//    CGContextRef currentContext = UIGraphicsGetCurrentContext();//获取当前quartz 2d绘图环境
//    CGContextClipToRect( currentContext, rect);//设置当前绘图环境到矩形框
//    
//    CGContextDrawImage(currentContext, rect, image.CGImage);//绘图
//    UIImage *cropped = UIGraphicsGetImageFromCurrentImageContext();//获得图片
//    UIGraphicsEndImageContext();//从当前堆栈中删除quartz 2d绘图环境
//    return cropped;
//    
//}
- (void)viewwillDisappear
{
    [super viewwillDisappear];
    self.isSelfLivPrepareTime = NO;
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"UITextFieldTextDidChangeNotification" object:nil];
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    
    
    [_controlBeloiew removeFromSuperview];
    _controlBeloiew = nil;
    
    [_controlMiddleView removeFromSuperview];
    _controlMiddleView = nil;
    
    [_controlTopViewLive removeFromSuperview];
    _controlTopViewLive = nil;
    
    [_controlTopViewPhoto removeFromSuperview];
    _controlTopViewPhoto = nil;
}
-(void)timetMothod{
    if (_controlRuond.hidden) {
        _controlRuond.hidden = NO;
    }else{
        _controlRuond.hidden = YES;
    }
}

-(void)setHaiB{
    
    
    
    if (_type==TIAOGUO) {
        [AppInfo shareInstance].isHaiBaoUp = YES;
        return;
    }
    __weak typeof(self) weakSelf = self;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        UpdateIntroductionmodel *updateIntroductionmodel = [[UpdateIntroductionmodel alloc] init];
        NSString *tempDir = NSTemporaryDirectory ();
        NSString *tempFile = [NSString stringWithFormat:@"%@/TempHaiB.png",tempDir];
        
        //    [UIImagePNGRepresentation(self.imageTempUpload) writeToFile:tempFile atomically:YES];
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        [updateIntroductionmodel uploadDataWithFileUrl:tempFile params:nil success:^(id object) {
            if (updateIntroductionmodel.result == 0)
            {//此处刷新数据放在main和liveroom里边
                
                [AppInfo shareInstance].isHaiBaoUp = YES;
                
                __weak   LiveRoomViewController* live =(LiveRoomViewController*)strongSelf.rootViewController;
                [live setHaiBaoUp];
                
                [UserInfoManager shareUserInfoManager].getUserInfoModel.userInfo.adphoto = @"有值";
                
            }
        } fail:^(id object) {
            
        }];
        
        
    });
}

-(void)setQianMing:(void(^)(BOOL isNew))success failed:(void(^)(BOOL))failed{
    
    __weak typeof(self) weakSelf = self;
    
    
    if ([AppInfo shareInstance].network ==0 || ![AppInfo IsEnableConnection])
    {
        __weak LiveRoomViewController* lr = (LiveRoomViewController*)weakSelf.rootViewController;
        [lr showNetworkErroDialog];
        return;
    }
    
    if ([AppInfo shareInstance].network ==0 || ![AppInfo IsEnableConnection])
    {
        __weak LiveRoomViewController* lr = (LiveRoomViewController*)weakSelf.rootViewController;
        [lr showNetworkErroDialog];
        return;
    }
    
    UpdateIntroductionmodel *updateIntroductionmodel = [[UpdateIntroductionmodel alloc] init];
    
    if ([ [UserInfoManager shareUserInfoManager].currentUserInfo.introduction toString].length!=0 && [[_testFieldLiveSigeCount.text toString]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length==0) {
        success(YES);
        return;
    }//有签名，没有修改过的，用原来的
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    if ([[_testFieldLiveSigeCount.text toString]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length==0) {//没有签名，没有被修改过的，用默认的
        [param setObject:@"全民星直播互动平台，娱乐你的生活" forKey:@"introduction"];
        
    }else {//没有签名，有修改过的
        
        [param setObject:[_testFieldLiveSigeCount.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] forKey:@"introduction"];
    }
    
    
    [updateIntroductionmodel requestDataWithParams:param success:^(id object) {
        if (updateIntroductionmodel.result == 0)
        {
            [[AppInfo shareInstance]refreshCurrentUserInfo:^{
                
            }];
            success(YES);
        }
        if (updateIntroductionmodel.result==1) {
            failed(YES);
        }
    } fail:^(id object) {
        
        
        
        failed(NO);
        //        [self showNoticeInWindow:@"修改个人签名失败"];
    }];}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
