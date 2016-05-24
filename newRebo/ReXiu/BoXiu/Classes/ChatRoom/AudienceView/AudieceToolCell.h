//
//  AudieceToolCell.h
//  BoXiu
//
//  Created by andy on 14-5-19.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatmemberModel.h"
#import "UserInfo.h"

@interface AudieceToolCellButton : UIButton

@end

@class AudieceToolCell;
@protocol AudienceToolDelegate <NSObject>

- (void)audieceToolCell:(AudieceToolCell *)audieceToolCell didSelectIndex:(int)index;

@end

@interface AudieceToolCell : UITableViewCell
@property (nonatomic,strong) UserInfo *userInfo;
@property (nonatomic,assign) NSInteger showType;//房间类型

@property (nonatomic,assign) id<AudienceToolDelegate> delegate;
+ (CGFloat)heightOfShowType:(NSInteger)showType;
@end
