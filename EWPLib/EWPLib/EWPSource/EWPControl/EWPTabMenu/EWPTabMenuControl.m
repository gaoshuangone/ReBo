//
//  EWPSegmentedControl.m
//  Community
//
//  Created by Andy on 14-6-23.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "EWPTabMenuControl.h"
#import "BaseViewController.h"

@interface TabMenuScrollView : UIScrollView
@end


@interface EWPTabMenuControl ()<UIScrollViewDelegate>


@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) NSMutableArray *tabViewControllerMArray;
@property (nonatomic,assign) BOOL isPaning;
@property (nonatomic,assign) NSInteger oldSelectedIndex;

@end

@implementation TabMenuScrollView

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!self.dragging) {
        [self.nextResponder touchesBegan:touches withEvent:event];
    } else {
        [super touchesBegan:touches withEvent:event];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    if (!self.dragging) {
        [self.nextResponder touchesMoved:touches withEvent:event];
    } else{
        [super touchesMoved:touches withEvent:event];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!self.dragging) {
        [self.nextResponder touchesEnded:touches withEvent:event];
    } else {
        [super touchesEnded:touches withEvent:event];
    }
}

@end

@implementation EWPTabMenuControl
@synthesize currentSelectedSegmentIndex = _currentSelectedSegmentIndex;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    self.backgroundColor = [UIColor clearColor];
    self.scrollView = [[TabMenuScrollView alloc]init];
    self.scrollView.backgroundColor = [UIColor clearColor];
    self.scrollView.delegate = self;
    self.scrollView.scrollsToTop = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.pagingEnabled = YES;
    [self.scrollView.panGestureRecognizer addTarget:self action:@selector(OnPanScrollView:)];
    [self addSubview:self.scrollView];
    
}

- (void)viewWillAppear
{
    [super viewWillAppear];
    if (self.tabViewControllerMArray && [self.tabViewControllerMArray count])
    {
        UIViewController *viewController = [self.tabViewControllerMArray objectAtIndex:self.currentSelectedSegmentIndex];
        [viewController viewWillAppear:YES];
    }
}

- (void)viewwillDisappear
{
    [super viewwillDisappear];
    if (self.tabViewControllerMArray && [self.tabViewControllerMArray count])
    {
        UIViewController *viewController = [self.tabViewControllerMArray objectAtIndex:self.currentSelectedSegmentIndex];
        [viewController viewWillDisappear:YES];
    }
}

- (void)setHideSegmentedControl:(BOOL)hideSegmentedControl
{
    _hideSegmentedControl = hideSegmentedControl;
    if (_ewpSegmentedControl)
    {
        _ewpSegmentedControl.hidden = hideSegmentedControl;
    }
}

- (void)reloadData
{
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(ewpSegmentedControl)])
    {
        EWPSegmentedControl *ewpSegmentedControl = [self.dataSource ewpSegmentedControl];
        if (ewpSegmentedControl == nil)
        {
            return;
        }
        [self.ewpSegmentedControl removeFromSuperview];
        self.ewpSegmentedControl = ewpSegmentedControl;
        
        [self addSubview:self.ewpSegmentedControl];
        [self.ewpSegmentedControl addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
        
         self.scrollView.frame = CGRectMake(0, self.ewpSegmentedControl.frame.size.height, self.frame.size.width, self.frame.size.height - self.ewpSegmentedControl.frame.size.height);
        
    }
    NSInteger tabCount = self.ewpSegmentedControl.sectionCount;
    if (tabCount < 0)
    {
        return;
    }
    
    if (_tabViewControllerMArray == nil)
    {
        _tabViewControllerMArray = [NSMutableArray array];
    }
    
    for (UIViewController *viewController in _tabViewControllerMArray)
    {
        [viewController.view removeFromSuperview];
    }
    [_tabViewControllerMArray removeAllObjects];
    
    
    for (int nIndex = 0; nIndex < tabCount; nIndex++)
    {
        if (self.dataSource && [self.dataSource respondsToSelector:@selector(ewpTabMenuControl:tabViewOfindex:)])
        {
            BaseViewController *viewController = (BaseViewController *)[self.dataSource ewpTabMenuControl:self tabViewOfindex:nIndex];
            if (viewController == nil)
            {
                viewController = [[BaseViewController alloc] init];
            }
            viewController.baseTabMenuControl = self;
            viewController.view.frame = CGRectMake(self.scrollView.frame.size.width * nIndex, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
            viewController.bFirstViewWillAppear = NO;
            [self.scrollView addSubview:viewController.view];
            viewController.bFirstViewWillAppear = YES;
            [self.tabViewControllerMArray addObject:viewController];
        }
    }
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * tabCount, 0);
    //必须放到最后，因为有的view还没创建完成。
    [self.ewpSegmentedControl setSelectedSegmentIndex:_currentSelectedSegmentIndex animated:YES];
  
}

- (void)updateTabMenuTitles:(NSArray *)tabMenuTitles
{
    if (self.ewpSegmentedControl)
    {
        self.ewpSegmentedControl.sectionTitles = tabMenuTitles;
        [self.ewpSegmentedControl setNeedsDisplay];
    }
}

