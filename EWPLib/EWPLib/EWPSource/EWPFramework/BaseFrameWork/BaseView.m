//
//  BaseView.m
//  EWPLib
//
//  Created by andy on 14-8-29.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "BaseView.h"
#import "EWPLib.h"

@implementation BaseView

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
    if (self)
    {
        [self initView:frame];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame showInView:(UIView *)containerView
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
        self.containerView = containerView;
        [self initView:frame];
    }
    return self;
}

- (void)initView:(CGRect)frame
{
    
}

- (void)viewWillAppear
{
    
}

- (void)viewwillDisappear
{
    
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
