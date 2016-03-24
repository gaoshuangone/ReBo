//
//  AudienceCell.h
//  BoXiu
//
//  Created by andy on 14-5-16.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfoManager.h"
#import "ChatmemberModel.h"

@interface AudienceCell : UITableViewCell

@property (nonatomic,strong) UserInfo *userInfo;
@property (nonatomic,assign,setter = setOpen:) BOOL IsOpen;

+ (CGFloat)height;

@end
