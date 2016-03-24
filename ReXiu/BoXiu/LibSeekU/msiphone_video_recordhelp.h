//
//  msiphone_video_recordhelp.h
//  seeku
//
//  Created by yzh on 13-7-5.
//  Copyright (c) 2013年 yzh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface msiphone_video_recordhelp : NSObject<AVCaptureVideoDataOutputSampleBufferDelegate>
{
    AVCaptureSession* avCaptureSession;
    AVCaptureDevice *avCaptureDevice;
    BOOL firstFrame; //是否为第一帧
    int producerFps;
}
@property (nonatomic, retain) AVCaptureSession *avCaptureSession;

- (void)createControl;
//设置前置摄像头
- (AVCaptureDevice *)getFrontCamera;
//在前置与后置摄像头之间进行切换
- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition)position;
- (void)swapFrontAndBackCameras;
//开始前设置捕获参数
- (void)prepareVideoCapture:(int) width andHeight: (int)height andFps: (int) fps andFrontCamera:(BOOL) bfront andPreview:(UIView*) view;
//开始捕获视频
- (void)startVideoCapture:(UIView*) localView;
//关闭摄像头，停止捕抓图像
- (void)stopVideoCapture:(UIView*) localView;
//设置要显示到的View
- (void)setPreview: (UIView*)preview;


@end
