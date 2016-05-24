//
//  EWPGuideViewController.m
//  BoXiu
//
//  Created by andy on 14-11-19.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "EWPGuideViewController.h"
#import "UIImageView+WebCache.h"

@interface EWPGuideViewController ()<UIScrollViewDelegate>
@property (nonatomic,strong) NSArray *imgNameArray;
@property (nonatomic,strong) NSArray *imgUrlArray;
@property (nonatomic,strong) NSArray *imgDataArray;
@property (nonatomic,assign) InitType initType;
@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic,assign) BOOL statusBarHidden;//显示引导界面之前statusBar的状态，消失时恢复。
@property (nonatomic,strong) NSTimer *timer;//自动滚动
@end

@implementation EWPGuideViewController

- (void)dealloc
{
    
}
- (id)initWithImgNameArray:(NSArray *)imgNameArray
{
    self = [super init];
    if (self)
    {
        _initType = eLocalImgName;
        _imgNameArray = [NSArray arrayWithArray:imgNameArray];
    }
    return self;
}

- (id)initWithImgUrlArray:(NSArray *)imgUrlArray
{
    self = [super init];
    if (self)
    {
        _initType = eImgUrl;
        _imgUrlArray = [NSArray arrayWithArray:imgUrlArray];
    }
    return self;
}

- (id)initWithImgDataArray:(NSArray *)imgDataArray
{
    self = [super init];
    if (self)
    {
        _initType = eLocalImgData;
        _imgDataArray = [NSArray arrayWithArray:imgDataArray];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor clearColor];
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.delegate = self;
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.bounces = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    [self.view addSubview:scrollView];
    
    NSArray *imgArray = nil;
    if (self.initType == 0)
    {
        imgArray = [NSArray arrayWithArray:_imgNameArray];
    }
    else if(self.initType == 1)
    {
        imgArray = [NSArray arrayWithArray:_imgUrlArray];
    }
    else
    {
        imgArray = [NSArray arrayWithArray:_imgDataArray];
    }
    
    for (int nIndex = 0; nIndex < [imgArray count]; nIndex++)
    {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(nIndex * scrollView.frame.size.width, 0, scrollView.frame.size.width, scrollView.frame.size.height)];
        view.tag = nIndex;
        view.backgroundColor = [UIColor clearColor];
        UIImageView *backView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
        backView.contentMode = UIViewContentModeScaleAspectFill;
        if (self.initType == 0)
        {
            NSString *imageName = [imgArray objectAtIndex:nIndex];
            backView.image = [UIImage imageNamed:imageName];
        }
        else if(self.initType == 1)
        {
            NSString *imageUrl = [imgArray objectAtIndex:nIndex];
            [backView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:nil];
        }
        else
        {
            NSData *imgData = [imgArray objectAtIndex:nIndex];
            backView.image = [UIImage imageWithData:imgData];
        }

        [view addSubview:backView];
        [scrollView addSubview:view];
        if (nIndex == [imgArray count] - 1)
        {
            [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnClickView:)]];
        }
    }
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * [imgArray count], scrollView.frame.size.height);
    
    if ([imgArray count] > 1)
    {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 100)/2, SCREEN_HEIGHT - 60, 100, 20)];
        _pageControl.numberOfPages = [imgArray count];
        _pageControl.backgroundColor = [UIColor clearColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        [self.view addSubview:_pageControl];
    }
    
    if (self.autoScroll)
    {
        if (_timer == nil)
        {
            _timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(handleTimer:) userInfo:nil repeats:YES];
        }
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.statusBarHidden = [UIApplication sharedApplication].statusBarHidden;
    [UIApplication sharedApplication].statusBarHidden = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarHidden = self.statusBarHidden;
}

- (void)OnClickView:(UITapGestureRecognizer *)tapGestureRecoginzer
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(guideViewController:clickAtIndex:)])
    {
        if (_timer)
        {
            [_timer invalidate];
            _timer = nil;
        }
        UIView *view = tapGestureRecoginzer.view;
        [self.delegate guideViewController:self clickAtIndex:view.tag];
    }

    [self hideGuideView];
}

- (void)showGuideView
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self.view];
}

- (void)hideGuideView
{
    [self.view removeFromSuperview];
}


- (void)handleTimer:(id)timer
{
    NSArray *imgArray = nil;
    if (self.initType == 0)
    {
        imgArray = [NSArray arrayWithArray:_imgNameArray];
    }
    else if(self.initType == 1)
    {
        imgArray = [NSArray arrayWithArray:_imgUrlArray];
    }
    else
    {
        imgArray = [NSArray arrayWithArray:_imgDataArray];
    }

    
    int nPage = _pageControl.currentPage; // 获取当前的page
    nPage++;
    if (nPage >= imgArray.count)
    {
        [_timer invalidate];
        _timer = nil;
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(guideViewScrollFinsh)])
        {
            
            [self.delegate guideViewScrollFinsh];
            [self hideGuideView];
        }
    }
    else
    {
        if (_pageControl)
        {
            [_pageControl setCurrentPage:nPage];
        }
        
        [self turnPage];
    }
}

- (void)turnPage
{
    int nPage = _pageControl.currentPage; // 获取当前的page
    [self.scrollView scrollRectToVisible:CGRectMake(CGRectGetWidth(self.view.frame) * (nPage + 1),0,CGRectGetWidth(self.view.frame),CGRectGetHeight(self.view.frame)) animated:NO]; // 触摸pagecontroller那个点点 往后翻一页 +1
}

#pragma mark - UIScroolViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSArray *imgArray = nil;
    if (self.initType == 0)
    {
        imgArray = [NSArray arrayWithArray:_imgNameArray];
    }
    else if(self.initType == 1)
    {
        imgArray = [NSArray arrayWithArray:_imgUrlArray];
    }
    else
    {
        imgArray = [NSArray arrayWithArray:_imgDataArray];
    }
    CGFloat pagewidth = scrollView.frame.size.width;
    int nPage = floor((scrollView.contentOffset.x - pagewidth/(imgArray.count + 2))/pagewidth)+1;
    _pageControl.currentPage = nPage;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
