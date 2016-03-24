//
//  HRSliderController.h
//  HRSliderControllerDemo
//
//  Created by Rannie on 13-10-7.
//  Copyright (c) 2013年 Rannie. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ClassModel;

@interface LRSliderMenuViewController : UIViewController

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
