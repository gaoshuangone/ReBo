//
//  LiangViewController.m
//  BoXiu
//
//  Created by tongmingyu on 14-8-29.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "LiangViewController.h"
#import "LiangQueryModel.h"
#import "LiangSearchCell.h"
#import "UserInfoManager.h"
#import "BuyLiangModel.h"
#import "MallViewController.h"

@interface LiangViewController ()<UISearchBarDelegate,BaseTableViewDataSoure,BaseTableViewDelegate,LiangSearchCellDelegate>

@property (nonatomic, strong) UISearchBar *searchBar;

@property (nonatomic, strong) NSMutableArray *LiangMArray;
@property (nonatomic,strong) EWPSimpleDialog *buyDialog;
@property (nonatomic,strong) LiangData *readyBuyLiangData;
@property (nonatomic,strong) UITextField *monthNum;
@property (nonatomic,strong) UIControl *bkControl;
@end


@implementation LiangViewController

- (void)dealloc
{
    [self removeNotifyKeyBoard];
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

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self refreshData];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [_searchBar resignFirstResponder];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"rankBg"]];
    self.tableView.backgroundColor = [UIColor clearColor];
    
//    self.tipLabeltext.text = @"无相关结果";
    
    UIControl* control = [[UIControl alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 10+31)];
    control.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:control];
    
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(10,15,self.view.bounds.size.width - 20 ,31)];
    _searchBar.delegate = self;
    [_searchBar.layer setMasksToBounds:YES];
    [_searchBar.layer setCornerRadius:13];
    _searchBar.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    _searchBar.layer.borderColor = [UIColor whiteColor].CGColor;
    _searchBar.layer.borderWidth = 0.5;
    [_searchBar setImage:[UIImage imageNamed:@"searchSC"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    UITextField *txfSearchField = [_searchBar valueForKey:@"_searchField"];
    txfSearchField.placeholder = @"请输入靓号";
    txfSearchField.textColor = [UIColor grayColor];
    txfSearchField.font = [UIFont systemFontOfSize:13];
    txfSearchField.backgroundColor = [UIColor whiteColor];
    [txfSearchField setValue:[CommonFuction colorFromHexRGB:@"959596"] forKeyPath:@"_placeholderLabel.textColor"];
//    txfSearchField.backgroundColor = [UIColor clearColor];

    
    float version = [[[ UIDevice currentDevice ] systemVersion ] floatValue ];
    if ([ _searchBar respondsToSelector : @selector (barTintColor)]) {
        
        float  iosversion7_1 = 7.1 ;
        if (version >= iosversion7_1)
        {
            //iOS7.1
            [[[[ _searchBar.subviews objectAtIndex : 0] subviews ] objectAtIndex : 0] removeFromSuperview ];
            
            [ _searchBar setBackgroundColor :[ UIColor clearColor ]];
        }
        else
        {
            //iOS7.0
            [ _searchBar setBarTintColor :[ UIColor clearColor]];
            
            [ _searchBar setBackgroundColor :[ UIColor clearColor]];
        }
    }

    
    [self.view addSubview:_searchBar];
    
    self.tableView.frame = CGRectMake(0,60,self.view.bounds.size.width ,SCREEN_HEIGHT - 64 - 36 - 70);
    self.tableView.baseDataSource = self;
    self.tableView.baseDelegate = self;
    self.loadMore = NO;
    
    [self addNotifyKeyBoard];
}


#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    [self refreshData];
}

- (void)refreshData
{
    if (_LiangMArray == nil)
    {
        _LiangMArray = [NSMutableArray array];
    }
    [_LiangMArray removeAllObjects];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    if (_searchBar.text && [_searchBar.text length])
    {
        [dict setObject:[NSNumber numberWithInteger:[_searchBar.text integerValue]] forKey:@"idxcode"];
    }

    [dict setObject:[NSNumber numberWithInteger:1] forKey:@"pageIndex"];
    [dict setObject:[NSNumber numberWithInteger:Count_Per_Page] forKey:@"pageSize"];
    
    [self requestDataWithAnalyseModel:[LiangQueryModel class] params:dict success:^(id object)
     {
         /*成功返回数据*/
         LiangQueryModel *model = object;
         if (model.result == 0)
         {
             [_LiangMArray addObjectsFromArray:model.liangdataMarry];
             [self.tableView reloadData];
             if ([_LiangMArray count] ==0)
             {
                 self.tipLabel.hidden = NO;
             }
             else
             {
                 self.tipLabel.hidden = YES;
             }

         }
         else
         {
             [self.tableView reloadData];
             [self showNoticeInWindow:model.msg];
         }
     }
    fail:^(id object)
     {
         /*失败返回数据*/
         [self.tableView reloadData];
     }];
}

