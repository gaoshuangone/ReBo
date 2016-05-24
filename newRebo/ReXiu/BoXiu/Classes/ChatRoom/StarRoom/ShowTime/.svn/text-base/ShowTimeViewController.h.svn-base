//
//  ShowTimeViewController.h
//  BoXiu
//
//  Created by tongmingyu on 15-1-22.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import "ViewController.h"

@protocol ShowTImeViewControllerDelegate <NSObject>

- (void)sendStarApproveWithPraiseType:(NSInteger )praiseType;

@end

@interface ShowTimeViewController : ViewController

@property (nonatomic,assign) id<ShowTImeViewControllerDelegate> delegate;
@property (nonatomic,assign) NSInteger approveCount;

- (void)initData;

//showTime开始
- (void)beginShowTime:(NSInteger)timeSecond;

/**
 *  showtime 结束通知消息
 *
 *  @param data 结束返回来的所有消息
 */
- (void)endShowTimeWithData:(NSDictionary *)data;

/**
 *  showtime正在进行时接收到tcp的实时数据
 *
 *  @param data 实时数据字典类型
 */
- (void)setShowTimeData:(NSDictionary *)data;

/**
 *  点收费赞返回结果
 */
- (void)receiveSendApproveResult:(NSDictionary *)data;


@end
