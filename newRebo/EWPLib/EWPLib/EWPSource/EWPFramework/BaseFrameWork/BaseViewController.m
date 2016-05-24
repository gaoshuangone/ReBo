//
//  BaseViewController.m
//  EWPLib
//
//  Created by andy on 14-8-29.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import "BaseViewController.h"
#import "EWPLib.h"
#import "EWPFramework.h"

#import "Reachability.h"




@interface BaseViewController ()<UIScrollViewDelegate>
{
    NavigationTouchButton nvLeftBtnAction;
    NavigationTouchButton nvRightBtnAction;
    
    /*上拉加载*/
    MJRefreshFooterView *_footer;
    
    /*下拉刷新*/
    MJRefreshHeaderView *_header;
    
    
}


@end

@implementation BaseViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    if (_tableView)
    {
        [_tableView free];
    }
}


- (id)init
{
    self = [super init];
    if (self)
    {
        if ([[EWPLib shareInstance] respondsToSelector:@selector(isSuccessOfInit)])
        {
            if (![[EWPLib shareInstance] isSuccessOfInit])
            {
                self = nil;
            }
        }
        else
        {
            self = nil;
        }
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.baseViewType = kbaseViewType;
        
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    
    /*如果view里包含scrollview，不设置此属性，会显示位置不正确。*/
    self.automaticallyAdjustsScrollViewInsets = NO;
    /*view里子视图如果不偏移64像素，会被覆盖*/
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.modalPresentationCapturesStatusBarAppearance = NO;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    CGRect rect = self.view.frame;
    rect.origin.y += 20;
    rect.size.height -= 20;
    self.view.frame = rect;
    
    
    if (self.baseViewType == kbaseScroolViewType)
    {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
        _scrollView.delegate = self;
        _scrollView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:_scrollView];
    }
    else if(self.baseViewType == kbaseTableViewType)
    {
        _tableView = [[BaseTableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
    }
    
}
- (void) reachabilityChanged:(NSNotification *)note
{
    Reachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
    [self configureTextField:nil imageView:nil reachability:curReach];
}

- (void)configureTextField:(UITextField *)textField imageView:(UIImageView *)imageView reachability:(Reachability *)reachability
{
    NetworkStatus netStatus = [reachability currentReachabilityStatus];
    
    switch (netStatus)
    {
        case NotReachable:        {
            [AppInfo shareInstance].network = 0;
            break;
        }
            
        case ReachableViaWWAN:        {
            [AppInfo shareInstance].network = 1;
            break;
        }
        case ReachableViaWiFi:        {
            [AppInfo shareInstance].network = 2;
            break;
        }
    }
}


- (void)addTableViewWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (_tableView) {
        [_tableView removeFromSuperview];
        _tableView = nil;
    }
    _tableView = [[BaseTableView alloc] initWithFrame:frame style:style];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

#pragma mark - tableView

- (void)setBaseViewType:(BaseViewType)baseViewType
{
    _baseViewType = baseViewType;
    if (_baseViewType == kbaseTableViewType)
    {
        self.loadMore = YES;
        
        self.refresh = YES;
    }
}

- (void)setLoadMore:(BOOL)loadMore
{
    if (_loadMore == loadMore)
    {
        return;
    }
    _loadMore = loadMore;
    if (_tableView)
    {
        _tableView.loadMore = _loadMore;
    }
}

- (void)setRefresh:(BOOL)refresh
{
    if (_refresh == refresh)
    {
        return;
    }
    _refresh = refresh;
    if (_tableView)
    {
        _tableView.refresh = _refresh;
    }
}

#pragma mark - ICanvasProtocol

- (BaseViewController *)pushCanvas:(NSString *) canvasName withArgument:(id)argumentData
{
    if (canvasName == nil) {
        return nil;
    }
    BaseViewController *canvasController = nil;
    Class object = NSClassFromString(canvasName);
    canvasController = (BaseViewController *)[[object alloc] init];
    if (canvasController)
    {
        
        if ([canvasController respondsToSelector:@selector(argumentForCanvas:)]) {
            [canvasController argumentForCanvas:argumentData];
        }
        //        if ([canvasName isEqualToString:PersonInfo_Canvas]|| [canvasName isEqualToString:Login_Canvas] || [canvasName isEqualToString:Search_Canvas]) {//隐藏navBar时候卡顿，暂时去掉push动画
        //        [self.navigationController pushViewController:(UIViewController *)canvasController animated:NO];
        //        }else{
        
        //        if (self.isShouldPop) {
        //
        //            [[AppDelegate shareAppDelegate].navigationController pushViewController:(UIViewController *)canvasController animated:[UIView areAnimationsEnabled]];
        //            self.isShouldPop = NO;
        //        }else{
        [self.navigationController pushViewController:(UIViewController *)canvasController animated:[UIView areAnimationsEnabled]];
        //        }
        //        }
        
    }
    
    return canvasController;
}

- (BaseViewController *)popCanvasWithArgment:(id)argumentData
{
    BaseViewController *canvasController = nil;
    NSUInteger nViewControllerCount = [self.navigationController.viewControllers count];
    if (nViewControllerCount >= 2)
    {
        BaseViewController *canvasController = [self.navigationController.viewControllers objectAtIndex:nViewControllerCount - 2];
        if (canvasController)
        {
            if ([canvasController respondsToSelector:@selector(argumentForCanvas:)]) {
                [canvasController argumentForCanvas:argumentData];
            }
            [self.navigationController popViewControllerAnimated:YES];
            
        }
    }
    return canvasController;
    
}

- (BaseViewController *)popToCanvas:(NSString *) canvasName withArgument:(id)argumentData
{
    if (canvasName == nil) {
        return nil;
    }
    BaseViewController *canvasController = nil;
    Class object = NSClassFromString(canvasName);
    
    for (BaseViewController *canvasController in self.navigationController.viewControllers)
    {
        if (canvasController && [canvasController isKindOfClass:[object class]])
        {
            if ([canvasController respondsToSelector:@selector(argumentForCanvas:)]) {
                [canvasController argumentForCanvas:argumentData];
            }
            [self.navigationController popToViewController:(UIViewController *)canvasController animated:YES];
            break;
        }
    }
    return canvasController;
}

- (BaseViewController *)popToRootCanvasWithArgment:(id)argumentData
{
    BaseViewController *canvasController = nil;
    canvasController = [self.navigationController.viewControllers objectAtIndex:0];
    if (canvasController)
    {
        
        if ([canvasController respondsToSelector:@selector(argumentForCanvas:)]) {
            [canvasController argumentForCanvas:argumentData];
        }
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    return canvasController;
}

- (void)argumentForCanvas:(id)argumentData
{
    EWPLog(@"BaseCanvas argumentForCanvas");
}

#pragma mark - NavigationLefButton

- (void)setNavigationBarLeftItem:(NSString *)title itemNormalImg:(UIImage *)itemNormalImg  itemHighlightImg:(UIImage *)itemHighlightImg withBlock:(NavigationTouchButton)block
{
    if (block == nil) {
        return;
    }
    if (title == nil && itemNormalImg == nil)
    {
        return;
    }
    
    int nBtnWidth = 0;
    int nBtnHeight = 0;
    if (itemNormalImg)
    {
        nBtnWidth = itemNormalImg.size.width;
        nBtnHeight = itemNormalImg.size.height;
        if (itemNormalImg.size.width >44 && itemNormalImg.size.height >44) {
            nBtnWidth = 30;
            nBtnHeight = 30;
        }
        
    }
    else
    {
        CGSize size = [CommonFuction sizeOfString:title maxWidth:200 maxHeight:44 withFontSize:14.0f];
        nBtnWidth = size.width;
        nBtnHeight = size.height;
    }
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    if (block)
    {
        nvLeftBtnAction = [block copy];
    }
    [btn addTarget:self action:@selector(OnClickLeft:) forControlEvents:UIControlEventTouchUpInside];
    [btn setFrame:CGRectMake(0, 0, nBtnWidth, nBtnHeight)];
    /*这里可以加按钮背景*/
    if (itemNormalImg)
    {
        [btn setBackgroundImage:itemNormalImg forState:UIControlStateNormal];
    }
    if (itemHighlightImg)
    {
        [btn setBackgroundImage:itemHighlightImg forState:UIControlStateHighlighted];
    }
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    btn.layer.cornerRadius = 15;
    btn.layer.masksToBounds = YES;
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithCustomView:btn];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = -2;
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, backBtn, nil];
    
}

- (void)OnClickLeft:(id)sender
{
    if (nvLeftBtnAction)
    {
        nvLeftBtnAction(sender);
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - NavigationRightButton
- (void)setNavigationBarRightItem:(NSString *)title itemNormalImg:(UIImage *)itemNormalImg  itemHighlightImg:(UIImage *)itemHighlightImg withBlock:(NavigationTouchButton)block
{
    if (block == nil) {
        return;
    }
    if (title == nil && itemNormalImg == nil)
    {
        return;
    }
    nvRightBtnAction = nil;
    nvRightBtnAction = [block copy];
    int nBtnWidth = 0;
    int nBtnHeight = 0;
    if (itemNormalImg)
    {
        nBtnWidth = itemNormalImg.size.width;
        nBtnHeight = itemNormalImg.size.height;
    }
    else
    {
        CGSize size = [CommonFuction sizeOfString:title maxWidth:200 maxHeight:44 withFontSize:14.0f];
        nBtnWidth = size.width;
        nBtnHeight = size.height;
    }
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(OnClickRight:) forControlEvents:UIControlEventTouchUpInside];
    [btn setFrame:CGRectMake(0, 0, nBtnWidth, nBtnHeight)];
    /*这里可以加按钮背景*/
    if (itemNormalImg)
    {
        [btn setBackgroundImage:itemNormalImg forState:UIControlStateNormal];
    }
    if (itemHighlightImg)
    {
        [btn setBackgroundImage:itemHighlightImg forState:UIControlStateHighlighted];
    }
    
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[CommonFuction colorFromHexRGB:@"454a4d"] forState:UIControlStateNormal];
    btn.titleLabel.textColor = [UIColor whiteColor];
    btn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = rightBtn;
}

- (void)OnClickRight:(id)sender
{
    if (nvRightBtnAction)
    {
        nvRightBtnAction(sender);
    }
}


#pragma mark - Canvas请求数据接口

- (void)requestDataWithAnalyseModel:(Class )analyseModel params:(NSDictionary *)params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    if ([AppInfo shareInstance].network ==0 || ![AppInfo IsEnableConnection])
    {
        [self.rootViewController showNoticeInWindow:@"您的网络有问题,请检查网络" duration:1.5];
        return;
    }else
    {
        if ([AppInfo shareInstance].nowtimesMillis == 0) {
            [[AppDelegate shareAppDelegate] enter:nil];
        }
    }
    
    if (analyseModel == nil)
    {
        return;
    }
    HttpModel *httpModel = [[analyseModel alloc] init];
    if (httpModel && [httpModel respondsToSelector:@selector(requestDataWithParams:success:fail:)])
    {
        MBProgressHUD *mbProgressHud = nil;
        if (_progressViewBlock)
        {
            _progressViewBlock(YES);
        }
        else
        {
            if (!self.hideProgressHud)
            {
                mbProgressHud = [[MBProgressHUD alloc] initWithView:self.view];
                [self.view addSubview:mbProgressHud];
                [mbProgressHud show:YES];
            }
        }
        
        [httpModel requestDataWithParams:params success:^(id object)
         {
             success(object);
             if (_progressViewBlock)
             {
                 _progressViewBlock(NO);
             }
             else
             {
                 if (!self.hideProgressHud)
                 {
                     [mbProgressHud hide:YES];
                 }
             }
         }
                                    fail:^(id sender)
         {
             if (_progressViewBlock)
             {
                 _progressViewBlock(NO);
             }
             else
             {
                 if (!self.hideProgressHud)
                 {
                     [mbProgressHud hide:YES];
                 }
             }
             
             [self showNoticeInWindow:@"网络连接失败，请重试" duration:1.5];
             fail(sender);
         }];
    }
}

