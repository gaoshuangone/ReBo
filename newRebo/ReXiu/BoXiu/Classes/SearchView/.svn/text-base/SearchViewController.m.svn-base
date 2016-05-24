//
//  SearchViewController.m
//  BoXiu
//
//  Created by andy on 14-4-25.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchUserModel.h"
#import "DelAttentionModel.h"
#import "AddAttentModel.h"
#import "RecommendCell.h"
#import "UIImage+Blur.h"
#import "GetTwoLevelCategoryModel.h"
#import "CategoryStarModel.h"
#define Category_StarCount_Per_Page (10)
@interface SearchViewController ()<UISearchBarDelegate,BaseTableViewDataSoure,BaseTableViewDelegate,RecommendCellDelegate>
@property (nonatomic,strong) NSMutableArray *starUserMArray;
@property (nonatomic,strong) NSString *searchValue;
@property (nonatomic,strong) StarInfo *selectedStarUser;
@property (nonatomic,strong) UILabel *tip;
@property (nonatomic,strong) UISearchBar *searchBar;
@property (nonatomic,strong) NSMutableArray* arrayTabMenuTitles;
@property (nonatomic,strong) UIControl* controlView;

@property (nonatomic,strong) UIControl* controlBGKuang;
@property (nonatomic,strong) UIButton* imageViewColose;


@property (nonatomic,assign) NSInteger categoryid;

@property (nonatomic,assign) BOOL isGetSearchData;


@end

@implementation SearchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.baseViewType = kbaseTableViewType;
    }
    return self;
}
- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size

{
    
    
        
        CGRect rect = CGRectMake(0, 0, size.width, size.height);
        
        UIGraphicsBeginImageContext(rect.size);
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGContextSetFillColorWithColor(context,
                                       
                                       color.CGColor);
        
        CGContextFillRect(context, rect);
        
        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
        
        
        return img;
        
    }
