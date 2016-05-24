



//
//  TakeBack_AutoBangWXViewController.m
//  BoXiu
//
//  Created by andy on 15/12/23.
//  Copyright © 2015年 rexiu. All rights reserved.
//

#import "TakeBack_AutoBangWXViewController.h"
#import "InitViewModel.h"
@interface TakeBack_AutoBangWXViewController ()
@property (nonatomic,strong) UIButton* buttonBack;
@property (nonatomic,strong) NSString* strJInE;
@property (nonatomic,strong) NSString* strwx;
@property (nonatomic,strong) NSString* strHuiLV;
@end

@implementation TakeBack_AutoBangWXViewController
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    self.navigationController.navigationBarHidden = NO;
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"notiRefarch" object:nil];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = YES;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notiRefarch) name:@"notiRefarch" object:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    UIControl* controlBG = [[UIControl alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    controlBG.backgroundColor = [CommonUtils colorFromHexRGB:@"f6f6f6"];
    [self.view addSubview:controlBG];
    
    self.view.backgroundColor = [CommonUtils colorFromHexRGB:@"ffffff"];
    _buttonBack = [UIButton buttonWithType:UIButtonTypeCustom];
    [_buttonBack setImage:[UIImage imageNamed:@"navB_Nor.png"] forState:UIControlStateHighlighted];
    [_buttonBack setImage:[UIImage imageNamed:@"backNew.png"] forState:UIControlStateNormal];
    _buttonBack.frame = CGRectMake(0, 20, 50, 40);
    _buttonBack.tag = 11;
    [_buttonBack addTarget:self action:@selector(buttonPres:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_buttonBack];
    
    UILabel* labelTitle = [CommonUtils commonSignleLabelWithText:@"首次提现账号绑定" withFontSize:18 withOriginX:self.view.center.x withOriginY:20+21 isRelativeCoordinate:NO];
    labelTitle.textColor = [CommonUtils colorFromHexRGB:@"454a4d"];
    [self.view addSubview:labelTitle];
    
    UIView* viewLine = [CommonUtils CommonViewLineWithFrame:CGRectMake(0, 63.5, SCREEN_WIDTH, 0.5)];
    viewLine.backgroundColor = [UIColor grayColor];
    [self.view addSubview:viewLine];
    
    
    
    self.view.backgroundColor = [CommonFuction colorFromHexRGB:@"ffffff"];
    
    
    UILabel* labeWxContent1 = [CommonUtils commonSignleLabelWithText:@"搜索并关注" withFontSize:17 withOriginX:self.view.center.x withOriginY:150+12 isRelativeCoordinate:NO];
    labeWxContent1.textColor = [CommonUtils colorFromHexRGB:@"959596"];
    [self.view addSubview:labeWxContent1];
    
    
    
    UILabel* noteLabel = [[UILabel alloc] init];
    noteLabel.frame = CGRectMake(0, 100, 200, 100);
    noteLabel.textColor = [CommonUtils colorFromHexRGB:@"f7c250"];
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:@"微信公众号: 热波间showtime"];
    NSRange redRange = NSMakeRange(0, [[noteStr string] rangeOfString:@":"].location+1);
    [noteStr addAttribute:NSForegroundColorAttributeName value:[CommonUtils colorFromHexRGB:@"959596"] range:redRange];
    [noteLabel setAttributedText:noteStr] ;
    [noteLabel sizeToFit];
    noteLabel.center = CGPointMake(self.view.center.x, 346/2+15);
    [self.view addSubview:noteLabel];
    
    UIImageView* imageView =[[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-534/2)/2, 450/2, 534/2, 518/2)];
    imageView.image = [UIImage imageNamed:@"TBpicGZ"];
    [self.view addSubview:imageView];


    // Do any additional setup after loading the view.
}
-(void)buttonPres:(UIButton*)sener{
    switch (sener.tag) {
        case 11://返回
              [self popToCanvas:@"TakeBackViewController" withArgument:nil];
            break;
            
        default:
            break;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -argument
-(void)argumentForCanvas:(id)argumentData
{
    
   
        self.strJInE = [argumentData valueForKey:@"jinE"];
        self.strwx = [argumentData valueForKey:@"wx"];
        self.strHuiLV = [argumentData valueForKey:@"huiLv"];
  
    
}
-(void)notiRefarch{
    InitViewModel* initViewModel = [[InitViewModel alloc]init];
    [initViewModel requestDataWithParams:nil success:^(id object) {
        if (initViewModel.result == 0)
        {
            
//            
//            bind = 0;
//            countlimit = 50;
//            lastaccount = "";
//            maxmoney = "6666.66";
//            minMoney = "0.01";
//            moneylimit = 1;
//            nickname = "\U590f\U672b";
//            rate = 1500;
//            subscribe = 0;
//            txcs = 0;
//            txzje = 0;
//            userbean = 10000000;
            
            
            NSDictionary* dict = [NSDictionary dictionaryWithDictionary:[object valueForKey:@"data"]];
            
           
//            self.subscribe =[[dict valueForKey:@"subscribe"]integerValue];
            
            if ([[dict valueForKey:@"bind"]integerValue] == 2) {
                
                NSString *canvasName = NSStringFromClass([self class]);
                NSDictionary* param = [NSDictionary dictionaryWithObjectsAndKeys:_strJInE,@"jinE",_strwx,@"wx",_strHuiLV,@"huiLv", nil];
                [self pushCanvas:@"TakeBack_2ViewController" withArgument:param];
                

            }
        }
    } fail:^(id object) {
        
   
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