#pragma  mark - canvas界面上传文件接口
- (void)uploadDataWithAnalyseModel:(Class )analyseModel fileUrl:(NSString *)fileUrl params:(NSDictionary *)params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail;
{
    if (analyseModel == nil)
    {
        return;
    }
    HttpModel *httpModel = [[analyseModel alloc] init];
    if (httpModel && [httpModel respondsToSelector:@selector(uploadDataWithFileUrl:params:success:fail:)])
    {
        MBProgressHUD *mbProgressHud = nil;
        if (_progressViewBlock)
        {
            _progressViewBlock(YES);
        }
        else
        {
            if (!self.hideProgressHud)
            {
                mbProgressHud = [[MBProgressHUD alloc] initWithView:self.view];
                [self.view addSubview:mbProgressHud];
                [mbProgressHud show:YES];
            }
        }
        [httpModel uploadDataWithFileUrl:fileUrl params:params success:^(id object) {
            success(object);
            if (_progressViewBlock)
            {
                _progressViewBlock(NO);
            }
            else
            {
                if (!self.hideProgressHud)
                {
                    [mbProgressHud hide:YES];
                }
            }
            
        } fail:^(id object) {
            if (_progressViewBlock)
            {
                _progressViewBlock(NO);
            }
            else
            {
                if (!self.hideProgressHud)
                {
                    [mbProgressHud hide:YES];
                }
            }
            
            [self showNoticeInWindow:@"网络连接失败，请重试" duration:1.5];
            fail(object);
            
        }];
    }
}

