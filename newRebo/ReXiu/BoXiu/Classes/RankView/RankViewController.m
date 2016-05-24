//
//  RankViewController.m
//  XiuBo
//
//  Created by Andy on 14-3-25.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "RankViewController.h"
#import "EWPSegmentedControl.h"
#import "EWPTabBar.h"
#import "GeneralRankCell.h"
#import "GeneralRankModel.h"
#import "SpecialRankModel.h"
#import "GrabStarRankCell.h"

@interface RankViewController ()<BaseTableViewDataSoure,BaseTableViewDelegate,EWPTabBarDelegate,EWPTabBarDataSource>

@property (nonatomic,strong) EWPSegmentedControl *segmentedbtn;
@property (nonatomic,strong) EWPTabBar *tabMenuBar;
@property (nonatomic,strong) NSMutableArray *tabTitles;
@property (nonatomic,strong) NSMutableArray *tabTitles2;

@property (nonatomic,strong) GeneralRankModel *generalRankModel;
@property (nonatomic,strong) SpecialRankModel *specialRankModel;
@property (nonatomic,assign) NSInteger segmentedBtnIndex;

@end

@implementation RankViewController

- (void)dealloc
{
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.baseViewType = kbaseTableViewType;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"排行";
    //    if (SCREEN_HEIGHT == 480)
    //    {
    //        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"rankBg"]];
    //    }
    //    else
    //    {
    //        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"rankBg_5"]];
    //    }
    
    
    _segmentedbtn = [[EWPSegmentedControl alloc] initWithSectionTitles:@[StarRank_Title,RichRank_Title,PopularRank_Title,GrabStar_Title]];
    _segmentedbtn.frame = CGRectMake(0, 0, self.view.bounds.size.width, 36);
    //    _segmentedbtn.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    _segmentedbtn.textColor = [CommonFuction colorFromHexRGB:@"575757"];
    _segmentedbtn.selectionStyle = EWPSegmentedControlSelectionStyleFullWidthStripe;
    _segmentedbtn.selectionIndicatorLocation = EWPSegmentedControlSelectionIndicatorLocationDown;
    _segmentedbtn.selectionIndicatorColor = [CommonFuction colorFromHexRGB:@"d14c49"];
    _segmentedbtn.selectedTextColor = [CommonFuction colorFromHexRGB:@"d14c49"];
    _segmentedbtn.indicatorBKColor = [CommonFuction colorFromHexRGB:@"ffffff"];
    _segmentedbtn.selectionIndicatorHeight = 1.5f;
    _segmentedbtn.backgroundColor = [UIColor whiteColor];
    _segmentedbtn.font = [UIFont systemFontOfSize:14.0f];
    
    [_segmentedbtn addTarget:self action:@selector(rankChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_segmentedbtn];
    
    _tabTitles = @[DayRank_Title,WeekRank_Title,MonthRank_Title,SuperRank_Title];
    _tabMenuBar = [[EWPTabBar alloc] initWithFrame:CGRectMake(10, 45, self.view.bounds.size.width-20, 30)];
    _tabMenuBar.tabSelectedBKColor = [CommonFuction colorFromHexRGB:@"d14c49"];
    _tabMenuBar.tabNormalBKColor = [UIColor clearColor];
    _tabMenuBar.normalTextColor = [CommonFuction colorFromHexRGB:@"d14c49"];
    _tabMenuBar.selectedTextColor = [CommonFuction colorFromHexRGB:@"ffffff"];
    _tabMenuBar.layer.cornerRadius = 4.0f;
    _tabMenuBar.layer.borderColor = [CommonFuction colorFromHexRGB:@"d14c49"].CGColor;
    _tabMenuBar.layer.borderWidth = 0.5f;
    //_tabMenuBar.xOffset = 30;
    _tabMenuBar.delegate = self;
    _tabMenuBar.dataSource = self;
    [self.view addSubview:_tabMenuBar];
    [_tabMenuBar reloadData];
    
    _tabTitles2 = @[ThisWeek_Title,LastWeek_Title];
    self.tableView.frame = CGRectMake(0, 86, self.view.frame.size.width, SCREEN_HEIGHT - 86 - 64);
    self.tableView.baseDataSource = self;
    self.tableView.baseDelegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.backgroundColor = [CommonFuction colorFromHexRGB:@"ffffff"];
    self.loadMore = NO;
    self.tipLabel.frame =CGRectMake((SCREEN_WIDTH -175)/2, (SCREEN_HEIGHT - 86 - 64 -175)/2, 175, 175);
    self.imageViewPoint = CGPointMake(self.view.center.x, (SCREEN_HEIGHT - 86 )/2);
    
    //    __weak typeof(self) weakself = self;
    //    [self setNavigationBarLeftItem:nil itemNormalImg:[UIImage imageNamed:@"navBack_normal"] itemHighlightImg:nil withBlock:^(id sender) {
    //        __strong typeof(self) strongself = weakself;
    //        if (strongself)
    //        {
    //            NSString *className = NSStringFromClass([strongself class]);
    //            NSDictionary *param = [NSDictionary dictionaryWithObject:className forKey:@"className"];
    //            [strongself popCanvasWithArgment:param];
    //        }
    //    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //    __weak typeof(self) weakSelf = self;
    //    [self setNavigationBarRightItem:nil itemNormalImg:[UIImage imageNamed:@"right_search_normal"] itemHighlightImg:[UIImage imageNamed:@"right_search_high"] withBlock:^(id sender) {
    //        __strong typeof(self) strongSelf = weakSelf;
    ////        NSDictionary *param = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES] forKey:@"pop"];
    ////        [strongSelf popCanvasWithArgment:param];
    //
    //        [strongSelf pushCanvas:Search_Canvas withArgument:nil];
    //    }];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)valueChanged:(id)sender
{
    //请求对应榜单的数据
    
    if (self.segmentedbtn.selectedSegmentIndex == 3)
    {
        if(self.tabMenuBar.selectedIndex == 0)
        {
            if (self.specialRankModel && self.specialRankModel.starUserMArray.count > 0)
            {
                [self.tableView reloadData];
                self.tipLabel.hidden = YES;
            }
            else
            {
                [self refreshData];
                
                if (self.generalRankModel.starUserMArray.count > 0){
                    
                }
                
                
            }
        }
        else
        {
            if (self.specialRankModel && self.specialRankModel.lastStarUserMArray.count > 0)
            {
                [self.tableView reloadData];
                self.tipLabel.hidden = YES;
            }
            else
            {
                [self refreshData];
                
                
            }
        }
    }
    else
    {
        [self refreshData];
    }
    
    if ([self.specialRankModel.starUserMArray count] > 0 ) {
        NSInteger lastSectionIndex = [self.tableView numberOfSections] - 1;
        NSInteger lastRowIndex = [self.tableView numberOfRowsInSection:lastSectionIndex] - 1;
        if (lastSectionIndex > 0 && lastRowIndex > 0) {
            NSIndexPath *lastIndexPath = [NSIndexPath indexPathForRow:lastRowIndex inSection:lastSectionIndex];
            [self.tableView scrollToRowAtIndexPath:lastIndexPath atScrollPosition: UITableViewScrollPositionBottom animated:NO];
        }
    }
    
}

- (void)refreshData
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInteger:self.segmentedbtn.selectedSegmentIndex + 1] forKey:@"type"];
    
    __weak typeof(self) weakSelf = self;
    
    if (self.segmentedbtn.selectedSegmentIndex != 3)
    {
        
        if (   self.generalRankModel.starUserMArray.count==0) {
            self.isFirstRequestData = YES;
        }else{
            self.isFirstRequestData = NO;
        }
        
        [dict setObject:[NSNumber numberWithInteger:self.tabMenuBar.selectedIndex + 1] forKey:@"timeType"];
        [self requestDataWithAnalyseModel:[GeneralRankModel class] params:dict success:^(id object)
         {
             
             [self stopAnimating];
             __strong typeof(self) strongSelf = weakSelf;
             /*成功返回数据*/
             strongSelf.generalRankModel = object;
             if (strongSelf.generalRankModel.result == 0)
             {
                 [strongSelf.tableView reloadData];
                 
             }
             if (strongSelf.generalRankModel.starUserMArray.count > 0)
             {
                 self.tipLabel.hidden = YES;
             }
             else
             {
                 self.tipLabel.hidden = NO;
             }
             
         }
                                     fail:^(id object)
         {
             
             [weakSelf stopAnimating];
             
             
             [weakSelf.tableView reloadData];
         }];
        
        
    }
    else
    {
        if ( self.specialRankModel.starUserMArray.count==0) {
            self.isFirstRequestData = YES;
        }else{
            self.isFirstRequestData = NO;
        }
        
        [dict setObject:[NSNumber numberWithInt:1] forKey:@"type"];
        [self requestDataWithAnalyseModel:[SpecialRankModel class] params:dict success:^(id object)
         {
             
             [self stopAnimating];
             
             __strong typeof(self) strongSelf = weakSelf;
             /*成功返回数据*/
             strongSelf.specialRankModel = object;
             if (strongSelf.specialRankModel.result == 0)
             {
                 [strongSelf.tableView reloadData];
             }
             
             if(self.tabMenuBar.selectedIndex == 0)
             {
                 if (  self.specialRankModel.starUserMArray.count > 0)
                 {
                     self.tipLabel.hidden = YES;
                 }
                 else
                 {
                     self.tipLabel.hidden = NO;
                 }
             }
             else
             {
                 if (self.specialRankModel.lastStarUserMArray.count > 0)
                 {
                     self.tipLabel.hidden = YES;
                 }
                 else
                 {
                     self.tipLabel.hidden = NO;
                 }
             }
             
         }
                                     fail:^(id object)
         {
             
             [self stopAnimating];
             
             /*失败返回数据*/
             [self.tableView reloadData];
         }];
    }
    
}