#pragma mark - baseTableView

-(void)loadMorData
{
    if (_LiangMArray == nil)
    {
        _LiangMArray = [NSMutableArray array];
    }
    [_LiangMArray removeAllObjects];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInteger:self.tableView.curentPage + 1] forKey:@"pageIndex"];
    [dict setObject:[NSNumber numberWithInteger:Count_Per_Page] forKey:@"pageSize"];
    [self requestDataWithAnalyseModel:[LiangQueryModel class] params:dict success:^(id object)
     {
         /*成功返回数据*/
         LiangQueryModel *model = object;
         
         if (model.result == 0)
         {
            [_LiangMArray addObjectsFromArray:model.liangdataMarry];
             [self.tableView reloadData];
         }
         else
         {
             [self.tableView reloadData];
             [self showNoticeInWindow:model.msg];
         }
     }
     fail:^(id object)
     {
         /*失败返回数据*/
        [self.tableView reloadData];
     }];
}


#pragma mark -BaseTableCanvasDataSoure
- (NSInteger)numberOfSectionsInBaseTableView:(BaseTableView *)baseTableView
{
    return 1;
}

- (NSInteger)baseTableView:(BaseTableView *)baseTableView numberOfRowsInSection:(NSInteger)section
{
    if (self.LiangMArray && [self.LiangMArray count])
    {
        NSInteger nCount = self.LiangMArray.count / 2 + ((self.LiangMArray.count % 2)? 1 : 0);
        return nCount;
    }
    return 0;
}

- (UITableViewCell *)baseTableView:(BaseTableView *)baseTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier =  @"cellIdentifier";
    LiangSearchCell *cell = [baseTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[LiangSearchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.delegate = self;
        cell.backgroundColor = [UIColor clearColor];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    if (_LiangMArray && [_LiangMArray count])
    {
        NSMutableArray *tempAry = [NSMutableArray array];
        NSInteger nIndex = indexPath.row * 2;
        NSInteger nCount = (self.LiangMArray.count - nIndex) >= 2? 2:(self.LiangMArray.count - nIndex);
        
        for (int i = 0; i < nCount; i++)
        {
            LiangData *liangData = [self.LiangMArray objectAtIndex:(nIndex + i)];
            [tempAry addObject:liangData];
        }
        
        cell.cellDataArray = tempAry;
    }
    
    return cell;
}

#pragma mark -UITableViewDelegate
- (void)baseTableView:(BaseTableView *)baseTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [baseTableView selectRowAtIndexPath:nil animated:NO scrollPosition:UITableViewScrollPositionNone];
    
}

- (CGFloat)baseTableView:(BaseTableView *)baseTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return [LiangSearchCell height];
}


