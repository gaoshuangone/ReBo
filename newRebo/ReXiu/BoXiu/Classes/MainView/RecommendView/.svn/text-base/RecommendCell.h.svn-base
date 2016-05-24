//
//  RecommendCell.h
//  BoXiu
//
//  Created by andy on 14-9-24.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfoManager.h"

@class RecommendCell;
@protocol RecommendCellDelegate <NSObject>

- (void)recommendCell:(RecommendCell *)recommendCell attendStar:(StarInfo *)starInfo;

@end
@interface RecommendCell : UITableViewCell
@property (nonatomic,assign) id<RecommendCellDelegate> delegate;
@property (nonatomic,strong) StarInfo *starInfo;
@property (nonatomic,strong) UIImageView *adPhoto;
+ (CGFloat)height;
@end
