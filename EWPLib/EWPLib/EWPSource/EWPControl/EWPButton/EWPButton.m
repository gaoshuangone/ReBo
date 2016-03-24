//
//  EWPButton.m
//  MemberMarket
//
//  Created by andy on 13-11-18.
//  Copyright (c) 2013年 yiwopai. All rights reserved.
//

#import "EWPButton.h"

@interface EWPButton ()

- (void)OnClick:(id) sender;
@end

@implementation EWPButton

- (void)setButtonBlock:(ButtonBlock)buttonBlock
{
    if (buttonBlock)
    {
        _buttonBlock = nil;
        _buttonBlock = [buttonBlock copy];
        [self removeTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
        [self addTarget:self action:@selector(OnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

-(void)setIsSoonCliCKLimit:(BOOL)isSoonCliCKLimit{
    _isSoonCliCKLimit =isSoonCliCKLimit;
}
/*按钮响应函数*/
- (void)OnClick:(id) sender
{
    if (_isSoonCliCKLimit) {
        self.userInteractionEnabled = NO;
        [self performSelector:@selector(timerDelay) withObject:self afterDelay:1.2];
    }
    
    if (_buttonBlock)
    {
        _buttonBlock(self);
    }
}
-(void)timerDelay{
    self.userInteractionEnabled = YES;
}
@end