#pragma mark - UITalbeViewDataSurce

- (NSInteger)numberOfSectionsInBaseTableView:(BaseTableView *)baseTableView
{
    
    return 1;
}

- (NSInteger)baseTableView:(BaseTableView *)baseTableView numberOfRowsInSection:(NSInteger)section
{
    if(self.segmentedbtn.selectedSegmentIndex != 3)
    {
        
        
        
        if (self.generalRankModel.starUserMArray.count>=1) {
            [self stopAnimating];
        }
        
        return self.generalRankModel.starUserMArray.count;
        
    }
    else
    {
        if(self.tabMenuBar.selectedIndex == 0)
        {
            if (self.specialRankModel.starUserMArray.count>=1) {
                [self stopAnimating];
            }
            
            return self.specialRankModel.starUserMArray.count;
        }
        else
        {
            if (self.specialRankModel.lastStarUserMArray.count>=1) {
                [self stopAnimating];
            }
            
            return self.specialRankModel.lastStarUserMArray.count;
        }
    }
}

- (UITableViewCell *)baseTableView:(BaseTableView *)baseTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (self.segmentedbtn.selectedSegmentIndex != 3)
    {
        static NSString *generaCellIdentifier =  @"GeneraCellIdentifier";
        GeneralRankCell *generaCell = [baseTableView dequeueReusableCellWithIdentifier:generaCellIdentifier];//明星榜
        if (generaCell == nil)
        {
            generaCell = [[GeneralRankCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:generaCellIdentifier];
            generaCell.backgroundColor = [UIColor clearColor];
            generaCell.accessoryType = UITableViewCellAccessoryNone;
            generaCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        if ( self.generalRankModel.starUserMArray == nil && self.generalRankModel.starUserMArray .count==0) {
            return generaCell;
        }
        StarInfo *starInfo=[self.generalRankModel.starUserMArray objectAtIndex:indexPath.row];
        generaCell.starInfo = starInfo;
        generaCell.rankIndex = indexPath.row;
        if(self.segmentedbtn.selectedSegmentIndex == 1)
        {
            generaCell.rankCellType=RankCellTypeUser;
        }
        else
        {
            generaCell.rankCellType=RankCellTypeStar;
        }
        
        cell = generaCell;
    }
    else
    {
        static NSString *grabStarRankCellIdentifier =  @"GrabStarRankCell";//抢星榜
        GrabStarRankCell *grabStarRankCell = [baseTableView dequeueReusableCellWithIdentifier:grabStarRankCellIdentifier];
        if (grabStarRankCell == nil)
        {
            grabStarRankCell = [[GrabStarRankCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:grabStarRankCellIdentifier];
            grabStarRankCell.backgroundColor = [UIColor clearColor];
            grabStarRankCell.accessoryType = UITableViewCellAccessoryNone;
            grabStarRankCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        StarGift *starGift=nil;
        
        if ( self.specialRankModel.starUserMArray == nil && self.specialRankModel.starUserMArray .count==0) {
            return grabStarRankCell;
        }
        if(self.tabMenuBar.selectedIndex == 0)
        {
            starGift = [self.specialRankModel.starUserMArray objectAtIndex:indexPath.row];
        }
        else
        {
            starGift = [self.specialRankModel.lastStarUserMArray objectAtIndex:indexPath.row];
        }
        
        grabStarRankCell.starGift = starGift;
        grabStarRankCell.rankIndex = indexPath.row;
        cell = grabStarRankCell;
    }
    return cell;
    
}


#pragma mark - UITableViewDelegate

- (CGFloat)baseTableView:(BaseTableView *)baseTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.segmentedbtn.selectedSegmentIndex == 3)
    {
        return [GrabStarRankCell height];
    }
    else
    {
        return [GeneralRankCell height];
    }
    
}

- (void)baseTableView:(BaseTableView *)baseTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.segmentedbtn.selectedSegmentIndex == 1)
    {
        //不做处理
        return;
    }
    StarInfo *starInfo = nil;
    if (self.segmentedbtn.selectedSegmentIndex != 3)
    {
        
        
        starInfo = [self.generalRankModel.starUserMArray objectAtIndex:indexPath.row];
        GeneralRankCell *cell = (GeneralRankCell *)[baseTableView cellForRowAtIndexPath:indexPath];
        
        if (cell.starInfo.onlineflag)
        {
            NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:cell.starInfo.userId],@"staruserid",NSStringFromClass([self class]),@"className",nil];
 
