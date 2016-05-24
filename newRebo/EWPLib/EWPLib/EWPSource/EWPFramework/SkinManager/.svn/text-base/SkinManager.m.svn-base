//
//  SkinManager.m
//  BoXiu
//
//  Created by andy on 15-1-27.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import "SkinManager.h"

@implementation SkinManager

+ (SkinManager *)sharedInstance
{
    static dispatch_once_t predicate;
    static id instance;
    dispatch_once(&predicate,^{
        instance = [[self alloc] init];
    });
    return instance;
}

@end
