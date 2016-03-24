#ifndef MSCOMMON_H
#define MSCOMMON_H

#include <stdint.h>
#include <sys/types.h>
#include <time.h>
#include <errno.h>
#include "msport.h"
#include "mslog.h"


#define ms_return_val_if_fail(_expr_, _ret_)\
	if (!(_expr_)) { ms_error("assert "#_expr_ "failed"); return (_ret_);}

#define ms_return_if_fail(_expr_)\
	if (!(_expr_)){ ms_error("assert "#_expr_ "failed"); return;}

typedef struct MSTimeSpec{
	int64_t tv_sec;
	int64_t tv_nsec;
}MSTimeSpec;

struct _MSList{
	struct _MSList *next;
	struct _MSList *prev;
	void *data;
};

typedef struct _MSList MSList;

#define ms_list_next(elem) ((elem)->next)

typedef int (*MSCompareFunc)(const void *a, const void *b);

#ifdef __cplusplus
extern "C" {
#endif

void ms_thread_exit(void *ret_val);

void ms_get_cur_time(MSTimeSpec *ret);
MSList * ms_list_append(MSList *elem, void * data);
MSList * ms_list_prepend(MSList *elem, void * data);
MSList * ms_list_free(MSList *elem);
MSList * ms_list_concat(MSList *first, MSList *second);
MSList * ms_list_remove(MSList *first, void *data);
int ms_list_size(const MSList *first);
void ms_list_for_each(const MSList *list, void (*func)(void *));
void ms_list_for_each2(const MSList *list, void (*func)(void *, void *), void *user_data);
MSList *ms_list_remove_link(MSList *list, MSList *elem);
MSList *ms_list_find(MSList *list, void *data);
MSList *ms_list_find_custom(MSList *list, MSCompareFunc compare_func, const void *user_data);
void * ms_list_nth_data(const MSList *list, int index);
int ms_list_position(const MSList *list, MSList *elem);
int ms_list_index(const MSList *list, void *data);
MSList *ms_list_insert_sorted(MSList *list, void *data, MSCompareFunc compare_func);
MSList *ms_list_insert(MSList *list, MSList *before, void *data);
MSList *ms_list_copy(const MSList *list);

#undef MIN
#define MIN(a,b)	((a)>(b) ? (b) : (a))
#undef MAX
#define MAX(a,b)	((a)>(b) ? (a) : (b))

#define ms_time time

void ms_sleep(int seconds);

void ms_usleep(uint64_t usec);


#ifdef __cplusplus
}
#endif

#endif

