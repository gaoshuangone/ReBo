//
//  VerifyResultViewController.m
//  BoXiu
//
//  Created by andy on 15/5/14.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import "VerifyResultViewController.h"
#import "UserInfoManager.h"

@interface VerifyResultViewController ()
@property (nonatomic,strong) UIImageView *verifyResultImageView;
@property (nonatomic,strong) UILabel *verifyResultLabel;
@end

@implementation VerifyResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"实名认证";
    
    _verifyResultImageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 51)/2, 180, 51, 51)];
    [self.view addSubview:_verifyResultImageView];
    
    _verifyResultLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 254, 300, 20)];
    _verifyResultLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    _verifyResultLabel.textAlignment = NSTextAlignmentCenter;
    _verifyResultLabel.textColor = [CommonFuction colorFromHexRGB:@"575757"];
    [self.view addSubview:_verifyResultLabel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    __weak typeof(self) weakself = self;
    [self setNavigationBarLeftItem:nil itemNormalImg:[UIImage imageNamed:@"navBack_normal"] itemHighlightImg:nil withBlock:^(id sender) {
        __strong typeof(weakself) strongself = weakself;
        if (strongself)
        {
            NSString *className = NSStringFromClass([strongself class]);
            NSDictionary *param = [NSDictionary dictionaryWithObject:className forKey:@"className"];
            [strongself popToCanvas:Setting_Canvas withArgument:param];
        }
    }];

    
    UserInfo *currentUserInfo = [UserInfoManager shareUserInfoManager].currentUserInfo;
    if (currentUserInfo)
    {
        if (currentUserInfo.authstatus == 1)
        {
            //待审核
            //您的申请已提交，请耐心等待审核
            _verifyResultImageView.image = [UIImage imageNamed:@"verifywait"];
            _verifyResultLabel.text = @"您的申请已提交，请耐心等待审核!";
        }
        else if (currentUserInfo.authstatus == 2)
        {
            //审核通过
            _verifyResultImageView.image = [UIImage imageNamed:@"verifysuccess"];
            _verifyResultLabel.text = @"认证成功!";
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
