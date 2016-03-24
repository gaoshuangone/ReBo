//
//  LiveRoomIamgeView.m
//  BoXiu
//
//  Created by andy on 16/1/6.
//  Copyright © 2016年 rexiu. All rights reserved.
//

#import "LiveRoomIamgeView.h"
#import "SeekuSingle.h"

@interface LiveRoomIamgeView()<AVCaptureVideoDataOutputSampleBufferDelegate>
@property (strong,nonatomic) AVCaptureDeviceInput *captureDeviceInput;//负责从AVCaptureDevice获得输入数据
@property (strong,nonatomic) AVCaptureStillImageOutput *captureStillImageOutput;//照片输出流
@property (strong,nonatomic) AVCaptureVideoPreviewLayer *captureVideoPreviewLayer;//相机拍摄预览图层
//@property (strong,nonatomic) AVCaptureMovieFileOutput *captureMovieFileOutput;//视频输出流


@property (strong, nonatomic)UIImage * imageTempUpload;

@end
#pragma mark Private methods and instance variables
typedef void(^PropertyChangeBlock)(AVCaptureDevice *captureDevice);
@implementation LiveRoomIamgeView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        // Initialization code
        
    }
    return self;
}
- (void)initView:(CGRect)frame
{
    self.viewContainer  = [[UIView alloc]initWithFrame:self.frame];
    self.viewContainer.userInteractionEnabled = YES;
    [self addSubview:self.viewContainer];
    
    //    [self startCaptureSession];
    [self rotateCamera];
    
    _imageViewHaiBao = [[UIImageView alloc]initWithFrame:self.frame];
    [self addSubview:_imageViewHaiBao];
    
    imageWidth = 0 ;
    imageHeight = 0 ;
    yuvbuffer = NULL;
    yuvBufferLength = 0;
    
   
    
}
//-(void)sCNetworkReachabilityFlags:(NSNotification*)noti{
//    
//    if ([[noti.userInfo valueForKey:@"SCNetworkReachabilityFlags"]isEqualToString:@"0"]) {
//        self.isCanUpLoad = NO;
//        [self performSelector:@selector(time) withObject:self afterDelay:15];
//    }else{
//        self.isCanUpLoad = YES;
//    }
//    
//    
//}
-(void)setCanUpLoad{
       self.isCanUpLoad = YES;
//    [[ NSNotificationCenter defaultCenter]removeObserver:self name:@"SCNetworkReachabilityFlags" object:nil];
//     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(sCNetworkReachabilityFlags:) name:@"SCNetworkReachabilityFlags" object:nil];
}
-(void)time{
    if (!self.isCanUpLoad) {
        
    }
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
//-(void)startCaptureSession{
//    _captureSession=[[AVCaptureSession alloc]init];
//    [_captureSession beginConfiguration];
//    if ([_captureSession canSetSessionPreset:AVCaptureSessionPreset1280x720]) {//设置分辨率
//        _captureSession.sessionPreset=AVCaptureSessionPreset1280x720;
//    }
//
//    //获得输入设备
//    AVCaptureDevice *captureDevice=[self getCameraDeviceWithPosition:AVCaptureDevicePositionBack];//取得后置摄像头
//    if (!captureDevice) {
//        NSLog(@"取得后置摄像头时出现问题.");
//        return;
//    }
//    NSError *error=nil;
//    //根据输入设备初始化设备输入对象，用于获得输入数据
//    _captureDeviceInput=[[AVCaptureDeviceInput alloc]initWithDevice:captureDevice error:&error];
//    if (error) {
//        NSLog(@"取得设备输入对象时出错，错误原因：%@",error.localizedDescription);
//        return;
//    }
//
//    //将设备输入添加到会话中
//    if ([_captureSession canAddInput:_captureDeviceInput]) {
//        [_captureSession addInput:_captureDeviceInput];
//    }
//
//    AVCaptureVideoDataOutput *output = [[AVCaptureVideoDataOutput alloc] init] ;
//   	[output setAlwaysDiscardsLateVideoFrames:NO];
//    dispatch_queue_t queue = dispatch_queue_create("myQueue", NULL);
//    [output setSampleBufferDelegate:self queue:queue];
//
//    // Specify the pixel format
//    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:
//                         [NSNumber numberWithInteger:kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange], (id)kCVPixelBufferPixelFormatTypeKey, nil];
//    [output setVideoSettings:dic];
//
//    /* Set the layer */
//    AVCaptureVideoPreviewLayer *previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
//    [previewLayer setOrientation:AVCaptureVideoOrientationPortrait];
//    [previewLayer setBackgroundColor:[[UIColor clearColor] CGColor]];
//    [previewLayer setOpaque:YES];
//    previewLayer.videoGravity = AVLayerVideoGravityResizeAspect;
//
//    if([_captureSession canAddOutput:output])
//        [_captureSession addOutput:output];
//
//    NSArray *connections = output.connections;
//    if ([connections count] > 0 && [[connections objectAtIndex:0] isVideoOrientationSupported]) {
//        [[connections objectAtIndex:0] setVideoOrientation:AVCaptureVideoOrientationPortrait];
//    }
//
//    // If you wish to cap the frame rate to a known value, such as 15 fps, set
//    // minFrameDuration.
//    //    output.minFrameDuration = CMTimeMake(1, 15);
//
//    //初始化设备输出对象，用于获得输出数据
//    _captureStillImageOutput=[[AVCaptureStillImageOutput alloc]init];
//    NSDictionary *outputSettings = @{AVVideoCodecKey:AVVideoCodecJPEG};
//    [_captureStillImageOutput setOutputSettings:outputSettings];//输出设置
//
//    //将设备输出添加到会话中
//    if ([_captureSession canAddOutput:_captureStillImageOutput]) {
//        [_captureSession addOutput:_captureStillImageOutput];
//    }
//
//    //将设备输出添加到会话中
//    //    if ([_captureSession canAddOutput:_captureMovieFileOutput]) {
//    //        [_captureSession addOutput:_captureMovieFileOutput];
//    //    }
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
//    [captureDevice setActiveVideoMinFrameDuration:CMTimeMake(1, 15)];
//    [captureDevice setActiveVideoMaxFrameDuration:CMTimeMake(1, 15)];
//
//    [_captureSession commitConfiguration];
//
//    [self.captureSession startRunning];
//}
- (void)captureOutput:(AVCaptureOutput *)captureOutput
didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer
       fromConnection:(AVCaptureConnection *)connection
{
    
    if (!self.isCanUpLoad) {
        return;
    }else{
        CVImageBufferRef frame = nil;
        @synchronized(self) {
            @try {
                if ([[SeekuSingle shareSeekuSingle] isStreaming]) {
                    frame = CMSampleBufferGetImageBuffer(sampleBuffer);
                    CVReturn status = CVPixelBufferLockBaseAddress(frame, 0);
                    if (kCVReturnSuccess != status) {
                        frame=nil;
                        return;
                    }
                    /*kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange*/
                    int width = (int)CVPixelBufferGetWidthOfPlane(frame, 0);
                    int height = (int)CVPixelBufferGetHeightOfPlane(frame, 0);
                    //sanity check
                    unsigned char* y = CVPixelBufferGetBaseAddressOfPlane(frame, 0);
                    unsigned char* uv = CVPixelBufferGetBaseAddressOfPlane(frame, 1);
                    if (imageWidth != width || imageHeight != height || yuvbuffer == NULL) {
                        imageWidth = width ;
                        imageHeight = height ;
                        if (yuvbuffer) {
                            free(yuvbuffer);
                        }
                        yuvbuffer = (unsigned char*)malloc(imageWidth * imageHeight * 3 / 2);
                    }
                    memcpy(yuvbuffer,y,imageWidth * imageHeight);
                    unsigned char *pu = yuvbuffer + imageWidth * imageHeight ;
                    unsigned char *pv = yuvbuffer + imageWidth * imageHeight + imageWidth * imageHeight / 4 ;
                    for (int i = 0 ; i < imageHeight / 2; i++) {
                        for (int j = 0 ; j < imageWidth / 2;j ++) {
                            *pu ++ = *uv++ ;
                            *pv ++ = *uv++ ;
                        }
                    }
                    [[SeekuSingle shareSeekuSingle] lib_seeku_put_yuv_image:yuvbuffer imageWidth:imageWidth imageHeight:imageHeight] ;
                }
                
            } @finally {
                if (frame)
                    CVPixelBufferUnlockBaseAddress(frame, 0);
            }
        }
    }
}
-(void)viewwillDisappear{
    [super viewwillDisappear];
    
    if (yuvbuffer) {
        free(yuvbuffer);
        yuvbuffer = NULL ;
        imageWidth =0 ;
        imageHeight = 0;
    }
    if (_imageViewHaiBao) {
        [_imageViewHaiBao removeFromSuperview];
        _imageViewHaiBao = nil;
    }
 
    
}

-(void)tackPicture{//拍照
    //根据设备输出获得连接
    
    __weak typeof(self) weakSelf = self;
    AVCaptureConnection *captureConnection=[self.captureStillImageOutput connectionWithMediaType:AVMediaTypeVideo];
    //根据连接取得设备输出的数据
    [self.captureStillImageOutput captureStillImageAsynchronouslyFromConnection:captureConnection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
        if (imageDataSampleBuffer) {
            NSData *imageData=[AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
            UIImage *image=[UIImage imageWithData:imageData];
            if (  weakSelf.imageViewHaiBao) {
                weakSelf.imageViewHaiBao.image = image;
                [weakSelf setImageViewHaiBaoHid:NO];
            }
            
            
            image = [weakSelf image:image scaledToSize:CGSizeMake(image.size.width, image.size.height)];
            image = [ weakSelf cutImage:image];
            weakSelf.imageTempUpload = image;
            
            
            
            NSString *tempDir = NSTemporaryDirectory ();
            NSString *tempFile = [NSString stringWithFormat:@"%@/TempHaiB.png",tempDir];
            
            [UIImagePNGRepresentation(weakSelf.imageTempUpload) writeToFile:tempFile atomically:YES];
            
        }
        
    }];
    
    
}
-(void)setImageViewHaiBaoHid:(BOOL)isHid{
    self.imageViewHaiBao.hidden = isHid;
}

/**
 *  改变设备属性的统一操作方法
 *
 *  @param propertyChange 属性改变操作
 */

-(void)changeDeviceProperty:(PropertyChangeBlock)propertyChange{
    AVCaptureDevice *captureDevice= [_captureDeviceInput device];
    NSError *error;
    //注意改变设备属性前一定要首先调用lockForConfiguration:调用完之后使用unlockForConfiguration方法解锁
    if ([captureDevice lockForConfiguration:&error]) {
        propertyChange(captureDevice);
        [captureDevice unlockForConfiguration];
    }else{
        NSLog(@"设置设备属性过程发生错误，错误信息：%@",error.localizedDescription);
    }
}
/**
 *  设置闪光灯模式
 *
 *  @param flashMode 闪光灯模式
 */
-(void)stFlashMode:(AVCaptureTorchMode )flashMode{
    
    
    __weak typeof(self) weakSelf =self;
    
    [self changeDeviceProperty:^(AVCaptureDevice *captureDevice) {
        
        if (flashMode == AVCaptureFlashModeOn) {
            [captureDevice setTorchMode:flashMode];
            weakSelf.isAVCaptureTorchModeOn = YES;
        }else if (flashMode == AVCaptureFlashModeOff){
            [captureDevice setTorchMode:flashMode];
            [captureDevice setFlashMode:AVCaptureFlashModeOff];
            weakSelf.isAVCaptureTorchModeOn = NO;
        }
        
        
    }];
}
//手电筒
-(void)setFlashMode:(AVCaptureTorchMode)mode{
    
    [self stFlashMode:mode];
}


//切换摄像头
-(void)rotateCamera{
    
    if (self.captureSession) {//切换摄像头不用重新创建时，切换的时候图像旋转了，暂时这样
        [self.captureSession  stopRunning];
        [self.captureSession removeOutput:_captureStillImageOutput];
        [self.captureSession removeInput:_captureDeviceInput];
        _captureStillImageOutput = nil;
        [_captureVideoPreviewLayer removeFromSuperlayer];
        _captureVideoPreviewLayer  = nil;
        _captureSession = nil;
    }
    
    
    
    
    _captureSession=[[AVCaptureSession alloc]init];
    [_captureSession beginConfiguration];
    if ([_captureSession canSetSessionPreset:AVCaptureSessionPreset1280x720]) {//设置分辨率
        _captureSession.sessionPreset=AVCaptureSessionPreset1280x720;
    }
    
    
    NSError *error;
    
    AVCaptureDevicePosition currentCameraPosition = [[_captureDeviceInput device] position];
    
    if (currentCameraPosition == AVCaptureDevicePositionBack)
    {
        [self stFlashMode:AVCaptureTorchModeOff];
        self.isAVCaptureDevicePositionFront = YES;
        currentCameraPosition = AVCaptureDevicePositionFront;
    }
    else if(currentCameraPosition == AVCaptureDevicePositionFront)
    {
        self.isAVCaptureDevicePositionFront = NO;
        currentCameraPosition = AVCaptureDevicePositionBack;
    }else{
        currentCameraPosition = AVCaptureDevicePositionBack;
    }
    
    AVCaptureDevice *backFacingCamera = nil;
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices)
    {
        if ([device position] == currentCameraPosition)
        {
            backFacingCamera = device;
        }
    }
    
    
    
    NSError *error1=nil;
    //根据输入设备初始化设备输入对象，用于获得输入数据
    _captureDeviceInput=[[AVCaptureDeviceInput alloc]initWithDevice:backFacingCamera error:&error];
    if (error1) {
        NSLog(@"取得设备输入对象时出错，错误原因：%@",error.localizedDescription);
        return;
    }
    
    //将设备输入添加到会话中
    if ([_captureSession canAddInput:_captureDeviceInput]) {
        [_captureSession addInput:_captureDeviceInput];
    }
    
    AVCaptureVideoDataOutput *output = [[AVCaptureVideoDataOutput alloc] init] ;
    [output setAlwaysDiscardsLateVideoFrames:NO];
    dispatch_queue_t queue = dispatch_queue_create("myQueue", NULL);
    [output setSampleBufferDelegate:self queue:queue];
    
    // Specify the pixel format
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         [NSNumber numberWithInteger:kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange], (id)kCVPixelBufferPixelFormatTypeKey, nil];
    [output setVideoSettings:dic];
    
    /* Set the layer */
    AVCaptureVideoPreviewLayer *previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
    [previewLayer setOrientation:AVCaptureVideoOrientationPortrait];
    [previewLayer setBackgroundColor:[[UIColor clearColor] CGColor]];
    [previewLayer setOpaque:YES];
    previewLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    
    if([_captureSession canAddOutput:output])
        [_captureSession addOutput:output];
    
    NSArray *connections = output.connections;
    if ([connections count] > 0 && [[connections objectAtIndex:0] isVideoOrientationSupported]) {
        [[connections objectAtIndex:0] setVideoOrientation:AVCaptureVideoOrientationPortrait];
    }
    
    
    //初始化设备输出对象，用于获得输出数据
    _captureStillImageOutput=[[AVCaptureStillImageOutput alloc]init];
    NSDictionary *outputSettings = @{AVVideoCodecKey:AVVideoCodecJPEG};
    [_captureStillImageOutput setOutputSettings:outputSettings];//输出设置
    
    //将设备输出添加到会话中
    if ([_captureSession canAddOutput:_captureStillImageOutput]) {
        [_captureSession addOutput:_captureStillImageOutput];
    }
    
    //创建视频预览层，用于实时展示摄像头状态
    _captureVideoPreviewLayer=[[AVCaptureVideoPreviewLayer alloc]initWithSession:self.captureSession];
    
    CALayer *layer=self.viewContainer.layer;
    layer.masksToBounds=YES;
    
    _captureVideoPreviewLayer.frame=layer.bounds;
    _captureVideoPreviewLayer.videoGravity=AVLayerVideoGravityResizeAspectFill;//填充模式
    //将视频预览层添加到界面中
    [layer addSublayer:_captureVideoPreviewLayer];
    
    [backFacingCamera setActiveVideoMinFrameDuration:CMTimeMake(1, 15)];
    [backFacingCamera setActiveVideoMaxFrameDuration:CMTimeMake(1, 15)];
    
    [_captureSession commitConfiguration];
    
    [self.captureSession startRunning];
    
    output = nil;
    previewLayer = nil;
}



- (void)stopCameraCapture;
{
    if ([_captureSession isRunning])
    {
        [_captureSession stopRunning];
    }
}
//裁剪图片
- (UIImage *)cutImage:(UIImage*)image
{
    CGRect  rect =CGRectMake(0,170/2, SCREEN_WIDTH, 338/2);
    
    //压缩图片
    CGSize newSize;
    CGImageRef imageRef = nil;
    
    if ((image.size.width / image.size.height) < (rect.size.width / rect.size.height)) {
        newSize.width = image.size.width;
        newSize.height = image.size.width * SCREEN_WIDTH*3/4 / rect.size.width;
        
        imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(rect.origin.x, rect.origin.y+105, newSize.width, newSize.height));
        
    } else {
        newSize.height = image.size.height;
        newSize.width = image.size.height * rect.size.width / rect.size.height;
        
        imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(fabs(image.size.width - newSize.width) / 2, 0, newSize.width, newSize.height));
        
    }
    
    return [UIImage imageWithCGImage:imageRef];
}
- (UIImage *)image:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    // End the context
    UIGraphicsEndImageContext();
    // Return the new image.
    return newImage;
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
