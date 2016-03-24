//
//  ShowtimeItemView.h
//  BoXiu
//
//  Created by tongmingyu on 15-1-28.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import "ShowTimeDataModel.h"
#import "ShowTimeEndModel.h"

@interface ShowtimeItemView : UIView

@property (nonatomic,assign) NSTimeInterval animateWithDuration;
@property (nonatomic,assign) BOOL needBold;

- (id)initShowTimeWithFrame:(CGRect)frame title:(NSString *)title praiseImgName:(NSString *)praiseImgName;

//更新用户信息
- (void)updateNick:(NSString *)nick praiseNum:(NSInteger)praiseNum;

- (void)setNick:(NSString *)nick praiseNum:(NSInteger)praiseNum;

@end