- (void)viewDidLoad
{
    [super viewDidLoad];
//        [bar setTranslucent:NO];
    // Do any additional setup after loading the view.
  
    self.isFirstRequestData = YES;

    _controlBGKuang =[[UIControl alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-416/2)/2, 9+1,  416/2, 23)];

    [_controlBGKuang.layer setMasksToBounds:YES];
        [_controlBGKuang.layer setMasksToBounds:YES];
        _controlBGKuang.layer.cornerRadius = 11.5;
        _controlBGKuang.layer.borderWidth = 0.65;
        _controlBGKuang.layer.borderColor = [CommonFuction colorFromHexRGB:@"cbcbcb"].CGColor;
    [self.navigationController.navigationBar addSubview:_controlBGKuang];
    
    
    
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-416/2)/2-2, 11+1
                                                            , 416/2, 21)];
    _searchBar.showsCancelButton = NO;
    _searchBar.delegate = self;
    UIImage* image =[UIImage imageNamed:@"searchSC"];
    _searchBar.backgroundColor = [UIColor clearColor];
    [_searchBar setImage:image forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    UITextField *txfSearchField = [_searchBar valueForKey:@"_searchField"];
    txfSearchField.placeholder = @"请输入靓号 / 昵称";

    txfSearchField.backgroundColor = [UIColor clearColor];
    txfSearchField.textColor = [CommonFuction colorFromHexRGB:@"959596"];
    txfSearchField.font = [UIFont systemFontOfSize:13];
    txfSearchField.clearButtonMode = UITextFieldViewModeNever;
    [txfSearchField setValue:[CommonFuction colorFromHexRGB:@"959596"] forKeyPath:@"_placeholderLabel.textColor"];

    _imageViewColose = [UIButton buttonWithType:UIButtonTypeCustom];
    [_imageViewColose setImage:[UIImage imageNamed:@"SScolose.png"] forState:UIControlStateNormal];
    [_imageViewColose addTarget:self action:@selector(buttonColosed) forControlEvents:UIControlEventTouchUpInside];

    _imageViewColose.hidden = YES;
     _imageViewColose.frame = CGRectMake(416/2-8-21+3+3, 11, 21, 21);
    [_searchBar addSubview:_imageViewColose];
    [self.navigationController.navigationBar addSubview:_searchBar];
    
     _controlView = [[UIControl alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:_controlView];
    
    UILabel* labelReMen = [CommonUtils commonSignleLabelWithText:@"热门分类" withFontSize:13 withOriginX:0 withOriginY:0 isRelativeCoordinate:NO];
    labelReMen.textColor = [CommonFuction colorFromHexRGB:@"959596"];
    labelReMen.center = CGPointMake(SCREEN_WIDTH/2,20+8);
    [_controlView addSubview:labelReMen];
    

    UIView* viewLine1 =[CommonUtils CommonViewLineWithFrame:CGRectMake(0, 0, 190/2, 1)];
    viewLine1.backgroundColor = [CommonFuction colorFromHexRGB:@"cbcbcb"];
    viewLine1.center = CGPointMake(56/2+190/4, labelReMen.center.y);
    [_controlView addSubview:viewLine1];
    
    
    UIView* viewLine2 =[CommonUtils CommonViewLineWithFrame:CGRectMake(0, 0, 190/2, 1)];
    viewLine2.backgroundColor = [CommonFuction colorFromHexRGB:@"cbcbcb"];
    viewLine2.center = CGPointMake( (SCREEN_WIDTH-56/2-190/4), labelReMen.center.y);
    [_controlView addSubview:viewLine2];
    
    
   

    
    self.tableView.frame = CGRectMake(0,0,self.view.bounds.size.width ,SCREEN_HEIGHT - 64);
    self.tableView.baseDataSource = self;
    self.tableView.baseDelegate = self;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.refresh = YES;
    self.loadMore =YES;
          self.tipLabel.hidden = YES;
//    self.refresh = NO;
//    self.loadMore = NO;
    [_searchBar becomeFirstResponder];
      self.tableView.totalPage = 1000;
    [self getTwoLevelCategory];
    
    __weak  typeof(self) weakSelf = self;
    self.netViewTouchEd = ^(){
        if (weakSelf.isGetSearchData) {
            [weakSelf refreshData];
        }else{
        [weakSelf getTwoLevelCategory];
        }
    };
    //[searchBar performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:0.3 ];
}
-(void)buttonColosed{
    
    _searchBar.text = @"";
       _searchBar.placeholder = @"请输入靓号 / 昵称";
    _imageViewColose.hidden = YES;
    _controlView.hidden = NO;
    [self stopAnimating];
       self.tipLabel.hidden = YES;
    self.tableView.hidden = YES;
}
-(void)getTwoLevelCategory{
    
    self.networkview.hidden = YES;
    
    if ( self.arrayTabMenuTitles.count==0) {
        self.isFirstRequestData = YES;
    }else{
        self.isFirstRequestData = NO;
    }
    
    [self requestDataWithAnalyseModel:[GetTwoLevelCategoryModel class] params:nil success:^(id object) {
        GetTwoLevelCategoryModel *model = (GetTwoLevelCategoryModel *)object;
        if (model.result == 0)
        {
            self.arrayTabMenuTitles = [NSMutableArray arrayWithCapacity:5];
            
            NSArray *categoryArray = model.TwoLevelCategoryMArray;
            for (int nIndex = 0; nIndex < [categoryArray count]; nIndex++)
            {
                TwoLevelCategoryData *categoryData = [categoryArray objectAtIndex:nIndex];
                CategoryMenu *menuData = [[CategoryMenu alloc] init];
                menuData.categoryId = categoryData.categoryId;
                menuData.title = categoryData.name;

                        [self.arrayTabMenuTitles addObject:menuData];
                
              
            }
              [self addButtonItem];
        
        }
        
    } fail:^(id object) {
        //        [self.tabMenuTitles removeAllObjects];
//        _message.text = @"暂无网络～";
//        _updateview.hidden = NO;
           [self.view bringSubviewToFront:self.networkview];
        self.networkview.hidden = NO;
         [self.searchBar resignFirstResponder];
    }];

}
-(void)addButtonItem{
    
    CGFloat offSet = 7;
    
    CGFloat offSetType1 = 90;
    CGFloat offSetType2 = 72;
    CGFloat offSetType3 = 56;
    
    
     CGFloat offSetType4 = 80;
     CGFloat offSetType = 0;

    CGFloat offX=0;
    CGFloat offY=0;
    
    for (int i =0; i<[self.arrayTabMenuTitles count]; i++) {
        CategoryMenu* menuData = [self.arrayTabMenuTitles objectAtIndex:i];
        
        
        UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        
        if (menuData.title.length==5) {
            offSetType =offSetType1;
        }else if (menuData.title.length==3){
             offSetType =offSetType2;
        }else if (menuData.title.length==2){
              offSetType =offSetType3;
        }else if (menuData.title.length==4){
             offSetType =offSetType4;
        }else{
             offSetType =offSetType4;
        }
        
        if (i==0) {
         
            button.frame =CGRectMake(56/2, (224-64*2)/2, offSetType, 30);
            offX+=offSetType+offSet;
        }else if (i==1){
            button.frame =CGRectMake(56/2+offX, (224-64*2)/2, offSetType, 30);
            offX+=offSetType+offSet;
        }else if (i==2){
               button.frame =CGRectMake(56/2+offX, (224-64*2)/2, offSetType, 30);
            offY +=30+7;
            offX=0;
        }else if (i ==3){
            button.frame =CGRectMake(56/2, (224-64*2)/2+offY, offSetType, 30);
                offX+=offSetType+offSet;
        }else if (i==4){
              button.frame =CGRectMake(56/2 +offX, (224-64*2)/2+30+7, offSetType, 30);
                 offX+=offSetType+offSet;
        }
        else if (i==5){
            button.frame =CGRectMake(56/2 +offX, (224-64*2)/2+30+7, offSetType, 30);
            offY +=30+7;
            offX=0;
        }    else if (i==6){
            button.frame =CGRectMake(56/2 +offX, (224-64*2)/2+30+7, offSetType, 30);
             offX+=offSetType+offSet;
        }
        else if (i==7){
            button.frame =CGRectMake(56/2 +offX, (224-64*2)/2+30+7, offSetType, 30);
            offX+=offSetType+offSet;
        }
        else if (i==8){
            button.frame =CGRectMake(56/2 +offX, (224-64*2)/2+30+7, offSetType, 30);
            offY +=30+7;
            offX=0;
        }
    
        
        [button setTitle:menuData.title forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        button.backgroundColor = [UIColor whiteColor];
        [button.layer setMasksToBounds:YES];
        button.layer.borderWidth = 0.65;
        button.layer.borderColor = [CommonFuction colorFromHexRGB:@"cbcbcb"].CGColor;
        button.layer.cornerRadius = 2;
        [button setTitleColor :[CommonFuction colorFromHexRGB:@"454a4d"] forState:UIControlStateNormal];
        button.tag=i;
        [button addTarget:self action:@selector(buttonPre:) forControlEvents:UIControlEventTouchUpInside];
        [_controlView addSubview:button];
        
    }
    
    
}
-(void)buttonPre:(UIButton*)sender{
    self.isGetSearchData = NO;
       CategoryMenu* menuData = [self.arrayTabMenuTitles objectAtIndex:sender.tag ];
    self.categoryid  = menuData.categoryId;
    self.searchBar.text = menuData.title;
    self.imageViewColose.hidden = NO;
    
    [self refreshData];
 
    [self.searchBar resignFirstResponder];
    _controlView.hidden = YES;
    self.tableView.hidden = NO;
    if (self.starUserMArray.count !=0) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:NO];
        
    }
//    self.searchBar.text = menuData.title;
}
- (void)refreshData{
    
 

    self.tableView.curentPage =1;
  self.tipLabel.hidden = YES;
        self.networkview.hidden = YES;
    if (self.isGetSearchData) {
        [self getData];
        return;
    }
    if ( self.starUserMArray.count==0) {
        self.isFirstRequestData = YES;
    }else{
        self.isFirstRequestData = NO;
    }
    
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInteger:self.categoryid] forKey:@"categoryid"];
    [params setObject:[NSNumber numberWithInteger:1] forKey:@"pageIndex"];
    [params setObject:[NSNumber numberWithInteger:Count_Per_Page] forKey:@"pageSize"];
    [params setObject:[NSNumber numberWithBool:YES] forKey:@"isFromMobile"];
    [self requestDataWithAnalyseModel:[CategoryStarModel class] params:params success:^(id object) {
        CategoryStarModel *model = (CategoryStarModel *)object;
        if (model.result == 0)
        {
            if (self.starUserMArray) {
                  [self.starUserMArray removeAllObjects];
                self.starUserMArray = nil;
            }
            self.starUserMArray = [NSMutableArray arrayWithCapacity:10];
          
            
            [self.starUserMArray addObjectsFromArray:model.starMArray];
            if ([self.starUserMArray count] < Category_StarCount_Per_Page)
            {
                self.tableView.totalPage = [self.starUserMArray count]/Category_StarCount_Per_Page + ([self.starUserMArray count] %Category_StarCount_Per_Page? 1:0);
            }
            else
            {
                self.tableView.totalPage = 1000;
            }
            
          
            NSInteger nCount = [self.starUserMArray count];
            if (nCount == 0)
            {
                self.tipLabel.hidden = NO;
            }
            else
            {
                self.tipLabel.hidden = YES;
            }
            
//                 _tip.hidden = YES;
//             self.tipLabel.hidden = YES;
        }
          [self.tableView reloadData];
    } fail:^(id object) {
        [self.view bringSubviewToFront:self.networkview];
        self.networkview.hidden = NO;
         [self.searchBar resignFirstResponder];
          [self.tableView reloadData];
    }];

}
- (void)loadMorData{
  
    if ( self.starUserMArray.count==0) {
        self.isFirstRequestData = YES;
    }else{
        self.isFirstRequestData = NO;
    }
    if (self.isGetSearchData) {
        [self getData];
        return;
    }
    
 
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInteger:self.categoryid] forKey:@"categoryid"];
    //底层是从page=0开始的
    [params setObject:[NSNumber numberWithInteger:self.tableView.curentPage + 1] forKey:@"pageIndex"];
    [params setObject:[NSNumber numberWithInteger:Count_Per_Page] forKey:@"pageSize"];
    [params setObject:[NSNumber numberWithBool:YES] forKey:@"isFromMobile"];
    [self requestDataWithAnalyseModel:[CategoryStarModel class] params:params success:^(id object) {
        CategoryStarModel *model = (CategoryStarModel *)object;
        if (model.result == 0)
        {
            [self.starUserMArray addObjectsFromArray: model.starMArray];
   
        }
                 [self.tableView reloadData];
    } fail:^(id object) {
              [self.tableView reloadData];
    }];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    //设置标签栏的颜色
    __weak typeof(self) strongSelf = self;
    __weak  UISearchBar* searBar = _searchBar;
    self.navigationController.navigationBar.barTintColor = [CommonFuction  colorFromHexRGB:@"EAF0EE"];
    [self setNavigationBarRightItem:@"搜索" itemNormalImg:nil itemHighlightImg:nil withBlock:^(id sender) {
       [searBar resignFirstResponder];
        
        if (_searchBar.text.length==0) {
            [strongSelf showNotice:@"关键字不能为空"];
            
            return ;
        }
        strongSelf.controlView.hidden = YES;
        _searchValue = _searchBar.text;
        strongSelf.isGetSearchData = YES;
        strongSelf.tableView.curentPage =1;
        [strongSelf getData];
    }];
    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        NSArray *list=self.navigationController.navigationBar.subviews;
        for (id obj in list) {
            if ([obj isKindOfClass:[UIImageView class]]) {
                UIImageView *imageView=(UIImageView *)obj;
                NSArray *list2=imageView.subviews;
                for (id obj2 in list2) {
                    if ([obj2 isKindOfClass:[UIImageView class]]) {
                        UIImageView *imageView2=(UIImageView *)obj2;
                        imageView2.hidden=YES;
                    }
                }
            }
        }
    }

    
    _searchBar.hidden = NO;
    _controlBGKuang.hidden = NO;
}
- (void)viewWillDisappear:(BOOL)animated
{
    //设置标签栏的颜色
    self.navigationController.navigationBar.barTintColor = [CommonFuction  colorFromHexRGB:@"ffffff"];

    [super viewWillDisappear:animated];
    [_searchBar resignFirstResponder];
    
    
    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        NSArray *list=self.navigationController.navigationBar.subviews;
        for (id obj in list) {
            if ([obj isKindOfClass:[UIImageView class]]) {
                UIImageView *imageView=(UIImageView *)obj;
                NSArray *list2=imageView.subviews;
                for (id obj2 in list2) {
                    if ([obj2 isKindOfClass:[UIImageView class]]) {
                        UIImageView *imageView2=(UIImageView *)obj2;
                        imageView2.hidden=NO;
                    }
                }
            }
        }
    }

    
    _searchBar.hidden = YES;
    _controlBGKuang.hidden  = YES;
}

