//
//  EWPSliderMenuViewController.m
//  BoXiu
//
//  Created by andy on 15-3-13.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import "EWPSliderMenuViewController.h"
#import <sys/utsname.h>

typedef NS_ENUM(NSInteger, RMoveDirection) {
    RMoveDirectionLeft = 0,
    RMoveDirectionRight
};

@interface EWPSliderMenuViewController ()<UIGestureRecognizerDelegate>

@property (nonatomic,strong) UIViewController *leftViewController;
@property (nonatomic,strong) UIViewController *rightViewController;
@property (nonatomic,strong) UIViewController *rootViewController;

@property (nonatomic,strong) UIView *rootContentView;
@property (nonatomic,strong) UIView *leftView;
@property (nonatomic,strong) UIView *rightView;

@property (nonatomic,strong) UITapGestureRecognizer *tapGestureRec;
@property (nonatomic,strong) UIPanGestureRecognizer *panGestureRec;

@property (nonatomic,assign) BOOL showingLeft;
@property (nonatomic,assign) BOOL showingRight;

@end

@implementation EWPSliderMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden=YES;
    
    [self initSubviews];
    
    [self initChildControllers];
    [self showRootView];

    
    _tapGestureRec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeSliderMenu)];
    _tapGestureRec.delegate = self;
    [_rootContentView addGestureRecognizer:_tapGestureRec];
    _tapGestureRec.enabled = NO;
    
    _panGestureRec = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveViewWithGesture:)];
    [_rootContentView addGestureRecognizer:_panGestureRec];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initWithRootViewController:(UIViewController *)rootViewController
              leftViewController:(UIViewController *)leftViewController
             rightViewController:(UIViewController *)rightViewController
{
    if (self = [self init])
    {
        if (rootViewController)
        {
            self.rootViewController = rootViewController;
        }
        
        if (leftViewController)
        {
            self.leftViewController = leftViewController;
        }
        
        if (rightViewController)
        {
            self.rightViewController = rightViewController;
        }
        
    }
    return self;
}

- (id)init
{
    if (self = [super init])
    {
        _canShowLeft = YES;
        _canShowRight = YES;
        
        _isSupportPanGesture = YES;
        _isSupportTapGesture = YES;
        
        _leftViewOffset = 250;
        _rightViewOffset = 160;
        _rootViewOffset = 90;
        _leftViewScale = 0.77;
        _rightViewScale = 0.85;
        _leftViewJudgeOffset = 160;
        _rightViewJudgeOffset = 100;
        _leftViewOpenDuration = 0.4;
        _rightViewOpenDuration = 0.4;
        _leftViewCloseDuration = 0.3;
        _rightViewCloseDuration=0.3;
        
    }
    return self;
}

- (void)initSubviews
{
    _rightView = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_rightView];
    
    _leftView = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_leftView];
    
    _rootContentView = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_rootContentView];
}

- (void)initChildControllers
{
    if (_canShowRight && _rightViewController != nil)
    {
        [self addChildViewController:_rightViewController];
        _rightViewController.view.frame=CGRectMake(0, 0, _rightViewController.view.frame.size.width, _rightViewController.view.frame.size.height);
        [_rightView addSubview:_rightViewController.view];
    }
    
    if (_canShowLeft && _leftViewController != nil)
    {
        [self addChildViewController:_leftViewController];
        _leftViewController.view.frame=CGRectMake(0, 0, _leftViewController.view.frame.size.width, _leftViewController.view.frame.size.height);
        [_leftView addSubview:_leftViewController.view];
    }
}

- (void)setSupportPanGesture:(BOOL)isSupportPanGesture
{
    _isSupportPanGesture = isSupportPanGesture;
    _panGestureRec.enabled = _isSupportPanGesture;
}

- (void)setSupportTapGesture:(BOOL)isSupportTapGesture
{
    _isSupportTapGesture = isSupportTapGesture;
    _tapGestureRec.enabled = isSupportTapGesture;
}

- (BOOL)isShowingLeftMenu
{
    return _showingLeft;
}

- (void)showLeftView
{
    if (_showingLeft)
    {
        [self closeSliderMenu];
        return;
    }
    
    if (!_canShowLeft || _leftViewController == nil)
    {
        return;
    }
    [self.view sendSubviewToBack:_rightView];
    
    if (_leftViewController)
    {
        [_leftViewController viewWillAppear:NO];
    }
    CGAffineTransform conT = [self transformWithDirection:RMoveDirectionRight];
    
    CGFloat ltransX = (0 - _leftViewOffset)/_leftViewOffset * _rootViewOffset;
    [self changeTransformForView:_leftView sca:_leftViewScale transX:ltransX];
    
    [self configureViewShadowWithDirection:RMoveDirectionRight];
    
    [UIView animateWithDuration:_leftViewOpenDuration
                     animations:^{
                         _rootContentView.transform = conT;
                         [self changeTransformForView:_leftView sca:1 transX:0];
                     }
                     completion:^(BOOL finished) {
                         _tapGestureRec.enabled = YES;
                         _showingLeft=YES;
                         _rootViewController.view.userInteractionEnabled=NO;
                     }];

}

