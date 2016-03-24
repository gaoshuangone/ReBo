#ifndef PLAYERSTREAM_H
#define PLAYERSTREAM_H

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import "msiphone_audio_playsensor.h"

#ifdef __cplusplus
extern "C"
{
#endif
    
#include <pthread.h>
#include "msfilter.h"
#include "libavutil/avstring.h"
#include "libavcodec/avcodec.h"
#include "libavformat/avformat.h"
#include "libavcodec/audioconvert.h"
    
    static void audiounit_player_init(MSFilter *f);
    static void audiounit_player_preprocess(MSFilter *f);
    static void audiounit_player_process(MSFilter *f);
    static void audiounit_player_uninit(MSFilter *f);
    
    int audioSampleRate;
    
#ifdef __cplusplus
}
#endif

msiphone_audio_playsensor *playsensor;

#endif
