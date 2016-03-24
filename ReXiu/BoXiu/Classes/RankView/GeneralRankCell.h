//
//  GeneralRankCell.h
//  BoXiu
//
//  Created by andy on 14-4-29.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfo.h"

enum {
    RankCellTypeStar,
    RankCellTypeUser
};

@class GeneralRankCell;
@protocol GeneralRankCellDelegate <NSObject>

- (void)generalRankCell:(GeneralRankCell *)generalRankCell didSeletedUserInfo:(UserInfo *)userInfo;

@end
@interface GeneralRankCell : UITableViewCell
{
   
    UILabel *_userNameLable;
    UIImageView *_consumptionLevelImageView;
    UIImageView *_starLevelImageView;
    UIButton *_indexButton;
    
    StarInfo *_starInfo;
}
@property (nonatomic,strong)  UIImageView *headImg;
@property (nonatomic,assign) id<GeneralRankCellDelegate> delegate;
@property (nonatomic,assign) NSInteger rankIndex;
@property (nonatomic,assign) NSInteger rankCellType;
@property (nonatomic,strong) StarInfo *starInfo;
@property (nonatomic,getter = userInfo,setter = setUserInfo:) UserInfo *userInfo;

@property (nonatomic,assign) NSInteger selectBtntag;  //抢星榜 3

+ (CGFloat)height;

@end