-(void)setBadge:(NSInteger)badgeNum atIndex:(NSInteger)idx
{
    if (self.ewpSegmentedControl)
    {
        [self.ewpSegmentedControl setBadge:badgeNum atIndex:idx];
    }
}


- (void)tabMenuBadge:(NSInteger)badge atIndex:(NSInteger)idx
{
    if (self.ewpSegmentedControl)
    {
        [self.ewpSegmentedControl ewpSegmentBadge:badge atIndex:idx];
    }
}

- (NSInteger)currentSelectedSegmentIndex
{
    return self.ewpSegmentedControl.selectedSegmentIndex;
}

- (void)setCurrentSelectedSegmentIndex:(NSInteger)currentSelectedSegmentIndex
{
    _currentSelectedSegmentIndex = currentSelectedSegmentIndex;
    self.ewpSegmentedControl.selectedSegmentIndex = currentSelectedSegmentIndex;
}

- (void)valueChanged:(id)ewpSegmentedControl
{
    NSInteger oldPage = self.ewpSegmentedControl.oldSelectedSegmentIndex;
    NSInteger page = self.ewpSegmentedControl.selectedSegmentIndex;
    _currentSelectedSegmentIndex = page;
    if (oldPage == page)
    {
        UIViewController *viewController = [self.tabViewControllerMArray objectAtIndex:page];
        if (viewController && [viewController respondsToSelector:@selector(viewWillAppear:)])
        {
            [viewController viewWillAppear:YES];
        }
        self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width * page, 0);
    }
    else
    {
        UIViewController *oldViewController = [self.tabViewControllerMArray objectAtIndex:oldPage];
        if (oldViewController && [oldViewController respondsToSelector:@selector(viewWillDisappear:)])
        {
            [oldViewController viewWillDisappear:YES];
        }
        
        UIViewController *viewController = [self.tabViewControllerMArray objectAtIndex:page];
        if (viewController && [viewController respondsToSelector:@selector(viewWillAppear:)])
        {
            [viewController viewWillAppear:YES];
        }
        self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width * page, 0);
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = scrollView.frame.size.width;
    
    //判断滑动的幅度来决定page值大小,floor取小于括号内数的最大的整数
    
    NSInteger page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    [self.ewpSegmentedControl setSelectedSegmentIndex:page animated:YES];
    if (self.delegate && [self.delegate respondsToSelector:@selector(progressEdgePanGestureRecognizer:tabMenuOfIndex:)])
    {
        [self.delegate progressEdgePanGestureRecognizer:nil tabMenuOfIndex:page];
    }
    if (self.ewpSegmentedControl.oldSelectedSegmentIndex != self.ewpSegmentedControl.selectedSegmentIndex)
    {
    
        UIViewController *oldViewController = [self.tabViewControllerMArray objectAtIndex:self.ewpSegmentedControl.oldSelectedSegmentIndex];
        if (oldViewController)
        {
            [oldViewController viewWillDisappear:YES];
        }
        UIViewController *viewController = [self.tabViewControllerMArray objectAtIndex:page];
        if (viewController && [viewController respondsToSelector:@selector(viewWillAppear:)])
        {
            [viewController viewWillAppear:YES];
        }
    }

}


#pragma mark -OnPanScrollView
- (void)OnPanScrollView:(UIPanGestureRecognizer *)panGestureRecognizer
{

    [[NSNotificationCenter defaultCenter] postNotificationName:ShowBarAndChat object:nil];
    if (self.scrollView.contentOffset.x < 0)
    {
        self.isPaning = YES;
        self.scrollView.bounces = NO;
    }
    else if(self.scrollView.contentOffset.x > self.scrollView.contentSize.width - self.scrollView.frame.size.width)
    {
        self.isPaning = YES;
        self.scrollView.bounces = NO;
    }
    if (self.isPaning)
    {
        if (self.delegate && [self.delegate respondsToSelector:@selector(progressEdgePanGestureRecognizer:tabMenuOfIndex:)])
        {
            [self.delegate progressEdgePanGestureRecognizer:panGestureRecognizer tabMenuOfIndex:self.ewpSegmentedControl.selectedSegmentIndex];
        }
    }
}

- (void)ennableEwpTabMenu:(BOOL)enable
{
    if (enable)
    {
        self.superview.userInteractionEnabled = YES;
        self.scrollView.scrollEnabled = YES;
        self.isPaning = NO;
        self.scrollView.bounces = YES;
        
    }
    else
    {
        self.superview.userInteractionEnabled = NO;
        self.scrollView.scrollEnabled = NO;
        self.isPaning = YES;
        self.scrollView.bounces = NO;
        
    }

}

#pragma mark - Observer
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"selectedSegmentIndex"])
    {
        
    }
}

#pragma mark - layoutSubView
- (void)layoutSubviews
{
    CGRect frame = self.ewpSegmentedControl.frame;
    self.ewpSegmentedControl.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);
    
    frame = self.scrollView.frame;
    self.scrollView.frame = CGRectMake(0, self.ewpSegmentedControl.frame.size.height, frame.size.width, frame.size.height);
    
    for (int nIndex = 0; nIndex < [_tabViewControllerMArray count]; nIndex++)
    {
        UIViewController *viewController = [_tabViewControllerMArray objectAtIndex:nIndex];
        viewController.view.frame = CGRectMake(self.scrollView.frame.size.width * nIndex, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
