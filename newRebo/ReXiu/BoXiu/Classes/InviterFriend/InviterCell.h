//
//  TheCarCell.h
//  BoXiu
//
//  Created by tongmingyu on 14-8-29.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InviterFriendModel.h"
#include "InviterFriendViewController.h"
#include "InviterCell.h"


@interface InviterCell : UITableViewCell

@property (nonatomic,strong) Reward *reward;
@property (nonatomic,assign) NSInteger successCount;
@property (nonatomic,assign) NSInteger count;

+ (CGFloat)height;
-(void)setViewLine;

@end
