//
//  VipViewController.m
//  BoXiu
//
//  Created by tongmingyu on 14-8-29.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "VipViewController.h"
#import "VIPItem.h"
#import "UserInfoManager.h"
#import "BuyVIPModel.h"
#import "MallViewController.h"

@interface VipViewController ()
@property (nonatomic,strong) EWPSimpleDialog *buyDialog;
@property (nonatomic,assign) NSInteger readyBuyVip;//1是正在购买紫色vip，2是正在购买黄色vip；
@end

@implementation VipViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
         self.baseViewType = kbaseScroolViewType;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"rankBg"]];
    
    self.scrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 36);
    
    CGFloat nYOffset = 11;
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(16, nYOffset, 100, 20)];
    titleLable.font = [UIFont systemFontOfSize:14.0f];
    titleLable.textColor = [CommonFuction colorFromHexRGB:@"454a4d"];
    titleLable.text = @"VIP特权";
    [self.scrollView addSubview:titleLable];
    
    
    UILabel *yellowVipLable = [[UILabel alloc] initWithFrame:CGRectMake(195, nYOffset , 50, 20)];
    yellowVipLable.font = [UIFont systemFontOfSize:13.0f];
    yellowVipLable.textColor = [CommonFuction colorFromHexRGB:@"454a4d"];
    yellowVipLable.text = @"黄色";
    [self.scrollView addSubview:yellowVipLable];

    UILabel *purpleVipLable = [[UILabel alloc] initWithFrame:CGRectMake(261, nYOffset , 50, 20)];
    purpleVipLable.font = [UIFont systemFontOfSize:13.0f];
    purpleVipLable.textColor = [CommonFuction colorFromHexRGB:@"454a4d"];
    purpleVipLable.text = @"紫色";
    [self.scrollView addSubview:purpleVipLable];
    
    nYOffset = 43;
    
    VIPItem *item = [[VIPItem alloc] initWithFrame:CGRectMake(0, nYOffset, SCREEN_HEIGHT, 41) title:@"享昵称前的尊贵VIP标志" isYellow:YES isPurple:YES];
    [self.scrollView addSubview:item];
    nYOffset += 41;
    
    item = [[VIPItem alloc] initWithFrame:CGRectMake(0, nYOffset, SCREEN_HEIGHT, 41) title:@"可不受限制进入满员房间" isYellow:YES isPurple:YES];
    item.hideHLine = YES;
    [self.scrollView addSubview:item];
    nYOffset += 41;
    
    nYOffset += 15;
    item = [[VIPItem alloc] initWithFrame:CGRectMake(0, nYOffset, SCREEN_HEIGHT, 41) title:@"防止被管理员踢出及禁言" isYellow:YES isPurple:YES];
    [self.scrollView addSubview:item];
    nYOffset += 41;
    
    item = [[VIPItem alloc] initWithFrame:CGRectMake(0, nYOffset, SCREEN_HEIGHT, 41) title:@"在房间内的排名直线上升" isYellow:YES isPurple:YES];
    item.hideHLine = YES;
    [self.scrollView addSubview:item];
    nYOffset += 41;
    
    nYOffset += 15;
    item = [[VIPItem alloc] initWithFrame:CGRectMake(0, nYOffset, SCREEN_HEIGHT, 41) title:@"可以禁言其他用户" isYellow:YES isPurple:YES];
    [self.scrollView addSubview:item];
    nYOffset += 41;
    
    item = [[VIPItem alloc] initWithFrame:CGRectMake(0, nYOffset, SCREEN_HEIGHT, 41) title:@"可以隐身进入房间" isYellow:NO isPurple:YES];
    item.hideHLine = YES;
    [self.scrollView addSubview:item];
    nYOffset += 53;
    
    
    UILabel *selectVipTypeLable = [[UILabel alloc] initWithFrame:CGRectMake(16, nYOffset, 100, 20)];
    selectVipTypeLable.font = [UIFont systemFontOfSize:14.0f];
    selectVipTypeLable.textColor = [CommonFuction colorFromHexRGB:@"454a4d"];
    selectVipTypeLable.text = @"选择VIP类型";
    [self.scrollView addSubview:selectVipTypeLable];
    
    nYOffset += 30;
    
    VIPItem *item1 = [[VIPItem alloc] initWithFrame:CGRectMake(0, nYOffset, SCREEN_HEIGHT, 41) title:@"紫色VIP" isYellow:NO isPurple:NO];
    item1.isVipType = YES;
    [self.scrollView addSubview:item1];
      [item1 changeFrameTitle];
    
    UIImageView *buyPurpleImg = [[UIImageView alloc] initWithFrame:CGRectMake(20, nYOffset+6, 25, 25)];
    buyPurpleImg.image = [UIImage imageNamed:@"ziSC"];
    
    [self.scrollView addSubview:buyPurpleImg];
    
    UIImage *rechargeImg = [CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"d14c49"] size:CGSizeMake(68, 25)];
    UIImage *rechargeImgNOR = [CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"ffffff"] size:CGSizeMake(68, 25)];
    
    
    UIButton *buyPurpleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    buyPurpleBtn.frame = CGRectMake(SCREEN_WIDTH-68-10, nYOffset + 8, 68, 25);
    [buyPurpleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [buyPurpleBtn setTitleColor:[CommonFuction colorFromHexRGB:@"d14c49"] forState:UIControlStateNormal];
    [buyPurpleBtn setTitle:@"开通" forState:UIControlStateNormal];
    buyPurpleBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    buyPurpleBtn.tag = 1;
    buyPurpleBtn.layer.cornerRadius = 12.5f;
    buyPurpleBtn.layer.masksToBounds = YES;
    buyPurpleBtn.layer.borderWidth = 0.5;
    buyPurpleBtn.layer.borderColor = [CommonFuction colorFromHexRGB:@"d14c49"].CGColor;
    [buyPurpleBtn setBackgroundImage:rechargeImg forState:UIControlStateHighlighted];
    [buyPurpleBtn setBackgroundImage:rechargeImgNOR forState:UIControlStateNormal];
    [buyPurpleBtn addTarget:self action:@selector(OnBuy:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:buyPurpleBtn];
    
      nYOffset += 41;
    
    VIPItem *item2 = [[VIPItem alloc] initWithFrame:CGRectMake(0, nYOffset, SCREEN_HEIGHT, 41) title:@"黄色VIP" isYellow:NO isPurple:NO];
      item2.isVipType = YES;
    [item2 changeFrameTitle];
    [self.scrollView addSubview:item2];
    
    UIImageView *buyYellowImg = [[UIImageView alloc] initWithFrame:CGRectMake(20, nYOffset+6, 25, 25)];
    buyYellowImg.image = [UIImage imageNamed:@"ySC"];
    [self.scrollView addSubview:buyYellowImg];
    

//    UIImage *rechargeImg = [CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"d14c49"] size:CGSizeMake(68, 25)];
//    UIImage *rechargeImgNOR = [CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"ffffff"] size:CGSizeMake(68, 25)];
//    UIButton *rechargeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    rechargeBtn.frame = CGRectMake(230+15, YOffset + 10, 68, 25);
//    [rechargeBtn setTitle:@"充值" forState:UIControlStateNormal];
//    [rechargeBtn setTitleColor:[CommonFuction colorFromHexRGB:@"d14c49"] forState:UIControlStateHighlighted];
//    [rechargeBtn setTitleColor:[CommonFuction colorFromHexRGB:@"ffffff"] forState:UIControlStateNormal];
//    rechargeBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
//    rechargeBtn.layer.cornerRadius = 12.5f;
//    rechargeBtn.layer.masksToBounds = YES;
//    rechargeBtn.layer.borderWidth = 0.5;
//    rechargeBtn.layer.borderColor = [CommonFuction colorFromHexRGB:@"d14c49"].CGColor;
//    [rechargeBtn setBackgroundImage:rechargeImg forState:UIControlStateNormal];
//    [rechargeBtn setBackgroundImage:rechargeImgNOR forState:UIControlStateHighlighted];
//    [rechargeBtn addTarget:self action:@selector(OnRecharge:) forControlEvents:UIControlEventTouchUpInside];
//    [self.scrollView addSubview:rechargeBtn];

    
    

    
    UIButton *buyYellowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    buyYellowBtn.frame = CGRectMake(SCREEN_WIDTH-68-10, nYOffset + 8, 68, 25);
    [buyYellowBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [buyYellowBtn setTitleColor:[CommonFuction colorFromHexRGB:@"d14c49"] forState:UIControlStateNormal];
    [buyYellowBtn setTitle:@"开通" forState:UIControlStateNormal];
    [buyYellowBtn setBackgroundImage:rechargeImg forState:UIControlStateHighlighted];
    [buyYellowBtn setBackgroundImage:rechargeImgNOR forState:UIControlStateNormal];
    buyYellowBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    buyYellowBtn.tag = 2;
    buyYellowBtn.layer.cornerRadius = 12.5f;
    buyYellowBtn.layer.masksToBounds = YES;
    buyYellowBtn.layer.borderWidth = 0.5;
    buyYellowBtn.layer.borderColor = [CommonFuction colorFromHexRGB:@"d14c49"].CGColor;
    [buyYellowBtn addTarget:self action:@selector(OnBuy:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:buyYellowBtn];
    nYOffset += 60;
    
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, nYOffset);
}

- (void)OnBuy:(id)sender
{
    ViewController *viewController = (ViewController *)self.rootViewController;
    
    if ([viewController showLoginDialog])
    {
        return;
    }
    
    UIButton *button = (UIButton *)sender;
    if(button.tag == 1)
    {
        //开通紫色vip
        self.readyBuyVip = 1;
    }
    else
    {
        //开通黄色vip
         self.readyBuyVip = 2;
    }
    [self ShowBuyDialog];
}

- (void)ShowBuyDialog
{

    _buyDialog = [[EWPSimpleDialog alloc] initWithFrame:CGRectMake(0, 0, 270, 273)];
    _buyDialog.layer.borderColor = [UIColor whiteColor].CGColor;
    _buyDialog.backgroundColor = [UIColor whiteColor];
    _buyDialog.layer.cornerRadius = 4.0f;
    _buyDialog.layer.borderWidth = 1.0f;
    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(230, 8, 30, 30)];
    [closeBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeDialog:) forControlEvents:UIControlEventTouchUpInside];
    [_buyDialog addSubview:closeBtn];
    
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake((270-140)/2, 20, 140, 20)];
    titleLable.font = [UIFont systemFontOfSize:18.0f];
    titleLable.textColor = [CommonFuction colorFromHexRGB:@"454a4d"];
    titleLable.text = @"选择VIP开通期限";
    [_buyDialog addSubview:titleLable];
    
    UIImageView *hLineImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, 50, 238, 0.5)];
    hLineImg.backgroundColor = [CommonFuction colorFromHexRGB:@"cbcbcb"];
    [_buyDialog addSubview:hLineImg];
    
    for (int nIndex = 0; nIndex < 4; nIndex++)
    {
        NSString *monthNum = nil;
        NSString *coinNum = nil;
        NSInteger tag;
        if (nIndex == 0)
        {
            monthNum = @"1个月";
            if (self.readyBuyVip == 1)
            {
                 coinNum = @"x 30000";
            }
            else
            {
                coinNum = @"x 2000";
            }
           
            tag = 1;
            
        }
        else if (nIndex == 1)
        {
            monthNum = @"3个月";
            if (self.readyBuyVip == 1)
            {
                coinNum = @"x 82500";
            }
            else
            {
                coinNum = @"x 5500";
            }
            
            tag = 3;
        }
        else if (nIndex == 2)
        {
            monthNum = @"6个月";
            if (self.readyBuyVip == 1)
            {
                coinNum = @"x 150000";
            }
            else
            {
                coinNum = @"x 10000";
            }
            
            tag = 6;
        }
        else
        {
            monthNum = @"12个月";
            if(self.readyBuyVip == 1)
            {
                coinNum = @"x 270000";
            }
            else
            {
                coinNum = @"x 18000";
            }
            
            tag = 12;
        }
        UILabel *monthLable = [[UILabel alloc] initWithFrame:CGRectMake(20, 70 + nIndex * 23 + nIndex * 28, 50, 20)];
        monthLable.text = monthNum;
        monthLable.textColor = [CommonFuction colorFromHexRGB:@"454a4d"];
        monthLable.font = [UIFont systemFontOfSize:14.0f];
        [_buyDialog addSubview:monthLable];
        
        UIImageView *coinImg = [[UIImageView alloc] initWithFrame:CGRectMake(monthLable.frame.origin.x + monthLable.frame.size.width + 5, 68 + nIndex * 27 + nIndex * 24, 25, 25)];
        coinImg.image = [UIImage imageNamed:@"rechageIcon"];
        [_buyDialog addSubview:coinImg];
        
        UILabel *coinLable = [[UILabel alloc] initWithFrame:CGRectMake(coinImg.frame.origin.x + coinImg.frame.size.width + 5, 72 + nIndex * 23 + nIndex * 28, 73, 15)];
        coinLable.textColor = [CommonFuction colorFromHexRGB:@"959596"];
        coinLable.font = [UIFont boldSystemFontOfSize:14.0f];
        coinLable.text = coinNum;
        [_buyDialog addSubview:coinLable];
        
        UIImage *rechargeImg = [CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"d14c49"] size:CGSizeMake(68, 25)];
        UIImage *rechargeImgNOR = [CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"ffffff"] size:CGSizeMake(68, 25)];
        
        
        
        UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        confirmBtn.frame = CGRectMake(coinLable.frame.origin.x + coinLable.frame.size.width, 68 + nIndex * 23 + nIndex * 28, 68, 25);
        [confirmBtn setTitleColor:[CommonFuction colorFromHexRGB:@"d14c49"] forState:UIControlStateNormal];
         [confirmBtn setTitleColor:[CommonFuction colorFromHexRGB:@"ffffff"] forState:UIControlStateHighlighted];
        confirmBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        [confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
        confirmBtn.tag = tag;
        confirmBtn.layer.cornerRadius = 12;
        confirmBtn.layer.masksToBounds = YES;
        confirmBtn.layer.borderColor = [CommonFuction colorFromHexRGB:@"d14c49"].CGColor;
        confirmBtn.layer.borderWidth = 0.5;
        [confirmBtn setBackgroundImage:rechargeImg forState:UIControlStateHighlighted];
        [confirmBtn setBackgroundImage:rechargeImgNOR forState:UIControlStateNormal];
        [confirmBtn addTarget:self action:@selector(OnBuyVip:) forControlEvents:UIControlEventTouchUpInside];
        [_buyDialog addSubview:confirmBtn];
    }
   [_buyDialog showInView:[UIApplication sharedApplication].keyWindow withColor:[UIColor blackColor] withAlpha:0.4];
}

