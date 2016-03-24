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
    
    
    static void audio_record_init(MSFilter *f);
    static void audio_record_preprocess(MSFilter *f);
    static void audio_record_process(MSFilter *f);
    static void audio_record_uninit(MSFilter *f);
    
    //设置音频格式
    void SetupAudioFormat(UInt32 inFormatID);
    
    //录制的回调函数
    OSStatus recordingCallback(void *inRefCon,
                               AudioUnitRenderActionFlags *ioActionFlags,
                               const AudioTimeStamp *inTimeStamp,
                               UInt32 inBusNumber,
                               UInt32 inNumberFrames,
                               AudioBufferList *ioData);
    
    
#ifdef __cplusplus
}
#endif

#endif
