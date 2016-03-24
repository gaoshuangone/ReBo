//
//  AttentCell.h
//  BoXiu
//
//  Created by Andy on 14-4-12.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GeneralRankCell.h"


@interface AttentCell : UITableViewCell
{
    UIButton *_liveStatus;
    UIImageView *_accessoryImage;
}

@property (nonatomic,strong) StarInfo *starInfo;
@property (nonatomic,strong) UIButton *addAttenBtn;

+ (CGFloat)height;

@end
