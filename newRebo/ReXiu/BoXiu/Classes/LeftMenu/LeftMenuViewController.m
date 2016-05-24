//
//  LeftMenuViewController.m
//  XiuBo
//
//  Created by Andy on 14-3-25.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "LeftMenuViewController.h"
#import "MainViewController.h"
#import "LeftMenuButton.h"
#import "UserInfoManager.h"
#import "StarCategoryViewController.h"
#import "GetOneLevelCategoryModel.h"
#import "LeftMenuCell.h"
#import "GetTwoLevelCategoryModel.h"
#import "GetUserInfoModel.h"

#import "FirstRechargeModel.h"
#import "CanShowOnMobile.h"
#import "LiveProtocolViewController.h"

@interface LeftMenuViewController ()<BaseTableViewDataSoure,BaseTableViewDelegate,LeftMenuCellDelegate>

@property (nonatomic,strong) UILabel *nick;             /**<姓名标签*/
@property (nonatomic,strong) UIImageView *headImgView;  /**<头像*/
@property (nonatomic,strong) UILabel *coinCountLable;   /**<热币*/

@property (nonatomic,strong) NSMutableArray *menuDataMArray;    /**<菜单数据数组*/

@property (nonatomic,strong) NSMutableArray *menuTitles;        /**<菜单标题数组*/

@property (nonatomic,strong) NSMutableArray *normalImgUrls;

@property (nonatomic,strong) UINavigationController *rechargenavgationController;

@property (nonatomic,strong) EWPButton *livingButton;

@end

@implementation LeftMenuViewController

