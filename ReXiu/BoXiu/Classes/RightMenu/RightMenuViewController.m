//
//  RightMenuViewController.m
//  XiuBo
//
//  Created by Andy on 14-3-25.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "RightMenuViewController.h"
#import "AppDelegate.h"
#import "AppInfo.h"
#import "UserInfoManager.h"
#import "RechargeViewController.h"
#import "FirstRechargeModel.h"
#import "LeftMenuButton.h"
#import "UIImageView+WebCache.h"

@interface RightMenuViewController ()
@property (nonatomic,strong) UIImageView *headImgView;
@property (nonatomic,strong) UILabel *nick;

@property (nonatomic,strong) UIView *coinCountCell;
@property (nonatomic,strong) UILabel *coinCountLable;
@property (nonatomic,strong) UIImageView *firstRechargeImg;

@end

@implementation RightMenuViewController

- (void)dealloc
{
     [[AppDelegate shareAppDelegate].lrSliderMenuViewController removeObserver:self forKeyPath:@"RightMenuShowing" context:nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    
    int nYOffset = 50;
    int nXOffset = 130;
    
    UIView *userInfoView = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 220, 90)];
    [self.view addSubview:userInfoView];
    UITapGestureRecognizer *tapUserInfoGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showUserInfo)];
    [userInfoView addGestureRecognizer:tapUserInfoGestureRecognizer];
    
    _headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(80+55, 0, 70, 70)];
    _headImgView.image = [UIImage imageNamed:@"right_head"];
    _headImgView.layer.borderColor = [UIColor whiteColor].CGColor;
    _headImgView.layer.borderWidth = 2;
    [userInfoView addSubview:_headImgView];
    _nick = [[UILabel alloc] initWithFrame:CGRectMake(80, 70+5, 180, 20)];
    _nick.textAlignment = NSTextAlignmentCenter;
    _nick.font = [UIFont systemFontOfSize:15.0f];
    _nick.textColor = [UIColor brownColor];
    _nick.text = @"登录/注册";
    [userInfoView addSubview:_nick];
     nYOffset += 95;
    
    _coinCountLable = [[UILabel alloc] initWithFrame:CGRectMake(80, 95, 180, 20)];
    _coinCountLable.textAlignment = NSTextAlignmentCenter;
    _coinCountLable.font = [UIFont systemFontOfSize:15.0f];
    _coinCountLable.text = [NSString stringWithFormat:@"%lld热币",[UserInfoManager shareUserInfoManager].currentUserInfo.coin];
    _coinCountLable.textColor = [UIColor redColor];
    [userInfoView addSubview:_coinCountLable];
    nYOffset += 20;

    //充值 设置
    UIView *viewAction = [[UIView alloc] initWithFrame:CGRectMake(nXOffset,nYOffset,190,80)];
    [self.view addSubview:viewAction];
    
    UIButton *buttonRecharge = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonRecharge.frame = CGRectMake(0,20,viewAction.bounds.size.width/2,40);
    [buttonRecharge setTitle:@"  充值" forState:UIControlStateNormal];
    [buttonRecharge setImage:[UIImage imageNamed:@"right_recharge_normal"] forState:UIControlStateNormal];
    [buttonRecharge setImage:[UIImage imageNamed:@"right_recharge_high"] forState:UIControlStateHighlighted];
    [buttonRecharge addTarget:self action:@selector(OnRecharge) forControlEvents:UIControlEventTouchUpInside];
    buttonRecharge.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [buttonRecharge setTitleColor:[UIColor colorWithRed:74.0f/255.0f green:48.0f/255.0f blue:21.0f/255.0f alpha:0.5] forState:UIControlStateNormal];
    [viewAction addSubview:buttonRecharge];
    
    _firstRechargeImg = [[UIImageView alloc] initWithFrame:CGRectMake(20,50, 64, 16)];
    _firstRechargeImg.image = [UIImage imageNamed:@"firstRecharge.png"];
    [viewAction addSubview:_firstRechargeImg];
    
    UIView *seperateView = [[UIView alloc] initWithFrame:CGRectMake(viewAction.bounds.size.width/2, 20, 1, 40)];
    seperateView.backgroundColor = [UIColor lightGrayColor];
    [viewAction addSubview:seperateView];
    
    EWPButton *settingBtn = [[EWPButton alloc] initWithFrame:CGRectMake(viewAction.bounds.size.width/2, 20, viewAction.bounds.size.width/2, 40)];
    [settingBtn setTitle:@"  设置" forState:UIControlStateNormal];
    [settingBtn setImage:[UIImage imageNamed:@"right_setting_normal"] forState:UIControlStateNormal];
    [settingBtn setImage:[UIImage imageNamed:@"right_setting_high"] forState:UIControlStateHighlighted];
    settingBtn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [settingBtn setTitleColor:[UIColor colorWithRed:74.0f/255.0f green:48.0f/255.0f blue:21.0f/255.0f alpha:0.5] forState:UIControlStateNormal];
    [viewAction addSubview: settingBtn];
    settingBtn.buttonBlock = ^(id sender)
    {
        Class viewControllerType = NSClassFromString(Setting_Canvas);
        UIViewController *viewController = [[viewControllerType alloc] init];
        [[AppDelegate shareAppDelegate].lrSliderMenuViewController.navigationController pushViewController:viewController animated:YES];
    };
    nYOffset += 80;
    
    
    UIView *menuBKView = [[UIView alloc] initWithFrame:CGRectMake(nXOffset, nYOffset, 190, 2 * 42)];
    menuBKView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:menuBKView];
    
    UIImageView *lineImg = [[UIImageView alloc] initWithFrame:CGRectZero];
    lineImg.frame = CGRectMake(0, 0, menuBKView.frame.size.width, 2);
    lineImg.image = [UIImage imageNamed:@"hLine"];
    [menuBKView addSubview:lineImg];
    
    //搜索
    CGSize textSize;
    UIImage *rightSelectd = [UIImage imageWithCGImage:[UIImage imageNamed:@"leftMenu_selected.png"].CGImage scale:1.0 orientation:UIImageOrientationDown];
    EWPButton *searchBtn = [EWPButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame = CGRectMake(0, 2, menuBKView.bounds.size.width, 38);
    [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    searchBtn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    searchBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    textSize = [CommonFuction sizeOfString:searchBtn.titleLabel.text maxWidth:300 maxHeight:30 withFontSize:searchBtn.titleLabel.font.pointSize];
    [searchBtn setImageEdgeInsets:UIEdgeInsetsMake(0,-90+ textSize.width, 0.0, 0.0)];
    [searchBtn setTitleEdgeInsets:UIEdgeInsetsMake(0,-50+ textSize.width,0.0,0.0)];
    [searchBtn setTitleColor:[UIColor colorWithRed:74.0f/255.0f green:48.0f/255.0f blue:21.0f/255.0f alpha:0.5] forState:UIControlStateNormal];
    [searchBtn setImage:[UIImage imageNamed:@"right_search_high"] forState:UIControlStateNormal];
    [searchBtn setImage:[UIImage imageNamed:@"right_search_normal"] forState:UIControlStateHighlighted];
    [searchBtn setBackgroundImage:rightSelectd forState:UIControlStateHighlighted];
    [menuBKView addSubview:searchBtn];
    searchBtn.buttonBlock = ^(id sender)
    {
        Class viewControllerType = NSClassFromString(Search_Canvas);
        UIViewController *viewController = [[viewControllerType alloc] init];
        [[AppDelegate shareAppDelegate].lrSliderMenuViewController.navigationController pushViewController:viewController animated:YES];
        
    };

    lineImg = [[UIImageView alloc] initWithFrame:CGRectZero];
    lineImg.frame = CGRectMake(0, 40, menuBKView.frame.size.width, 2);
    lineImg.image = [UIImage imageNamed:@"hLine"];
    [menuBKView addSubview:lineImg];

    //我看过的
    EWPButton *attentionBtn = [EWPButton buttonWithType:UIButtonTypeCustom];
    attentionBtn.frame = CGRectMake(0, 42, menuBKView.bounds.size.width, 38);
    [attentionBtn setTitle:@"我的关注" forState:UIControlStateNormal];
    attentionBtn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    attentionBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    textSize = [CommonFuction sizeOfString:attentionBtn.titleLabel.text maxWidth:300 maxHeight:30 withFontSize:attentionBtn.titleLabel.font.pointSize];
    [attentionBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -90+ textSize.width, 0.0, 0.0)];
    [attentionBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -50+ textSize.width,0.0,0.0)];
    [attentionBtn setTitleColor:[UIColor colorWithRed:74.0f/255.0f green:48.0f/255.0f blue:21.0f/255.0f alpha:0.5] forState:UIControlStateNormal];
    [attentionBtn setImage:[UIImage imageNamed:@"right_history_normal"] forState:UIControlStateNormal];
    [attentionBtn setImage:[UIImage imageNamed:@"right_history_high"] forState:UIControlStateHighlighted];
    [attentionBtn setBackgroundImage:rightSelectd forState:UIControlStateHighlighted];
