//
//  LiangSearchCell.h
//  BoXiu
//
//  Created by tongmingyu on 14-9-3.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LiangQueryModel.h"

@protocol LiangSearchCellDelegate <NSObject>

- (void)didLiangIdxcodeCell:(LiangData *)liangData;

@end


@interface LiangSearchCell : UITableViewCell

@property (nonatomic, assign) id<LiangSearchCellDelegate> delegate;

@property (nonatomic,strong) NSArray *cellDataArray;

+ (CGFloat)height;


@end
