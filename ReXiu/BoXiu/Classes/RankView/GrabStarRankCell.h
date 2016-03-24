//
//  GrabStarRankCell.h
//  BoXiu
//
//  Created by tongmingyu on 14-10-21.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfo.h"

@class StarGift;

@interface GrabStarRankCell : UITableViewCell

@property (nonatomic,strong) StarGift *starGift;
@property (nonatomic,assign) NSInteger rankIndex;
@property (nonatomic,strong) UIImageView *headImgView;

+ (CGFloat)height;

@end
