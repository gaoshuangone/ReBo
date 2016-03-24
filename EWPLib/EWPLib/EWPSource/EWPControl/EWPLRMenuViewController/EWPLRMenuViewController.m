//
//  EWPLRMenuViewController.m
//  BoXiu
//
//  Created by andy on 15-1-21.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import "EWPLRMenuViewController.h"
#import <QuartzCore/QuartzCore.h>

#define LRCloseDuration 0.3f
#define LROpenMenuDuration 0.4f
#define LRContentScale 1.0f
#define LRContentOffset 250.0f
#define LRJudgeOffset 100.0f

typedef NS_ENUM(NSInteger, LRMoveDirection) {
    LRMoveDirectionLeft = 0,
    LRMoveDirectionRight
};

@interface EWPLRMenuViewController ()<UINavigationControllerDelegate>

@property (nonatomic,strong) UIViewController *leftViewController;
@property (nonatomic,strong) UIViewController *rightViewController;
@property (nonatomic,strong) UIViewController *rootViewController;

@property (nonatomic,assign) BOOL canShowLeftMenu;
@property (nonatomic,assign) BOOL canShowRightMenu;

@property (nonatomic,strong) UITapGestureRecognizer *tapGestureRec;
@property (nonatomic,strong) UIPanGestureRecognizer *panGestureRec;

@property (nonatomic,strong) UIView *mainContentView;
@property (nonatomic,strong) UIView *leftSideView;
@property (nonatomic,strong) UIView *rightSideView;

@end

@implementation EWPLRMenuViewController


- (id)initWithRootViewController:(UIViewController *)rootViewController
              leftViewController:(UIViewController *)leftViewController
             rightViewController:(UIViewController *)rightViewController
{
    if (self = [super init])
    {
        self.canShowLeftMenu = NO;
        self.canShowLeftMenu = NO;
        if (rootViewController)
        {
            self.rootViewController = rootViewController;
        }

        if (leftViewController)
        {
            self.leftViewController = leftViewController;
            self.canShowLeftMenu = YES;
        }
        
        if (rightViewController)
        {
            self.rightViewController = rightViewController;
            self.canShowRightMenu = YES;
        }
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    UINavigationBar *navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    [self.view addSubview:navigationBar];
    
    self.menuShowing = NO;
    self.LeftMenuShowing = NO;
    self.RightMenuShowing = NO;
    [self initSubviews];
    [self initChildControllers];
    
    [self showRootViewController:self.rootViewController];

    
    _tapGestureRec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeSideBar)];
    [self.view addGestureRecognizer:_tapGestureRec];
    _tapGestureRec.enabled = NO;
    
    _panGestureRec = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveViewWithGesture:)];
    [_mainContentView addGestureRecognizer:_panGestureRec];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}
#pragma mark -
#pragma mark Intialize Method

