#ifndef MSDECODERECV_H
#define MSDECODERECV_H

#include "msfilter.h"

//ffmpeg begin
#include <pthread.h>
#include "libavutil/avstring.h"
#include "libavcodec/avcodec.h"
#include "libavformat/avformat.h"
#include "libavcodec/audioconvert.h"

typedef struct _AudioDecContext{
	AVFormatContext *afc;
	AVStream *audio_st;
	AVCodecContext *audio_ctx;
	pthread_t initd;
	pthread_t recvd;
	ms_mutex_t mutex;
	ms_mutex_t mutex2;
	MSBufferizer rb;
	char *url;
	int audio_st_idx;
	int abort_request;
	int abort_drop;
	int sample_rate;
	int channels;
	int spearkerstate;
	int streamtype;
	bool_t begin;
	bool_t stoprecv;
}AudioDecContext;

static AudioDecContext *cont = NULL;

#define MS_AUDIO_DEC_RECV_SET_URL		MS_FILTER_METHOD(MS_AUDIO_DEC_RECV_ID, 0, char *)

int open_audio_codec(AudioDecContext *atx);
static void* audio_dec_init_thread(void *arg);

#endif


