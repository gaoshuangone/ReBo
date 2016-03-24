//
//  UIView+Tools.m
//  BoXiu
//
//  Created by CaiZetong on 15/8/5.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import "UIView+Tools.h"
#import <objc/runtime.h>

const static char * userIdKey = "userIdKey";

@implementation UIView (Tools)

- (void)setUserId:(NSString *)userId
{
    objc_setAssociatedObject(self, userIdKey, userId, OBJC_ASSOCIATION_RETAIN);
}

- (NSString *)userId {
    id obj = objc_getAssociatedObject(self, userIdKey);
    if([obj isKindOfClass:[NSString class]])
    {
        return (NSString *)obj;
    }
    return nil;
}

@end
