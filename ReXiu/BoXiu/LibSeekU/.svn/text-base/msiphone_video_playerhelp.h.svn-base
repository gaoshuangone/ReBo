//
//  msiphone_video_playerhelp.h
//  seeku
//
//  Created by yzh on 13-6-18.
//  Copyright (c) 2013年 yzh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#include <QuartzCore/QuartzCore.h>
#include <QuartzCore/CALayer.h>

#ifdef __cplusplus
extern "C"
{
#endif
    
#include "libavformat/avformat.h"
#include "libswscale/swscale.h"
    
#ifdef __cplusplus
}
#endif

AVFrame *pFrame;
AVPicture picture;
struct SwsContext *img_convert_ctx;
UIImageView *remotView;
//int frameIndex=0;

@interface msiphone_video_playerhelp : NSObject {
    int outputWidth, outputHeight,inputWidth, inputHeight;
	
}
@property (nonatomic) int outputWidth, outputHeight,inputWidth, inputHeight;

//设置输出图像宽度
-(void)setOutputWidth:(int)newValue;  
//设置输出图像高度
-(void)setOutputHeight:(int)newValue;
//设置输出图像宽度
-(void)setInputWidth:(int)newValue;
//设置输出图像高度
-(void)setInputHeight:(int)newValue;
//获取当前帧图像
-(UIImage *)currentImage;
//转换像素格式，由PIX_FMT_YUV420P转换成PIX_FMT_RGB24
-(void)convertFrameToRGB;
//生成ppm图片文件
-(void)savePPMPicture:(AVPicture)pict width:(int)width height:(int)height index:(int)iFrame;
//将AVPicture转换成UIImage对象
-(UIImage *)imageFromAVPicture:(AVPicture)pict width:(int)width height:(int)height;
//显示视频画面
-(void) show_video;


@end
