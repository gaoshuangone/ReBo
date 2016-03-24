//
//  CarSmallCell.h
//  BoXiu
//
//  Created by tongmingyu on 14-9-2.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TheCarModel.h"

@class CarSmallCell;
@protocol CarSmallCellDelegate <NSObject>

- (void)carSmallCell:(CarSmallCell *)carSmallCell buyCar:(MallCarData *)carData;

@end

@interface CarSmallCell : UIView

@property (nonatomic,assign) id<CarSmallCellDelegate> delegate;
@property (nonatomic,strong) MallCarData *carData;

- (id)initWithFrame:(CGRect)frame carData:(MallCarData *)carData;

@end
