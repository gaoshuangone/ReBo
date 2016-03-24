
//
//  EWPADView.m
//  MemberMarket
//
//  Created by andy on 13-11-20.
//  Copyright (c) 2013年 yiwopai. All rights reserved.
//

#import "EWPADView.h"
#import "UIButton+WebCache.h"
#import "MacroMethod.h"

#define PageHeight (38)

@interface EWPADView ()

@property(nonatomic,strong) UIScrollView *scrollView;
@property(nonatomic,strong) UIPageControl *pageControl;
@property(nonatomic,strong) NSTimer *timer;
@end
@implementation EWPADView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code

        
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame placeHolderImg:(UIImage *)placeHolderImg adImgUrlArray:(NSArray *)adImgUrlArray adBlock:(AdBlock)adBlock
{
    self = [super initWithFrame:frame];
    if (self)
    {
       /*默认循环，间隔5s*/
        _timeInterval = 5;
        self.cycle = YES;
        self.hidePageControl = NO;
        
        self.placeHolderImg = placeHolderImg;
        if (adBlock)
        {
            self.adBlock = adBlock;
        }
        
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _scrollView.delegate = self;
        _scrollView.directionalLockEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.userInteractionEnabled = YES;
        _scrollView.alwaysBounceVertical = NO;
        [self addSubview:_scrollView];
        
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectZero];
        [_pageControl addTarget:self action:@selector(turnPage) forControlEvents:UIControlEventValueChanged]; // 触摸mypagecontrol触发change这个方法事件
        
        [_pageControl setCurrentPageIndicatorTintColor:[UIColor whiteColor]];
        [_pageControl setPageIndicatorTintColor:[UIColor colorWithWhite:1 alpha:0.3]];
        
        self.adImgUrlArray = adImgUrlArray;
        
        [self addSubview:_pageControl];
        
    }
    return self;
}

- (void)setHidePageControl:(BOOL)hidePageControl
{
    _hidePageControl = hidePageControl;
    _pageControl.hidden = hidePageControl;
}

