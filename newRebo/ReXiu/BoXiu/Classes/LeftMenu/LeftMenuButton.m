//
//  LeftMenuButton.m
//  BoXiu
//
//  Created by andy on 14-6-25.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "LeftMenuButton.h"

@interface LeftMenuButton ()

@end

@implementation LeftMenuButton

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(55, 0, contentRect.size.width-70, contentRect.size.height);
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(10, 12.6, 23, 23);
}

@end
