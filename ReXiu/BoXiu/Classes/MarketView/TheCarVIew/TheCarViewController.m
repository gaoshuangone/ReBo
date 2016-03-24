 //
//  TheCarViewController.m
//  BoXiu
//
//  Created by tongmingyu on 14-8-29.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "TheCarViewController.h"
#import "TheCarModel.h"
#import "TheCarCell.h"
#import "UserInfoManager.h"
#import "CarOrderModel.h"
#import "MallViewController.h"

@interface TheCarViewController () <BaseTableViewDelegate,BaseTableViewDataSoure,TheCarCellDelegate>

@property (nonatomic, strong) MallCarData *mallCarData;

@property (nonatomic, strong) NSMutableArray *carDataArray;

@property (nonatomic,strong) EWPSimpleDialog *buyDialog;
@property (nonatomic,strong) MallCarData *readyBuyCarData;
@property (nonatomic,strong) UITextField *monthNum;
@end

@implementation TheCarViewController

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
    
    if (_carDataArray == nil)
    {
        _carDataArray = [NSMutableArray array];
    }
    [_carDataArray removeAllObjects];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInt:1] forKey:@"pageIndex"];
    [dict setObject:[NSNumber numberWithInt:Count_Per_Page] forKey:@"pageSize"];
    [self requestDataWithAnalyseModel:[TheCarModel class] params:dict success:^(id object)
     {
         /*成功返回数据*/
         TheCarModel *model = object;
         
         self.tipLabel.hidden = YES;
         self.networkview.hidden = YES;
         
         if (model.result == 0)
         {
             [_carDataArray addObjectsFromArray:model.CarMarray];
             
             [self.tableView reloadData];
         }else if (model.code == 403){
             [self showOherTerminalLoggedDialog];
         }
         else
         {
             [self showNoticeInWindow:model.msg];
         }
     }
    fail:^(id object)
     {
         self.tipLabel.hidden = NO;
         self.networkview.hidden = NO;
         /*失败返回数据*/
     }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"rankBg"]];
//    self.view.backgroundColor  = [UIColor whiteColor];
    self.tableView.frame = CGRectMake(0, 5, self.view.frame.size.width, SCREEN_HEIGHT - 64-40);
    self.tableView.baseDelegate = self;
    self.tableView.baseDataSource = self;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.refresh = NO;
    self.loadMore = NO;
}

-(void)loadMorData
{
    if (_carDataArray == nil)
    {
        _carDataArray = [NSMutableArray array];
    }
    [_carDataArray removeAllObjects];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInteger:self.tableView.curentPage + 1] forKey:@"pageIndex"];
    [dict setObject:[NSNumber numberWithInteger:Count_Per_Page] forKey:@"pageSize"];
    [self requestDataWithAnalyseModel:[TheCarModel class] params:dict success:^(id object)
     {
         /*成功返回数据*/
         TheCarModel *model = object;
         self.tipLabel.hidden = YES;
         self.networkview.hidden = YES;
         if (model.result == 0)
         {
             [_carDataArray addObjectsFromArray:model.CarMarray];
             [self.tableView reloadData];
         }else if (model.code == 403){
             [self showOherTerminalLoggedDialog];
         }
         else
         {
             [self showNoticeInWindow:model.msg];
         }
     }
    fail:^(id object)
     {
         self.tipLabel.hidden = NO;
         self.networkview.hidden = NO;
         /*失败返回数据*/
     }];
}

#pragma mark - UITalbeViewDataSurce

- (NSInteger)baseTableView:(BaseTableView *)baseTableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger nCount = 0;
    if (self.carDataArray && [self.carDataArray count])
    {
        nCount = self.carDataArray.count;
    }
    return nCount;
}

- (NSInteger)numberOfSectionsInBaseTableView:(BaseTableView *)baseTableView
{
    return 1;
}

- (UITableViewCell *)baseTableView:(BaseTableView *)baseTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *generaCellIdentifier =  @"GeneraCellIdentifier";
    TheCarCell *theCarCell = [baseTableView dequeueReusableCellWithIdentifier:generaCellIdentifier];
    if (theCarCell == nil)
    {
        theCarCell = [[TheCarCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:generaCellIdentifier];
        theCarCell.delegate = self;
        theCarCell.backgroundColor = [UIColor clearColor];
        theCarCell.accessoryType = UITableViewCellAccessoryNone;
        theCarCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    MallCarData *mallCarData = [_carDataArray objectAtIndex:indexPath.row];
    theCarCell.carData = mallCarData;

    return  theCarCell;
}


#pragma mark - UITableViewDelegate

- (CGFloat)baseTableView:(BaseTableView *)baseTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return [TheCarCell height];
}



