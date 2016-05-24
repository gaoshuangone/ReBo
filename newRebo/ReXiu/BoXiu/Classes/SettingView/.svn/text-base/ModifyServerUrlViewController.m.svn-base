//
//  ModifyServerUrlViewController.m
//  BoXiu
//
//  Created by andy on 14-7-24.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "ModifyServerUrlViewController.h"
#import "UserInfoManager.h"

@interface ModifyServerUrlViewController ()

@end

@implementation ModifyServerUrlViewController

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
    self.title = @"修改服务器地址";
    
    CGFloat yOffset = 10;
    CGFloat yGap = 10;
    UIButton *button8 = [UIButton buttonWithType:UIButtonTypeCustom];
    button8.frame= CGRectMake(20, yOffset, 280, 40);
    button8.tag = 8;
    [button8 setBackgroundImage:[UIImage imageNamed:@"bigBtn_normal.png"] forState:UIControlStateNormal];
    [button8 setBackgroundImage:[UIImage imageNamed:@"bigBtn_selected.png"] forState:UIControlStateSelected];
    [button8 setTitle:@"SUNNY服务器" forState:UIControlStateNormal];
    [button8 addTarget:self action:@selector(modifyServerUrl:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button8];
    
    yOffset += 40+yGap;
    UIButton *button10 = [UIButton buttonWithType:UIButtonTypeCustom];
    button10.frame= CGRectMake(20, yOffset, 280, 40);
    button10.tag = 10;
    [button10 setBackgroundImage:[UIImage imageNamed:@"bigBtn_normal.png"] forState:UIControlStateNormal];
    [button10 setBackgroundImage:[UIImage imageNamed:@"bigBtn_selected.png"] forState:UIControlStateSelected];
    [button10 setTitle:@"SUN服务器" forState:UIControlStateNormal];
    [button10 addTarget:self action:@selector(modifyServerUrl:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button10];
    
    yOffset += 40+yGap;
    UIButton *button9 = [UIButton buttonWithType:UIButtonTypeCustom];
    button9.frame= CGRectMake(20, yOffset, 280, 40);
    button9.tag = 9;
    [button9 setBackgroundImage:[UIImage imageNamed:@"bigBtn_normal.png"] forState:UIControlStateNormal];
    [button9 setBackgroundImage:[UIImage imageNamed:@"bigBtn_selected.png"] forState:UIControlStateSelected];
    [button9 setTitle:@"LuQi服务器" forState:UIControlStateNormal];
    [button9 addTarget:self action:@selector(modifyServerUrl:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button9];
    
    yOffset += 40+yGap;
    UIButton *button6 = [UIButton buttonWithType:UIButtonTypeCustom];
    button6.frame= CGRectMake(20, yOffset, 280, 40);
    button6.tag = 6;
    [button6 setBackgroundImage:[UIImage imageNamed:@"bigBtn_normal.png"] forState:UIControlStateNormal];
    [button6 setBackgroundImage:[UIImage imageNamed:@"bigBtn_selected.png"] forState:UIControlStateSelected];
    [button6 setTitle:@"谭耀武服务器" forState:UIControlStateNormal];
    [button6 addTarget:self action:@selector(modifyServerUrl:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button6];
    
    yOffset += 40+yGap;
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame= CGRectMake(20, yOffset, 280, 40);
    button1.tag = 1;
    [button1 setBackgroundImage:[UIImage imageNamed:@"bigBtn_normal.png"] forState:UIControlStateNormal];
    [button1 setBackgroundImage:[UIImage imageNamed:@"bigBtn_selected.png"] forState:UIControlStateSelected];
    [button1 setTitle:@"许飞服务器" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(modifyServerUrl:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
    yOffset += 40+yGap;
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame= CGRectMake(20, yOffset, 280, 40);
    button2.tag = 2;
    [button2 setBackgroundImage:[UIImage imageNamed:@"bigBtn_normal.png"] forState:UIControlStateNormal];
    [button2 setBackgroundImage:[UIImage imageNamed:@"bigBtn_selected.png"] forState:UIControlStateSelected];
    [button2 setTitle:@"文磊服务器" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(modifyServerUrl:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
    yOffset += 40+yGap;
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    button3.frame= CGRectMake(20, yOffset, 280, 40);
    button3.tag = 3;
    [button3 setBackgroundImage:[UIImage imageNamed:@"bigBtn_normal.png"] forState:UIControlStateNormal];
    [button3 setBackgroundImage:[UIImage imageNamed:@"bigBtn_selected.png"] forState:UIControlStateSelected];
    [button3 setTitle:@"测试服务器" forState:UIControlStateNormal];
    [button3 addTarget:self action:@selector(modifyServerUrl:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button3];
    
    yOffset += 40+yGap;
    UIButton *button4 = [UIButton buttonWithType:UIButtonTypeCustom];
    button4.frame= CGRectMake(20, yOffset, 280, 40);
    button4.tag = 4;
    [button4 setBackgroundImage:[UIImage imageNamed:@"bigBtn_normal.png"] forState:UIControlStateNormal];
    [button4 setBackgroundImage:[UIImage imageNamed:@"bigBtn_selected.png"] forState:UIControlStateSelected];
    [button4 setTitle:@"模测服务器" forState:UIControlStateNormal];
    [button4 addTarget:self action:@selector(modifyServerUrl:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button4];
    
    yOffset += 40+yGap;
    UIButton *button5 = [UIButton buttonWithType:UIButtonTypeCustom];
    button5.frame= CGRectMake(20, yOffset, 280, 40);
    button5.tag = 5;
    [button5 setBackgroundImage:[UIImage imageNamed:@"bigBtn_normal.png"] forState:UIControlStateNormal];
    [button5 setBackgroundImage:[UIImage imageNamed:@"bigBtn_selected.png"] forState:UIControlStateSelected];
    [button5 setTitle:@"现网服务器" forState:UIControlStateNormal];
    [button5 addTarget:self action:@selector(modifyServerUrl:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button5];
    
    yOffset += 40+yGap;
    UIButton *button7 = [UIButton buttonWithType:UIButtonTypeCustom];
    button7.frame= CGRectMake(20, yOffset, 280, 40);
    button7.tag = 7;
    [button7 setBackgroundImage:[UIImage imageNamed:@"bigBtn_normal.png"] forState:UIControlStateNormal];
    [button7 setBackgroundImage:[UIImage imageNamed:@"bigBtn_selected.png"] forState:UIControlStateSelected];
    [button7 setTitle:@"性能服务器" forState:UIControlStateNormal];
    [button7 addTarget:self action:@selector(modifyServerUrl:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button7];
    
    
    EWPButton* buttonMMPlaceHolder = [EWPButton buttonWithType:UIButtonTypeCustom];
    [buttonMMPlaceHolder setTitle:@"视觉" forState:UIControlStateNormal];
    [buttonMMPlaceHolder setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    buttonMMPlaceHolder.frame = CGRectMake(0, 0, 50, 50);
    buttonMMPlaceHolder.buttonBlock = ^(EWPButton* sender ){
        [self pushCanvas:@"MMPlaceHolderSetViewController" withArgument:nil];
    };
    UIBarButtonItem * barItem = [[UIBarButtonItem alloc]initWithCustomView:buttonMMPlaceHolder];
    self.navigationItem.rightBarButtonItem = barItem;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    UIButton *button = (UIButton *)[self.view viewWithTag:[AppInfo shareInstance].serverType];
    button.selected = YES;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)modifyServerUrl:(id)sender
{
    UIButton *button = (UIButton *)sender;
    
    UIButton *oldbutton = (UIButton *)[self.view viewWithTag:[AppInfo shareInstance].serverType];
    oldbutton.selected = NO;
    
    button.selected = YES;
    
    //保存appserverurl
    [[AppInfo shareInstance] saveServerType:button.tag];
    
    //恢复app初始状态
    [self resetAppState];

//    [self popCanvasWithArgment:nil];
}

- (void)resetAppState
{
    //appInfo
    [UserInfoManager shareUserInfoManager].currentUserInfo = nil;
    [MessageCenter shareMessageCenter].unReadCount = 0;
    //删除数据库
    [[MessageCenter shareMessageCenter] deleteAllMessage];
    
    [AppInfo shareInstance].initCoinfigState = 1;
//    [[AppInfo shareInstance] initConfigInfo];
    
    //切换APP尽力保持跟新安装的app一样
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //恢复首次登录
    [defaults removeObjectForKey:@"loginType"];
    [defaults removeObjectForKey:@"login_name"];
    [defaults removeObjectForKey:@"login_password"];
    [defaults removeObjectForKey:@"auto_user"];
    //恢复送礼引导
    [defaults removeObjectForKey:@"GiftGuide"];
    [defaults synchronize];
    exit(0);

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
