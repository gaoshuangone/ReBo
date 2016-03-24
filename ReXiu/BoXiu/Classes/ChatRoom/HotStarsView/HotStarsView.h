//
//  HotStarsView.h
//  BoXiu
//
//  Created by tongmingyu on 14-10-28.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HotStarsData;

@protocol HotStarsViewDelegate <NSObject>

- (void)didHotStarUserIdData:(HotStarsData *)hotData;

@end


@interface HotStarsView : UIView

@property (nonatomic, assign) id <HotStarsViewDelegate> delegate;

@property (nonatomic, strong) NSMutableArray *hotStarViewMary;

- (id)initNoHotStarWithFrame:(CGRect)frame title:(NSString *)title message:(NSString *)message;

- (void)setHotStarViewMary:(NSMutableArray *)hotStarViewMary;

@end