- (void)showRightView
{
    if (_showingRight) {
        [self closeSliderMenu];
        return;
    }
    if (!_canShowRight || _rightViewController == nil)
    {
        return;
    }
    [self.view sendSubviewToBack:_leftView];
    
    if (_rightViewController)
    {
        [_rightViewController viewWillAppear:NO];
    }
    
    CGAffineTransform conT = [self transformWithDirection:RMoveDirectionLeft];
    
    
    [self configureViewShadowWithDirection:RMoveDirectionLeft];
    
    [UIView animateWithDuration:_rightViewOpenDuration
                     animations:^{
                         _rootContentView.transform = conT;
                     }
                     completion:^(BOOL finished) {
                         _tapGestureRec.enabled = YES;
                         _showingRight=YES;
                         _rootViewController.view.userInteractionEnabled=NO;
                     }];

}

- (void)showRootView
{
    [self closeSliderMenu];
    
    if (_rootViewController == nil)
    {
        _rootViewController = [[UINavigationController alloc] initWithRootViewController:[[UIViewController alloc] init]];
    }

    
    _rootViewController.view.frame = _rootContentView.frame;
    [_rootContentView addSubview:_rootViewController.view];
}

- (void)closeSliderMenu
{
    [self closeSliderMenuComplete:^(BOOL finished) {
        
    }];
}

- (void)closeSliderMenuComplete:(void(^)(BOOL finished))complete
{
    if (_showingLeft)
    {
        CGAffineTransform oriT = CGAffineTransformIdentity;
        CGFloat ltransX = (0 - _leftViewOffset)/_leftViewOffset * _rootViewOffset;
        
        [UIView animateWithDuration:_rootContentView.transform.tx == _leftViewOffset?_leftViewCloseDuration:_rightViewCloseDuration
                         animations:^{
                             _rootContentView.transform = oriT;
                             [self changeTransformForView:_leftView sca:_leftViewScale transX:ltransX];
                         }
                         completion:^(BOOL finished) {
                             _tapGestureRec.enabled = NO;
                             _showingRight=NO;
                             _showingLeft=NO;
                             _rootViewController.view.userInteractionEnabled=YES;
                             complete(finished);
                         }];

    }
    
    if (_showingRight)
    {
        
    }
  

}

- (void)moveViewWithGesture:(UIPanGestureRecognizer *)panGes
{
    static CGFloat currentTranslateX;
    if (panGes.state == UIGestureRecognizerStateBegan)
    {
        currentTranslateX = _rootContentView.transform.tx;
    }
    if (panGes.state == UIGestureRecognizerStateChanged)
    {
        CGFloat transX = [panGes translationInView:_rootContentView].x;
        transX = transX + currentTranslateX;
        CGFloat sca=0;
        
        CGFloat ltransX = (transX - _leftViewOffset)/_leftViewOffset * _rootViewOffset;
        CGFloat lsca = 1;
        
        if (transX > 0)
        {
            if (!_canShowLeft || _leftViewController == nil)
            {
                return;
            }
            
            [self.view sendSubviewToBack:_rightView];
            [self configureViewShadowWithDirection:RMoveDirectionRight];
            
            if (_rootContentView.frame.origin.x < _leftViewOffset)
            {
                sca = 1 - (_rootContentView.frame.origin.x/_leftViewOffset) * (1 - _leftViewScale);
                lsca = 1 - sca + _leftViewScale;
            }
            else
            {
                sca = _leftViewScale;
                lsca = 1;
                
                ltransX = 0;
            }
            [self changeTransformForView:_leftView sca:lsca transX:ltransX];
        }
        else    //transX < 0
        {
            if (!_canShowRight || _rightViewController == nil)
            {
                return;
            }
            
            [self.view sendSubviewToBack:_leftView];
            [self configureViewShadowWithDirection:RMoveDirectionLeft];
            
            if (_rootContentView.frame.origin.x > -_rightViewOffset)
            {
                sca = 1 - (-_rootContentView.frame.origin.x/_rightViewOffset) * (1-_rightViewScale);
            }
            else
            {
                sca = _rightViewScale;
            }
        }
        CGAffineTransform transS = CGAffineTransformMakeScale(sca, sca);
        CGAffineTransform transT = CGAffineTransformMakeTranslation(transX, 0);
        CGAffineTransform conT = CGAffineTransformConcat(transT, transS);
        _rootContentView.transform = conT;
    }
    else if (panGes.state == UIGestureRecognizerStateEnded)
    {
        CGFloat panX = [panGes translationInView:_rootContentView].x;
        CGFloat finalX = currentTranslateX + panX;
        if (finalX > _leftViewJudgeOffset)
        {
            if (!_canShowLeft || _leftViewController == nil)
            {
                return;
            }
            
            if (_leftViewController)
            {
                [_leftViewController viewWillAppear:NO];
            }
            
            CGAffineTransform conT = [self transformWithDirection:RMoveDirectionRight];
            [UIView beginAnimations:nil context:nil];
            _rootContentView.transform = conT;
            [UIView commitAnimations];
            
            _showingLeft=YES;
            _rootViewController.view.userInteractionEnabled=NO;
            
            _tapGestureRec.enabled = YES;
            
            [self showLeft:YES];
            
            return;
        }
        if (finalX < -_rightViewJudgeOffset)
        {
            if (!_canShowRight || _rightViewController == nil)
            {
                return;
            }
            if (_rightViewController)
            {
                [_rightViewController viewWillAppear:NO];
            }
            
            CGAffineTransform conT = [self transformWithDirection:RMoveDirectionLeft];
            [UIView beginAnimations:nil context:nil];
            _rootContentView.transform = conT;
            [UIView commitAnimations];
            
            _showingRight=YES;
            _rootViewController.view.userInteractionEnabled=NO;
            
            _tapGestureRec.enabled = YES;
            
            return;
        }
        else
        {
            CGAffineTransform oriT = CGAffineTransformIdentity;
            [UIView beginAnimations:nil context:nil];
            _rootContentView.transform = oriT;
            [UIView commitAnimations];
            
            [self showLeft:NO];
            
            _showingRight=NO;
            _showingLeft=NO;
            _rootViewController.view.userInteractionEnabled=YES;
            _tapGestureRec.enabled = NO;
        }
    }
}

