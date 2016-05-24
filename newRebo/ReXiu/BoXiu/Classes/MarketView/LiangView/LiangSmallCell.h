//
//  LiangSmallCell.h
//  BoXiu
//
//  Created by tongmingyu on 14-9-3.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LiangQueryModel.h"

@class LiangSmallCell;
@protocol LiangSmallCellDelegate <NSObject>

- (void)liangSmallCell:(LiangSmallCell *)liangSmallCell buyIdxcode:(LiangData *)liangData;

@end

@interface LiangSmallCell : UIView
@property (nonatomic,assign) id<LiangSmallCellDelegate> delegate;
@property (nonatomic, strong) LiangData *liangData;

- (id)initWithFrame:(CGRect)frame liangData:(LiangData *)liangData;

@end
