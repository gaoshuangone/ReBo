#ifndef PORT_H
#define PORT_H

#include <errno.h>
#include <sys/types.h>
#include <pthread.h>
#include <unistd.h>
#include <fcntl.h>
#include <stdlib.h>
#include <stdio.h>
#include <stdarg.h>
#include <string.h>

typedef int ms_socket_t;
typedef pthread_t ms_thread_t;
typedef pthread_mutex_t ms_mutex_t;
typedef pthread_cond_t ms_cond_t;

#ifdef __cplusplus
extern "C"
{
#endif

int __ms_thread_join(ms_thread_t thread, void **ptr);
int __ms_thread_create(pthread_t *thread, pthread_attr_t *attr, void * (*routine)(void*), void *arg);

#ifdef __cplusplus
}
#endif

#define ms_thread_create	__ms_thread_create
#define ms_thread_join	__ms_thread_join
#define ms_thread_exit1	pthread_exit
#define ms_mutex_init		pthread_mutex_init
#define ms_mutex_lock		pthread_mutex_lock
#define ms_mutex_unlock	pthread_mutex_unlock
#define ms_mutex_destroy	pthread_mutex_destroy
#define ms_cond_init		pthread_cond_init
#define ms_cond_signal	pthread_cond_signal
#define ms_cond_broadcast	pthread_cond_broadcast
#define ms_cond_wait		pthread_cond_wait
#define ms_cond_destroy	pthread_cond_destroy

typedef unsigned char bool_t;
#undef TRUE
#undef FALSE
#define TRUE 1
#define FALSE 0

#ifdef __cplusplus
extern "C"{
#endif

void* ms_malloc(size_t sz);
void ms_free(void *ptr);
void* ms_realloc(void *ptr, size_t sz);
void* ms_malloc0(size_t sz);
char * ms_strdup(const char *tmp);

typedef struct _MSMemoryFunctions {
	void *(*malloc_fun)(size_t sz);
	void *(*realloc_fun)(void *ptr, size_t sz);
	void (*free_fun)(void *ptr);
} MSMemoryFunctions;

void ms_set_memory_functions(MSMemoryFunctions *functions);


#define ms_new0(type,count)	(type *)ms_malloc0(sizeof(type)*(count))

#define ms_new(type,count)		(type *)ms_malloc(sizeof(type)*(count))


#ifdef __cplusplus
}
#endif


#endif

