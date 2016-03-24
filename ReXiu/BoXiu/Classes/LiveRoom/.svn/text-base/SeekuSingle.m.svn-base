//
//  SeekuSingle.m
//  BoXiu
//
//  Created by andy on 15/12/15.
//  Copyright © 2015年 rexiu. All rights reserved.
//

#import "SeekuSingle.h"

@implementation SeekuSingle
+(seeku*)shareSeekuSingle{
    static seeku *seekuInstance = nil;
    static dispatch_once_t onckToken;
    dispatch_once(&onckToken,^{
        seekuInstance = [[seeku alloc]init];
        //          [seekuInstance lib_audioSession_initialize];
        
    });
    return seekuInstance;
}

@end