//    [menuBKView addSubview:attentionBtn];
    attentionBtn.buttonBlock = ^(id sender)
    {
        if ([AppInfo shareInstance].bLoginSuccess)
        {
            Class viewControllerType = NSClassFromString(My_Attend_Canvas);
            UIViewController *viewController = [[viewControllerType alloc] init];
            [[AppDelegate shareAppDelegate].lrSliderMenuViewController.navigationController pushViewController:viewController animated:YES];
        }
        else
        {
            Class viewControllerType = NSClassFromString(Login_Canvas);
            UIViewController *viewController = [[viewControllerType alloc] init];
            [[AppDelegate shareAppDelegate].lrSliderMenuViewController.navigationController pushViewController:viewController animated:YES];
        }

    };
    
    lineImg = [[UIImageView alloc] initWithFrame:CGRectZero];
    lineImg.frame = CGRectMake(0, 80, menuBKView.frame.size.width, 2);
    lineImg.image = [UIImage imageNamed:@"hLine"];
//    [menuBKView addSubview:lineImg];

    
    [[AppDelegate shareAppDelegate].lrSliderMenuViewController addObserver:self forKeyPath:@"RightMenuShowing" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([AppInfo shareInstance].bLoginSuccess)
    {
        FirstRechargeModel *firstRechargeModel = [[FirstRechargeModel alloc] init];
        [firstRechargeModel requestDataWithParams:nil success:^(id object) {
            if (firstRechargeModel.bFirstRecharge)
            {
                self.firstRechargeImg.hidden = YES;
            }
        } fail:^(id object) {
            
        }];
        
        self.coinCountLable.hidden = NO;
        self.nick.text = [UserInfoManager shareUserInfoManager].currentUserInfo.nick;
        self.coinCountLable.text = [NSString stringWithFormat:@"%lld热币",[UserInfoManager shareUserInfoManager].currentUserInfo.coin];
        NSString *url = [NSString stringWithFormat:@"%@%@",[AppInfo shareInstance].res_server,[UserInfoManager shareUserInfoManager].currentUserInfo.photo];
        [self.headImgView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil];
    }
    else
    {
        self.coinCountLable.hidden = YES;
        _headImgView.image = [UIImage imageNamed:@"right_head"];
        _nick.text = @"登录/注册";
    }
    
}


