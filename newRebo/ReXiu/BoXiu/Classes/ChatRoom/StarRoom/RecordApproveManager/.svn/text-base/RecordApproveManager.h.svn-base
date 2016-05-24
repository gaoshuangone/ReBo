//
//  RecordApproveManager.h
//  BoXiu
//
//  Created by andy on 15-1-26.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecordApproveManager : NSObject

+ (RecordApproveManager *)shareInstance;

- (void)addApproveCount:(NSInteger)approveCount;

- (void)addFreeApproveCount;

//保存当前用户送给的当前主播的赞数
- (BOOL)saveApproveCount:(NSInteger)approveCount showId:(NSInteger)showId;

- (NSInteger)approveCountOfCurrentShowId;

//返回当前用户送给当前主播的赞数
- (NSInteger)approveCountOfShowId:(NSInteger)showId;

//showtime开始，每5s发送一次免费赞
- (void)beginSendFreeApproveWithShowId:(NSInteger)showId;

//showtime结束，关闭定时器，停止发送
- (void)stopSendFreeApprove;

@end
