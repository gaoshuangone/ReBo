//
//  AudioMedia_ios.h
//  seeku
//
//  Created by yzh on 13-7-16.
//  Copyright (c) 2013年 yzh. All rights reserved.
//

//
//  AudioMedia_ios.h
//  mmsplayer
//
//  Created by Weiny on 12-4-4.
//  Copyright (c) 2012年 Weiny Zhou. All rights reserved.
//

#ifndef mmsplayer_AudioMedia_ios_h
#define mmsplayer_AudioMedia_ios_h
//#include "wdef.h"

typedef void* wAudio;

#ifdef __cplusplus
extern "C"
{
#endif
    wAudio audio_open(int sample,int nchannles,int bits,int nFrameSize);//初始化声音接口
    int audio_play(wAudio audio);//播放
	int audio_pause(wAudio audio);
    int audio_wirte(wAudio audio,unsigned char* pcm,size_t count,__int64_t dts);//写入音频数据
    int audio_stop(wAudio audio);//停止
    int audio_close(wAudio audio);//关闭
#ifdef __cplusplus
};
#endif

#endif

