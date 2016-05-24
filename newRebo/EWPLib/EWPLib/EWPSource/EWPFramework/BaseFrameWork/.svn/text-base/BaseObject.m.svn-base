//
//  BaseObject.m
//  EWPLib
//
//  Created by andy on 14-8-29.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "BaseObject.h"
#import "EWPLib.h"


@implementation BaseObject

- (id)init
{
    self = [super init];
    if (self)
    {
        if ([[EWPLib shareInstance] respondsToSelector:@selector(isSuccessOfInit)])
        {
            if (![[EWPLib shareInstance] isSuccessOfInit])
            {
                self = nil;
            }
        }
        else
        {
            self = nil;
        }
    }
    return self;
}
@end