- (void)closeDialog:(id)sender
{
    [_buyDialog hide];
}

- (void)OnBuyVip:(id)sender
{
    UIButton *buyBtn = (UIButton *)sender;
    long long needCoin = 0;
    if (buyBtn.tag == 1)
    {
        if (self.readyBuyVip == 1)
        {
            needCoin = 30000;
        }
        else
        {
            needCoin = 2000;
        }
        
    }
    else if (buyBtn.tag == 3)
    {
        if (self.readyBuyVip == 1)
        {
            needCoin = 82500;
        }
        else
        {
            needCoin = 5500;
        }
        
    }
    else if (buyBtn.tag == 6)
    {
        if (self.readyBuyVip == 1)
        {
            needCoin = 150000;
        }
        else
        {
            needCoin = 10000;
        }
        
    }
    else if (buyBtn.tag == 12)
    {
        if (self.readyBuyVip == 1)
        {
            needCoin = 270000;
        }
        else
        {
            needCoin = 180000;
        }
        
    }
    if ([self showLoginDialog])
    {
           [_buyDialog hide];
        return;
    }
    long long coin = [[UserInfoManager shareUserInfoManager] currentUserInfo].coin;
    if (coin >= needCoin)
    {
        //紫色VIPID 3 黄色VIPID 4
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:[NSNumber numberWithInteger:buyBtn.tag] forKey:@"monthnum"];
        if (self.readyBuyVip == 1)
        {
            [dict setObject:[NSNumber numberWithInt:3] forKey:@"vipid"];
        }
        else
        {
            [dict setObject:[NSNumber numberWithInt:4] forKey:@"vipid"];
        }
      
      
        [self requestDataWithAnalyseModel:[BuyVIPModel class] params:dict success:^(id object)
         {
             /*成功返回数据*/
             BuyVIPModel *model = (BuyVIPModel *)object;
             if (model.result == 0)
             {
                 [[AppInfo shareInstance] refreshCurrentUserInfo:^{
                     [self showNoticeInWindow:model.msg];
                     [_buyDialog hide];
                 }];

             }else if (model.code == 403){
                 [self showOherTerminalLoggedDialog];
                    [_buyDialog hide];
             }
             else
             {
                 if([model.msg isEqualToString:@"没有登陆！"])
                 {
                     [[AppInfo shareInstance] loginOut];
                     [self showOherTerminalLoggedDialog];
                        [_buyDialog hide];
                     
                 }else{
                 
                 [self showNoticeInWindow:model.msg];
                 }
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
           [mallViewController showRechargeDialogWithClassStr:@"VipViewController"];
        }
        else
        {
            [self showNoticeInWindow:@"余额不足，请充值后购买"];
        }
        
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
