//
//  LiveRoomIamgeView.h
//  BoXiu
//
//  Created by andy on 16/1/6.
//  Copyright © 2016年 rexiu. All rights reserved.
//

#import "BaseView.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
//typedef enum {
//    FairType_jingdian,
//    FairType_rouguang,
//    FairType_HDR,
//    FairType_baoGuang,
//    FairType_YinYing,
//    FairType_HuaiJiu
//}FairType;//枚举名称
@interface LiveRoomIamgeView : BaseView
{
    int imageWidth ,imageHeight ;
    unsigned char * yuvbuffer ;
    int yuvBufferLength ;
}


@property (strong, nonatomic)UIImageView* imageViewHaiBao;

@property (strong, nonatomic)NSMutableArray *arrayTemp;

@property (assign, nonatomic)BOOL isCanUpLoad;
@property (strong,nonatomic) AVCaptureSession *captureSession;//负责输入和输出设置之间的数据传递
@property (strong, nonatomic)  UIView *viewContainer;

@property (assign, nonatomic) BOOL isAVCaptureTorchModeOn;
@property (assign, nonatomic) BOOL isAVCaptureDevicePositionFront;
-(void)tackPicture;//拍照
-(void)setFlashMode:(AVCaptureTorchMode)mode;//手电筒
-(void)rotateCamera;//切换摄像头
-(void)changeFairType:(NSInteger)type;
- (void)stopCameraCapture;
-(void)setImageViewHaiBaoHid:(BOOL)isHid;//拍摄过的海报
-(void)setCanUpLoad;
@end
