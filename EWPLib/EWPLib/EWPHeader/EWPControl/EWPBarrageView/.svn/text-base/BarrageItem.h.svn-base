//
//  BarrageItem.h
//  BoXiu
//
//  Created by andy on 14-12-18.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "BaseView.h"
#import "BarrageMessageLabel.h"


@interface BarrageItem : BaseView

@property (nonatomic,assign) CGFloat textFontSize;
@property (nonatomic,readonly,getter=canAddBarrageMessage) BOOL canAddBarrageMessage;
/**
 *  在该item里加入弹幕消息
 *
 *  @param barrageMessage 弹幕消息
 */
- (void)addBarrageMessage:(NSString *)barrageMessage textColor:(UIColor *)textColor;

/**
 *  判断所有消息是否显示完成
 *
 *  @return 完成返回YES，未完成显示NO
 */
- (BOOL)commpleteStateOfBarrageItem;

@end