- (void)baseTableView:(BaseTableView *)baseTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{

}

#pragma mark - TheCarCellDelegate
- (void)buyCarWithData:(MallCarData *)carData
{
    self.readyBuyCarData = carData;
    [self showBuyCarDialog];
}

#pragma mark - ShowBuyCarDialog
- (void)showBuyCarDialog
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

    CGSize carNameSize = [CommonFuction sizeOfString:self.readyBuyCarData.carName maxWidth:200 maxHeight:25 withFontSize:17.0f];
    UIImageView *carLogo = [[UIImageView alloc] initWithFrame:CGRectMake(12, 13, 25, 25)];
    NSString *url = [NSString stringWithFormat:@"%@%@",[AppInfo shareInstance].res_server,self.readyBuyCarData.brandimg];
    [carLogo sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil];
    [_buyDialog addSubview:carLogo];
    
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(carLogo.frame.origin.x + carLogo.frame.size.width + 9, 18, carNameSize.width, carNameSize.height)];
    titleLable.font = [UIFont boldSystemFontOfSize:16.0f];
    titleLable.textColor = [CommonFuction colorFromHexRGB:@"454a4d"];
    titleLable.text = self.readyBuyCarData.carName;
    titleLable.textAlignment = NSTextAlignmentLeft;
    [_buyDialog addSubview:titleLable];
    
    carLogo.frame =CGRectMake ((270-carNameSize.width-25)/2 -5,15,25,25);
    titleLable.frame = CGRectMake(carLogo.frame.origin.x + carLogo.frame.size.width + 9, 18, carNameSize.width +5, carNameSize.height);
    
    UIImageView *hLineImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, 50, 240, 0.5)];
    hLineImg.backgroundColor = [CommonFuction colorFromHexRGB:@"e5e5e5"];
    [_buyDialog addSubview:hLineImg];

    UIImageView *carBKImg = [[UIImageView alloc] initWithFrame:CGRectMake(20, 98, 100, 20)];
    carBKImg.image = [UIImage imageNamed:@"carBK"];
    [_buyDialog addSubview:carBKImg];
    
    UIImageView *carImg = [[UIImageView alloc] initWithFrame:CGRectMake(32, 65, 74, 50)];
    url = [NSString stringWithFormat:@"%@%@",[AppInfo shareInstance].res_server,self.readyBuyCarData.carimg];
    [carImg sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil];
    [_buyDialog addSubview:carImg];
    
    CGSize coinSize = [CommonFuction sizeOfString:[NSString stringWithFormat:@"%lld",self.readyBuyCarData.coin] maxWidth:95 maxHeight:20 withFontSize:19.0f];
    
    NSString *unit = self.readyBuyCarData.timeunit==1 ? @"月" : @"年";
    CGSize unitSize = [CommonFuction sizeOfString:[NSString stringWithFormat:@"热币/%@",unit] maxWidth:50 maxHeight:20 withFontSize:14.0f];

    UILabel *coinNameLable = [[UILabel alloc] initWithFrame:CGRectMake(120, 70, coinSize.width, 20)];
    coinNameLable.textAlignment = NSTextAlignmentLeft;
    coinNameLable.font = [UIFont boldSystemFontOfSize:15.0f];
    coinNameLable.textColor = [CommonFuction colorFromHexRGB:@"f7c520"];
    coinNameLable.backgroundColor = [UIColor clearColor];
    coinNameLable.text = [NSString stringWithFormat:@"%lld",self.readyBuyCarData.coin];
    [coinNameLable sizeToFit];
    [_buyDialog addSubview:coinNameLable];
    
    UILabel *unitLabel = [[UILabel alloc] initWithFrame:CGRectMake(coinNameLable.frame.origin.x + coinNameLable.frame.size.width + 5, 70, unitSize.width, unitSize.height)];
    unitLabel.textAlignment = NSTextAlignmentLeft;
    unitLabel.font = [UIFont systemFontOfSize:12.0f];
    unitLabel.textColor = [CommonFuction colorFromHexRGB:@"959596"];
    unitLabel.backgroundColor = [UIColor clearColor];
    unitLabel.text = [NSString stringWithFormat:@"热币/%@",unit];
    [_buyDialog addSubview:unitLabel];

    UILabel *tipMonth = [[UILabel alloc] initWithFrame:CGRectMake(120, 94, 50, 20)];
    tipMonth.text = [NSString stringWithFormat:@"包%@",unit];
    tipMonth.font = [UIFont systemFontOfSize:14.0f];
    tipMonth.textColor = [CommonFuction colorFromHexRGB:@"454a4d"];
    [_buyDialog addSubview:tipMonth];
    
    UIButton *reduceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    reduceBtn.frame = CGRectMake(156, 92, 26, 26);
    reduceBtn.tag = 100;
    [reduceBtn setImage:[UIImage imageNamed:@"reduction"] forState:UIControlStateNormal];
    [reduceBtn setImage:[UIImage imageNamed:@"reduction_select"] forState:UIControlStateHighlighted];
    [reduceBtn addTarget:self action:@selector(changeNumber:) forControlEvents:UIControlEventTouchUpInside];
    [_buyDialog addSubview:reduceBtn];
    
    _monthNum = [[UITextField alloc] initWithFrame:CGRectMake(185, 95, 27, 19)];
    _monthNum.enabled = NO;
    _monthNum.backgroundColor = [UIColor clearColor];
    _monthNum.text = @"1";
    _monthNum.font = [UIFont systemFontOfSize:14.0f];
    _monthNum.textAlignment = NSTextAlignmentCenter;
    _monthNum.textColor = [CommonFuction colorFromHexRGB:@"575757"];
    [_buyDialog addSubview:_monthNum];
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(215, 92, 26, 26);
    addBtn.tag = 101;
    [addBtn setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [addBtn setImage:[UIImage imageNamed:@"add_select"] forState:UIControlStateHighlighted];
    [addBtn addTarget:self action:@selector(changeNumber:) forControlEvents:UIControlEventTouchUpInside];
    [_buyDialog addSubview:addBtn];
    
    
    UIImage *rechargeImg = [CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"d14c49"] size:CGSizeMake(149, 32)];
    UIImage *rechargeImgNOR = [CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"ffffff"] size:CGSizeMake(149, 32)];

    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    confirmBtn.frame = CGRectMake(61, 135, 149, 32);
    [confirmBtn setTitleColor:[CommonFuction colorFromHexRGB:@"d14c49"] forState:UIControlStateNormal];
    [confirmBtn setTitleColor:[CommonFuction colorFromHexRGB:@"ffffff"] forState:UIControlStateHighlighted];
    confirmBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    [confirmBtn setTitle:@"立即拥有" forState:UIControlStateNormal];
    confirmBtn.layer.cornerRadius = 16.0f;
    confirmBtn.layer.masksToBounds = YES;
    confirmBtn.layer.borderColor = [CommonFuction colorFromHexRGB:@"d14c49"].CGColor;
    confirmBtn.layer.borderWidth = 0.5;
    [confirmBtn setBackgroundImage:rechargeImg forState:UIControlStateHighlighted];
    [confirmBtn setBackgroundImage:rechargeImgNOR forState:UIControlStateNormal];
  
    [confirmBtn addTarget:self action:@selector(OnBuyCar:) forControlEvents:UIControlEventTouchUpInside];
    [_buyDialog addSubview:confirmBtn];
      [_buyDialog showInView:[UIApplication sharedApplication].keyWindow withColor:[UIColor blackColor] withAlpha:0.4];
}

