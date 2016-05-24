//
//  TakeBackProtoclViewController.m
//  BoXiu
//
//  Created by andy on 15/12/2.
//  Copyright © 2015年 rexiu. All rights reserved.
//

#import "TakeBackProtoclViewController.h"
#define BottomHeight        50
#define ButtonHeight        35
#define ButtonWidth         100
#define TxquestionsUrl            @"chat/beantomoney/txquestions.talent"
@interface TakeBackProtoclViewController ()
@property (nonatomic,strong) UIButton* buttonBack;
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation TakeBackProtoclViewController
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    self.navigationController.navigationBarHidden = NO;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = YES;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UIControl* controlBG = [[UIControl alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    controlBG.backgroundColor = [CommonUtils colorFromHexRGB:@"f6f6f6"];
    [self.view addSubview:controlBG];
    
    _buttonBack = [UIButton buttonWithType:UIButtonTypeCustom];
    [_buttonBack setImage:[UIImage imageNamed:@"navB_Nor.png"] forState:UIControlStateHighlighted];
    [_buttonBack setImage:[UIImage imageNamed:@"backNew.png"] forState:UIControlStateNormal];
    _buttonBack.frame = CGRectMake(0, 20, 50, 40);
    _buttonBack.tag = 11;
    [_buttonBack addTarget:self action:@selector(buttonPres:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_buttonBack];
    
    UILabel* labelTitle = [CommonUtils commonSignleLabelWithText:@"常见问题" withFontSize:18 withOriginX:self.view.center.x withOriginY:20+21 isRelativeCoordinate:NO];
    labelTitle.textColor = [CommonUtils colorFromHexRGB:@"454a4d"];
    [self.view addSubview:labelTitle];
    

    UIView* viewLine = [CommonUtils CommonViewLineWithFrame:CGRectMake(0, 63.5, SCREEN_WIDTH, 0.5)];
    viewLine.backgroundColor = [UIColor grayColor];
    [self.view addSubview:viewLine];
    
    
    
    self.view.backgroundColor = [CommonFuction colorFromHexRGB:@"ffffff"];

    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, SCREEN_HEIGHT-64)];
    //        }
    [self.view addSubview:self.webView];
    [self.webView loadRequest:nil];
    self.webView.scrollView.backgroundColor = [UIColor whiteColor];
    
    NSString *agreemetUrl = [[AppInfo shareInstance].serverBaseUrl stringByAppendingPathComponent:TxquestionsUrl] ;
    
    [self.webView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:agreemetUrl]]];
    
    
    // Do any additional setup after loading the view.
}
-(void)buttonPres:(UIButton*)sener{
    [self popCanvasWithArgment:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -argument
-(void)argumentForCanvas:(id)argumentData
{
    
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
