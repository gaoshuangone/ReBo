//
//  SelectModePaymentViewController.m
//  BoXiu
//
//  Created by tongmingyu on 15-3-16.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import "SelectModePaymentViewController.h"
#import "EWPIconButtonView.h"

@interface SelectModePaymentViewController ()

@property (nonatomic,assign) BOOL enterFromChatRoom;
@property (nonatomic,strong) NSString* strArgument;
@end


@implementation SelectModePaymentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"充值";
    
    int YOffset = 15;
    
    UILabel *rechargeTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, YOffset, 90, 15)];
    rechargeTitle.font = [UIFont systemFontOfSize:14.0f];
    rechargeTitle.text = @"选择支付方式";
    rechargeTitle.textColor = [CommonFuction colorFromHexRGB:@"454a4d"];
    [self.view addSubview:rechargeTitle];
    
    YOffset += 30;
    
    UIButton *alipayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    alipayBtn.frame = CGRectMake(0, YOffset, SCREEN_WIDTH, 43);
    alipayBtn.tag = 11;
    [alipayBtn setTitle:@"支付宝" forState:UIControlStateNormal];
    alipayBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -33, 0, 180);
    alipayBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [alipayBtn setTitleColor:[CommonFuction colorFromHexRGB:@"454a4d"] forState:UIControlStateNormal];
    [alipayBtn setImage:[UIImage imageNamed:@"01ZF"] forState:UIControlStateNormal];
    [alipayBtn setImage:[UIImage imageNamed:@"01ZF"] forState:UIControlStateHighlighted];
    alipayBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 215);
    alipayBtn.backgroundColor = [UIColor whiteColor];
    [alipayBtn addTarget:self action:@selector(modelPayMent:) forControlEvents:UIControlEventTouchUpInside];
    
    NSInteger hideSwitch = [[[AppInfo shareInstance].hideSwitch substringToIndex:1] integerValue];
    if (hideSwitch != 1)
    {
        [self.view addSubview:alipayBtn];
        
        UIView* viewLine1 = [CommonUtils CommonViewLineWithFrame:CGRectMake(46, YOffset +42, SCREEN_WIDTH-46, 0.5)];
        viewLine1.backgroundColor = [CommonFuction colorFromHexRGB:@"000000"];
        viewLine1.alpha = 0.08;
        [self.view addSubview:viewLine1];
        
    }

    YOffset += 43;
    
    UIButton *unbankBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    unbankBtn.frame = CGRectMake(0, YOffset, SCREEN_WIDTH, 43);
    [unbankBtn setTitle:@"银联支付" forState:UIControlStateNormal];
    unbankBtn.tag = 12;
    unbankBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 180);
    unbankBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [unbankBtn setTitleColor:[CommonFuction colorFromHexRGB:@"454a4d"] forState:UIControlStateNormal];
    [unbankBtn setImage:[UIImage imageNamed:@"02ZF"] forState:UIControlStateNormal];
    [unbankBtn setImage:[UIImage imageNamed:@"02ZF"] forState:UIControlStateHighlighted];
    unbankBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 200);
    unbankBtn.backgroundColor = [UIColor whiteColor];
    [unbankBtn addTarget:self action:@selector(modelPayMent:) forControlEvents:UIControlEventTouchUpInside];
    
    if (hideSwitch != 1)
    {
        [self.view addSubview:unbankBtn];
        UIView* viewLine1 = [CommonUtils CommonViewLineWithFrame:CGRectMake(46, YOffset+42, SCREEN_WIDTH-46, 0.3)];
        viewLine1.backgroundColor = [CommonFuction colorFromHexRGB:@"f6f6f6f"];
        viewLine1.alpha = 0.15;
        [self.view addSubview:viewLine1];
    }
    
    YOffset += 43;
    
    UIButton *wxBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    wxBtn.frame = CGRectMake(0, YOffset, SCREEN_WIDTH, 43);
    [wxBtn setTitle:@"微信支付" forState:UIControlStateNormal];
    wxBtn.tag = 13;
    wxBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 180);
    wxBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [wxBtn setTitleColor:[CommonFuction colorFromHexRGB:@"454a4d"] forState:UIControlStateNormal];
    [wxBtn setImage:[UIImage imageNamed:@"03ZF"] forState:UIControlStateNormal];
    [wxBtn setImage:[UIImage imageNamed:@"03ZF"] forState:UIControlStateHighlighted];
    wxBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 200);

    wxBtn.backgroundColor = [UIColor whiteColor];
    [wxBtn addTarget:self action:@selector(modelPayMent:) forControlEvents:UIControlEventTouchUpInside];
    if (hideSwitch != 1)
    {
        [self.view addSubview:wxBtn];
        UIView* viewLine1 = [CommonUtils CommonViewLineWithFrame:CGRectMake(46, YOffset+42, SCREEN_WIDTH-46, 0.3)];
        viewLine1.backgroundColor = [CommonFuction colorFromHexRGB:@"f6f6f6f"];
        viewLine1.alpha = 0.15;
        [self.view addSubview:viewLine1];
    }
    
    YOffset += 43;
    
    UIButton *telphoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    telphoneBtn.frame = CGRectMake(0, YOffset, SCREEN_WIDTH, 43);
    [telphoneBtn setTitle:@"手机卡支付" forState:UIControlStateNormal];
    telphoneBtn.tag = 14;
    telphoneBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 166);
    telphoneBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [telphoneBtn setTitleColor:[CommonFuction colorFromHexRGB:@"454a4d"] forState:UIControlStateNormal];
    [telphoneBtn setImage:[UIImage imageNamed:@"04ZF"] forState:UIControlStateNormal];
    [telphoneBtn setImage:[UIImage imageNamed:@"04ZF"] forState:UIControlStateHighlighted];
    telphoneBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 185);
    telphoneBtn.backgroundColor = [UIColor whiteColor];
    [telphoneBtn addTarget:self action:@selector(modelPayMent:) forControlEvents:UIControlEventTouchUpInside];
    if (hideSwitch != 1)
    {
        [self.view addSubview:telphoneBtn];
    }
    
    __weak typeof(self) weakself = self;
    [self setNavigationBarLeftItem:nil itemNormalImg:[UIImage imageNamed:@"navBack_normal"] itemHighlightImg:nil withBlock:^(id sender) {
        __strong typeof(self) strongself = weakself;
        if (strongself)
        {
            NSString *className = NSStringFromClass([strongself class]);
            NSDictionary *param = nil;
            if (weakself.strArgument) {//返回时需要制定返回位置的
              param   = [NSDictionary dictionaryWithObject:self.strArgument forKey:@"className"];
            }else{
                    param   = [NSDictionary dictionaryWithObject:className forKey:@"className"];
            }
           
            [strongself popCanvasWithArgment:param];
        }
    }];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    __weak typeof(self) weakSelf = self;
    [self setNavigationBarRightItem:nil itemNormalImg:[UIImage imageNamed:@"chongZhiCheck"] itemHighlightImg:nil withBlock:^(id sender) {
        __strong typeof(self) strongSelf = weakSelf;
        
        NSString *className = NSStringFromClass([strongSelf class]);
        NSDictionary *param = [NSDictionary dictionaryWithObject:className forKey:@"className"];
        [strongSelf pushCanvas:RechargeRecord_Canvas withArgument:param];
    }];
}

- (void)modelPayMent:(id)sender
{
    UIButton *btn  = (UIButton *)sender;
    NSDictionary *param = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:self.enterFromChatRoom] forKey:@"enterFromChatRoom"];
    if (btn.tag == 14)
    {
        [self pushCanvas:PhoneCard_Canvas withArgument:param];
    }
    else
    {
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:param];
        [dict setObject:[NSNumber numberWithInteger:btn.tag] forKey:@"rechargeType"];
        [dict setObject:btn.titleLabel.text forKey:@"title"];
        [self pushCanvas:Recharge_Canvas withArgument:dict];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    }else {
        if (argumentData && [argumentData isKindOfClass:[NSString class]]){

        self.strArgument = (NSString*)argumentData;
    }
    }
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
