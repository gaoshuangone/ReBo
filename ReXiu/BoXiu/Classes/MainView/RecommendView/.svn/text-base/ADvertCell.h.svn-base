//
//  ADvertCell.h
//  BoXiu
//
//  Created by tongmingyu on 14-12-29.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ADvertCell.h"
@class ADvertCell;
@protocol ADvertCellDelegate <NSObject>

- (void)closeAdVertCell;

- (void)adVertCell:(ADvertCell *)adVertCell indexOfAdImg:(NSInteger)index;

@end

@interface ADvertCell : UITableViewCell

@property (nonatomic,assign) id<ADvertCellDelegate> delegate;

@property (nonatomic,strong) NSMutableArray *AdImgUrlArray;

+ (CGFloat)height;
@end
