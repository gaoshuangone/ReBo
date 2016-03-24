#ifndef MSFILTER_H
#define MSFILTER_H

#include <sys/types.h>
#include "allfilters.h"
#include "msqueue.h"
#include "msport.h"
#include "mscommon.h"

typedef void (*MSFilterFunc)(struct _MSFilter *f);

typedef int (*MSFilterMethodFunc)(struct _MSFilter *f, void *arg);

typedef void (*MSFilterNotifyFunc)(void *userdata, struct _MSFilter *f, unsigned int id, void *arg);


struct _MSFilterMethod{
	int id;
	MSFilterMethodFunc method;
};

typedef struct _MSFilterMethod MSFilterMethod;

enum _MSFilterCategory{
	MS_FILTER_OTHER,
	MS_FILTER_ENCODER,
	MS_FILTER_DECODER
};

typedef enum _MSFilterCategory MSFilterCategory;

enum _MSFilterFlags {
	MS_FILTER_IS_PUMP = 1
};

typedef enum _MSFilterFlags MSFilterFlags;

struct _MSFilterStats{
	const char *name;
	uint64_t elapsed;
	unsigned int count;
};

typedef struct _MSFilterStats MSFilterStats;

struct _MSFilterDesc{
	MSFilterId id;
	const char *name;
	const char *text;
	MSFilterCategory category;
	const char *enc_fmt;
	int ninputs;
	int noutputs;
	MSFilterFunc init;
	MSFilterFunc preprocess;
	MSFilterFunc process;
	MSFilterFunc postprocess;
	MSFilterFunc uninit;
	MSFilterMethod *methods;
 	unsigned int flags;
};

typedef struct _MSFilterDesc MSFilterDesc;

struct _MSFilter{
	MSFilterDesc *desc;
	ms_mutex_t lock;
	MSQueue **inputs;
	MSQueue **outputs;
	MSFilterNotifyFunc notify;
	void *notify_ud;
	void *data;
	struct _MSTicker *ticker;
	uint32_t last_tick;
	MSFilterStats *stats;
	bool_t seen;
};

typedef struct _MSFilter MSFilter;

struct _MSConnectionPoint{
	MSFilter *filter;
	int pin;
};

typedef struct _MSConnectionPoint MSConnectionPoint;

struct _MSConnectionHelper{
	MSConnectionPoint last;
};

typedef struct _MSConnectionHelper MSConnectionHelper;

