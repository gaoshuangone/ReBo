//
//  ShowPreViewCell.h
//  BoXiu
//
//  Created by tongmingyu on 14-10-28.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QueryLiveSchedulesModel.h"

@protocol ShowPreViewCellDelegate<NSObject>

- (void)didRoom:(LiveSchedulesData *)liveSchedData;

- (void)didLinkType:(LiveSchedulesData *)liveSchedData;

@end

@interface ShowPreViewCell : UITableViewCell

@property (nonatomic, strong) LiveSchedulesData *liveScheData;

@property (nonatomic, assign) id <ShowPreViewCellDelegate> delegate;

@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UIImageView *vertImgView;
@property (nonatomic, strong) UIImageView *vertImgView2;

+ (CGFloat)height;

@end