- (void)closeDialog:(id)sender
{
    [_buyDialog hide];
}

- (void)OnBuyCar:(id)sender
{
    long long needCoin = self.readyBuyCarData.coin * [_monthNum.text integerValue];
    long long coin = [[UserInfoManager shareUserInfoManager] currentUserInfo].coin;
    if ([self showLoginDialog])
    {
           [_buyDialog hide];
        return;
    }
    if (coin >= needCoin)
    {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:[NSNumber numberWithInteger:self.readyBuyCarData.pid] forKey:@"goodid"];
        [dict setObject:[NSNumber numberWithInteger:[_monthNum.text integerValue]] forKey:@"goodsnum"];
     
        [self requestDataWithAnalyseModel:[CarOrderModel class] params:dict success:^(id object)
         {
             /*成功返回数据*/
             CarOrderModel *model = (CarOrderModel *)object;
             
             if (model.result == 0)
             {
                 [[AppInfo shareInstance] refreshCurrentUserInfo:^{
                     [self showNoticeInWindow:model.msg];
                     [_buyDialog hide];
                 }];

             }else if (model.code == 403){
                 [self showOherTerminalLoggedDialog];
                    [[AppInfo shareInstance] loginOut];
                    [_buyDialog hide];
             }
             else
             {
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
            [mallViewController showRechargeDialogWithClassStr:@"TheCarViewController"];
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
        _monthNum.text = [NSString stringWithFormat:@"%d",monthNum];
    }
    else
    {
        NSInteger monthNum = [_monthNum.text integerValue];
        monthNum++;
        _monthNum.text = [NSString stringWithFormat:@"%d",monthNum];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
