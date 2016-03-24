#ifndef MSLOG_H
#define MSLOG_H

#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>

#ifdef __cplusplus
extern "C" {
#endif

typedef enum {
	MS_DEBUG=1,
	MS_MESSAGE=1<<1,
	MS_WARNING=1<<2,
	MS_ERROR=1<<3,
	MS_FATAL=1<<4,
	MS_LOGLEV_EN=1<<5
}MSLogLevel;

typedef void (*MSLogFunc)(MSLogLevel lev, const char *fmt, va_list args);

void ms_set_log_file(FILE *file);
void ms_set_log_handler(MSLogFunc func);

extern MSLogFunc ms_logv_out;

extern unsigned int _ms_log_mask;

#define ms_log_level_enabled(level)  (_ms_log_mask & (level))

#define ms_logv(level, fmt, args) \
{\
	if (ms_logv_out != NULL && ms_log_level_enabled(level)) \
		ms_logv_out(level, fmt, args); \
	if ((level) == MS_FATAL) abort(); \
}while(0)

void ms_set_log_level_mask(int levelmask);

static inline void ms_log(MSLogLevel lev, const char *fmt, ...){
	va_list args;
	va_start(args, fmt);
	ms_logv(lev, fmt, args);
	va_end(args);
}

static inline void ms_message(const char *fmt, ...){
	va_list args;
	va_start(args, fmt);
	ms_logv(MS_MESSAGE, fmt, args);
	va_end(args);
}


static inline void ms_warning(const char *fmt, ...)
{
	va_list args;
	va_start(args, fmt);
	ms_logv(MS_WARNING, fmt, args);
	va_end(args);
}

static inline void ms_error(const char *fmt, ...)
{
	va_list args;
	va_start(args, fmt);
	ms_logv(MS_ERROR, fmt, args);
	va_end(args);
}

static inline void ms_fatal(const char *fmt, ...)
{
	va_list args;
	va_start(args, fmt);
	ms_logv(MS_FATAL, fmt, args);
	va_end(args);
}

static inline void ms_debug(const char *fmt, ...)
{
	va_list args;
	va_start (args, fmt);
	ms_logv(MS_DEBUG, fmt, args);
	va_end (args);
}


#ifdef __cplusplus
}
#endif

#endif

