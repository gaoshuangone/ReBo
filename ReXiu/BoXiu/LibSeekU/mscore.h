#ifndef MSCORE_H
#define MSCORE_H

#include "msticker.h"
#include "msfilter.h"
#include "msport.h"
#include "msdecoderecv.h"
#include "msencodesend.h"

typedef struct _VideoStream
{
	MSTicker *ticker;
	MSFilter  *videorecv;
	MSFilter  *videodisplay;
	MSFilter  *videosend;
	MSFilter  *videocapture;
	time_t start_time;
	time_t last_packet_time;
	bool_t is_beginning;
}VideoStream;

typedef struct _AudioStream
{
	MSTicker  *ticker;
	MSFilter  *soundread;
	MSFilter  *soundwrite;
	MSFilter  *decrecv;
	MSFilter  *encsend;
	MSFilter  *ec;
	time_t start_time;
	time_t last_packet_time;
	bool_t is_beginning;
}AudioStream;

typedef struct _AVPlayStream
{
	MSTicker *ticker;
	MSFilter  *videorecv;
	MSFilter  *videodisplay;
	MSFilter  *soundwrite;
	MSFilter  *decrecv;
	time_t start_time;
	time_t last_packet_time;
	bool_t is_beginning;
}AVPlayStream;


#ifdef __cplusplus
extern "C" {
#endif

//开始通话
    int seeku_audio_start(char *purl, char *rurl); //const char *purl, const char *rurl
//停止通话
    void seeku_audio_stop();
//开始录音
    void seeku_audio_recordStart(char *rurl);
//停止录音
    void seeku_audio_recordStop();

//开始播放
    void seeku_audio_playStart(char *purl);
//停止播放
    void seeku_audio_playStop();
    
//直播间
    int seeku_single_play_start(const char *url);
    void seeku_single_play_stop();
    int seeku_single_play_version();
    int seeku_single_play_amode();
    
#ifdef __cplusplus
}
#endif


#endif

