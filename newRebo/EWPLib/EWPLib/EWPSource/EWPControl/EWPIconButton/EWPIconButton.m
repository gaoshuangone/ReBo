//
//  EWPIconButton.m
//
//  Created by Rannie on 13-10-7.
//  Copyright (c) 2013年 Rannie. All rights reserved.
//

#import "EWPIconButton.h"

@implementation EWPIconButton

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(80, 0, contentRect.size.width-70, contentRect.size.height);
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(50, 21, 25, 25);
}

@end