- (void)dealloc
{
    [[AppInfo shareInstance] removeObserver:self forKeyPath:@"hideSwitch"];
//    [[AppInfo shareInstance] removeObserver:self forKeyPath:@"bLoginSuccess" context:nil];
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
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.view.backgroundColor = [UIColor clearColor];
    int nYOffset = 20;
    int nXOffset = 0;
    
    UIView *userInfoView = [[UIView alloc] initWithFrame:CGRectMake(nXOffset, nYOffset, 192, 169)];
    [self.view addSubview:userInfoView];
    UITapGestureRecognizer *tapUserInfoGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showUserInfo)];
    [userInfoView addGestureRecognizer:tapUserInfoGestureRecognizer];
    
    UIImageView *headBKView = [[UIImageView alloc] initWithFrame:CGRectMake(80, 32, 64, 64)];
    headBKView.image = [UIImage imageNamed:@"leftHead"];
    [userInfoView addSubview:headBKView];
    
    _headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 54, 54)];
    _headImgView.layer.masksToBounds = YES;
    _headImgView.layer.cornerRadius = 27.0f;
    [headBKView addSubview:_headImgView];
    
    _nick = [[UILabel alloc] init];
    _nick.frame = CGRectMake(18, 105, 192, 20);
    _nick.textAlignment = NSTextAlignmentCenter;
    _nick.font = [UIFont systemFontOfSize:16.0f];
    _nick.textColor = [CommonFuction colorFromHexRGB:@"ffffff"];
    _nick.text = [NSString stringWithFormat:@"%@",[UserInfoManager shareUserInfoManager].currentUserInfo.nick];
    [userInfoView addSubview:_nick];
    
    _coinCountLable = [[UILabel alloc] initWithFrame:CGRectMake(18, 127, 192, 20)];
    _coinCountLable.textAlignment = NSTextAlignmentCenter;
    _coinCountLable.font = [UIFont systemFontOfSize:12.0f];
    _coinCountLable.text = [NSString stringWithFormat:@"热币：%lld",[UserInfoManager shareUserInfoManager].currentUserInfo.coin];
    _coinCountLable.textColor = [CommonFuction colorFromHexRGB:@"ffffff"];
    [userInfoView addSubview:_coinCountLable];
    
    UIImageView *hLineImgeView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 160, 200, 0.5)];
    hLineImgeView.backgroundColor = [UIColor whiteColor];
    [userInfoView addSubview:hLineImgeView];
    
    nYOffset += 169;
    nYOffset += 5;
    
    self.tableView.frame = CGRectMake(nXOffset, nYOffset, self.view.frame.size.width, self.view.frame.size.height - nYOffset);
    self.tableView.baseDataSource = self;
    self.tableView.baseDelegate = self;
    self.tableView.loadMore = NO;
    self.tableView.refresh = NO;
    self.tableView.bounces = NO;
    self.tableView.delaysContentTouches = NO;
    
    //    //我要直播
    //    EWPButton *liveBtn = [[EWPButton alloc] initWithFrame:CGRectMake(nXOffset + 10,self.view.bounds.size.height - 200, 120 , 50)];
    //我要直播
    EWPButton *liveBtn = [[EWPButton alloc] initWithFrame:CGRectMake(nXOffset + 10,SCREEN_HEIGHT - 55, 120 , 50)];
    liveBtn.backgroundColor = [UIColor clearColor];
    [liveBtn setTitle:@"     我要开播" forState:UIControlStateNormal];
    liveBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [liveBtn setImage:[UIImage imageNamed:@"leftLiving11"] forState:UIControlStateNormal];
    [liveBtn setTitleColor:[CommonFuction colorFromHexRGB:@"ffffff"] forState:UIControlStateNormal];
    NSString *iphone = [AppInfo getMachineName];
    if (![iphone isEqualToString :@"iPhone 4S (A1387/A1431)"] && ![iphone isEqualToString:@"iPhone 4 (A1349)" ] && ![iphone isEqualToString:@"iPhone 4 (A1332)"])
    {
        [self.view addSubview:liveBtn];
        
    }
    liveBtn.hidden = YES;
    self.livingButton = liveBtn;
    liveBtn.buttonBlock = ^(id sender)
    {
        
        __block CanShowOnMobile *model = [[CanShowOnMobile alloc] init];
        [self requestDataWithAnalyseModel:[CanShowOnMobile class] params:nil success:^(id object) {
            model = object;
            if (model.code == 1   )
            {
                [AppDelegate shareAppDelegate].showingLeftMenu = YES;
                Class viewControllerType = NSClassFromString(LiveRoom_CanVas);
                UIViewController *viewController = [[viewControllerType alloc] init];
                [viewController setValue:@([UserInfoManager shareUserInfoManager].currentUserInfo.userId) forKey:@"staruserid"];
                //                NSDictionary *param = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:[UserInfoManager shareUserInfoManager].currentUserInfo.userId] forKey:@"staruserid"];
                //                ;
                //                [self.rootViewController pushCanvas:LiveRoom_CanVas withArgument:param];
                [self pushViewController:viewController];
                
            }
            else if (model.code == 3)
            {
                [AppDelegate shareAppDelegate].showingLeftMenu = YES;
                LiveProtocolViewController *vc = [[LiveProtocolViewController alloc] init];
                [self pushViewController:vc];
            }  else if(model.code == 2)
            {
                
                [self showNoticeInWindow:@"手机直播未开启" duration:2.0];
            }  else if(model.code == 4)
            {
                
                [self showNoticeInWindow:@"你已经在开播了，不允许重复开播" duration:2.0];
            }  else if(model.code == 5)
            {
                
                [self showNoticeInWindow:@"你已被禁止手机直播" duration:2.0];
            }else{
                
                if (model.code == 403)
                {
                    [[AppInfo shareInstance] loginOut];
                    [self showOherTerminalLoggedDialog];
                    
                    return ;
                }
            }
            if (model.title && [model.title isEqualToString:@"用户没有登陆！"]){
                [[AppInfo shareInstance] loginOut];
                [self showNoticeInWindow:@"用户没有登陆！" duration:2.0];
            }
            
            
            
        } fail:^(id object) {
            
        }];
        
    };
    
    UIView *setview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 65, 65)];
    setview.backgroundColor = [UIColor clearColor];
    [userInfoView addSubview:setview];
    UITapGestureRecognizer *setinfor = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(setinfor)];
    [setview addGestureRecognizer:setinfor];
    
    EWPButton *settingBtn = [[EWPButton alloc] initWithFrame:CGRectMake(nXOffset, 10, 90, 40)];
    [settingBtn setTitle:@"  设置" forState:UIControlStateNormal];
    [settingBtn setImage:[UIImage imageNamed:@"leftSetting"] forState:UIControlStateNormal];
    settingBtn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    [settingBtn setTitleColor:[CommonFuction colorFromHexRGB:@"ffffff"] forState:UIControlStateNormal];
    [setview addSubview: settingBtn];
    settingBtn.buttonBlock = ^(id sender)
    {
        
            [AppDelegate shareAppDelegate].showingLeftMenu = YES;
            Class viewControllerType = NSClassFromString(Setting_Canvas);
            UIViewController *viewController = [[viewControllerType alloc] init];
            [self pushViewController:viewController];


    };
    
    [[AppInfo shareInstance] addObserver:self forKeyPath:@"hideSwitch" options:NSKeyValueObservingOptionNew context:nil];
