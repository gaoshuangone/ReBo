//
//  msiphone_audio_playsensor.h
//  seeku
//
//  Created by yzh on 13-4-1.
//  Copyright (c) 2013年 yzh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <OpenAL/al.h>
#import <OpenAL/alc.h>
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>


@interface msiphone_audio_playsensor : NSObject
{
    ALCdevice*				device;
    ALCcontext*				context;
    ALuint					buffer;
    ALuint					source;
    bool route;
}
@property (nonatomic, assign) BOOL hadHeadset;

//初始化音频会话
- (void)lib_audioSession_init;
//检测是否存在耳机
- (BOOL)hasHeadset;
//监听耳机的插拔状态
void audioRouteChangeListenerCallback (
                                       void                     *inUserData,
                                       AudioSessionPropertyID  inPropertyID,
                                       UInt32           inPropertyValueSize,
                                       const void          *inPropertyValue
                                       );



@end
