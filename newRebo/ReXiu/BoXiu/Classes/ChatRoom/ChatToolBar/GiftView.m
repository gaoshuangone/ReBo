//
//  NewGiftView.m
//  BoXiu
//
//  Created by andy on 14-11-17.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "GiftView.h"
#import "DropList.h"
#import "UserInfoManager.h"
#import "GiftCell.h"
#import "QueryAllEmotionModel.h"
#import "GiftDataManager.h"

#define GiftCount_Per_Page (5)


@interface GiftView ()<UIScrollViewDelegate,DropListDelegate,DropListDataSource,GiftCellDelegate>
@property (nonatomic,strong) DropList *givedUserBtn;
@property (nonatomic,assign) UserInfo *selectedUserInfo;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic,strong) UILabel *coinCount;
@property (nonatomic,assign) NSInteger currentTabMenuIndex;
@property (nonatomic,strong) NSMutableArray *typeBtnMArray;
@property (nonatomic,strong) NSMutableDictionary *giftMDic;
@property (nonatomic,strong) GiftCell *selectedGiftCell;
@property (nonatomic,strong) UIView *giftCountView;
@property (nonatomic,strong) NSArray *giftCountArray;
@property (nonatomic,strong) NSMutableArray *userList;
@property (nonatomic,strong) UIButton *selectedButton;

@property (nonatomic,strong) UILabel *line;
@end

@implementation GiftView

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
    _giftCountArray = @[@"1",@"50",@"99",@"520",@"1314",@"3344"];
    self.clipsToBounds = YES;
    self.backgroundColor = [CommonFuction colorFromHexRGB:@"000000" alpha:0.4];
    self.currentTabMenuIndex = -1;
    UIView* view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 38)];
    view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
    [self addSubview:view];
    UILabel *giveToLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 11, 30, 15)];
    giveToLable.text = @"送给";
    giveToLable.font = [UIFont boldSystemFontOfSize:13.0f];
    giveToLable.textColor = [CommonFuction colorFromHexRGB:@"d14c49"];
    [self addSubview:giveToLable];    

    _givedUserBtn = [[DropList alloc] initWithFrame:CGRectMake(45, 6, 100, 25) showInView:self.containerView];
    _givedUserBtn.delegate = self;
    _givedUserBtn.dataSource = self;
    _givedUserBtn.selectTextColor = [CommonFuction colorFromHexRGB:@"a4a4a4"];
    _givedUserBtn.selectBackColor = [CommonFuction colorFromHexRGB:@"ffffff"];
    _givedUserBtn.listBackColor = [UIColor whiteColor];
    _givedUserBtn.listTextColor = [CommonFuction colorFromHexRGB:@"a4a4a4"];
    _givedUserBtn.backView.layer.borderColor = [UIColor clearColor].CGColor;
    [self addSubview:_givedUserBtn];

    _line = [[UILabel alloc] init];
    _line.backgroundColor = [CommonFuction colorFromHexRGB:@"f7c250"];
    [self addSubview:_line];
   
    
    
    _typeBtnMArray = [NSMutableArray array];
    NSArray *tabTitles = [[NSArray alloc] initWithObjects:@"普通",@"时尚",@"奢华",nil];
      for(int nIndex = 0; nIndex < tabTitles.count; nIndex++)
    {
        UIButton *giftTypeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        giftTypeBtn.tag = nIndex;
        giftTypeBtn.frame = CGRectMake(40 + (75 + 5) * nIndex, 40, 75, 25);
        giftTypeBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [giftTypeBtn setTitle:[tabTitles objectAtIndex:nIndex] forState:UIControlStateNormal];
        [giftTypeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [giftTypeBtn setTitleColor:[CommonFuction colorFromHexRGB:@"f7c250"] forState:UIControlStateSelected];
        [giftTypeBtn addTarget:self action:@selector(OnTabMenu:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:giftTypeBtn];
        [_typeBtnMArray addObject:giftTypeBtn];
    }
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 72, self.frame.size.width, 80)];
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.bounces = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    [self addSubview:_scrollView];
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake((self.frame.size.width - 50) / 2,_scrollView.frame.origin.y + _scrollView.frame.size.height + 2, 50, 10)];
    _pageControl.pageIndicatorTintColor = [UIColor colorWithWhite:1 alpha:0.3];//[CommonFuction colorFromHexRGB:@"f0f0f0"];
    _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];//[CommonFuction colorFromHexRGB:@"e4c155"];
    [self addSubview:_pageControl];
    
    UIImageView *coinImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 162, 15, 15)];
    coinImg.image = [UIImage imageNamed:@"rebi"];
    [self addSubview:coinImg];
    
    _coinCount = [[UILabel alloc] initWithFrame:CGRectMake(30, 162, 150, 15)];
    _coinCount.text = [NSString stringWithFormat:@"%lld",[UserInfoManager shareUserInfoManager].currentUserInfo.coin];
    _coinCount.textColor = [CommonFuction colorFromHexRGB:@"f7c250"];
    _coinCount.font = [UIFont systemFontOfSize:14];
    _coinCount.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_coinCount];
    
    UIImage *normalImg = [CommonFuction imageWithColor:[UIColor clearColor] size:CGSizeMake(97, 43)];
    UIImage *selectImg = [CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"f7c250"] size:CGSizeMake(97, 43)];

    UIButton *rechargeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rechargeBtn.layer.cornerRadius = 12.5;
    rechargeBtn.layer.masksToBounds = YES;
    rechargeBtn.layer.borderColor = [CommonFuction colorFromHexRGB:@"f7c250"].CGColor;
    rechargeBtn.layer.borderWidth = 1;
    rechargeBtn.frame = CGRectMake(SCREEN_WIDTH-69-12, 153, 69, 25);
    [rechargeBtn setTitleColor:[CommonFuction colorFromHexRGB:@"f7c250"] forState:UIControlStateNormal];
    [rechargeBtn setTitleColor:[CommonFuction colorFromHexRGB:@"ffffff"] forState:UIControlStateHighlighted];
    [rechargeBtn setTitle:@"充值" forState:UIControlStateNormal];
    rechargeBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    [rechargeBtn setBackgroundImage:normalImg forState:UIControlStateNormal];
    [rechargeBtn setBackgroundImage:selectImg forState:UIControlStateHighlighted];
    [rechargeBtn addTarget:self action:@selector(OnRecharge:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:rechargeBtn];

    
    [self initUserList];
    
    [self OnTabMenu:[_typeBtnMArray objectAtIndex:0]];
    
}

