//
//  FansCell.h
//  BoXiu
//
//  Created by tongmingyu on 14-5-12.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfoManager.h"

@interface FansCell : UITableViewCell
@property (nonatomic,assign) BOOL isThis;
@property (nonatomic,strong) UserInfo *userInfo;
@property (nonatomic,assign) NSInteger rankIndex;
+ (CGFloat)height;

@end