#pragma mark - UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    
    if (_searchBar.text.length!= 0) {
        _imageViewColose.hidden = NO;
    }
    return YES;
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    _searchValue = searchBar.text;
    [searchBar resignFirstResponder];
    self.tableView.curentPage =1;
    [self getData];
    self.isGetSearchData = YES;
    _controlView.hidden = YES;
    
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
//     self.imageViewColose.hidden = YES;
}
- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
           self.imageViewColose.hidden = NO;
    if (_searchBar.text.length==1 && [text isEqualToString:@""]) {
        self.imageViewColose.hidden = YES;
        _controlView.hidden = NO;
        self.tableView.hidden = YES;
        self.tipLabel.hidden = YES;
    }

    return YES;
}
#pragma mark-点击搜索和键盘上搜索，上啦也会调
- (void)getData
{
    self.networkview.hidden = YES;
    self.tipLabel.hidden = YES;
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSString *content = [_searchValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    [dict setObject:content?content:@"" forKey:@"searchvalue"];
    [dict setObject:[NSString stringWithFormat:@"%ld",self.tableView.curentPage] forKey:@"pageIndex"];
     [dict setObject:@"10" forKey:@"pageSize"];
 
    if(content.length <1)
    {
        self.tipLabel.hidden = NO;
        self.tableView.hidden = NO;
        if (_starUserMArray )
        {
                [_starUserMArray removeAllObjects];
        }
        [self.tableView reloadData];
        return;
    }

    if (self.starUserMArray.count==0) {
        self.isFirstRequestData = YES;
    }else{
        self.isFirstRequestData = NO;
    }
    __weak typeof(self) weakSelf = self;
    [self requestDataWithAnalyseModel:[SearchUserModel class] params:dict success:^(id object)
     {
         /*成功返回数据*/
         SearchUserModel *model = (SearchUserModel *)object;
         if (model.result == 0)
         {
             
             if (_starUserMArray == nil)
             {
                 _starUserMArray = [NSMutableArray array];
             }
             if (self.tableView.curentPage ==1) {
                 if (self.starUserMArray.count !=0) {
                     [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:NO];

                 }
                   [_starUserMArray removeAllObjects];
              
             }
             
             _controlView.hidden = YES;
             
        
           
             [self.starUserMArray addObjectsFromArray:model.userMArray];
           
             if ([self.starUserMArray count] < Category_StarCount_Per_Page)
             {
                 self.tableView.totalPage = [self.starUserMArray count]/Category_StarCount_Per_Page + ([self.starUserMArray count] %Category_StarCount_Per_Page? 1:0);
             }
             else
             {
                 self.tableView.totalPage = 1000;
             }

             
             
             self.tableView.hidden = NO;
             if (_starUserMArray.count == 0)
             {
                  self.tipLabel.hidden = NO;
             }
             else
             {
                  self.tipLabel.hidden = YES;
             }
         }
           [weakSelf.tableView reloadData];
     }
    fail:^(id object)
     {
         
         self.networkview.hidden = NO;
         [self.searchBar resignFirstResponder];
      
         /*失败返回数据*/
     }];
}

#pragma mark -BaseTableCanvasDataSoure
- (NSInteger)numberOfSectionsInBaseTableView:(BaseTableView *)baseTableView
{
    return 1;
}

- (NSInteger)baseTableView:(BaseTableView *)baseTableView numberOfRowsInSection:(NSInteger)section
{
    return [self.starUserMArray count];
}

- (UITableViewCell *)baseTableView:(BaseTableView *)baseTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier =  @"cellIdentifier";
    RecommendCell *cell = [baseTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[RecommendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.starInfo = [self.starUserMArray objectAtIndex:indexPath.row];
    UIButton  *starinforButton = [UIButton buttonWithType:UIButtonTypeCustom];
    starinforButton.frame = CGRectMake(6, 198, 65, 65);
    starinforButton.backgroundColor = [UIColor clearColor];
    [starinforButton addTarget:self action:@selector(starinforButton:) forControlEvents:UIControlEventTouchUpInside];
    starinforButton.tag = indexPath.row;
    [cell.contentView addSubview:starinforButton];
    return cell;
}
- (void)starinforButton:(UIButton *)sender{
    
    StarInfo *starInfo =[self.starUserMArray objectAtIndex:sender.tag];
        [UserInfoManager shareUserInfoManager].tempStarInfo = starInfo;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:[NSNumber numberWithInteger:starInfo.userId] forKey:@"userid"];
    [self pushCanvas:PersonInfo_Canvas withArgument:param];
    
    RecommendCell* cell = (RecommendCell*)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:sender.tag inSection:0]  ];
    
     [UserInfoManager shareUserInfoManager].tempHederImage = cell.adPhoto.image;
    
}
#pragma mark -UITableViewDelegate
- (void)baseTableView:(BaseTableView *)baseTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedStarUser = [self.starUserMArray objectAtIndex:indexPath.row];
    [AppDelegate shareAppDelegate].isSelfWillLive = NO;
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:self.selectedStarUser.userId],@"staruserid",NSStringFromClass([self class]),@"className",nil];
    

    [self pushCanvas:LiveRoom_CanVas withArgument:param];
}

