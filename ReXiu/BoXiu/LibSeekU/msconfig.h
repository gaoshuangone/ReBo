//
//  msconfig.h
//  seeku
//
//  Created by yzh on 13-9-24.
//  Copyright (c) 2013年 yzh. All rights reserved.
//

#ifndef seeku_msconfig_h
#define seeku_msconfig_h
#include "msport.h"

#define srcWidth 192
#define srcHeight 144
#define yuvBufferSize (srcWidth * srcHeight * 3)/2
#define bufferByteSize 42248

//#define DEFAULT_FRONT_CAMERA 1
//#define CREATE_JPEG_DEBUG 1
//#define DEBUG_PATH 1

//是否正式开始录像
int isStartCapture;
//操作类型：2：录音 3：录像
int optionType;
//切换前后置摄像头后是否停止了视频捕捉
int isSwapCameraStopedCapture;
//获取原视频的宽高
typedef struct _OriVideoSize{
    int oriWidth;
    int oriHeight;
}OriVideoSize;

OriVideoSize *orivideosize;

//是否生成封面
bool_t coverflag;
int coverCount;
char *picFullPath;
bool_t isPrintLog=FALSE;

#endif
