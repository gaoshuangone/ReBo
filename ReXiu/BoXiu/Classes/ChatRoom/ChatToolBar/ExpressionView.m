//
//  ExpressionView.m
//  BoXiu
//
//  Created by andy on 14-4-21.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "ExpressionView.h"
#import "ExpressionManager.h"

#define Line_Count (4)
#define Colum_Count (6)

@interface ExpressionView ()<UIScrollViewDelegate>

@property(nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIPageControl *pageControl;

@property (nonatomic,strong) NSArray *imageNames;

@end

@implementation ExpressionView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)initView:(CGRect)frame
{
    self.backgroundColor = [CommonFuction colorFromHexRGB:@"EAE3D8"];
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.bounces = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    [self addSubview:_scrollView];
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake((self.frame.size.width - 50) / 2, self.frame.size.height - 20, 50, 10)];
    _pageControl.pageIndicatorTintColor = [CommonFuction colorFromHexRGB:@"DED4CC"];
    _pageControl.currentPageIndicatorTintColor = [CommonFuction colorFromHexRGB:@"9B8977"];
    [self addSubview:_pageControl];

    self.imageNames = [[ExpressionManager shareInstance] expressionImageArray];
    
    NSInteger nExpressionCount = [self.imageNames count];
    NSInteger countPerPage = Line_Count * Colum_Count;
    NSInteger pageCount = nExpressionCount / countPerPage + ((nExpressionCount % countPerPage) ? 1 : 0);
    for (NSInteger nPageIndex = 0; nPageIndex < pageCount; nPageIndex++)
    {
        NSInteger countInCurrentPage = (nExpressionCount - nPageIndex * countPerPage) > countPerPage? countPerPage : nExpressionCount % countPerPage;
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(nPageIndex * frame.size.width,0, frame.size.width, frame.size.height)];
        for (NSInteger nIndex = 0; nIndex < countInCurrentPage; nIndex++)
        {
            NSString *imageName = [self.imageNames objectAtIndex:(nPageIndex *countPerPage + nIndex)];
            UIButton *faceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [faceBtn setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
            [faceBtn addTarget:self action:@selector(OnClick:) forControlEvents:UIControlEventTouchUpInside];
            faceBtn.tag = nIndex + nPageIndex * countPerPage;
            NSInteger x = ((nIndex % Colum_Count) * 28) + ((nIndex % Colum_Count) + 1) * 20;
            NSInteger y = 28 * (nIndex / Colum_Count) + 20 * ((nIndex / Colum_Count) + 1);
            faceBtn.frame = CGRectMake(x, y, 28, 28);
            [view addSubview:faceBtn];
        }
        [self.scrollView addSubview:view];
    }
    _scrollView.contentSize = CGSizeMake(pageCount * self.frame.size.width, self.frame.size.height);
    self.pageControl.numberOfPages = pageCount;
    self.pageControl.currentPage = 0;
}

- (void)OnClick:(id)sender
{
    UIButton *faceBtn = (id)sender;

    if (self.delegate && [self.delegate respondsToSelector:@selector(expressionView:didSelectExpressionName:)])
    {
        NSString *imageName = [NSString stringWithFormat:@"%@",[self.imageNames objectAtIndex:faceBtn.tag]];
        
        [self.delegate expressionView:self didSelectExpressionName:imageName];
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int page = scrollView.contentOffset.x / self.frame.size.width;
    
    self.pageControl.currentPage = page;
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