- (void)showUserInfo
{
    //如果已登录则跳转到跟人信息界面，否则登录界面
    BOOL bLoginSuccess= [AppInfo shareInstance].bLoginSuccess;
    Class viewControllerType = nil;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    if (bLoginSuccess)
    {
        viewControllerType = NSClassFromString(PersonInfo_Canvas);
        [dict setObject:[NSNumber numberWithInteger:[UserInfoManager shareUserInfoManager].currentUserInfo.userId ] forKey:@"userid"];
    }
    else
    {
        
        viewControllerType = NSClassFromString(Login_Canvas);
    }
    UIViewController *viewController = [[viewControllerType alloc] init];
    if ([viewController respondsToSelector:@selector(argumentForCanvas:)]) {
        [((ViewController *)viewController) argumentForCanvas:dict];
    }
    [[AppDelegate shareAppDelegate].lrSliderMenuViewController.navigationController pushViewController:viewController animated:YES];
}

- (void)OnRecharge
{
    if (![[AppDelegate shareAppDelegate] showLoginDialog:YES])
    {
//        [self requestDataWithAnalyseModel:[FirstRechargeModel class] params:nil success:^(id object)
//         {
//             /*成功返回数据*/
//             FirstRechargeModel *model = object;
//             if (model.result == 0)
//             {
//                 if (model.bFirstRecharge)
//                 {
//
//                 }
//             }
//             else
//             {
//                 [self showNotice:model];
//             }
//         }
        RechargeViewController *viewController = [[RechargeViewController alloc] init];
        viewController.bRootType = NO;
        [[AppDelegate shareAppDelegate].lrSliderMenuViewController.navigationController pushViewController:viewController animated:YES];
    }
}

#pragma mark - observer
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqual:@"RightMenuShowing"])
    {
        BOOL rightMenuShowing = [[change objectForKey:NSKeyValueChangeNewKey] boolValue];
        if (rightMenuShowing)
        {
            [self viewWillAppear:NO];
        }

    }
}
@end