- (CGFloat)baseTableView:(BaseTableView *)baseTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [RecommendCell height];
}

#pragma mark - RecommendCellDelegate
- (void)recommendCell:(RecommendCell *)recommendCell attendStar:(StarInfo *)starInfo
{
    if (![AppInfo shareInstance].bLoginSuccess)
    {
        [self showNoticeInWindow:@"需要先登录哦"];
        return;
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInteger:starInfo.userId]forKey:@"staruserid"];
    
    __weak typeof(self) weakSelf = self;
    if (starInfo.attentionflag)
    {
        //取消关注
        DelAttentionModel *delAttentionModel = [[DelAttentionModel alloc] init];
        [delAttentionModel requestDataWithParams:dict success:^(id object) {
            __strong typeof(self) strongSelf = weakSelf;
            /*成功返回数据*/
            if (delAttentionModel.result == 0)
            {
                starInfo.attentionflag = NO;
                recommendCell.starInfo = starInfo;
                [strongSelf showNoticeInWindow:@"已取消对TA的关注"];
            }else if (delAttentionModel.code == 403){
                [[AppInfo shareInstance] loginOut];
                [self showOherTerminalLoggedDialog];
            }
            else
            {
//                EWPAlertView *alerView = [[EWPAlertView alloc] initWithTitle:delAttentionModel.title message:delAttentionModel.msg confirmBlock:^(id sender) {
//                    
//                } cancelBlock:nil];
//                [alerView show];
            }
        } fail:^(id object) {
      
        }];
    }
    else
    {
        //添加关注
        AddAttentModel *addAttentionModel = [[AddAttentModel alloc] init];
        [addAttentionModel requestDataWithMethod:AddAttention_Method params:dict success:^(id object) {
            __strong typeof(self) strongSelf = weakSelf;
            /*成功返回数据*/
            if (addAttentionModel.result == 0)
            {
                starInfo.attentionflag = YES;
                recommendCell.starInfo = starInfo;
                [strongSelf showNoticeInWindow:@"已成功关注TA"];
            }else if (addAttentionModel.code == 403){
                [[AppInfo shareInstance] loginOut];
                [self showOherTerminalLoggedDialog];
            }
            else
            {
                [strongSelf showNoticeInWindow:@"需要先登录哦"];
            }
            
        } fail:^(id object) {
            
        }];
    }
    
}

@end
