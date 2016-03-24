//
//  RXAlertView.h
//  BoXiu
//
//  Created by andy on 14-10-20.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "EWPSimpleDialog.h"

typedef void(^RXAlertViewBtnBlock)(id sender);

@interface RXAlertView : EWPSimpleDialog

- (id)initWithFrame:(CGRect)frame title:(NSString *)title message:(NSString *)message;

- (void)setLeftBtnTitle:(NSString *)leftBtnTitle normalImg:(UIImage *)normalImg selectedImg:(UIImage *)selectedImg buttonBlock:(RXAlertViewBtnBlock)buttonBlock;

- (void)setRightBtnTitle:(NSString *)rightBtnTitle normalImg:(UIImage *)normalImg selectedImg:(UIImage *)selectedImg buttonBlock:(RXAlertViewBtnBlock)buttonBlock;
@end
