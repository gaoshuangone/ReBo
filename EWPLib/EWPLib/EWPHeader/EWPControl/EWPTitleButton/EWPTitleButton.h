//
//  EWPTitleButton.h
//  BoXiu
//
//  Created by andy on 14-5-12.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EWPTitleButton : UIControl

@property (nonatomic,assign) CGFloat fontSize;
@property (nonatomic,assign) CGFloat spaceOfImageTitle;
@property (nonatomic,strong) UIColor *textColor;
- (id)initWithTitle:(NSString *)title Image:(UIImage *)image;

@end
