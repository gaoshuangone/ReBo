//
//  EWPDialog.h
//  BoXiu
//
//  Created by andy on 14-5-13.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ButtonBlock)(id sender);

@interface EWPDialog : UIView

@property (nonatomic,strong) UIColor *titleColor;
@property (nonatomic,strong) UIColor *messageColor;
@property (nonatomic,assign) BOOL hideCloseBtn;
@property (nonatomic) BOOL backTouchHide;
@property (nonatomic,assign) CGFloat maskValue;
@property (nonatomic,strong) UIImage *dialogBKImage;

- (id)initWithTitle:(NSString *)title message:(NSString *)message parentView:(UIView *)parentView;

- (void)setLeftBtnTitle:(NSString *)leftBtnTitle normalImg:(UIImage *)normalImg selectedImg:(UIImage *)selectedImg buttonBlock:(ButtonBlock)buttonBlock;
- (void)setRightBtnTitle:(NSString *)rightBtnTitle normalImg:(UIImage *)normalImg selectedImg:(UIImage *)selectedImg buttonBlock:(ButtonBlock)buttonBlock;

- (void)show;
- (void)hideDialog;

@end