//    [[AppInfo shareInstance] addObserver:self forKeyPath:@"bLoginSuccess" options:NSKeyValueObservingOptionNew context:nil];
    [[AppInfo shareInstance] addObserver:self forKeyPath:@"bShowLivingButton" options:NSKeyValueObservingOptionNew context:nil];
    
    [self loadMenu];
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ShowLiveBtnOnMobile:) name:@"ShowLiveBtnOnMobile" object:nil];
}
-(void)ShowLiveBtnOnMobile:(NSNotification*)noti{
    if ([[noti.userInfo valueForKey:@"bool"]integerValue]) {
        self.livingButton.hidden = NO;
    }else{
        self.livingButton.hidden = YES;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[AppInfo shareInstance] updateLivingButton];
    
    [[AppInfo shareInstance]refreshCurrentUserInfo:^{
        if ([AppInfo shareInstance].bLoginSuccess)
        {
            self.nick.text = [UserInfoManager shareUserInfoManager].currentUserInfo.nick;
            self.coinCountLable.text = [NSString stringWithFormat:@"热币：%lld",[UserInfoManager shareUserInfoManager].currentUserInfo.coin];
            NSString *url = [NSString stringWithFormat:@"%@%@",[AppInfo shareInstance].res_server,[UserInfoManager shareUserInfoManager].currentUserInfo.photo];
            
            [self.headImgView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil];
        }
        else
        {
            self.coinCountLable.text = @"热币：0";
            _nick.text = @"游客";
        }

    }];
    //    self.livingButton.hidden = ![AppInfo shareInstance].bShowLivingButton;
    //    self.livingButton.hidden = NO;
    
    
}
- (void)argumentForCanvas:(id)argumentData
{
    EWPLog(@"BaseCanvas argumentForCanvas");
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (![AppInfo shareInstance].bLoginSuccess && [AppInfo shareInstance].bFirstExitFromSetting)
    {
        [AppInfo shareInstance].bFirstExitFromSetting = NO;
        [[AppDelegate shareAppDelegate] performSelector:@selector(showHomeView) withObject:nil];
    }
}

- (void)setinfor
{
    [AppDelegate shareAppDelegate].showingLeftMenu = YES;
    Class viewControllerType = NSClassFromString(Setting_Canvas);
    UIViewController *viewController = [[viewControllerType alloc] init];
    [self pushViewController:viewController];
    
}

- (void)showUserInfo
{
    //如果已登录则跳转到跟人信息界面，否则登录界面
    BOOL bLoginSuccess= [AppInfo shareInstance].bLoginSuccess;
    Class viewControllerType = nil;
    if (bLoginSuccess)
    {
        viewControllerType = NSClassFromString(PersonInfo_Canvas);
    }
    else
    {
        
        viewControllerType = NSClassFromString(Login_Canvas);
    }
    UIViewController *viewController = [[viewControllerType alloc] init];
    [self pushViewController:viewController];
    [AppDelegate shareAppDelegate].showingLeftMenu = YES;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)loadMenu
{
    if (_menuDataMArray == nil)
    {
        _menuDataMArray = [NSMutableArray array];
    }
    [_menuDataMArray removeAllObjects];
    
    [self loadLocalMenu];
    [self.tableView reloadData];
}

- (void)loadLocalMenu
{
    //上线之前去掉活动，商城，充值换成appstore
    _menuTitles = [NSMutableArray arrayWithObjects:Rank_Title,Activity_Title,Market_Title,Recharge_Title,Invite_friends, nil];
    _normalImgUrls = [NSMutableArray arrayWithObjects:@"leftRank_normal",@"leftActivity_normal",@"leftMarket_normal",@"leftRecharge_normal",@"Invite_friend@2x",nil];
    
    for (int nIndex = 0; nIndex < [_menuTitles count]; nIndex++)
    {
        MenuData *menuData = [[MenuData alloc] init];
        menuData.normalImg = [UIImage imageNamed:[_normalImgUrls objectAtIndex:nIndex]];
        menuData.menuTitle = [_menuTitles objectAtIndex:nIndex];
        menuData.menuId = nIndex;
        [self.menuDataMArray addObject:menuData];
    }
    
        NSInteger hideSwitch = [[[AppInfo shareInstance].hideSwitch substringFromIndex:1] integerValue];
        if (hideSwitch == 1)
        {
            [self.menuDataMArray removeObjectAtIndex:1];
            [self.menuDataMArray removeObjectAtIndex:1];
        }
    
         hideSwitch = [[[AppInfo shareInstance].hideSwitch substringToIndex:1] integerValue];
        if (hideSwitch == 1)
        {
            [self.menuDataMArray removeLastObject];
        }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:@"bLoginSuccess"])
    {
        BOOL bLoginSuccess = [[change objectForKey:NSKeyValueChangeNewKey] boolValue];
        if (bLoginSuccess)
        {
            self.nick.text = [UserInfoManager shareUserInfoManager].currentUserInfo.nick;
            self.coinCountLable.text = [NSString stringWithFormat:@"热币：%lld",[UserInfoManager shareUserInfoManager].currentUserInfo.coin];
            NSString *url = [NSString stringWithFormat:@"%@%@",[AppInfo shareInstance].res_server,[UserInfoManager shareUserInfoManager].currentUserInfo.photo];
            [self.headImgView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil];
        }
        else
        {
            self.headImgView.image = nil;
            self.coinCountLable.text = @"热币：0";
            _nick.text = @"游客";
            
        }
        [self.view setNeedsDisplay];
    }
    else if ([keyPath isEqualToString:@"hideSwitch"])
    {
        NSInteger hideSwitch = [[[AppInfo shareInstance].hideSwitch substringFromIndex:1] integerValue];
        if (hideSwitch == 2)
        {
            MenuData *menuData = [[MenuData alloc] init];
            menuData.normalImg = [UIImage imageNamed:[_normalImgUrls objectAtIndex:1]];
            menuData.menuTitle = [_menuTitles objectAtIndex:1];
            menuData.menuId = 1;
            [self.menuDataMArray insertObject:menuData atIndex:1];
            
            menuData = [[MenuData alloc] init];
            menuData.normalImg = [UIImage imageNamed:[_normalImgUrls objectAtIndex:2]];
            menuData.menuTitle = [_menuTitles objectAtIndex:2];
            menuData.menuId = 2;
            [self.menuDataMArray insertObject:menuData atIndex:2];
        }
        
        hideSwitch = [[[AppInfo shareInstance].hideSwitch substringToIndex:1] integerValue];
        if (hideSwitch == 2)
        {
            MenuData *menuData = [[MenuData alloc] init];
            menuData.normalImg = [UIImage imageNamed:[_normalImgUrls lastObject]];
            menuData.menuTitle = [_menuTitles lastObject];
            menuData.menuId = self.menuDataMArray.count;
            [self.menuDataMArray addObject:menuData];
        }
        
        [self.tableView reloadData];
        
    }
    else if ([keyPath isEqualToString:@"bShowLivingButton"])
    {
        self.livingButton.hidden = ![AppInfo shareInstance].bShowLivingButton;
    }
    
}

