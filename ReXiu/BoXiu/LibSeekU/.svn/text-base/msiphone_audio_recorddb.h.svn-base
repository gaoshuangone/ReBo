//
//  msiphone_audio_recorddb.h
//  seeku
//
//  Created by yzh on 13-8-20.
//  Copyright (c) 2013年 yzh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#include <AudioToolbox/AudioToolbox.h>

@interface msiphone_audio_recorddb : NSObject
{
    AudioQueueRef                mQueue;
    AudioStreamBasicDescription    mFormat;
    AudioQueueLevelMeterState    *_chan_lvls;
    NSArray                        *_channelNumbers;
}

//设置声道数组
-(void)setChannelNumbers:(NSArray *)v;
//初始化音频会话
-(void)initAudioSession;
//定时获取当前分贝值
-(void)_refresh:(NSTimer *)timer;
//计算平均电平值avgPowerForChannel，并判断平均电平值avgPowerForChannel的范围，显示分贝效果。
-(void)showPower:(NSInteger) channelIdx ptimer:(NSTimer *)timer;
//开启麦克风
-(void)startMicrophone;
//停止麦克风
-(void)stopMicrophone;
//开启或停止麦克风
-(void)startOrStopMicrophone;

@end
