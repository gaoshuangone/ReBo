//
//  LiveProtocolViewController.m
//  BoXiu
//
//  Created by CaiZetong on 15/7/22.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import "LiveProtocolViewController.h"
#import "EWPButton.h"
#import "LiveRoomViewController.h"
#import "UserInfoManager.h"

#define BottomHeight        50
#define ButtonHeight        35
#define ButtonWidth         100

#define AgreeUrl            @"chat/roomshow/agreeallshow.talent"


@interface LiveProtocolViewController ()

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation LiveProtocolViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    [self setNeedsStatusBarAppearanceUpdate];
    
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [CommonFuction colorFromHexRGB:@"f6f6f6"];
    self.title = @"开播协议";
    __weak typeof(self) weakself = self;
    [self setNavigationBarLeftItem:nil itemNormalImg:[UIImage imageNamed:@"navBack_normal"] itemHighlightImg:nil withBlock:^(id sender) {
        __strong typeof(self) strongself = weakself;
        if (strongself)
        {
            NSString *className = NSStringFromClass([weakself class]);
            NSDictionary *param = [NSDictionary dictionaryWithObject:className forKey:@"className"];
            [strongself popCanvasWithArgment:param];
        }
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    if (!self.webView)
    {
        
      
        
//        if ([AppInfo ip5]) {
//       
//                   self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - BottomHeight-40-10)];
//        }else{
//  self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, SCREEN_HEIGHT - BottomHeight-3-64)];
          self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, SCREEN_HEIGHT - BottomHeight)];
//        }
        [self.view addSubview:self.webView];
        [self.webView loadRequest:nil];
        self.webView.scrollView.backgroundColor = [UIColor whiteColor];
        
        NSString *agreemetUrl = [[AppInfo shareInstance].serverBaseUrl stringByAppendingPathComponent:AgreeUrl] ;
        
        [self.webView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:agreemetUrl]]];
        
//        EWPButton *agreeButton = [[EWPButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - ButtonWidth / 2  , CGRectGetMaxY(self.webView.frame) + 10, ButtonWidth, ButtonHeight)];
//        [agreeButton setTitle:@"同意" forState:UIControlStateNormal];
//        agreeButton.titleLabel.font = [UIFont systemFontOfSize:18.0f];
//        agreeButton.layer.cornerRadius = ButtonHeight/2;
//        agreeButton.clipsToBounds = YES;
//        [agreeButton setTitleColor:[CommonFuction colorFromHexRGB:@"ffffff"] forState:UIControlStateNormal];
////        [agreeButton setBackgroundColor:[CommonFuction colorFromHexRGB:@"01b6a1"]];
//        
//        UIImage *normalImg = [CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"d14c49"] size:CGSizeMake(ButtonWidth, ButtonHeight)];
//        UIImage *highImg = [CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"d14c49"] size:CGSizeMake(ButtonWidth, ButtonHeight)];
//        
//        [agreeButton setBackgroundImage:normalImg forState:UIControlStateNormal];
//        [agreeButton setBackgroundImage:IMAGE_SUBJECT_SEL(ButtonWidth, ButtonHeight) forState:UIControlStateHighlighted];
//        [self.view addSubview:agreeButton];
        
//        agreeButton.buttonBlock = ^(id sender)
//        {
//            agreeButton.userInteractionEnabled = NO;
//            NSLog(@"base:%@",[AppInfo shareInstance].serverBaseUrl);
//            __block BaseHttpModel *model = [[BaseHttpModel alloc] init];
//            [model requestDataWithMethod:SubmitAgreeAllShow params:nil success:^(id object)
//             {
//                 model = object;
//                 
//                 
//                 if (model.result == 0 || model.result == 1)
//                 {
//                     
//                     model = object;
//                     [AppDelegate shareAppDelegate].isSelfWillLive = NO;
//                     [AppDelegate shareAppDelegate].isSelfWillLive = YES;
//                     
//                     //可以开播
//                     //                     [AppDelegate shareAppDelegate].showingLeftMenu = YES;
//                     //                     LiveRoomViewController *viewController = [[LiveRoomViewController alloc] init];
//                     //                     [self.navigationController pushViewController:viewController animated:YES];
//                     Class viewControllerType = NSClassFromString(LiveRoom_CanVas);
//                     UIViewController *viewController = [[viewControllerType alloc] init];
//                     
//                     [viewController setValue:@([UserInfoManager shareUserInfoManager].currentUserInfo.userId) forKey:@"staruserid"];
//                     //                     NSDictionary *param = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:[UserInfoManager shareUserInfoManager].currentUserInfo.userId] forKey:@"staruserid"];
//                     //                     ;
//                     //                       [self popToRootCanvasWithArgment:self];
//                     //                     [self pushViewController:viewController];
//                     NSString *className = NSStringFromClass([self class]);
//                     NSMutableDictionary *param =[NSMutableDictionary dictionary];
//                     [param setObject:className forKey:@"className"];
//                     [param setObject:[NSNumber numberWithInt:[UserInfoManager shareUserInfoManager].currentUserInfo.userId] forKey:@"staruserid"];
//                     
//                     [[AppDelegate shareAppDelegate].lrSliderMenuViewController closeSliderMenu];
//                     //                     par
//                     
//                     agreeButton.userInteractionEnabled = YES;
//                     [self pushCanvas:LiveRoom_CanVas withArgument:param];
//                     
//                     //                     NSDictionary *param = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:[UserInfoManager shareUserInfoManager].currentUserInfo.userId] forKey:@"staruserid"];
//                     //                     ;
//                     //                     [self pushCanvas:LiveRoom_CanVas withArgument:param];
//                 }
//                 NSLog(@"object:%@", object);
//             } fail:^(id object)
//             {
//                 agreeButton.userInteractionEnabled = YES;
//                 [self showNotice:@"出错了，请重试" duration:2.0f];
//             }];
//        };
    }

}

//- (void)pushViewController:(UIViewController *)viewController
//{
//    [[AppDelegate shareAppDelegate].lrSliderMenuViewController closeSliderMenu];
//    [[AppDelegate shareAppDelegate].navigationController pushViewController:viewController animated:YES];
//    
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
