//
//  TheCarCell.h
//  BoXiu
//
//  Created by tongmingyu on 14-8-29.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TheCarModel.h"

@protocol TheCarCellDelegate <NSObject>

- (void)buyCarWithData:(MallCarData *)carData;

@end


@interface TheCarCell : UITableViewCell

@property (nonatomic, assign) id<TheCarCellDelegate> delegate;

@property (nonatomic,strong) MallCarData *carData;

+ (CGFloat)height;

@end
