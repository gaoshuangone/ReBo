//
//  HRSliderController.m
//  HRSliderControllerDemo
//
//  Created by Rannie on 13-10-7.
//  Copyright (c) 2013年 Rannie. All rights reserved.
//

#import "LRSliderMenuViewController.h"
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

@interface LRSliderMenuViewController ()<UINavigationControllerDelegate>

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

@property(strong,nonatomic)UIImageView* maskView;
@end

@implementation LRSliderMenuViewController


- (id)initWithRootViewController:(UIViewController *)rootViewController
              leftViewController:(UIViewController *)leftViewController
             rightViewController:(UIViewController *)rightViewController
{
    if (self = [super init])
    {
        self.canShowLeftMenu = NO;
        self.canShowLeftMenu = NO;
        self.rootViewController = rootViewController;
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
    [navigationBar setBackgroundImage:[CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"ebf5ed"] size:CGSizeMake(SCREEN_WIDTH, 66)] forBarMetrics:UIBarMetricsDefault];
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

#pragma mark -
#pragma mark Intialize Method

- (void)initSubviews
{
    if (self.rightViewController)
    {
        UIView *rv = [[UIView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:rv];
        _rightSideView = rv;
    }

    if (self.leftViewController)
    {
        UIView *lv = [[UIView alloc] initWithFrame:self.view.bounds];
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
    
    [self.view sendSubviewToBack:_rightSideView];
    [self configureViewShadowWithDirection:LRMoveDirectionRight];
    
    [UIView animateWithDuration:LROpenMenuDuration
                     animations:^{
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
    
    [self.view sendSubviewToBack:_leftSideView];
    [self configureViewShadowWithDirection:LRMoveDirectionLeft];
    
    [UIView animateWithDuration:LROpenMenuDuration
                     animations:^{
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
        
        CGFloat sca;
        if (transX > 0)
        {
            if (!self.canShowLeftMenu)
            {
                return;
            }
            if (!self.leftViewController) {
                return;
            }
            [self.view sendSubviewToBack:_rightSideView];
            [self configureViewShadowWithDirection:LRMoveDirectionRight];
            
            if (_mainContentView.frame.origin.x < LRContentOffset)
            {
                sca = 1 - (_mainContentView.frame.origin.x/LRContentOffset) * (1-LRContentScale);
            }
            else
            {
                sca = LRContentScale;
            }
            menuWillShow = YES;
        }
        else    //transX < 0
        {
            if (!self.canShowRightMenu)
            {
                return;
            }
            if (!self.rightViewController)
            {
                return;
            }
            [self.view sendSubviewToBack:_leftSideView];
            [self configureViewShadowWithDirection:LRMoveDirectionLeft];
            
            if (_mainContentView.frame.origin.x > -LRContentOffset)
            {
                sca = 1 - (-_mainContentView.frame.origin.x/LRContentOffset) * (1-LRContentScale);
            }
            else
            {
                sca = LRContentScale;
            }
            menuWillShow = YES;
        }
        CGAffineTransform transS = CGAffineTransformMakeScale(1.0, sca);
        CGAffineTransform transT = CGAffineTransformMakeTranslation(transX, 0);
        
        CGAffineTransform conT = CGAffineTransformConcat(transT, transS);
        
        _mainContentView.transform = conT;
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
    CGAffineTransform scaleT = CGAffineTransformMakeScale(1.0, LRContentScale);
    CGAffineTransform conT = CGAffineTransformConcat(transT, scaleT);
    
    return conT;
}

- (void)configureViewShadowWithDirection:(LRMoveDirection)direction
{
    CGFloat shadowW;
    switch (direction)
    {
        case LRMoveDirectionLeft:
            shadowW = 1.0f;
            break;
        case LRMoveDirectionRight:
            shadowW = -1.0f;
            break;
        default:
            break;
    }
    
    _mainContentView.layer.shadowOffset = CGSizeMake(shadowW, 1.0);
    _mainContentView.layer.shadowColor = [UIColor blackColor].CGColor;
    _mainContentView.layer.shadowOpacity = 0.2f;
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
