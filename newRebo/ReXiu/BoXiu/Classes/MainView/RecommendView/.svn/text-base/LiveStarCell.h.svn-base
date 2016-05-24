//
//  LiveStarCell.h
//  BoXiu
//
//  Created by tongmingyu on 14-12-29.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QueryLiveSchedulesModel.h"

@class LiveStarCell;
@protocol LiveStarCellDelegate <NSObject>

- (void)liveStarCell:(LiveStarCell *)liveStarCell liveStarData:(LiveSchedulesData *)liveStarData;

@end

@interface LiveStarCell : UITableViewCell

@property (nonatomic,assign) id<LiveStarCellDelegate> delegate;

@property (nonatomic,strong) LiveSchedulesData *liveStarData;

+ (CGFloat)height;

@end
