//
//  msiphone_video_player.h
//  seeku
//
//  Created by yzh on 13-6-17.
//  Copyright (c) 2013年 yzh. All rights reserved.
//

#ifndef PLAYERSTREAM_H
#define PLAYERSTREAM_H

#include "msiphone_video_playerhelp.h"

#ifdef __cplusplus
extern "C"
{
#endif
    
#include "msfilter.h"
#include "libswscale/swscale.h"
#include "libavcodec/avcodec.h"  
    
    static void video_player_init(MSFilter *f);
    static void video_player_preprocess(MSFilter *f);
    static void video_player_process(MSFilter *f);
    static void video_player_uninit(MSFilter *f);
    
    
#ifdef __cplusplus
}
#endif

msiphone_video_playerhelp *playerhelp;

#endif
