//
//  ProgramCell.h
//  BoXiu
//
//  Created by tongmingyu on 14-10-30.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QueryLiveSchedulesModel.h"

@protocol ProgramCellDelegate <NSObject>

-(void)didShowPre;

@end

@interface ProgramCell : UITableViewCell

@property(nonatomic, assign) id <ProgramCellDelegate> delegate;

@property (nonatomic, strong) NSMutableArray *liveMary;

+ (CGFloat)height;

@end
