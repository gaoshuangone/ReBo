//
//  VipHeadView.h
//  BoXiu
//
//  Created by 李杰 on 15/7/18.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SofaListModel.h"
#import "SofaCell.h"

@class VipHeadView;
@protocol VipHeadViewDelegate <NSObject>

@optional
- (void)didSelectedCell:(VipHeadView *)vipHeadView;

@end

@interface VipHeadView : UIView

@property (nonatomic, strong) SofaData *data;
@property (nonatomic, assign) id<VipHeadViewDelegate> delegate;

@property (nonatomic, strong) UILabel *nick;
@property (nonatomic,strong) UIImageView *headImgView;

@end