- (void)setAdImgUrlArray:(NSArray *)adImgUrlArray
{
    _adImgUrlArray = adImgUrlArray;
    if (adImgUrlArray.count > 1)
    {
        if (!_hidePageControl)
        {
            _pageControl.hidden = NO;
        }
        
        [_pageControl setNumberOfPages:self.adImgUrlArray.count];
        [_pageControl setCurrentPage:_nCurrentPage];
    }
    else
    {
        _pageControl.hidden = YES;
    }
    
    //从scrollView上移除所有的subview
    NSArray *subViews = [_scrollView subviews];
    if([subViews count] != 0)
    {
        [subViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    
    if (adImgUrlArray.count == 0)
    {
        // 如果个数为0，则加载一张默认图片
        UIButton *imgBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [imgBtn addTarget:self action:@selector(OnClickImg:) forControlEvents:UIControlEventTouchUpInside];
        imgBtn.tag = 0;
        [imgBtn setImage:self.placeHolderImg forState:UIControlStateNormal];
        [imgBtn setImage:self.placeHolderImg forState:UIControlStateHighlighted];
          [imgBtn.imageView setContentMode:UIViewContentModeScaleAspectFit];
        
        [_scrollView addSubview:imgBtn];
    }
    
    /*第0页放最后一页的内容*/
    if (adImgUrlArray.count > 1)
    {
        // 取数组最后一张图片 放在第0页
        UIButton *imgBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [imgBtn addTarget:self action:@selector(OnClickImg:) forControlEvents:UIControlEventTouchUpInside];
        imgBtn.tag = self.adImgUrlArray.count - 1;
        NSURL *url = [NSURL URLWithString:[self.adImgUrlArray objectAtIndex:(adImgUrlArray.count - 1)]];
        [imgBtn sd_setImageWithURL:url forState:UIControlStateNormal placeholderImage:self.placeHolderImg];
             [imgBtn.imageView setContentMode:UIViewContentModeScaleAspectFill];
        [_scrollView addSubview:imgBtn];
    }
    

    
    for (int nIndex = 0; nIndex < self.adImgUrlArray.count; nIndex++)
    {
        UIButton *imgBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [imgBtn addTarget:self action:@selector(OnClickImg:) forControlEvents:UIControlEventTouchUpInside];
        imgBtn.tag = nIndex;
        NSURL *url = [NSURL URLWithString:[self.adImgUrlArray objectAtIndex:nIndex]];
        [imgBtn sd_setImageWithURL:url forState:UIControlStateNormal placeholderImage:self.placeHolderImg];
           [imgBtn.imageView setContentMode:UIViewContentModeScaleAspectFill];
        [_scrollView addSubview:imgBtn];
    }
   /*最后一页放第一页的内容*/
    if (adImgUrlArray.count > 1)
    {
        // 取数组最后一张图片 放在第0页
        UIButton *imgBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [imgBtn addTarget:self action:@selector(OnClickImg:) forControlEvents:UIControlEventTouchUpInside];
        imgBtn.tag = 0;
        NSURL *url = [NSURL URLWithString:[self.adImgUrlArray objectAtIndex:0]];
        [imgBtn sd_setImageWithURL:url forState:UIControlStateNormal placeholderImage:self.placeHolderImg];
           [imgBtn.imageView setContentMode:UIViewContentModeScaleAspectFill];
        [_scrollView addSubview:imgBtn];
    }
    [self setNeedsLayout];
}

- (void)setCycle:(BOOL)cycle
{
    if (cycle == YES)
    {
        if (_timer)
        {
            [_timer invalidate];
            _timer = nil;
        }
        self.timer = [NSTimer scheduledTimerWithTimeInterval:self.timeInterval target: self selector: @selector(handleTimer:)  userInfo:nil  repeats: YES];;
    }
    else
    {
        if (_timer)
        {
            [_timer invalidate];
            _timer = nil;
        }
    }
}

- (void)setTimeInterval:(int)timeInterval
{
    _timeInterval = timeInterval;
    if (self.cycle == YES)
    {
        if (_timer)
        {
            [_timer invalidate];
            _timer = nil;
        }
        self.timer = [NSTimer scheduledTimerWithTimeInterval:_timeInterval target: self selector: @selector(handleTimer:)  userInfo:nil  repeats: YES];;
    }
}

- (void)handleTimer:(id)timer
{
    int nPage = _pageControl.currentPage; // 获取当前的page
    nPage++;
    nPage = (nPage > self.adImgUrlArray.count - 1) ? 0 : nPage ;
    [_pageControl setCurrentPage:nPage];
    [self turnPage];

}


- (void)OnClickImg:(id)sender
{
    if (self.adBlock)
    {
        UIButton *button = (UIButton *)sender;
        self.adBlock(button.tag);
    }
}

- (void)layoutSubviews
{
    _scrollView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    

    
    int nXPos = 0;
    for (int nIndex = 0; nIndex < _scrollView.subviews.count; nIndex++)
    {
        UIView *view = [_scrollView.subviews objectAtIndex:nIndex];
        if ([view isKindOfClass:[UIButton class]])
        {
            CGRect imgframe = CGRectMake(nXPos, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
            view.frame = imgframe;
            nXPos += CGRectGetWidth(self.frame);
        }
    }
    if (self.adImgUrlArray.count <= 1 )
    {
        [_scrollView setContentSize:CGSizeMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))]; //  +上第1页和第4页  原理：4-[1-2-3-4]-1
        [_scrollView setContentOffset:CGPointMake(0, 0)];
        [self.scrollView scrollRectToVisible:CGRectMake(0,0,CGRectGetWidth(self.frame),CGRectGetHeight(self.frame)) animated:NO]; // 默认从序号1位置放第1页 ，序号0位置位置放第4页
    }
    else
    {
        [_scrollView setContentSize:CGSizeMake(CGRectGetWidth(self.frame) * (self.adImgUrlArray.count + 2), CGRectGetHeight(self.frame))]; //  +上第1页和第4页  原理：4-[1-2-3-4]-1
        [_scrollView setContentOffset:CGPointMake(CGRectGetWidth(self.frame), 0)];
        [self.scrollView scrollRectToVisible:CGRectMake(CGRectGetWidth(self.frame),0,CGRectGetWidth(self.frame),CGRectGetHeight(self.frame)) animated:NO]; // 默认从序号1位置放第1页 ，序号0位置位置放第4页
    }


    _pageControl.frame = CGRectMake(0, CGRectGetHeight(self.frame) - PageHeight - 5, CGRectGetWidth(self.frame), PageHeight);

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma mark - SCrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pagewidth = self.scrollView.frame.size.width;
    int nPage = floor((self.scrollView.contentOffset.x - pagewidth/(self.adImgUrlArray.count + 2))/pagewidth)+1;
    nPage --;  // 默认从第二页开始
    _pageControl.currentPage = nPage;
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pagewidth = self.scrollView.frame.size.width;
    int currentPage = floor((self.scrollView.contentOffset.x - pagewidth/ (self.adImgUrlArray.count + 2)) / pagewidth) + 1;
    if (currentPage==0)
    {
        [self.scrollView scrollRectToVisible:CGRectMake(CGRectGetWidth(self.frame) * self.adImgUrlArray.count,0,CGRectGetWidth(self.frame),CGRectGetHeight(self.frame)) animated:NO]; // 序号0 最后1页
    }
    else if (currentPage==(self.adImgUrlArray.count+1))
    {
        [self.scrollView scrollRectToVisible:CGRectMake(CGRectGetWidth(self.frame),0,CGRectGetWidth(self.frame),CGRectGetHeight(self.frame)) animated:NO]; // 最后+1,循环第1页
    }

}

#pragma mark - pagecontrol 选择器的方法
- (void)turnPage
{
    int nPage = _pageControl.currentPage; // 获取当前的page
    [self.scrollView scrollRectToVisible:CGRectMake(CGRectGetWidth(self.frame) * (nPage + 1),0,CGRectGetWidth(self.frame),CGRectGetHeight(self.frame)) animated:NO]; // 触摸pagecontroller那个点点 往后翻一页 +1
}
@end

