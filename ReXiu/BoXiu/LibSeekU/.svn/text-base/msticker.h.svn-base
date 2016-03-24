#ifndef MSTICKER_H
#define MSTICKER_H

#include "msport.h"
#include <sys/time.h>
#include <sys/resource.h>
#include "msfilter.h"
#include "mslog.h"
#include "msqueue.h"

typedef uint64_t (*MSTickerTimeFunc)(void *);

enum _MSTickerPrio{
	MS_TICKER_PRIO_NORMAL,
	MS_TICKER_PRIO_HIGH,
	MS_TICKER_PRIO_REALTIME
};

typedef enum _MSTickerPrio MSTickerPrio;

struct _MSTicker
{
	ms_mutex_t lock;
	ms_cond_t cond;
	MSList *execution_list;
	ms_thread_t thread;
	int interval;
	int exec_id;
	uint32_t ticks;
	uint64_t time;
	uint64_t orig;
	MSTickerTimeFunc get_cur_time_ptr;
	void *get_cur_time_data;
	char *name;
	double av_load;
	MSTickerPrio prio;
	bool_t run;
};

typedef struct _MSTicker MSTicker;


#ifdef __cplusplus
extern "C"{
#endif

MSTicker *ms_ticker_new(void);

void ms_ticker_start(MSTicker *s);

void ms_ticker_set_name(MSTicker *ticker, const char *name);

void ms_ticker_set_priority(MSTicker *ticker, MSTickerPrio prio);

int ms_ticker_attach(MSTicker *ticker, MSFilter *f);

int ms_ticker_detach(MSTicker *ticker, MSFilter *f);

void ms_ticker_destory(MSTicker *ticker);

void ms_ticker_set_time_func(MSTicker *ticker, MSTickerTimeFunc func, void *user_data);

void ms_ticker_print_graphs(MSTicker *ticker);

float ms_ticker_get_average_load(MSTicker *ticker);



#ifdef __cplusplus
}
#endif

#endif 