- (void)initSubviews
{
    if (self.rightViewController)
    {
        UIView *rv = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [self.view addSubview:rv];
        _rightSideView = rv;
    }
    
    if (self.leftViewController)
    {
        UIView *lv = [[UIView alloc] initWithFrame:CGRectMake(-SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [self.view addSubview:lv];
        _leftSideView = lv;

    }
    
    if (self.rootViewController)
    {
        UIView *mv = [[UIView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:mv];
        _mainContentView = mv;
    }

}

- (void)initChildControllers
{
    
    if (self.leftViewController)
    {
        [self addChildViewController:self.leftViewController];
        [_leftSideView addSubview:self.leftViewController.view];
    }
    
    if (self.rightViewController)
    {
        [self addChildViewController:self.rightViewController];
        [_rightSideView addSubview:self.rightViewController.view];
    }
    
}

- (void)showRootViewController
{
    [self closeSideBar];
}

- (void)showRootViewController:(UIViewController *)rootViewController
{
    if (rootViewController == nil)
    {
        return;
    }
    if ([rootViewController isKindOfClass:[UINavigationController class]])
    {
        UINavigationController *navigationController = (UINavigationController *)rootViewController;
        navigationController.delegate = self;
    }
    [self closeSideBar];
    UIView *tempView = _rootViewController.view;
    _rootViewController = rootViewController;
    if (tempView)
    {
        [tempView removeFromSuperview];
    }
    
    
    [_mainContentView addSubview:rootViewController.view];
}

- (void)closeSideBar
{
    CGAffineTransform oriT = CGAffineTransformIdentity;
    [UIView animateWithDuration:LRCloseDuration
                     animations:^{
                         if (self.LeftMenuShowing)
                         {
                             _leftSideView.transform = oriT;
                         }
                         
                         if (self.RightMenuShowing)
                         {
                             _rightSideView.transform = oriT;
                         }
                         _mainContentView.transform = oriT;
                     }
                     completion:^(BOOL finished) {
                         _tapGestureRec.enabled = NO;
                         self.menuShowing = NO;
                         self.LeftMenuShowing = NO;
                         self.RightMenuShowing = NO;
                     }];
}


/*显示左侧view*/
- (void)showLeftView
{
    if (!self.canShowLeftMenu)
    {
        return;
    }
    if (!self.leftViewController) {
        return;
    }
    CGAffineTransform conT = [self transformWithDirection:LRMoveDirectionRight];
    
    [self.view bringSubviewToFront:_leftSideView];
    [self.view sendSubviewToBack:_rightSideView];
    [self configureViewShadowWithDirection:LRMoveDirectionRight];
    
    [UIView animateWithDuration:LROpenMenuDuration
                     animations:^{
                         _leftSideView.transform = conT;
                         _mainContentView.transform = conT;
                     }
                     completion:^(BOOL finished) {
                         _tapGestureRec.enabled = YES;
                         self.menuShowing = YES;
                         self.LeftMenuShowing = YES;
                     }];
}

/*显示右侧view*/
- (void)showRightView
{
    if (!self.canShowRightMenu)
    {
        return;
    }
    if (!self.rightViewController)
    {
        return;
    }
    CGAffineTransform conT = [self transformWithDirection:LRMoveDirectionLeft];
    
    [self.view bringSubviewToFront:_rightSideView];
    [self.view sendSubviewToBack:_leftSideView];
    [self configureViewShadowWithDirection:LRMoveDirectionLeft];
    
    [UIView animateWithDuration:LROpenMenuDuration
                     animations:^{
                         _rightSideView.transform = conT;
                         _mainContentView.transform = conT;
                     }
                     completion:^(BOOL finished) {
                         _tapGestureRec.enabled = YES;
                         self.menuShowing = YES;
                         self.RightMenuShowing = YES;
                     }];
    
}


- (void)moveViewWithGesture:(UIPanGestureRecognizer *)panGes
{
    static CGFloat currentTranslateX;
    static BOOL menuWillShow = NO;
    if (panGes.state == UIGestureRecognizerStateBegan)
    {
        currentTranslateX = _mainContentView.transform.tx;
    }
    if (panGes.state == UIGestureRecognizerStateChanged)
    {
        CGFloat transX = [panGes translationInView:_mainContentView].x;
        transX = transX + currentTranslateX;
        
        CGAffineTransform transS = CGAffineTransformMakeScale(1.0, 1.0);
        CGAffineTransform transT = CGAffineTransformMakeTranslation(transX, 0);
        
        CGAffineTransform conT = CGAffineTransformConcat(transT, transS);
        if (transX > 0 && transX < LRContentOffset)
        {
            if (!self.canShowLeftMenu)
            {
                return;
            }
            if (!self.leftViewController) {
                return;
            }
            [self configureViewShadowWithDirection:LRMoveDirectionRight];
            
            menuWillShow = YES;
            _leftSideView.transform = conT;
            _mainContentView.transform = conT;
        }
        else if(transX < 0 && transX > -LRContentOffset)   //transX < 0
        {
            if (!self.canShowRightMenu)
            {
                return;
            }
            if (!self.rightViewController)
            {
                return;
            }
            [self configureViewShadowWithDirection:LRMoveDirectionLeft];
            
            menuWillShow = YES;
            _rightSideView.transform = conT;
            _mainContentView.transform = conT;
        }
    }
    else if (panGes.state == UIGestureRecognizerStateEnded)
    {
        CGFloat panX = [panGes translationInView:_mainContentView].x;
        CGFloat finalX = currentTranslateX + panX;
        if (finalX > LRJudgeOffset)
        {
            if (!self.canShowLeftMenu )
            {
                return;
            }
            if (!self.leftViewController) {
                return;
            }
            CGAffineTransform conT = [self transformWithDirection:LRMoveDirectionRight];
            [UIView beginAnimations:nil context:nil];
            _leftSideView.transform = conT;
            _mainContentView.transform = conT;
            [UIView commitAnimations];
            self.menuShowing = YES;
            self.LeftMenuShowing = YES;
            _tapGestureRec.enabled = YES;
            return;
        }
        if (finalX < -LRJudgeOffset)
        {
            if (!self.canShowRightMenu)
            {
                return;
            }
            if (!self.rightViewController)
            {
                return;
            }
            CGAffineTransform conT = [self transformWithDirection:LRMoveDirectionLeft];
            [UIView beginAnimations:nil context:nil];
            _rightSideView.transform = conT;
            _mainContentView.transform = conT;
            [UIView commitAnimations];
            self.menuShowing = YES;
            self.RightMenuShowing = YES;
            _tapGestureRec.enabled = YES;
            return;
        }
        else
        {
            if (self.RightMenuShowing || self.LeftMenuShowing)
            {
                CGAffineTransform oriT = CGAffineTransformIdentity;
                [UIView beginAnimations:nil context:nil];
                if (self.LeftMenuShowing)
                {
                    _leftSideView.transform = oriT;
                }
                if (self.RightMenuShowing)
                {
                    _rightSideView.transform = oriT;
                }
                _mainContentView.transform = oriT;

                [UIView commitAnimations];
                self.menuShowing = NO;
                self.LeftMenuShowing = NO;
                self.RightMenuShowing = NO;
                _tapGestureRec.enabled = NO;
            }
            if (menuWillShow)
            {
                CGAffineTransform oriT = CGAffineTransformIdentity;
                [UIView beginAnimations:nil context:nil];
                if (_leftSideView)
                {
                    _leftSideView.transform = oriT;
                }
                if (_rightSideView)
                {
                    _rightSideView.transform = oriT;
                }
                _mainContentView.transform = oriT;
                [UIView commitAnimations];
                self.menuShowing = NO;
                self.LeftMenuShowing = NO;
                self.RightMenuShowing = NO;
                _tapGestureRec.enabled = NO;
            }
            
        }
    }
}

#pragma mark -
#pragma mark Private

- (CGAffineTransform)transformWithDirection:(LRMoveDirection)direction
{
    CGFloat translateX = 0;
    switch (direction) {
        case LRMoveDirectionLeft:
            translateX = -LRContentOffset;
            break;
        case LRMoveDirectionRight:
            translateX = LRContentOffset;
            break;
        default:
            break;
    }
    
    CGAffineTransform transT = CGAffineTransformMakeTranslation(translateX, 0);
    CGAffineTransform scaleT = CGAffineTransformMakeScale(1.0, 1.0);
    CGAffineTransform conT = CGAffineTransformConcat(transT, scaleT);
    
    return conT;
}

- (void)configureViewShadowWithDirection:(LRMoveDirection)direction
{
    UIView *view = nil;
    CGFloat shadowW;
    switch (direction)
    {
        case LRMoveDirectionLeft:
        {
            view = _rightSideView;
            shadowW = -1.5f;
        }
            break;
        case LRMoveDirectionRight:
        {
            view = _leftSideView;
            shadowW = 1.5f;
        }
            break;
        default:
            break;
    }
    [self.view bringSubviewToFront:view];
    view.layer.shadowOffset = CGSizeMake(shadowW, 1.0);
    view.layer.shadowColor = [UIColor blackColor].CGColor;
    view.layer.shadowOpacity = 0.2f;
}

#pragma mark -UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (navigationController == self.rootViewController)
    {
        UINavigationController *curNavigationController = (UINavigationController *)self.rootViewController;
        NSArray *viewControllers = curNavigationController.viewControllers;
        if (viewControllers && [viewControllers count])
        {
            UIViewController *rootViewController = [viewControllers objectAtIndex:0];
            if (rootViewController == viewController)
            {
                self.panGestureRec.enabled = YES;
                self.canShowLeftMenu = YES;
                self.canShowRightMenu = YES;
            }
            else
            {
                self.panGestureRec.enabled = NO;
                self.canShowLeftMenu = NO;
                self.canShowRightMenu = NO;
            }
        }
        
    }
}
@end
