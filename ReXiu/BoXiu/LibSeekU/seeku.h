#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <pthread.h>

@interface seeku : NSObject
//{
//    FILE *pfile ;
//};

- (void)lib_audioSession_initialize;
- (void)lib_audioSession_uninitialize;

- (int)lib_start_audio_call:(char *) purl secondPara:(char *) rurl;
- (void)lib_start_audio_callStop;

- (void)lib_seeku_audio_recordStart:(char *) rurl;
- (void)lib_seeku_audio_recordStop;

- (void)lib_seeku_audio_playStart:(char *) purl;
- (void)lib_seeku_audio_playStop;


- (void)lib_seeku_single_play_start:(NSDictionary *) myDict;
- (void)lib_seeku_single_play_start:(UIImageView *) parentView playAdress:(const char *)purl;
- (void) lib_seeku_single_play_stop;

- (int) lib_seeku_single_play_version;
- (long) lib_seeku_single_play_getStreamTotal;
- (void) lib_seeku_single_play_hook: (void *)pfunc args:(void *)pargs;

- (int)  lib_seeku_record_support;
- (void) lib_seeku_record_start_preview:(UIView *)parentView;
- (void) lib_seeku_record_stop_preview;
- (void) lib_seeku_video_switchCapture;
- (int)  lib_seeku_video_hasFlashMode;
- (void) lib_seeku_video_setFlashMode:(int)flashmode;
- (void) lib_seeku_audio_switchMute;
- (int) lib_seeku_record_start_upload:(const char*)url args:(const char *)pargs;
- (void) lib_seeku_record_stop_upload;

@property (readwrite) BOOL playing;
@property (readwrite) BOOL previewing;
@property (readwrite) BOOL uploading;


// new func
// 直播初始化
-(void) lib_seeku_stream_initialize ;
// 直播资源释放
-(void) lib_seeku_stream_release ;
// 开始直播
-(int) lib_seeku_stream_start:(const char*)url args:(const char *)pargs;
// 结束直播
-(void) lib_seeku_stream_stop;
// 直播开始后，往音视频苦传输视频图像RGBA数据
-(void) lib_seeku_put_yuv_image:(unsigned char*)buffer imageWidth:(int)width imageHeight:(int)height;
// 直播开始后，往音视频库传输YUV420视频图像数据
-(void) lib_seeku_put_rgba_image:(unsigned char*)buffer imageWidth:(int)width imageHeight:(int)height;
// new property for new fucn
// 直播是否初始化标志
@property (readwrite) BOOL streamInitialized;
// 是否正在直播标志
@property (readwrite) BOOL isStreaming;

@end