//            NSString *className = NSStringFromClass([self class]);
//            NSDictionary *param = [NSDictionary dictionaryWithObject:className forKey:@"className"];
            [self pushCanvas:LiveRoom_CanVas withArgument:param];
        }
        else
        {
            NSString *className = NSStringFromClass([self class]);
            [UserInfoManager shareUserInfoManager].tempStarInfo = starInfo;
            [UserInfoManager shareUserInfoManager].tempHederImage = cell.headImg.image;
            NSMutableDictionary *param = [NSMutableDictionary dictionary];
            [param setObject:[NSNumber numberWithInteger:starInfo.userId] forKey:@"userid"];
            [param setObject:className forKey:@"className"];
            [self pushCanvas:PersonInfo_Canvas withArgument:param];
        }
        
    }
    else
    {
        //        StarGift *starGift = nil;
        //        if (self.tabMenuBar.selectedIndex == 0)
        //        {
        //            starGift = [self.specialRankModel.starUserMArray objectAtIndex:indexPath.row];
        //            starInfo = starGift.starInfo;
        //        }
        //        else
        //        {
        //            starGift = [self.specialRankModel.lastStarUserMArray objectAtIndex:indexPath.row];
        //            starInfo = starGift.starInfo;
        //        }
        
        GrabStarRankCell *cell = (GrabStarRankCell *)[baseTableView cellForRowAtIndexPath:indexPath];
        StarInfo *starInfo = cell.starGift.starInfo;
        if (starInfo.onlineflag)
        {
            NSDictionary *param = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:starInfo.userId] forKey:@"staruserid"];
            [self pushCanvas:LiveRoom_CanVas withArgument:param];
        }
        else
        {
            [UserInfoManager shareUserInfoManager].tempStarInfo = starInfo;
            [UserInfoManager shareUserInfoManager].tempHederImage = cell.headImgView.image;
            NSMutableDictionary *param = [NSMutableDictionary dictionary];
            [param setObject:[NSNumber numberWithInteger:starInfo.userId] forKey:@"userid"];
            [self pushCanvas:PersonInfo_Canvas withArgument:param];
        }
    }
    
}


