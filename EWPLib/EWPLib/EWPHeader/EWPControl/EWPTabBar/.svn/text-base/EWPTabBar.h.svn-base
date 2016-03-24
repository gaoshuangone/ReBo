//
//  EWPTabBar.h
//  BoXiu
//
//  Created by andy on 14-4-23.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "BaseView.h"

@class EWPTabBar;
@protocol EWPTabBarDelegate <NSObject>

- (void)tabBar:(EWPTabBar *)tabBar didSelectItemWithTag:(NSInteger)itemTag;

@end

@protocol EWPTabBarDataSource <NSObject>

- (NSInteger)numberOfItems;
- (CGFloat)widthOfItem:(NSInteger)index;
- (CGFloat)heightOfItem;
- (NSString *)titleOfItem:(NSInteger)index;
- (NSInteger)tagOfItem:(NSInteger)index;
@end

@interface EWPTabBar : BaseView
@property (nonatomic,assign) id<EWPTabBarDelegate> delegate;
@property (nonatomic,assign) id<EWPTabBarDataSource> dataSource;

@property (nonatomic,strong) UIColor *normalTextColor;
@property (nonatomic,strong) UIColor *selectedTextColor;

@property (nonatomic,strong) UIImage *normalImage;
@property (nonatomic,strong) UIImage *selectedImage;

@property (nonatomic,strong) UIColor *tabNormalBKColor;
@property (nonatomic,strong) UIColor *tabSelectedBKColor;

@property (nonatomic,assign) NSInteger selectedIndex;
@property (nonatomic,assign) CGFloat xOffset;
- (void)reloadData;

@end
