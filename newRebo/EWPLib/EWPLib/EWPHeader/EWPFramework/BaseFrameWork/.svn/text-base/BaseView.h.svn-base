//
//  BaseView.h
//  EWPLib
//
//  Created by andy on 14-8-29.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "EWPFramework.h"

@protocol IBaseViewProtocol <NSObject>

- (void)viewWillAppear;
- (void)viewwillDisappear;

- (void)initView:(CGRect)frame;

@end

@class BaseViewController;
@interface BaseView : UIView<IBaseViewProtocol>

//包含此view的父视图
@property (nonatomic,strong) UIView *containerView;

@property (nonatomic,assign) id prames;
@property (nonatomic,strong) BaseViewController *rootViewController;

- (id)initWithFrame:(CGRect)frame showInView:(UIView *)containerView;




- (void)viewWillAppear;
- (void)viewwillDisappear;

@end
