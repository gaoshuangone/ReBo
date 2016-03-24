//
//  EWPSimpleScrollNotice.h
//  BoXiu
//
//  Created by andy on 14-7-2.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EWPSimpleScrollNotice : UIView
@property (nonatomic,assign) int scrollCircleCount;
@property (nonatomic,strong) UIColor *textColor;
@property (nonatomic,strong) UIFont *textFont;

- (id)initWithFrame:(CGRect)frame message:(NSString *)message inParrentView:(UIView *)parentView;
- (void)addMessage:(NSString *)message;

- (void)start;
- (void)stop;
@end
