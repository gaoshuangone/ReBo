//
//  EWPScrollNotice.h
//  BoXiu
//
//  Created by andy on 14-5-14.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EWPScrollNotice : UIView
@property (nonatomic,assign) int scrollCircleCount;
@property (nonatomic,strong) UIColor *linkColor;

- (id)initWithFrame:(CGRect)frame message:(NSString *)message inParrentView:(UIView *)parentView;
- (void)addMessage:(NSString *)message;

- (void)start;
- (void)stop;
@end
