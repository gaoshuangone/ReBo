
//  AppStoreRechargeViewController.m
//  BoXiu
//
//  Created by andy on 14-11-7.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "AppStoreRechargeViewController.h"
#import "RMStore.h"
#import "UserInfoManager.h"
#import "VerifyAppStoreRechargeModel.h"
#import "NSData+GTMBase64.h"
#import "Recharge.h"

@implementation AppStoreRechargeInfo


@end

@interface AppStoreRechargeViewController ()

@property (nonatomic,strong) NSArray *productIdentifers;
@property (nonatomic,strong) NSArray *coinArray;
@property (nonatomic,strong) NSArray *moneyArray;
@property (nonatomic,assign) BOOL productsRequestFinished;
@property (nonatomic,assign) NSInteger selectProductIndex;
@property (nonatomic,strong) NSMutableArray *purchasedMArray;
@property (nonatomic,strong) UILabel *coin;

@property (nonatomic,assign) BOOL enterFromChatRoom;
@end

@implementation AppStoreRechargeViewController

- (void)dealloc
{
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.baseViewType = kbaseScroolViewType;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"充值";
    self.scrollView.hidden = YES;
    self.scrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64);
    
    UserInfo *currentUserInfo = [UserInfoManager shareUserInfoManager].currentUserInfo;
    
    //不会变动，写死
    _coinArray = @[@"600 热币",@"3,000 热币",@"6,800 热币",@"9,800 热币",@"19,800 热币",@"48,800 热币"];
    _moneyArray = @[@"￥6",@"￥30",@"￥68",@"￥98",@"￥198",@"￥488"];
    _productIdentifers = @[@"com.ReXiu.ReBo.BoXiu.coin600",@"com.ReXiu.ReBo.BoXiu.coin3000",@"com.ReXiu.ReBo.BoXiu.coin6800",
                           @"com.ReXiu.ReBo.BoXiu.coin9800",@"com.ReXiu.ReBo.BoXiu.coin19800",@"com.ReXiu.ReBo.BoXiu.coin48800"];
    
    UIView *userInfoBKView = [[UIView alloc] initWithFrame:CGRectMake(10, 20, 300, 75)];
    userInfoBKView.layer.borderColor = [CommonFuction colorFromHexRGB:@"cbcbcb"].CGColor;
    userInfoBKView.layer.borderWidth = 1.0f;
    userInfoBKView.layer.cornerRadius = 4.0f;
    [self.scrollView addSubview:userInfoBKView];
    
    UILabel *nickLable = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, 80, 17)];
    nickLable.text = @"充值账号:";
    nickLable.textColor = [CommonFuction colorFromHexRGB:@"343a36"];
    nickLable.font = [UIFont boldSystemFontOfSize:15.0f];
    [userInfoBKView addSubview:nickLable];
    
    UILabel *nick = [[UILabel alloc] initWithFrame:CGRectMake(90, 15, 200, 17)];
    nick.text = currentUserInfo.nick;
    nick.font = [UIFont boldSystemFontOfSize:15.0f];
    nick.textColor = [CommonFuction colorFromHexRGB:@"343a36"];
    nick.textAlignment = NSTextAlignmentLeft;
    [userInfoBKView addSubview:nick];
    
    UILabel *coinLable = [[UILabel alloc] initWithFrame:CGRectMake(20, 45, 80, 15)];
    coinLable.text = @"财富余额:";
    coinLable.textColor = [CommonFuction colorFromHexRGB:@"343a36"];
    coinLable.font = [UIFont boldSystemFontOfSize:15.0f];
    [userInfoBKView addSubview:coinLable];
    
    _coin = [[UILabel alloc] initWithFrame:CGRectMake(90, 45, 200, 15)];
    _coin.text = [NSString stringWithFormat:@"%lld 热币",currentUserInfo.coin];
    _coin.textColor = [CommonFuction colorFromHexRGB:@"f79350"];
    _coin.font = [UIFont boldSystemFontOfSize:15.0f];
    _coin.textAlignment = NSTextAlignmentLeft;
    [userInfoBKView addSubview:_coin];
    
    UILabel *rechargeCoinTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 115, 150, 20)];
    rechargeCoinTitle.font = [UIFont systemFontOfSize:14.0f];
    rechargeCoinTitle.textColor = [CommonFuction colorFromHexRGB:@"575757"];
    rechargeCoinTitle.text = @"请选择充值金额:";
    [self.scrollView addSubview:rechargeCoinTitle];
    
    UIView *coinBKView = [[UIView alloc] initWithFrame:CGRectMake(10, 140, 300, 272)];
    coinBKView.layer.borderColor = [CommonFuction colorFromHexRGB:@"cbcbcb"].CGColor;
    coinBKView.layer.borderWidth = 1.0f;
    [self.scrollView addSubview:coinBKView];
    
    for (int nIndex = 0; nIndex < [_productIdentifers count]; nIndex++)
    {
        CGFloat xPos = 22;
        CGFloat yPos = 10;
        UILabel *coinTitle = [[UILabel alloc] initWithFrame:CGRectMake(xPos, yPos +  nIndex * 45, 150, 27)];
        coinTitle.text = [_coinArray objectAtIndex:nIndex];
        coinTitle.textColor = [CommonFuction colorFromHexRGB:@"343a36"];
        [coinBKView addSubview:coinTitle];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(208, yPos +  nIndex  * 45, 80, 28);
        button.backgroundColor = [CommonFuction colorFromHexRGB:@"d14c49"];
        [button setTitle:[_moneyArray objectAtIndex:nIndex] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(OnRecharge:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = nIndex;
        [coinBKView addSubview:button];
        
        if (nIndex != [_productIdentifers count] - 1)
        {
            UIImageView *lineImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 45 * (nIndex + 1), 300, 1)];
            lineImg.backgroundColor = [CommonFuction colorFromHexRGB:@"cbcbcb"];
            [coinBKView addSubview:lineImg];
        }
        
    }
    UILabel *tipTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 427, 250, 20)];
    tipTitle.text = @"提示:人民币和热币兑换比例为1:100";
    tipTitle.textColor = [CommonFuction colorFromHexRGB:@"959596"];
    tipTitle.font = [UIFont systemFontOfSize:14.0f];
    [self.scrollView addSubview:tipTitle];
    
    __weak typeof(self) weakself = self;
    [self setNavigationBarLeftItem:nil itemNormalImg:[UIImage imageNamed:@"navBack_normal"] itemHighlightImg:nil withBlock:^(id sender) {
        __strong typeof(self) strongself = weakself;
        if (strongself)
        {
            NSString *className = NSStringFromClass([strongself class]);
            NSDictionary *param = [NSDictionary dictionaryWithObject:className forKey:@"className"];
            [strongself popCanvasWithArgment:param];
        }
    }];
   
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.scrollView.hidden)
    {
        [[RMStore defaultStore] requestProducts:[NSSet setWithArray:_productIdentifers] success:^(NSArray *products, NSArray *invalidProductIdentifiers) {
            
            if (products && [products count])
            {
                self.scrollView.hidden = NO;
            }
        } failure:^(NSError *error) {
            [self showNoticeInWindow:error.localizedDescription];
        }];

    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}