-(void) rankChanged:(id)sender
{
    
    if (self.segmentedBtnIndex != self.segmentedbtn.selectedSegmentIndex)
    {
        self.segmentedBtnIndex = self.segmentedbtn.selectedSegmentIndex;
        
        if (self.segmentedbtn.selectedSegmentIndex == 3)
        {
            //self.tabMenuBar.xOffset = 60;
            
        }
        else
        {
            //self.tabMenuBar.xOffset = 30;
            
        }
        
        [self.tabMenuBar reloadData];
        
        self.segmentedBtnIndex = self.segmentedbtn.selectedSegmentIndex;
    }
}

#pragma mark - EWPTabBarDataSource

- (NSInteger)numberOfItems
{
    if (self.segmentedbtn.selectedSegmentIndex == 3)
    {
        return 2;
    }else{
        return 4;
    }
}

- (CGFloat)widthOfItem:(NSInteger)index
{
    if (self.segmentedbtn.selectedSegmentIndex == 3)
        return 150;
    else
        return 75;
}

- (CGFloat)heightOfItem
{
    return 30.0f;
}

- (NSString *)titleOfItem:(NSInteger)index
{
    if (self.segmentedbtn.selectedSegmentIndex == 3)
        return [self.tabTitles2 objectAtIndex:index];
    else
        return [self.tabTitles objectAtIndex:index];
}

- (NSInteger)tagOfItem:(NSInteger)index
{
    return index;
}

#pragma mark - EWPTabBarDelegate

- (void)tabBar:(EWPTabBar *)tabBar didSelectItemWithTag:(NSInteger)itemTag
{
    
    [self stopAnimating];
    [self valueChanged:tabBar];
}

@end
