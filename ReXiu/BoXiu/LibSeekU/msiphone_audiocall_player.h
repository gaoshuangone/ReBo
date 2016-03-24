#ifndef PLAYERSTREAM_H
#define PLAYERSTREAM_H

#ifdef __cplusplus
extern "C"
{
#endif
    
#include <pthread.h>
#include "msfilter.h"
#import <AudioToolbox/AudioToolbox.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "msiphone_audio_playsensor.h"
#import <OpenAL/al.h>
#import <OpenAL/alc.h>
    
#include "libavutil/avstring.h"
#include "libavcodec/avcodec.h"
#include "libavformat/avformat.h"
#include "libavcodec/audioconvert.h"
    

    msiphone_audio_playsensor *playsensor;
    
    static void audiocall_player_init(MSFilter *f);
    static void audiocall_player_preprocess(MSFilter *f);
    static void audiocall_player_process(MSFilter *f);
    static void audiocall_player_uninit(MSFilter *f);
    
#ifdef __cplusplus
}
#endif

#endif