//
//  GiftRankCell.h
//  BoXiu
//
//  Created by tongmingyu on 14-5-28.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "UserInfo.h"

@class StarGift;

@interface GiftRankCell : UITableViewCell

@property (nonatomic,strong) StarInfo *starInfo;
@property (nonatomic,strong) StarGift *starGift;

+ (CGFloat)height;

@end
