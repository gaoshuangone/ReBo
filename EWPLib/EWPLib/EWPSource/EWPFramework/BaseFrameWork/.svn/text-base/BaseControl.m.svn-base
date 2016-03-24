//
//  BaseControl.m
//  EWPLib
//
//  Created by andy on 14-9-18.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "BaseControl.h"
#import "EWPLib.h"

@implementation BaseControl

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


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
