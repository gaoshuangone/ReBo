#ifndef MSPLAYSINGLE_H
#define MSPLAYSINGLE_H


#include "msfilter.h"
#include "mslog.h"
#include "msticker.h"
#include "msvideo.h"

#include "libavcodec/avcodec.h"
#include "libavformat/avformat.h"
#include "libavutil/avstring.h"

#include "mspktqueue.h"

typedef struct _AVPlaySingle {
	AVFormatContext *afc;
	AVStream *video_st;
	AVCodecContext *video_ctx;
	char *url;
	int video_st_idx;
	YuvBuf outbuf;
	mblk_t *yuv_msg;
	struct SwsContext *sws_ctx;
	enum PixelFormat output_pix_fmt;

	AVStream *audio_st;
	AVCodecContext *audio_ctx;

	int audio_st_idx;
	int sample_rate;
	int channels;
	int streamtype;

	PacketQueue audioq;
	PacketQueue videoq;
	pthread_t decodep;	

	double audio_clock;
	double video_clock;

	int begin;
	int stoplay;
} AVPlaySingle;

AVPlaySingle *playsingle;

int play_av_single_start(const char *url);
int play_av_single_stop();

void play_av_single_stop_one();



#endif