- (void)didLiangIdxcodeCell:(LiangData *)liangData
{
    self.readyBuyLiangData = liangData;
    [self showBuyIdXcodeDialog];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - keyNotice
/*当键盘快要显示时调用*/
- (void)notifyShowKeyBoard:(NSNotification *)notification
{
    if (_bkControl == nil)
    {
        _bkControl = [[UIControl alloc] initWithFrame:CGRectMake(0, self.tableView.frame.origin.y, self.tableView.frame.size.width, self.tableView.frame.size.height)];
        _bkControl.alpha = 1;
        _bkControl.tag = 100;
        [_bkControl addTarget:self action:@selector(hideKeyBoard:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_bkControl];
    }
}

- (void)notifyHideKeyBoard:(NSNotification *)notification
{
    if (_bkControl)
    {
        //默认不做任何处理
        [_bkControl removeFromSuperview];
        _bkControl = nil;
    }

}

- (void)hideKeyBoard:(id)sender
{
    [_searchBar resignFirstResponder];
}

#pragma mark - ShowBuyCarDialog
- (void)showBuyIdXcodeDialog
{
    ViewController *viewController = (ViewController *)self.rootViewController;
    if ([viewController showLoginDialog])
    {
        return;
    }
    _buyDialog = [[EWPSimpleDialog alloc] initWithFrame:CGRectMake(0, 0, 270, 192)];
    _buyDialog.layer.borderColor = [UIColor whiteColor].CGColor;
    _buyDialog.backgroundColor = [UIColor whiteColor];
    _buyDialog.layer.cornerRadius = 4.0f;
    _buyDialog.layer.borderWidth = 1.0f;
    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(230, 8, 30, 30)];
    [closeBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeDialog:) forControlEvents:UIControlEventTouchUpInside];
    [_buyDialog addSubview:closeBtn];
    
    UIImageView *liangLogo = [[UIImageView alloc] initWithFrame:CGRectMake(15, 14, 22, 22)];
    liangLogo.image = [UIImage imageNamed:@"liangDialog"];
    [_buyDialog addSubview:liangLogo];
    
    UILabel *idXcodeLable = [[UILabel alloc] initWithFrame:CGRectMake(liangLogo.frame.origin.x + liangLogo.frame.size.width + 10, 15,200, 20)];
    idXcodeLable.font = [UIFont boldSystemFontOfSize:16.0f];
    idXcodeLable.textColor = [CommonFuction colorFromHexRGB:@"d14c49"];
    idXcodeLable.text = [NSString stringWithFormat:@"%ld",(long)self.readyBuyLiangData.Idxcode];
    idXcodeLable.textAlignment = NSTextAlignmentLeft;
    [_buyDialog addSubview:idXcodeLable];
    
    liangLogo.frame = CGRectMake((270 - 80 - 22)/2, 14, 22, 22);
    idXcodeLable.frame = CGRectMake(liangLogo.frame.origin.x + liangLogo.frame.size.width + 10, 15,200, 20);
    
    UIImageView *hLineImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, 50, 240, 1)];
    hLineImg.backgroundColor = [CommonFuction colorFromHexRGB:@"cbcbcb"];
    [_buyDialog addSubview:hLineImg];
    
    NSString *unit = nil;
    if (self.readyBuyLiangData.timeunit == 1)
    {
        unit = @"月";
    }
    else if (self.readyBuyLiangData.timeunit == 2)
    {
        unit = @"年";
    }
    else
    {
        unit = @"永久";
    }
    CGSize coinSize = [CommonFuction sizeOfString:[NSString stringWithFormat:@"%lld",self.readyBuyLiangData.coin] maxWidth:100 maxHeight:20 withFontSize:19.0f];
    CGSize unitSize = [CommonFuction sizeOfString:[NSString stringWithFormat:@"热币/%@",unit] maxWidth:80 maxHeight:20 withFontSize:14.0f];
    
    UILabel *coinNameLable = [[UILabel alloc] initWithFrame:CGRectMake(13, 65, coinSize.width  , 20)];
    coinNameLable.textAlignment = NSTextAlignmentRight;
    coinNameLable.font = [UIFont boldSystemFontOfSize:15.0f];
    coinNameLable.textColor = [CommonFuction colorFromHexRGB:@"f7c520"];
    coinNameLable.backgroundColor = [UIColor clearColor];
    coinNameLable.text = [NSString stringWithFormat:@"%lld",self.readyBuyLiangData.coin];
    [_buyDialog addSubview:coinNameLable];
    
    UILabel *unitLabel = [[UILabel alloc] initWithFrame:CGRectMake(coinNameLable.frame.origin.x + coinNameLable.frame.size.width , 65, unitSize.width, unitSize.height)];
    unitLabel.textAlignment = NSTextAlignmentLeft;
    unitLabel.font = [UIFont systemFontOfSize:14.0f];
    unitLabel.textColor = [CommonFuction colorFromHexRGB:@"575757"];
    unitLabel.backgroundColor = [UIColor clearColor];
    unitLabel.text = [NSString stringWithFormat:@"热币/%@",unit];
    [_buyDialog addSubview:unitLabel];
    
    if (self.readyBuyLiangData.timeunit != 10)
    {
        UILabel *tipMonth = [[UILabel alloc] initWithFrame:CGRectMake(20, 90, 50, 20)];
        tipMonth.text = [NSString stringWithFormat:@"包%@",unit];
        tipMonth.font = [UIFont systemFontOfSize:14.0f];
        tipMonth.textColor = [CommonFuction colorFromHexRGB:@"575757"];
        [_buyDialog addSubview:tipMonth];
        
        UIButton *reduceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        reduceBtn.frame = CGRectMake(55, 88, 26, 26);
        reduceBtn.tag = 100;
        [reduceBtn setImage:[UIImage imageNamed:@"reduction"] forState:UIControlStateNormal];
        [reduceBtn setImage:[UIImage imageNamed:@"reduction_select"] forState:UIControlStateHighlighted];
        [reduceBtn addTarget:self action:@selector(changeNumber:) forControlEvents:UIControlEventTouchUpInside];
        [_buyDialog addSubview:reduceBtn];
        
        _monthNum = [[UITextField alloc] initWithFrame:CGRectMake(84, 91, 38, 19)];
        _monthNum.enabled = NO;
        _monthNum.backgroundColor = [UIColor clearColor];
        _monthNum.text = @"1";
        _monthNum.font = [UIFont systemFontOfSize:14.0f];
        _monthNum.textAlignment = NSTextAlignmentCenter;
        _monthNum.textColor = [CommonFuction colorFromHexRGB:@"575757"];
        [_buyDialog addSubview:_monthNum];
        
        UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        addBtn.frame = CGRectMake(126, 87, 26, 26);
        addBtn.tag = 101;
        [addBtn setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
        [addBtn setImage:[UIImage imageNamed:@"add_select"] forState:UIControlStateHighlighted];
        [addBtn addTarget:self action:@selector(changeNumber:) forControlEvents:UIControlEventTouchUpInside];
        [_buyDialog addSubview:addBtn];
    }
    
    UIImage *rechargeImg = [CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"d14c49"] size:CGSizeMake(68, 25)];
    UIImage *rechargeImgNOR = [CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"ffffff"] size:CGSizeMake(68, 25)];
    
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    
    confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmBtn setTitleColor:[CommonFuction colorFromHexRGB:@"d14c49"] forState:UIControlStateNormal];
    [confirmBtn setTitleColor:[CommonFuction colorFromHexRGB:@"ffffff"] forState:UIControlStateHighlighted];
    [confirmBtn setTitle:@"立即拥有" forState:UIControlStateNormal];
    confirmBtn.titleLabel.font = [UIFont boldSystemFontOfSize:12.0f];
    confirmBtn.layer.cornerRadius = 16.0;
    [confirmBtn setBackgroundImage:rechargeImgNOR forState:UIControlStateNormal];
    [confirmBtn setBackgroundImage:rechargeImg forState:UIControlStateHighlighted];
    confirmBtn.layer.masksToBounds = YES;
    confirmBtn.layer.borderColor =[CommonFuction colorFromHexRGB:@"d14c49"].CGColor;
    confirmBtn.layer.borderWidth = 0.5;
    [confirmBtn addTarget:self action:@selector(OnBuyIdXcode:) forControlEvents:UIControlEventTouchUpInside];
    confirmBtn.frame = CGRectMake(61, 135, 149, 32);
    [_buyDialog addSubview:confirmBtn];
      [_buyDialog showInView:[UIApplication sharedApplication].keyWindow withColor:[UIColor blackColor] withAlpha:0.4];
}

