//
//  EWPScrollNotice.h
//  BoXiu
//
//  Created by andy on 14-5-14.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OHAttributedLabel.h"

@interface EWPScrollNotice : UIView
@property (nonatomic,assign) int scrollCircleCount;
@property (nonatomic,strong) UIColor *linkColor;
@property (nonatomic,strong) NSString *textColor;//十六进制
@property (nonatomic,assign) CGFloat fontSize;

- (id)initWithFrame:(CGRect)frame message:(NSString *)message inParrentView:(UIView *)parentView;
- (OHAttributedLabel *)addMessage:(NSString *)message;

- (void)start;
- (void)stop;
@end
