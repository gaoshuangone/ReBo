//
//  VipSofaView.m
//  BoXiu
//
//  Created by 李杰 on 15/7/16.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import "VipSofaView.h"
#import "MacroMethod.h"

@implementation VipSofaView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)initView:(CGRect)frame
{
    if (_vipSofaView == nil) {
        _vipSofaView = [[UIView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 284) / 2, SCREEN_HEIGHT - 277, 284, 277 + 20)];
        _vipSofaView.backgroundColor = [UIColor whiteColor];
        _vipSofaView.layer.cornerRadius = 20;
    }
}
@end
