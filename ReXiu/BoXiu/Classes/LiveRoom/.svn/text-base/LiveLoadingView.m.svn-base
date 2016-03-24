//
//  LiveLoadingView.m
//  BoXiu
//
//  Created by andy on 15/12/10.
//  Copyright © 2015年 rexiu. All rights reserved.
//

#import "LiveLoadingView.h"
#import "OLImage.h"
#import "OLImageView.h"

@implementation LiveLoadingView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(0, 0, frame.size.width   , frame.size.height)];
    if (self)
    {
        OLImageView *Aimv = [[OLImageView alloc] initWithImage:[OLImage imageNamed:@"加载(5).gif"]];
//            OLImageView *Aimv = [[OLImageView alloc] initWithImage:[OLImage imageNamed:@"引导1-拷贝(1).gif"]];
        
        [Aimv setFrame:CGRectMake(0, 0, frame.size.width , frame.size.height)];
        [Aimv setUserInteractionEnabled:YES];
        [self addSubview:Aimv];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