#pragma mark - AlertView

- (void)showAlertView:(NSString *)title message:(NSString *)message confirm:(AlertViewBlock)confirm cancel:(AlertViewBlock)cancel
{
    dispatch_async(dispatch_get_main_queue(), ^{
        EWPAlertView *alertView = [[EWPAlertView alloc] initWithTitle:title message:message confirmBlock:confirm cancelBlock:cancel];
        if (alertView)
        {
            [alertView show];
        }
    });
}

#pragma mark - ActionSheetView

- (void)showActionSheetView:(NSString *)title buttonTitles:(NSArray *)buttonTitles actionSheetBlock:(ActionSheetBlock)actionSheetBlock
{
    EWPActionSheet *actionSheet = [[EWPActionSheet alloc] initWithTitle:title buttonTitles:buttonTitles actionSheetBlock:actionSheetBlock];
    if (actionSheet)
    {
        [actionSheet show];
    }
}

#pragma mark - ShowNotice
/*自定义短暂性提示框*/
- (void)showNotice:(NSString *)message
{
    //默认设为2.
    [self showNotice:message duration:2];
}

- (void)showNotice:(NSString *)message duration:(CGFloat)duration
{
    if (message != nil && [message length])
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
            MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithWindow:keyWindow];
            HUD.yOffset = 130;
            HUD.margin = 5;
            HUD.labelFont = [UIFont systemFontOfSize:14.0f];
            HUD.removeFromSuperViewOnHide=YES;
            HUD.mode = MBProgressHUDModeCustomView;
            CGSize size = [CommonFuction sizeOfString:message maxWidth:300 maxHeight:100 withFontSize:14.0f];
            UILabel *messageLable = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, size.width + 10, size.height + 10)];
            messageLable.font = [UIFont systemFontOfSize:14.0f];
            messageLable.numberOfLines = 0;
            messageLable.lineBreakMode = NSLineBreakByWordWrapping;
            messageLable.textAlignment = NSTextAlignmentCenter;
            messageLable.alpha = 0.8;
            messageLable.layer.cornerRadius = 12.0f;
            messageLable.backgroundColor = [UIColor clearColor];
            messageLable.textColor = [UIColor whiteColor];
            messageLable.text = message;
            HUD.customView = messageLable;
            [self.view addSubview:HUD];
            [HUD show:YES];
            [HUD hide:YES afterDelay:duration];
        });
    }
}