- (void)argumentForCanvas:(id)argumentData
{
    if (argumentData && [argumentData isKindOfClass:[NSDictionary class]])
    {
        NSDictionary *param = (NSDictionary *)argumentData;
        NSString *className = [param objectForKey:@"className"];
        if (className && [className isEqualToString:LiveRoom_CanVas])
        {
            self.enterFromChatRoom = YES;
        }
    }
}

- (void)OnRecharge:(id)sender
{
    UIButton *button = (UIButton *)sender;
    NSString *productID = [_productIdentifers objectAtIndex:button.tag];
    self.selectProductIndex = button.tag;
    
    [self startAnimating];
    __weak typeof(self) weakSelf = self;
    [[Recharge shareRechargeInstance] appstorepayWithProductID:productID PayResult:^(NSInteger resultCode,NSString *resultMsg) {
        __strong typeof(self) strongSelf = weakSelf;
        if (strongSelf)
        {
            [self stopAnimating];
            if (resultCode == 0)
            {
                UserInfo *userInfo = [UserInfoManager shareUserInfoManager].currentUserInfo;
                NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lld热币",userInfo.coin]];
                [str addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:15.0f] range:NSMakeRange(0,[str length] - 2)];
                [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13.0f] range:NSMakeRange([str length] - 2,2)];
                strongSelf.coin.attributedText = str;
                
                [strongSelf showNoticeInWindow:@"充值处理中，请稍后刷新查看" duration:2];
                if (strongSelf.enterFromChatRoom)
                {
                    [strongSelf popToCanvas:LiveRoom_CanVas withArgument:nil];
                }
            }
            else
            {
                 [strongSelf showNoticeInWindow:resultMsg];
            }
            [strongSelf stopAnimating];
        }

    }];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
