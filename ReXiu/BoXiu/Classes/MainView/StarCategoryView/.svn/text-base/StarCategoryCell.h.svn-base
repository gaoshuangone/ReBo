//
//  TableViewCell+StarCategoryCell.h
//  BoXiu
//
//  Created by tongmingyu on 15/11/4.
//  Copyright © 2015年 rexiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfoManager.h"

@class StarCategoryCell;
@protocol StarCategoryCellDelegate <NSObject>

- (void)StarCategoryCell:(StarCategoryCell *)StarCategoryCell attendStar:(StarInfo *)starInfo;

@end
@interface StarCategoryCell : UITableViewCell
@property (nonatomic,assign) id<StarCategoryCellDelegate> delegate;
@property (nonatomic,strong) StarInfo *starInfo;

+ (CGFloat)height;
@end
