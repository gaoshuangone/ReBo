#ifndef RECOREDSTREAM_H
#define RECOREDSTREAM_H

#ifdef __cplusplus
extern "C"
{
#endif
    
#include <pthread.h>
#include "msfilter.h"
#import <AudioToolbox/AudioToolbox.h>
#import "msiphone_audio_playsensor.h"

    
    msiphone_audio_playsensor *playmsqsensor;
    
    static void audioqueue_player_init(MSFilter *f);
    static void audioqueue_player_preprocess(MSFilter *f);
    static void audioqueue_player_process(MSFilter *f);
    static void audioqueue_player_uninit(MSFilter *f);
    
    static void readPacketsIntoBuffer(AudioQueueBufferRef buffer);
    static void startQueueService();
    
    //设置一系列格式参数
    void SetupAudioFormat2(UInt32 inFormatID);
    
    //播放回调函数(Callback)的实现
    void BufferCallback(void *inUserData,AudioQueueRef inAQ,
                        AudioQueueBufferRef buffer);
    
    
#ifdef __cplusplus
}
#endif

#endif
