//
//  VoteMusicCell.h
//  BoXiu
//
//  Created by tongmingyu on 14-12-25.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QueryMusicListModel.h"

@class VoteMusicCell;

@protocol VoteMusicCellDelegate <NSObject>

- (void)voteMusicCell:(VoteMusicCell *)voteMusicCell  musicData:(MusicData *)musicListData longPressGesture:(BOOL)longPressGesture;

@end

@interface VoteMusicCell : UITableViewCell

@property (nonatomic,strong) MusicData *musicData;

@property (nonatomic,assign) id<VoteMusicCellDelegate>delegate;

- (void)canOperate:(NSInteger)canOperate;

+ (CGFloat)height;

@end