- (void)viewWillAppear
{
    if ([AppInfo shareInstance].bLoginSuccess)
    {
        _coinCount.text = [NSString stringWithFormat:@"%lld",[UserInfoManager shareUserInfoManager].currentUserInfo.coin];
    }
    else
    {
        _coinCount.text = @"0";
    }
}

- (void)initUserList
{
    if (_userList == nil)
//
    {
        _userList = [NSMutableArray array];
    }

    [_userList addObjectsFromArray:[UserInfoManager shareUserInfoManager].giftMember];
    
    UserInfo *userinfo = nil;
    if(self.userList.count > 0)
    {
        userinfo = [self.userList objectAtIndex:([self.userList count] - 1)];
    }
    
    if(userinfo!=nil)
    {
        self.selectedUserInfo = userinfo;
        _givedUserBtn.selectedText = userinfo.nick;
        
        NSLog(@"%@",userinfo.nick);
    }
//6-5 ＝1
//    
}


- (void)OnTabMenu:(id)sender

{
    UIButton *button = (UIButton *)sender;

    _line.frame = CGRectMake(59 + 80 * button.tag , 65, 38, 2);

    if (self.currentTabMenuIndex == button.tag)
    {
        return;
    }
    self.currentTabMenuIndex = button.tag;
    _giftCountView.hidden = YES;
    
    if (self.selectedButton)
    {
        self.selectedButton.selected = NO;
    }
    self.selectedButton = button;
    button.selected = YES;

    
//    for (UIButton *button in self.typeBtnMArray)
//    {
//        if (button.tag == self.currentTabMenuIndex)
//        {
//            button.selected = YES;
//            button.layer.borderWidth = 0;
//        }
//        else
//        {
//            button.selected = NO;
//            button.layer.borderWidth = 1;
//        }
//    }
    
    
    NSInteger giftCategory = button.tag + 1;//服务器是从1开始
    if (button.tag > 0)
    {
        giftCategory += 1;
    }
    
    NSArray *giftArray = [[[GiftDataManager shareInstance] baseGiftData] objectForKey:[NSString stringWithFormat:@"%ld",(long)giftCategory]];;
    
    if (giftArray)
    {
        [self reloadGift:giftArray];
    }
}

- (void)reloadGift:(NSArray *)giftArray
{
    for (UIView *view in [self.scrollView subviews])
    {
        [view removeFromSuperview];
    }
    _scrollView.contentOffset = CGPointMake(0, 0);
    
    NSInteger nGiftCount = [giftArray count];
    NSInteger nPageCount = nGiftCount / GiftCount_Per_Page + ((nGiftCount % GiftCount_Per_Page) ? 1 : 0);
    for (NSInteger nPageIndex = 0; nPageIndex < nPageCount; nPageIndex++)
    {
        NSInteger giftCountInCurrentPage = (nGiftCount - nPageIndex * GiftCount_Per_Page) > GiftCount_Per_Page? GiftCount_Per_Page : ((nGiftCount - nPageIndex * GiftCount_Per_Page));
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(nPageIndex * _scrollView.frame.size.width,0,_scrollView.frame.size.width, _scrollView.frame.size.height)];
        for (int nIndex = 0; nIndex < giftCountInCurrentPage; nIndex++)
        {
            int nCellWidth = 64;
            int nCellHeight = 65;
            int x = nIndex *nCellWidth;
            int y = 0;
            
            GiftCell *giftCell = [[GiftCell alloc] initWithFrame:CGRectMake(x, y, nCellWidth, nCellHeight) showInView:self];
            giftCell.delegate = self;
            GiftData *giftData = [giftArray objectAtIndex:nIndex + nPageIndex * GiftCount_Per_Page];
            [giftCell setGiftData:giftData];
            [view addSubview:giftCell];
        }
        [self.scrollView addSubview:view];
    }
    _scrollView.contentSize = CGSizeMake(nPageCount * _scrollView.frame.size.width, _scrollView.frame.size.height);
    self.pageControl.numberOfPages = nPageCount;
    self.pageControl.currentPage = 0;
}