- (void)closeDialog:(id)sender
{
    [_buyDialog hide];
}

- (void)OnBuyIdXcode:(id)sender
{
    long long needCoin = self.readyBuyLiangData.coin * [_monthNum.text integerValue];
    long long coin = [[UserInfoManager shareUserInfoManager] currentUserInfo].coin;
    if ([self showLoginDialog])
    {
           [_buyDialog hide];
        return;
    }
    if (coin >= needCoin)
    {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:[NSNumber numberWithInteger:self.readyBuyLiangData.pid] forKey:@"idxcodeid"];
        [dict setObject:[NSNumber numberWithInteger:[_monthNum.text integerValue]] forKey:@"buynum"];
    
        [self requestDataWithAnalyseModel:[BuyLiangModel class] params:dict success:^(id object)
         {
             /*成功返回数据*/
             BuyLiangModel *model = object;
             
             if (model.result == 0)
             {
                 [[AppInfo shareInstance]refreshCurrentUserInfo:^{
                     [self showNoticeInWindow:model.msg];
                     [_buyDialog hide];
                     [self performSelector:@selector(refreshData)];
                 }];
             }else if (model.code == 403){
                 [self showOherTerminalLoggedDialog];
                    [[AppInfo shareInstance] loginOut];
                    [_buyDialog hide];
             }

             else
             {
                 [_buyDialog hide];
                 [self showNoticeInWindow:model.msg];
             }
         }
        fail:^(id object)
         {
             /*失败返回数据*/
         }];
    }
    else
    {
        if (self.rootViewController)
        {
            [_buyDialog hide];
            MallViewController *mallViewController = (MallViewController *)self.rootViewController;
                 [mallViewController showRechargeDialogWithClassStr:@"LiangViewController"];
        }
        else
        {
            [self showNoticeInWindow:@"余额不足，请充值后购买"];
        }
    }
    
}

- (void)changeNumber:(id)sender
{
    UIButton *button = (UIButton *)sender;
    if (button.tag == 100)
    {
        NSInteger monthNum = [_monthNum.text integerValue];
        if (monthNum == 1)
        {
            return;
        }
        monthNum--;
        _monthNum.text = [NSString stringWithFormat:@"%ld",(long)monthNum];
    }
    else
    {
        NSInteger monthNum = [_monthNum.text integerValue];
        monthNum++;
        _monthNum.text = [NSString stringWithFormat:@"%ld",(long)monthNum];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
