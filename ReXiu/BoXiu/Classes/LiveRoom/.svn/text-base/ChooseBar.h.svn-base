//
//  ChooseBar.h
//  BrandShow
//
//  Created by CaiZetong on 15/2/3.
//  Copyright (c) 2015年 cc. All rights reserved.
//

#import <UIKit/UIKit.h>


@class ChooseBar;
@protocol ChooseBarDelegate <NSObject>

@optional

- (void)chooseBar:(ChooseBar *)chooseBar didSelectIndex:(NSInteger)index;

@end

@interface ChooseBar : UIView

@property (nonatomic, strong) NSMutableArray *stringArray;

@property (nonatomic, strong) NSMutableArray *topItems;
@property (nonatomic, strong) NSMutableArray *bottomItems;
@property (nonatomic, strong) UIImageView *selectedMark;
@property (nonatomic, assign) NSInteger selectedIndex;

@property (nonatomic, strong) UIView *itemBottomView;
@property (nonatomic, strong) UIView *itemTopView;
@property (nonatomic, strong) CALayer *selectedMarkLayer;

@property (nonatomic, assign) id<ChooseBarDelegate> delegate;

- (void)setSelectedIndex:(NSInteger)selectedIndex animated:(BOOL)animated;

@end