#pragma mark -

- (void)showLeft:(BOOL)bShow
{
    if (bShow)
    {
        [UIView beginAnimations:nil context:nil];
        [self changeTransformForView:_leftView sca:1 transX:0];
        [UIView commitAnimations];
    }
    else
    {
        [UIView beginAnimations:nil context:nil];
        [self changeTransformForView:_leftView sca:_leftViewScale transX:-_rootViewOffset];
        [UIView commitAnimations];
    }
}

- (CGAffineTransform)transformWithDirection:(RMoveDirection)direction
{
    CGFloat translateX = 0;
    CGFloat transcale = 0;
    switch (direction) {
        case RMoveDirectionLeft:
            translateX = -_rightViewOffset;
            transcale = _rightViewScale;
            break;
        case RMoveDirectionRight:
            translateX = _leftViewOffset;
            transcale = _leftViewScale;
            break;
        default:
            break;
    }
    
    CGAffineTransform transT = CGAffineTransformMakeTranslation(translateX, 0);
    CGAffineTransform scaleT = CGAffineTransformMakeScale(transcale, transcale);
    CGAffineTransform conT = CGAffineTransformConcat(transT, scaleT);
    
    return conT;
}

- (NSString*)deviceWithNumString
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    @try {
        return [deviceString stringByReplacingOccurrencesOfString:@"," withString:@""];
    }
    @catch (NSException *exception) {
        return deviceString;
    }
    @finally {
    }
}

- (void)configureViewShadowWithDirection:(RMoveDirection)direction
{
    if ([[self deviceWithNumString] hasPrefix:@"iPhone"]&&[[[self deviceWithNumString] stringByReplacingOccurrencesOfString:@"iPhone" withString:@""] floatValue]<40) {
        return;
    }
    if ([[self deviceWithNumString] hasPrefix:@"iPod"]&&[[[self deviceWithNumString] stringByReplacingOccurrencesOfString:@"iPod" withString:@""] floatValue]<40) {
        return;
    }
    if ([[self deviceWithNumString] hasPrefix:@"iPad"]&&[[[self deviceWithNumString] stringByReplacingOccurrencesOfString:@"iPad" withString:@""] floatValue]<25) {
        return;
    }
    
    CGFloat shadowW,shadowH;
    switch (direction)
    {
        case RMoveDirectionLeft:
        {
            shadowW = 2.0f;
            shadowH = -2.0f;
        }
            break;
        case RMoveDirectionRight:
        {
            shadowW = -2.0f;
            shadowH = -2.0f;
        }
            
            break;
        default:
            break;
    }
    _rootContentView.layer.shadowOffset = CGSizeMake(shadowW, shadowH);
    _rootContentView.layer.shadowColor = [UIColor blackColor].CGColor;
    _rootContentView.layer.shadowOpacity = 0.2f;
}

- (void)changeTransformForView:(UIView *)view sca:(CGFloat)sca transX:(CGFloat)transX
{
    if (view)
    {
        CGAffineTransform ltransS = CGAffineTransformMakeScale(sca, sca);
        CGAffineTransform ltransT = CGAffineTransformMakeTranslation(transX, 0);
        CGAffineTransform lconT = CGAffineTransformConcat(ltransT, ltransS);
        view.transform = lconT;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
