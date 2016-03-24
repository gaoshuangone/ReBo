#ifndef MSJAVA_H
#define MSJAVA_H

#include <jni.h>

#ifdef __cplusplus
extern "C"{
#endif

void ms_set_jvm(JavaVM *vm);

JavaVM *ms_get_jvm(void);

JNIEnv *ms_get_jni_env(void);


#ifdef __cplusplus
}
#endif


#endif
