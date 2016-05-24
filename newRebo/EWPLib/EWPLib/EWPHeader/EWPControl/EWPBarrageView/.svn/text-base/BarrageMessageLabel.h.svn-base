//
//  BarrageMessageLabel.h
//  BoXiu
//
//  Created by andy on 14-12-19.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OHAttributedLabel.h"
typedef void(^Completion)();

@interface BarrageMessageLabel : OHAttributedLabel

//监测是否超过指定位置
@property (nonatomic,assign) CGPoint fixedLocation;

@property (nonatomic,assign,readonly) BOOL isExceedLocation;
/**
 *  在一定时间内显示完
 *
 *  @param duration   显示时长
 *  @param completion 完成回调
 */
- (void)starAnimationWithDuraion:(CGFloat)duration completion:(Completion)completion;

/**
 *  以一定速度显示完
 *
 *  @param rate       每秒多少贞，默认25
 *  @param completion 完成时回调
 */
- (void)starAnimationWithRate:(CGFloat)rate completion:(Completion)completion;

@end
