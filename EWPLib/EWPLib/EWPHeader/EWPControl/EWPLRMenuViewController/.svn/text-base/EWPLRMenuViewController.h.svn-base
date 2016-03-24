//
//  EWPLRMenuViewController.h
//  BoXiu
//
//  Created by andy on 15-1-21.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ClassModel;

@interface EWPLRMenuViewController : UIViewController
@property (nonatomic,assign) BOOL menuShowing;
@property (nonatomic,assign) BOOL LeftMenuShowing;
@property (nonatomic,assign) BOOL RightMenuShowing;

- (id)initWithRootViewController:(UIViewController *)rootViewController
              leftViewController:(UIViewController *)leftViewController
             rightViewController:(UIViewController *)rightViewController;


- (void)showLeftView;
- (void)showRightView;
- (void)showRootViewController;
- (void)showRootViewController:(UIViewController *)rootViewController;

- (void)moveViewWithGesture:(UIPanGestureRecognizer *)panGes;
@end
