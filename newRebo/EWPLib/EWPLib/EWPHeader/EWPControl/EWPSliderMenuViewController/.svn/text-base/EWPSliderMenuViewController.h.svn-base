//
//  EWPSliderMenuViewController.h
//  BoXiu
//
//  Created by andy on 15-3-13.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EWPSliderMenuViewController : UIViewController

@property (nonatomic,assign,setter = setSupportPanGesture:) BOOL isSupportPanGesture;
@property (nonatomic,assign,setter = setSupportTapGesture:) BOOL isSupportTapGesture;

@property (nonatomic,assign)BOOL canShowLeft;
@property (nonatomic,assign)BOOL canShowRight;

@property (nonatomic,assign)float leftViewOffset;
@property (nonatomic,assign)float rootViewOffset;
@property (nonatomic,assign)float rightViewOffset;

@property (nonatomic,assign)float leftViewScale;
@property (nonatomic,assign)float rightViewScale;

@property (nonatomic,assign)float leftViewJudgeOffset;
@property (nonatomic,assign)float rightViewJudgeOffset;

@property (nonatomic,assign)float leftViewOpenDuration;
@property (nonatomic,assign)float rightViewOpenDuration;

@property (nonatomic,assign)float leftViewCloseDuration;
@property (nonatomic,assign)float rightViewCloseDuration;

- (id)initWithRootViewController:(UIViewController *)rootViewController
              leftViewController:(UIViewController *)leftViewController
             rightViewController:(UIViewController *)rightViewController;


- (void)showLeftView;
- (void)showRightView;

- (void)closeSliderMenu;
- (void)closeSliderMenuComplete:(void(^)(BOOL finished))complete;
- (void)moveViewWithGesture:(UIPanGestureRecognizer *)panGes;

- (BOOL)isShowingLeftMenu;

@end
