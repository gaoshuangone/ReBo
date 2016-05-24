//
//  EWPBarrageView.h
//  BoXiu
//
//  Created by andy on 14-12-18.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "BaseView.h"
#import "BarrageItem.h"

@class EWPBarrageView;
@protocol EWPBarrageViewDataSource <NSObject>

/**
 *  返回弹幕的行数，计算弹幕的总高。
 *
 *
 *  @return 整数
 */
- (NSInteger)numberOfBarrageViewItem;

/**
 *  返回弹幕每一行高度，计算弹幕总高度
 *
 *
 *  @return 某一行高度
 */
- (CGFloat)heightOfBarrageViewItem;

/**
 *  每一行弹幕的间距
 *
 *  @return 间距高度
 */
- (CGFloat)spaceOfBarrageViewItem;

/**
 *  从数据获取消息
 */
- (NSString *)GetBarrageMessageFromQueue;

@end

@interface EWPBarrageView : BaseView

@property (nonatomic,assign) CGFloat fontSize;
@property (nonatomic,strong) NSMutableArray *textColors;
@property (nonatomic,assign) CGFloat duration;

@property (nonatomic,assign) id<EWPBarrageViewDataSource> dataSource;

- (void)showBarrageView;

- (void)hideBarrageView;

@end