- (void)showNoticeInWindow:(NSString *)message
{
    [self showNoticeInWindow:message duration:2];
    self.view.userInteractionEnabled = NO;
    [self performSelector:@selector(useraTouch) withObject:self afterDelay:2];//解决不同页面调用多次弹框的问题请我e4wqeeew4e41
}

- (void)showNoticeInWindow:(NSString *)message duration:(CGFloat)duration
{
    if (message != nil && [message length])
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
            
            MBProgressHUD* vie = (MBProgressHUD*)[keyWindow viewWithTag:1001];
            if (vie) {
                [vie removeFromSuperview];
                vie = nil;
            }
            MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithWindow:keyWindow];
            HUD.yOffset = 200;
            HUD.margin = 5;
            HUD.labelFont = [UIFont systemFontOfSize:14.0f];
            HUD.removeFromSuperViewOnHide=YES;
            HUD.mode = MBProgressHUDModeCustomView;
            CGSize size = [CommonFuction sizeOfString:message maxWidth:300 maxHeight:100 withFontSize:14.0f];
            UILabel *messageLable = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, size.width + 10, size.height + 10)];
            messageLable.font = [UIFont systemFontOfSize:14.0f];
            messageLable.numberOfLines = 0;
            HUD.tag = 1001;
            messageLable.lineBreakMode = NSLineBreakByWordWrapping;
            messageLable.textAlignment = NSTextAlignmentCenter;
            messageLable.alpha = 0.8;
            messageLable.layer.cornerRadius = 12.0f;
            messageLable.backgroundColor = [UIColor clearColor];
            messageLable.textColor = [UIColor whiteColor];
            messageLable.text = message;
            HUD.customView = messageLable;
            [keyWindow addSubview:HUD];
            [HUD show:YES];
            [HUD hide:YES afterDelay:duration];
            
            
            
        });
    }
    
}
-(void)useraTouch{
    self.view.userInteractionEnabled = YES;
}

#pragma mark - NotifyKeyBoard
/*打开监测*/
- (void)addNotifyKeyBoard
{
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self
                           selector:@selector(notifyShowKeyBoard:)
                               name:UIKeyboardWillShowNotification
                             object:nil];
    [notificationCenter addObserver:self
                           selector:@selector(notifyHideKeyBoard:)
                               name:UIKeyboardWillHideNotification
                             object:nil];
}

/*关闭监测*/
- (void)removeNotifyKeyBoard
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

/*当键盘快要显示时调用*/
- (void)notifyShowKeyBoard:(NSNotification *)notification
{
    //默认不做任何处理
}

- (void)notifyHideKeyBoard:(NSNotification *)notification
{
    //默认不做任何处理
}

@end
