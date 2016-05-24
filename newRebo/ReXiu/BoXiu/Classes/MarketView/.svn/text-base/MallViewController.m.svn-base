//
//  MallViewController.m
//  BoXiu
//
//  Created by andy on 14-7-24.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "MallViewController.h"
#import "MBProgressHUD.h"
#import "AppInfo.h"
#import "RXAlertView.h"

@interface MallViewController ()<EWPTabMenuControlDataSource,EWPTabMenuControlDelegate>
@property (nonatomic,strong) NSArray *tabMenuTitles;

@property (nonatomic,strong) NSMutableArray *contentViewControllerMArray;
@property (nonatomic,assign) NSInteger tabMenuIndex;
@property (nonatomic,assign) BOOL isFormPopViewController;//区别从其它界面pop回来，不刷新itemIndex
@end

@implementation MallViewController

- (void)dealloc
{
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
    self.title = @"商城";
//    close
    _tabMenuTitles = [[NSArray alloc] initWithObjects:@"VIP",@"座驾",@"靓号", nil];

    [self initContentView];

    _tabMenuControl = [[EWPTabMenuControl alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _tabMenuControl.dataSource = self;
    _tabMenuControl.delegate = self;
    _tabMenuControl.defaultSelectedSegmentIndex =  _tabMenuIndex;
    [self.view addSubview:_tabMenuControl];
    
    [_tabMenuControl reloadData];
    
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


- (void)initContentView
{
    if (_contentViewControllerMArray == nil)
    {
        _contentViewControllerMArray = [NSMutableArray array];
    }
    [self.contentViewControllerMArray removeAllObjects];
    
    Class contentViewControllerType = NSClassFromString(Vip_Canvas);
    ViewController *viewController = (ViewController *)[[contentViewControllerType alloc] init];
    viewController.rootViewController = self;
    [self.contentViewControllerMArray addObject:viewController];
    
    contentViewControllerType = NSClassFromString(TheCar_Canvas);
    viewController = [[contentViewControllerType alloc] init];
    viewController.rootViewController = self;
    [self.contentViewControllerMArray addObject:viewController];
    
    contentViewControllerType = NSClassFromString(Liang_Canvas);
    viewController = [[contentViewControllerType alloc] init];
    viewController.rootViewController = self;
    [self.contentViewControllerMArray addObject:viewController];
}
#pragma mark - EWPTabMenuDataSource

- (EWPSegmentedControl *)ewpSegmentedControl
{
    EWPSegmentedControl *segmentedControl = [[EWPSegmentedControl alloc] initWithSectionTitles:_tabMenuTitles];
    segmentedControl.frame = CGRectMake(0, 0, self.view.frame.size.width, 36);
    segmentedControl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    segmentedControl.backgroundColor = [UIColor whiteColor];
    segmentedControl.textColor = [CommonFuction colorFromHexRGB:@"575757"];
    segmentedControl.selectionStyle = EWPSegmentedControlSelectionStyleFullWidthStripe;
    segmentedControl.selectionIndicatorLocation = EWPSegmentedControlSelectionIndicatorLocationDown;
    segmentedControl.selectionIndicatorColor = [CommonFuction colorFromHexRGB:@"d14c49"];
    segmentedControl.selectedTextColor = [CommonFuction colorFromHexRGB:@"d14c49"];
    segmentedControl.indicatorBKColor = [CommonFuction colorFromHexRGB:@"ffffff"];
    segmentedControl.selectionIndicatorHeight = 2.0f;
    segmentedControl.font = [UIFont systemFontOfSize:14.0f];
     segmentedControl.segmentWidthStyle = EWPSegmentedControlSegmentWidthStyleEqually;
    return segmentedControl;
}

- (UIViewController *)ewpTabMenuControl:(EWPTabMenuControl *)ewpTabMenuControl tabViewOfindex:(NSInteger)index
{
    UIViewController *itemViewController = nil;
    if (self.contentViewControllerMArray && [self.contentViewControllerMArray count] > index)
    {
        itemViewController = [self.contentViewControllerMArray objectAtIndex:index];
    }
    return itemViewController;
}

#pragma mark - EWPTabMenuDelegate

- (void)progressEdgePanGestureRecognizer:(UIPanGestureRecognizer *)panGestureRecognizer tabMenuOfIndex:(NSInteger)index
{
 
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (!self.isFormPopViewController) {
            self.tabMenuControl.currentSelectedSegmentIndex = _tabMenuIndex;
    }

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    _tabMenuIndex = 0;
}

- (void)argumentForCanvas:(id)argumentData
{
    if (argumentData)
    {
        NSDictionary *dic = (NSDictionary *)argumentData;
        self.isFormPopViewController = YES;
//        _tabMenuIndex = [[dic objectForKey:@"marketType"] integerValue];
        NSString* str =[dic objectForKey:@"className"] ;
        if ([str isEqualToString:@"TheCarViewController"]) {
            _tabMenuIndex =1;
            self.isFormPopViewController = NO;
        }else if ([str isEqualToString:@"VipViewController"]){
              _tabMenuIndex =0;
             self.isFormPopViewController = NO;
        }else if ([str isEqualToString:@"LiangViewController"]){
              _tabMenuIndex =2;
             self.isFormPopViewController = NO;
        }else if([str isEqualToString:@"PersonInfoViewController"]){
             _tabMenuIndex =1;
             self.isFormPopViewController = NO;
        }
        
        
        
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
#pragma mark - 显示充值弹出框

- (void)showRechargeDialog
{
//    RXAlertView *alertView = [[RXAlertView alloc] initWithFrame:CGRectMake(0, 0, 271, 147) title:@"余额不足" message:@"您的账户余额不足,请充值!"];
//    [alertView setLeftBtnTitle:@"立即充值" normalImg:nil selectedImg:nil buttonBlock:^(id sender) {
//        if ([AppInfo shareInstance].hiddenPay)
//        {
//            [self pushCanvas:AppStore_Recharge_Canvas withArgument:nil];
//        }
//        else
//        {
//            [self pushCanvas:SelectModePay_Canvas withArgument:nil];
//        }
//    }];
//    
//    [alertView setRightBtnTitle:@"取消" normalImg:nil selectedImg:nil buttonBlock:^(id sender) {
//        
//    }];
//    [alertView showInWindow];
    
    EWPAlertView *alertView = [[EWPAlertView alloc] initWithTitle:@"提示" message:@"您的账户余额不足,请充值!" leftBtnTitle:@"取消" rightBtnTitle:@"立即充值" clickBtnBlock:^(NSInteger nIndex) {
        if (nIndex == 0)
        {
            
        }
        else if(nIndex == 1)
        {
            NSInteger hideSwitch = [[[AppInfo shareInstance].hideSwitch substringToIndex:1] integerValue];
            if (hideSwitch == 1)
            {
                [self pushCanvas:AppStore_Recharge_Canvas withArgument:nil];
            }
            else
            {
                [self pushCanvas:SelectModePay_Canvas withArgument:nil];
            }

        }
    }];
    [alertView show];

}
#pragma mark - 显示充值弹出框

- (void)showRechargeDialogWithClassStr:(NSString*)str
{
    //    RXAlertView *alertView = [[RXAlertView alloc] initWithFrame:CGRectMake(0, 0, 271, 147) title:@"余额不足" message:@"您的账户余额不足,请充值!"];
    //    [alertView setLeftBtnTitle:@"立即充值" normalImg:nil selectedImg:nil buttonBlock:^(id sender) {
    //        if ([AppInfo shareInstance].hiddenPay)
    //        {
    //            [self pushCanvas:AppStore_Recharge_Canvas withArgument:nil];
    //        }
    //        else
    //        {
    //            [self pushCanvas:SelectModePay_Canvas withArgument:nil];
    //        }
    //    }];
    //
    //    [alertView setRightBtnTitle:@"取消" normalImg:nil selectedImg:nil buttonBlock:^(id sender) {
    //
    //    }];
    //    [alertView showInWindow];
    
    EWPAlertView *alertView = [[EWPAlertView alloc] initWithTitle:@"提示" message:@"您的账户余额不足,请充值!" leftBtnTitle:@"取消" rightBtnTitle:@"立即充值" clickBtnBlock:^(NSInteger nIndex) {
        if (nIndex == 0)
        {
            
        }
        else if(nIndex == 1)
        {
            NSInteger hideSwitch = [[[AppInfo shareInstance].hideSwitch substringToIndex:1] integerValue];
            if (hideSwitch == 1)
            {
                [self pushCanvas:AppStore_Recharge_Canvas withArgument:nil];
            }
            else
            {
                [self pushCanvas:SelectModePay_Canvas withArgument:str];
            }
            
        }
    }];
    [alertView show];
    
}

@end
