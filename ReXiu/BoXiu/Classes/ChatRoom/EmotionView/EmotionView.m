//
//  EmotionView.m
//  BoXiu
//
//  Created by andy on 14-12-3.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "EmotionView.h"

#import "UserInfoManager.h"
#import "UIButton+WebCache.h"


//#define EmotionTypeMenuHeight (50)
@interface EmotionView ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIView *emotionTypeMenu;//界面
@property (nonatomic,strong) NSMutableArray *emotionGroups;//数据源
@property (nonatomic,strong) NSMutableArray *emotionTypeBtns;//界面元素
@property (nonatomic,assign) NSInteger currentEmotionGroupIndex;

@property(nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic,assign) CGFloat EmotionTypeMenuHeight;

@end
@implementation EmotionView

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"currentEmotionGroupIndex" context:nil];
}

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
    if (iPhone4 || IPHONE_5) {
        self.EmotionTypeMenuHeight = 50;
    }else{
        self.EmotionTypeMenuHeight = 60;
    }
    [self addObserver:self forKeyPath:@"currentEmotionGroupIndex" options:NSKeyValueObservingOptionNew context:nil];
    
    self.backgroundColor = [CommonFuction colorFromHexRGB:@"ffffff"];

    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectZero];
    _pageControl.pageIndicatorTintColor = [CommonFuction colorFromHexRGB:@"DED4CC"];
    _pageControl.currentPageIndicatorTintColor = [CommonFuction colorFromHexRGB:@"9B8977"];
    [self addSubview:_pageControl];
    
    _emotionTypeMenu = [[UIView alloc] initWithFrame:CGRectZero];
    [self addSubview:_emotionTypeMenu];
    
    [self reloadData];
}

- (void)reloadData
{
    [self setUpEmotionTypeMenu];

}

- (void)setUpEmotionTypeMenu
{

    //类型重新获取
    if (_emotionGroups == nil)
    {
        _emotionGroups = [NSMutableArray array];
    }
    [_emotionGroups removeAllObjects];
    
    if ([[EmotionManager shareInstance] allGroupEmotion] == nil)
    {
        return;
    }
    
    UserInfo *currentUserInfo = [UserInfoManager shareUserInfoManager].currentUserInfo;
    NSInteger hideSwitch =  [[[AppInfo shareInstance].hideSwitch substringFromIndex:1] integerValue];
    if (hideSwitch == 1)
    {
        [_emotionGroups addObject:[[[EmotionManager shareInstance] allGroupEmotion] objectAtIndex:0]];
    }
    else
    {
        [_emotionGroups addObjectsFromArray:[NSMutableArray arrayWithArray:[[EmotionManager shareInstance] allGroupEmotion]]];
    }
    if (currentUserInfo)
    {
        if (!currentUserInfo.issupermanager)
        {
            for (EmotionGroupData *emotionGroupData in _emotionGroups)
            {
                if (emotionGroupData.emotionType == eSuperManagerType)
                {
                    [_emotionGroups removeObject:emotionGroupData];
                }
            }
        }
    }
    else
    {
        for (EmotionGroupData *emotionGroupData in _emotionGroups)
        {
            if (emotionGroupData.emotionType == eSuperManagerType)
            {
                [_emotionGroups removeObject:emotionGroupData];
            }
        }
    }
    
    //创建表情类型按钮
    if(_emotionTypeBtns == nil)
    {
        _emotionTypeBtns = [NSMutableArray array];
    }
    [_emotionTypeBtns removeAllObjects];
    for (int nIndex = 0; nIndex < _emotionGroups.count;nIndex++)
    {
        EmotionGroupData *emotionGroupData = [_emotionGroups objectAtIndex:nIndex];
        UIButton *emotionTypeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        emotionTypeBtn.tag = nIndex;
        emotionTypeBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        emotionTypeBtn.layer.borderWidth = 0.5f;
        NSURL *emotionTypeUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[AppInfo shareInstance].res_server,emotionGroupData.mlink]];
        [emotionTypeBtn sd_setImageWithURL:emotionTypeUrl forState:UIControlStateNormal placeholderImage:nil];
        CGFloat btnwidth = self.frame.size.width / _emotionGroups.count;
        [emotionTypeBtn setBackgroundImage:[CommonFuction imageWithColor:[UIColor lightGrayColor] size:CGSizeMake(btnwidth, self.EmotionTypeMenuHeight)] forState:UIControlStateSelected];
        [emotionTypeBtn addTarget:self action:@selector(OnEmotionType:) forControlEvents:UIControlEventTouchUpInside];
        [_emotionTypeMenu addSubview:emotionTypeBtn];
        [_emotionTypeBtns addObject:emotionTypeBtn];
    }
    self.currentEmotionGroupIndex = 0;
}

- (void)OnEmotionType:(id)sender
{
    UIButton *emotionTypeBtn = (UIButton *)sender;
    emotionTypeBtn.selected = YES;
    
    for (UIButton *button in _emotionTypeBtns)
    {
        if (button != emotionTypeBtn)
        {
            button.selected = NO;
        }
    }
    self.currentEmotionGroupIndex = emotionTypeBtn.tag;
}