#pragma mark -BaseTableCanvasDataSoure
- (NSInteger)numberOfSectionsInBaseTableView:(BaseTableView *)baseTableView
{
    return 1;
}

- (NSInteger)baseTableView:(BaseTableView *)baseTableView numberOfRowsInSection:(NSInteger)section
{
    return [self.menuDataMArray count];
}

- (UITableViewCell *)baseTableView:(BaseTableView *)baseTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier =  @"cellIdentifier";
    LeftMenuCell *cell = [baseTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[LeftMenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        cell.delegate = self;
        
    }
    
    MenuData *menuData = [self.menuDataMArray objectAtIndex:indexPath.row];
    cell.menuData = menuData;
    return cell;
}

#pragma mark -UITableViewDelegate
- (void)baseTableView:(BaseTableView *)baseTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGFloat)baseTableView:(BaseTableView *)baseTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 43.0f;
}

#pragma mark - LeftMenuDelegate
- (void)didSelectLeftMenu:(LeftMenuCell *)leftMenu
{
    [AppDelegate shareAppDelegate].showingLeftMenu = YES;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:leftMenu];
    
    Class viewControllerType = nil;
    MenuData *menuData = [self.menuDataMArray objectAtIndex:indexPath.row];
    if([menuData.menuTitle isEqualToString:Rank_Title])
    {
        viewControllerType = NSClassFromString(Rank_Canvas);
    }
    else if([menuData.menuTitle isEqualToString:Activity_Title])
    {
        viewControllerType = NSClassFromString(Activity_Canvas);
    }
    else if([menuData.menuTitle isEqualToString:Market_Title])
    {
        viewControllerType = NSClassFromString(Mall_Canvas);
    }
    else if([menuData.menuTitle isEqualToString:Recharge_Title])
    {
        if (![AppInfo shareInstance].bLoginSuccess)
        {
            if ([self showLoginDialog])
            {
                return;
            }
        }
        NSInteger hideSwitch = [[[AppInfo shareInstance].hideSwitch substringToIndex:1] integerValue];
        if (hideSwitch == 1)
        {
            viewControllerType = NSClassFromString(AppStore_Recharge_Canvas);
        }
        else
        {
            
            viewControllerType = NSClassFromString(SelectModePay_Canvas);
        }
    }
    else if ([menuData.menuTitle isEqualToString:Invite_friends])
    {
        viewControllerType = NSClassFromString(Invite_Canvas);
        
    }
    UIViewController *viewController = [[viewControllerType alloc] init];
    [self pushViewController:viewController];
    
}

- (void)pushViewController:(UIViewController *)viewController
{
    [[AppDelegate shareAppDelegate].lrSliderMenuViewController closeSliderMenu];
    [[AppDelegate shareAppDelegate].navigationController pushViewController:viewController animated:YES];
}
@end