#ifdef __cplusplus
extern "C" {
#endif

void ms_filter_register(MSFilterDesc *desc);

MSFilterDesc *ms_filter_get_encoder(const char *mime);

MSFilterDesc *ms_filter_get_decoder(const char *mime);

MSFilterDesc *ms_filter_lookup_by_name(const char *filter_name);

MSFilter *ms_filter_create_encoder(const char *mime);

MSFilter *ms_filter_create_decoder(const char *mime);

bool_t ms_filter_codec_supported(const char *mime);

MSFilter *ms_filter_new(MSFilterId id);

MSFilter *ms_filter_new_from_name(const char *name);

MSFilter *ms_filter_new_from_desc(MSFilterDesc *desc);

int ms_filter_link(MSFilter *f1, int pin1, MSFilter *f2, int pin2);

int ms_filter_unlink(MSFilter *f1, int pin1, MSFilter *f2, int pin2);

int ms_filter_call_method(MSFilter *f, unsigned int id, void *arg);

int ms_filter_call_method_noarg(MSFilter *f, unsigned int id);

bool_t ms_filter_has_method(MSFilter *f, unsigned int id);

void ms_filter_set_notify_callback(MSFilter *f, MSFilterNotifyFunc fn, void *userdata);

MSFilterId ms_filter_get_id(MSFilter *f);

MSList *ms_filter_find_neighbours(MSFilter *me);

void ms_filter_destory(MSFilter *f);

void ms_connection_helper_start(MSConnectionHelper *h);

int ms_connection_helper_link(MSConnectionHelper *h, MSFilter *f, int inpin, int outpin);

int ms_connection_helper_unlink(MSConnectionHelper *h, MSFilter *f, int inpin, int outpin);

void ms_filter_enable_statistics(bool_t enabled);

void ms_filter_reset_statistics(void);

const MSList *ms_filter_get_statistics(void);

void ms_filter_log_statistics(void);

#define MS_FILTER_METHOD_ID(_id_,_cnt_,_argsize_) \
	(  (((unsigned long)(_id_)) & 0xFFFF)<<16 | (_cnt_<<8) | (_argsize_ & 0xFF ))

#define MS_FILTER_METHOD(_id_,_count_,_argtype_) \
	MS_FILTER_METHOD_ID(_id_,_count_,sizeof(_argtype_))

#define MS_FILTER_METHOD_NO_ARG(_id_,_count_) \
	MS_FILTER_METHOD_ID(_id_,_count_,0)


#define MS_FILTER_BASE_METHOD(_count_,_argtype_) \
	MS_FILTER_METHOD_ID(MS_FILTER_BASE_ID,_count_,sizeof(_argtype_))

#define MS_FILTER_BASE_METHOD_NO_ARG(_count_) \
	MS_FILTER_METHOD_ID(MS_FILTER_BASE_ID,_count_,0)

#define MS_FILTER_EVENT(_id_,_count_,_argtype_) \
	MS_FILTER_METHOD_ID(_id_,_count_,sizeof(_argtype_))

#define MS_FILTER_EVENT_NO_ARG(_id_,_count_)\
	MS_FILTER_METHOD_ID(_id_,_count_,0)


#define MS_FILTER_SET_SAMPLE_RATE	MS_FILTER_BASE_METHOD(0,int)
/**
 * Get filter output/input sampling frequency in hertz
 */

#define MS_FILTER_GET_SAMPLE_RATE	MS_FILTER_BASE_METHOD(1,int)
/**
 * Set filter output network bitrate in bit per seconds, this value include IP+UDP+RTP overhead
 */
#define MS_FILTER_SET_BITRATE		MS_FILTER_BASE_METHOD(2,int)
/**
 * Get filter output network bitrate in bit per seconds, this value include IP+UDP+RTP overhead
 */
#define MS_FILTER_GET_BITRATE		MS_FILTER_BASE_METHOD(3,int)
#define MS_FILTER_GET_NCHANNELS		MS_FILTER_BASE_METHOD(5,int)
#define MS_FILTER_SET_NCHANNELS		MS_FILTER_BASE_METHOD(6,int)
/**
 * Set codec dependent attributes as taken from the SDP
 */
#define MS_FILTER_ADD_FMTP		MS_FILTER_BASE_METHOD(7,const char)

#define MS_FILTER_ADD_ATTR		MS_FILTER_BASE_METHOD(8,const char)
#define MS_FILTER_SET_MTU		MS_FILTER_BASE_METHOD(9,int)
#define MS_FILTER_GET_MTU		MS_FILTER_BASE_METHOD(10,int)
/**Filters can return their latency in milliseconds (if known) using this method:*/
#define MS_FILTER_GET_LATENCY	MS_FILTER_BASE_METHOD(11,int)

enum _MSFilterInterfaceId{
	MSFilterInterfaceBegin=16384,
	MSFilterPlayerInterface,
	MSFilterRecorderInterface,
	MSFilterVideoDisplayInterface,
	MSFilterEchoCancellerInterface,
	MSFilterVideoDecoderInterface,
	MSFilterVideoCaptureInterface,
};

typedef enum _MSFilterInterfaceId MSFilterInterfaceId;


/* more specific methods: to be moved into implementation specific header files*/
#define MS_FILTER_SET_FILTERLENGTH 	MS_FILTER_BASE_METHOD(12,int)
#define MS_FILTER_SET_OUTPUT_SAMPLE_RATE MS_FILTER_BASE_METHOD(13,int)
#define MS_FILTER_ENABLE_DIRECTMODE	MS_FILTER_BASE_METHOD(14,int)
#define MS_FILTER_ENABLE_VAD		MS_FILTER_BASE_METHOD(15,int)
#define MS_FILTER_GET_STAT_DISCARDED	MS_FILTER_BASE_METHOD(16,int)
#define MS_FILTER_GET_STAT_MISSED	MS_FILTER_BASE_METHOD(17,int)
#define MS_FILTER_GET_STAT_INPUT	MS_FILTER_BASE_METHOD(18,int)
#define MS_FILTER_GET_STAT_OUTPUT	MS_FILTER_BASE_METHOD(19,int)
#define MS_FILTER_ENABLE_AGC 		MS_FILTER_BASE_METHOD(20,int)
#define MS_FILTER_SET_PLAYBACKDELAY MS_FILTER_BASE_METHOD(21,int)
#define MS_FILTER_ENABLE_HALFDUPLEX MS_FILTER_BASE_METHOD(22,int)
#define MS_FILTER_SET_VAD_PROB_START MS_FILTER_BASE_METHOD(23,int)
#define MS_FILTER_SET_VAD_PROB_CONTINUE MS_FILTER_BASE_METHOD(24,int)
#define MS_FILTER_SET_MAX_GAIN  MS_FILTER_BASE_METHOD(25,int)
#define MS_VIDEO_CAPTURE_SET_AUTOFOCUS MS_FILTER_BASE_METHOD(26,int)
/* pass value of type MSRtpPayloadPickerContext copied by the filter*/
#define MS_FILTER_SET_RTP_PAYLOAD_PICKER MS_FILTER_BASE_METHOD(27,void*)	

#define MS_CONF_SPEEX_PREPROCESS_MIC	MS_FILTER_EVENT(MS_CONF_ID, 1, void*)
#define MS_CONF_CHANNEL_VOLUME	MS_FILTER_EVENT(MS_CONF_ID, 3, void*)

void ms_filter_process(MSFilter *f);
void ms_filter_preprocess(MSFilter *f, struct _MSTicker *t);
void ms_filter_postprocess(MSFilter *f);
bool_t ms_filter_inputs_have_data(MSFilter *f);
void ms_filter_notify(MSFilter *f, unsigned int id, void *arg);
void ms_filter_notify_synchronous(MSFilter *f, unsigned int id, void *arg);
void ms_filter_notify_no_arg(MSFilter *f, unsigned int id);
#define ms_filter_lock(f)	ms_mutex_lock(&(f)->lock)
#define ms_filter_unlock(f)	ms_mutex_unlock(&(f)->lock)
void ms_filter_unregister_all(void);

#ifdef __cplusplus
}
#endif

#include "msinterfaces.h"

#define MS_FILTER_DESC_EXPORT(desc)


#endif