- (void)loadDataOfEmotionType:(NSInteger)currentEmotionGroupIndex
{
    if (_scrollView)
    {
        [_scrollView removeFromSuperview];
        _scrollView = nil;
    }
    
    if (_scrollView == nil)
    {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.bounces = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        [self addSubview:_scrollView];
    }

    EmotionGroupData *emotionGroupData = [self.emotionGroups objectAtIndex:currentEmotionGroupIndex];
    if (emotionGroupData)
    {
        NSInteger emotionTotalCount = [emotionGroupData.emotionDataMArray count];
        NSInteger nLineCount = 2;
        NSInteger nColumCount = 4;
        //暂时这样识别普通表情
        if (currentEmotionGroupIndex == 0)
        {
            nLineCount = 4;
            nColumCount = 7;
        }
        NSInteger countPerPage = nLineCount * nColumCount;
        NSInteger pageCount = emotionTotalCount / countPerPage + ((emotionTotalCount % countPerPage) ? 1 : 0);
        NSInteger emotionWidth = emotionGroupData.width;
        NSInteger emotionHeight = emotionGroupData.height;
        for (int nPageIndex = 0; nPageIndex < pageCount; nPageIndex++)
        {
            int countInCurrentPage = (emotionTotalCount - nPageIndex * countPerPage) >= countPerPage? countPerPage : emotionTotalCount % countPerPage;
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(nPageIndex * self.frame.size.width,0, self.frame.size.width, self.frame.size.height)];
            for (int nIndex = 0; nIndex < countInCurrentPage; nIndex++)
            {
                EmotionData *emotionData = [emotionGroupData.emotionDataMArray objectAtIndex:(nPageIndex * countPerPage + nIndex)];
                UIButton *emotionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[AppInfo shareInstance].res_server,emotionData.mlink]];
                [emotionBtn sd_setImageWithURL:url forState:UIControlStateNormal];
                [emotionBtn addTarget:self action:@selector(OnEmotion:) forControlEvents:UIControlEventTouchUpInside];
                emotionBtn.tag = nIndex + nPageIndex * countPerPage;
                int x = ((nIndex % nColumCount) * emotionWidth) + ((nIndex % nColumCount) + 1) * 19;
                int y = emotionHeight * (nIndex / nColumCount) + 20 * ((nIndex / nColumCount) + 1);
                emotionBtn.frame = CGRectMake(x, y, emotionWidth, emotionHeight);
                [view addSubview:emotionBtn];
            }
            [self.scrollView addSubview:view];
        }
        _scrollView.contentSize = CGSizeMake(pageCount * self.frame.size.width, self.frame.size.height - self.EmotionTypeMenuHeight);
        self.pageControl.numberOfPages = pageCount;
        self.pageControl.currentPage = 0;
    }
}

- (void)OnEmotion:(id)sender
{
    UIButton *emotionBtn = sender;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(emotionView:didSelectEmotionData:)])
    {
        EmotionGroupData *emotionGroupData = [self.emotionGroups objectAtIndex:self.currentEmotionGroupIndex];
        if (emotionGroupData)
        {
            EmotionData *emotionData = [emotionGroupData.emotionDataMArray objectAtIndex:emotionBtn.tag];
            if (emotionData)
            {
                [self.delegate emotionView:self didSelectEmotionData:emotionData];
            }
        }
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int page = scrollView.contentOffset.x / self.frame.size.width;
    
    self.pageControl.currentPage = page;
}


- (void)layoutSubviews
{
    if (_emotionTypeBtns.count > 1)
    {
        _emotionTypeMenu.frame = CGRectMake(0, self.frame.size.height - self.EmotionTypeMenuHeight, self.frame.size.width, self.EmotionTypeMenuHeight);
        CGFloat btnWidth = self.frame.size.width / _emotionTypeBtns.count;
        for (int nIndex = 0; nIndex < _emotionTypeBtns.count; nIndex++)
        {
            UIButton *emotionTypeBtn = [_emotionTypeBtns objectAtIndex:nIndex];
            emotionTypeBtn.frame = CGRectMake(nIndex * btnWidth, 0, btnWidth, _emotionTypeMenu.frame.size.height);
        }
        
        _scrollView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - self.EmotionTypeMenuHeight);
        _pageControl.frame = CGRectMake((self.frame.size.width - 50) / 2, self.frame.size.height - self.EmotionTypeMenuHeight - 20, 50, 10);
    }
    else
    {
        _emotionTypeMenu.frame = CGRectZero;
        _scrollView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        _pageControl.frame = CGRectMake((self.frame.size.width - 50) / 2, self.frame.size.height - 20, 50, 10);
    }
}

#pragma mark -observer
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"currentEmotionGroupIndex"])
    {
        NSInteger currentEmotionGroupIndex = [[change objectForKey:NSKeyValueChangeNewKey] integerValue];
        [self loadDataOfEmotionType:currentEmotionGroupIndex];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