- (void)showGiftCountView
{
    if (_giftCountView == nil)
    {
        _giftCountView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 41, self.frame.size.width, 41)];
        _giftCountView.backgroundColor = [CommonFuction colorFromHexRGB:@"ffffff" alpha:0.4];
        [self addSubview:_giftCountView];
        

        
        for (int nIndex = 0; nIndex < _giftCountArray.count; nIndex++)
        {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            CGFloat x = 31 + (37 + 8) * nIndex;
            CGFloat y = 2;
            button.frame = CGRectMake(x, y, 37, 37);
            button.layer.masksToBounds = YES;
            button.layer.cornerRadius = 18.5;
            button.backgroundColor = [UIColor whiteColor];
            [button setTitle:[_giftCountArray objectAtIndex:nIndex] forState:UIControlStateNormal];
            button.tag = nIndex;
            button.titleLabel.font = [UIFont boldSystemFontOfSize:12];
            [button setTitleColor:[CommonFuction colorFromHexRGB:@"ff6666"] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(OnSelectGiftCout:) forControlEvents:UIControlEventTouchUpInside];
            [_giftCountView addSubview:button];
            
        }
    }
    _giftCountView.hidden = NO;
}

- (void)OnSelectGiftCout:(id)sender
{
    UIButton *button = (UIButton *)sender;
    button.layer.borderColor = [CommonFuction colorFromHexRGB:@"ff6666"].CGColor;
    button.layer.borderWidth = 1;
    [self giveGift:[[_giftCountArray objectAtIndex:button.tag] integerValue]];
    
}

- (void)giveGift:(NSInteger)giftCount
{
    if (self.selectedGiftCell!=nil)
    {
        if(self.delegate && [self.delegate respondsToSelector:@selector(giftView:giveGiftInfo:)])
        {
            NSMutableDictionary *giftInfo = [NSMutableDictionary dictionary];
            [giftInfo setObject:[NSNumber numberWithInteger:self.selectedGiftCell.giftData.giftid] forKey:@"objectid"];
            [giftInfo setObject:[NSNumber numberWithInteger:giftCount] forKey:@"objectnum"];
            [giftInfo setObject:[NSNumber numberWithInteger:self.selectedUserInfo.userId] forKey:@"useridto"];
            [giftInfo setObject:self.selectedUserInfo.nick forKey:@"usernickto"];
            [giftInfo setObject:[NSNumber numberWithInteger:(giftCount * self.selectedGiftCell.giftData.coin)] forKey:@"coin"];
            [self.delegate giftView:self giveGiftInfo:giftInfo];
        }
    }
}

- (void)OnRecharge:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(goToRecharge)])
    {
        [self.delegate goToRecharge];
    }
}

#pragma mark - GiftCellDelegate

- (void)gitfCell:(GiftCell *)giftCell didSelectItemWithTag:(NSInteger)itemTag
{
    if (self.selectedGiftCell)
    {
        self.selectedGiftCell.bSelected = NO;
    }
    self.selectedGiftCell = giftCell;
    self.selectedGiftCell.bSelected = YES;
    
    [self showGiftCountView];
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int page = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    self.pageControl.currentPage = page;
}

#pragma mark - DropListDelegate

- (void)dropList:(DropList *)dropList didSelectedIndex:(NSInteger)index
{
    if(dropList == _givedUserBtn)
    {
        self.selectedUserInfo =[self.userList objectAtIndex:index];
        dropList.selectedText = self.selectedUserInfo.nick;
    }
 }

#pragma mark -DropListDataSource

- (NSInteger)numberOfRowsInDropList:(DropList *)dropList;
{
    if(dropList == _givedUserBtn)
    {
        return self.userList.count;
    }
    else
        return 0;
}

- (NSString *)dropList:(DropList *)dropList textOfRow:(NSInteger)row;
{
    if(dropList == _givedUserBtn)
    {
        UserInfo *userinfo=[self.userList objectAtIndex:row];
        return userinfo.nick;
    }
    else
        return nil;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
