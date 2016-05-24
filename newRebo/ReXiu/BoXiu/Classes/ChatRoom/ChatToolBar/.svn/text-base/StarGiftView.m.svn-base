//
//  StarGiftView.m
//  BoXiu
//
//  Created by andy on 15-1-7.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import "StarGiftView.h"
#import "UserInfoManager.h"
#import "GiftCell.h"
#import "GiftDataManager.h"

#define GiftCount_Per_Page (5)

@interface StarGiftView ()<UIScrollViewDelegate,GiftCellDelegate>

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UILabel *coinCount;
@property (nonatomic,strong) NSMutableArray *giftArray;
@property (nonatomic,strong) GiftCell *selectedGiftCell;
@property (nonatomic,strong) UIView *giftCountView;
@property (nonatomic,strong) NSArray *giftCountArray;

@end

@implementation StarGiftView

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
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 80)];
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.bounces = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    [self addSubview:_scrollView];
    
    UIImageView *coinImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 93, 15, 15)];
    coinImg.image = [UIImage imageNamed:@"rebi"];
    [self addSubview:coinImg];
    
    _coinCount = [[UILabel alloc] initWithFrame:CGRectMake(30, 93, 150, 15)];
    _coinCount.text = [NSString stringWithFormat:@"%lld",[UserInfoManager shareUserInfoManager].currentUserInfo.coin];
    _coinCount.textColor = [CommonFuction colorFromHexRGB:@"f79350"];
    _coinCount.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_coinCount];
    
    UIImage *normalImg = [CommonFuction imageWithColor:[UIColor clearColor] size:CGSizeMake(97, 43)];
    UIImage *selectImg = [CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"f7c250"] size:CGSizeMake(97, 43)];
    
    UIButton *rechargeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rechargeBtn.layer.cornerRadius = 10.5;
    rechargeBtn.layer.masksToBounds = YES;
    rechargeBtn.layer.borderColor = [CommonFuction colorFromHexRGB:@"f7c250"].CGColor;
    rechargeBtn.layer.borderWidth = 0.5;
    rechargeBtn.frame = CGRectMake(258, 160, 50, 20);
    [rechargeBtn setTitleColor:[CommonFuction colorFromHexRGB:@"f7c250"] forState:UIControlStateNormal];
    [rechargeBtn setTitleColor:[CommonFuction colorFromHexRGB:@"ffffff"] forState:UIControlStateHighlighted];
    [rechargeBtn setTitle:@"充值" forState:UIControlStateNormal];
    rechargeBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    [rechargeBtn setBackgroundImage:normalImg forState:UIControlStateNormal];
    [rechargeBtn setBackgroundImage:selectImg forState:UIControlStateHighlighted];
    [rechargeBtn addTarget:self action:@selector(OnRecharge:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:rechargeBtn];

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

- (void)reloadData
{
    NSArray *giftArray = [[GiftDataManager shareInstance] starGiftData];
    if (giftArray == nil)
    {
        return;
    }
    NSInteger nGiftCount = [giftArray count];
    NSInteger nPageCount = nGiftCount / GiftCount_Per_Page + ((nGiftCount % GiftCount_Per_Page) ? 1 : 0);
    for (NSInteger nPageIndex = 0; nPageIndex < nPageCount; nPageIndex++)
    {
        NSInteger giftCountInCurrentPage = (nGiftCount - nPageIndex * GiftCount_Per_Page) > GiftCount_Per_Page? GiftCount_Per_Page : ((nGiftCount - nPageIndex * GiftCount_Per_Page));
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(nPageIndex * _scrollView.frame.size.width,0,_scrollView.frame.size.width, _scrollView.frame.size.height)];
        for (NSInteger nIndex = 0; nIndex < giftCountInCurrentPage; nIndex++)
        {
            NSInteger nCellWidth = 64;
            NSInteger nCellHeight = 65;
            NSInteger x = nIndex *nCellWidth;
            NSInteger y = 5;
            
            GiftCell *giftCell = [[GiftCell alloc] initWithFrame:CGRectMake(x, y, nCellWidth, nCellHeight) showInView:self];
            giftCell.delegate = self;
            GiftData *giftData = [giftArray objectAtIndex:nIndex + nPageIndex * GiftCount_Per_Page];
            [giftCell setGiftData:giftData];
            [view addSubview:giftCell];
        }
        [self.scrollView addSubview:view];
    }
    _scrollView.contentSize = CGSizeMake(nPageCount * _scrollView.frame.size.width, _scrollView.frame.size.height);
}

- (void)showGiftCountView
{
    if (_giftCountView == nil)
    {
        _giftCountView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 41, self.frame.size.width, 41)];
        _giftCountView.backgroundColor = [UIColor clearColor];
        [self addSubview:_giftCountView];
        
        UIImageView *backImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _giftCountView.frame.size.width, _giftCountView.frame.size.height)];
        backImg.image = [UIImage imageNamed:@"  "];
        [_giftCountView addSubview:backImg];
        
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
            StarInfo *starInfo = [UserInfoManager shareUserInfoManager].currentStarInfo;
            NSMutableDictionary *giftInfo = [NSMutableDictionary dictionary];
            [giftInfo setObject:[NSNumber numberWithInteger:self.selectedGiftCell.giftData.giftid] forKey:@"objectid"];
            [giftInfo setObject:[NSNumber numberWithInteger:giftCount] forKey:@"objectnum"];
            [giftInfo setObject:[NSNumber numberWithInteger:starInfo.userId] forKey:@"useridto"];
            [giftInfo setObject:starInfo.nick forKey:@"usernickto"];
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
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
