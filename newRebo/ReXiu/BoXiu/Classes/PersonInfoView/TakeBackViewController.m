//
//  TakeBackViewController.m
//  BoXiu
//
//  Created by andy on 15/11/30.
//  Copyright © 2015年 rexiu. All rights reserved.
//

#import "TakeBackViewController.h"
#import "InitViewModel.h"


@interface TakeBackViewController ()
@property (strong, nonatomic)UILabel* labelDou;
@property (strong, nonatomic)UILabel* labelJinE;
@property (strong, nonatomic)UILabel* labelTiXian;
@property (nonatomic,strong) UIButton* buttonBack;
@property (nonatomic,strong) UIButton* buttonList;
@property (nonatomic,strong) NSDictionary* dictData;
@property (nonatomic,strong) UIWebView* webView;

@property (assign,nonatomic) NSInteger bind;//0未授权，1已授权，2已授权和已关注,（可提现）
@property (assign,nonatomic) NSInteger subscribe;//1:已关注，0未关注

@end

@implementation TakeBackViewController
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    self.navigationController.navigationBarHidden = NO;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = YES;
       [self getData];
}
-(void)time{
    [_webView  reload];
    
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
    
    UILabel* labelTitle = [CommonUtils commonSignleLabelWithText:@"提现中心" withFontSize:18 withOriginX:self.view.center.x withOriginY:20+21 isRelativeCoordinate:NO];
    labelTitle.textColor = [CommonUtils colorFromHexRGB:@"454a4d"];
    [self.view addSubview:labelTitle];
    
    _buttonList = [UIButton buttonWithType:UIButtonTypeCustom];
    [_buttonList setImage:[UIImage imageNamed:@"TBlist.png"] forState:UIControlStateNormal];
    _buttonList.frame = CGRectMake(SCREEN_WIDTH-50, 20, 50, 40);
    _buttonList.tag = 12;
    [_buttonList addTarget:self action:@selector(buttonPres:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_buttonList];
    
    UIView* viewLine = [CommonUtils CommonViewLineWithFrame:CGRectMake(0, 63.5, SCREEN_WIDTH, 0.5)];
    viewLine.backgroundColor = [UIColor grayColor];
    [self.view addSubview:viewLine];
    

    
    self.view.backgroundColor = [CommonFuction colorFromHexRGB:@"ffffff"];

    


    
    CGFloat UpDis = 256/2;
    
    UIImageView* iamgeViewIcon =[[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-69)/2, UpDis, 69, 69)];
    iamgeViewIcon.image = [UIImage imageNamed:@"TBdou.png"];
    [self.view addSubview:iamgeViewIcon];
    
    UpDis+=69+20;
    
    UILabel* labeoText = [CommonUtils commonSignleLabelWithText:@"拥有热豆" withFontSize:11 withOriginX:self.view.center.x withOriginY:UpDis isRelativeCoordinate:NO];
    [labeoText comFontSetCenter:[UIFont boldSystemFontOfSize:11]];
    labeoText.textColor = [CommonFuction colorFromHexRGB:@"4a5a5d"];
   
    [self.view addSubview: labeoText];
    
    
    UpDis+=labeoText.boundsHeight+10;
    
    _labelDou = [CommonUtils commonSignleLabelWithText:@"0000" withFontSize:24 withOriginX:self.view.center.x withOriginY:UpDis isRelativeCoordinate:NO];
    _labelDou.textColor =[CommonUtils colorFromHexRGB:@"f7c250"];
    [self.view addSubview:_labelDou];
    
    
    UpDis+=_labelDou.boundsHeight+16;
    
    UILabel* labelTotol = [CommonUtils commonSignleLabelWithText:@"总金额(元)" withFontSize:13 withOriginX:self.view.center.x-50 withOriginY:UpDis isRelativeCoordinate:NO];
    labelTotol.textColor = [CommonUtils colorFromHexRGB:@"959596"];
    [self.view addSubview:labelTotol];
    
    UILabel* labelTiXian = [CommonUtils commonSignleLabelWithText:@"可提现(元)" withFontSize:13 withOriginX:self.view.center.x+50 withOriginY:UpDis isRelativeCoordinate:NO];
    labelTiXian.textColor = [CommonUtils colorFromHexRGB:@"959596"];
    [self.view addSubview:labelTiXian];
    
    UpDis +=labelTotol.boundsHeight+6;
    _labelJinE = [CommonUtils commonSignleLabelWithText:@"000" withFontSize:19 withOriginX:labelTotol.center.x withOriginY:UpDis isRelativeCoordinate:NO];
     _labelJinE.textColor = [CommonUtils colorFromHexRGB:@"454a4d"];
    [self.view addSubview:_labelJinE];
    
    
    _labelTiXian = [CommonUtils commonSignleLabelWithText:@"000" withFontSize:19 withOriginX:labelTiXian.center.x withOriginY:UpDis isRelativeCoordinate:NO];
    _labelTiXian.textColor = [CommonUtils colorFromHexRGB:@"454a4d"];
    [self.view addSubview:_labelTiXian];
    

    UIView* viewlLineL = [[UIView alloc]initWithFrame:CGRectMake(self.view.center.x-0.5, 566/2-5, 0.8, 40)];

    viewlLineL.backgroundColor  =[CommonUtils colorFromHexRGB:@"cbcbcb"];
    [self.view addSubview:viewlLineL];
    
    
    UpDis = 744/2;
    
    UIButton* buttonTiXian = [[EWPButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH- 396/2)/2, UpDis, 396/2, 38)];
    [buttonTiXian setTitle:@"提现" forState:UIControlStateNormal];
    buttonTiXian.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    buttonTiXian.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [buttonTiXian setImage:[UIImage imageNamed:@"TBka.png"] forState:UIControlStateNormal];
    buttonTiXian.titleLabel.textColor = [CommonFuction colorFromHexRGB:@"ffffff"];
    [buttonTiXian setBackgroundImage:IMAGE_SUBJECT_NOR(396/2, 38) forState:UIControlStateNormal];
    [buttonTiXian setBackgroundImage:IMAGE_SUBJECT_SEL(396/2, 38) forState:UIControlStateHighlighted];
    buttonTiXian.layer.masksToBounds = YES;
    buttonTiXian.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    buttonTiXian.layer.cornerRadius = 19.0f;
    [self.view addSubview:buttonTiXian];
    buttonTiXian.tag = 13;
    [buttonTiXian addTarget:self action:@selector(buttonPres:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UpDis += 38+20;
    
    EWPButton *buttonDuiHuan = [[EWPButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH- 396/2)/2, UpDis, 396/2, 38)];
    [buttonDuiHuan setTitle:@"兑换" forState:UIControlStateNormal];
    [buttonDuiHuan setImage:[UIImage imageNamed:@"TBdui.png"] forState:UIControlStateNormal];
        [buttonDuiHuan setImage:[UIImage imageNamed:@"TBdui1.png"] forState:UIControlStateHighlighted];
    buttonDuiHuan.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    buttonDuiHuan.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [buttonDuiHuan setTitleColor:COLOR_SUBJECT_White forState:UIControlStateHighlighted];
    [buttonDuiHuan setTitleColor:COLOR_SUBJECTCOLOR forState:UIControlStateNormal];
      UIImage *normalImg = [CommonFuction imageWithColor:[CommonFuction colorFromHexRGB:@"ffffff"] size:CGSizeMake(396/2, 38)];
    [buttonDuiHuan setBackgroundImage:normalImg forState:UIControlStateNormal];
    [buttonDuiHuan setBackgroundImage:IMAGE_SUBJECT_NOR(396/2, 38) forState:UIControlStateHighlighted];
    buttonDuiHuan.backgroundColor =[CommonFuction colorFromHexRGB:@"ffffff"];
    buttonDuiHuan.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    buttonDuiHuan.layer.masksToBounds = YES;
    buttonDuiHuan.layer.cornerRadius = 19.0f;
    buttonDuiHuan.layer.borderWidth=1;
    buttonDuiHuan.layer.borderColor = COLOR_SUBJECTCOLOR.CGColor;
    [self.view addSubview:buttonDuiHuan];

       __weak typeof(self) safeSelf = self;
    [buttonDuiHuan setButtonBlock:^(id sender)
     {
         [safeSelf pushCanvas:@"ChangeBeanViewController" withArgument:[[_dictData valueForKey:@"userbean"] toString]];
     }];
    
    UpDis = 990/2;
    
    EWPButton *buttonGongG = [[EWPButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH- 60)/2, UpDis, 60, 38)];
    [buttonGongG setTitle:@"常见问题" forState:UIControlStateNormal];
    [buttonGongG setTitleColor:[CommonUtils colorFromHexRGB:@"959596"] forState:UIControlStateNormal];
    [buttonGongG setImage:[UIImage imageNamed:@"TBwen.png"] forState:UIControlStateNormal];
    buttonGongG.imageEdgeInsets = UIEdgeInsetsMake(0, -7, 0, 0);
    buttonGongG.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    buttonGongG.backgroundColor =[CommonFuction colorFromHexRGB:@"ffffff"];
    buttonGongG.titleLabel.font = [UIFont systemFontOfSize:11.0f];
    [self.view addSubview:buttonGongG];
    [buttonGongG setButtonBlock:^(id sender)
     {
         [self pushCanvas:@"TakeBackProtoclViewController" withArgument:nil];
     }];

 
    
    // Do any additional setup after loading the view.
}
-(NSString *)notRounding:(NSString*)price afterPoint:(NSInteger)position
{
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
    NSDecimalNumber *ouncesDecimal;
    NSDecimalNumber *roundedOunces;
    
//    ouncesDecimal = [[NSDecimalNumber alloc] initWithFloat:price];
       ouncesDecimal = [[NSDecimalNumber alloc]initWithString:price];
    roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
NSString* string = [NSString stringWithFormat:@"%@",roundedOunces];
    if ([string rangeOfString:@"."].length==0) {
      string=  [string stringByAppendingString:@".00"];
        
     
    }else{
        NSRange range = [string rangeOfString:@"."];
        if (string.length-range.location-1==2) {
            
        }else{
            string=   [string stringByAppendingString:@"0"];
        }
    }
    
    
    return string;
}
-(void)getData{
    
    
    
    InitViewModel* initViewModel = [[InitViewModel alloc]init];
    [initViewModel requestDataWithParams:nil success:^(id object) {
        if (initViewModel.result == 0)
        {
            
            
            //            countlimit = 3;//限制次数
            //            lastaccount = "";微信号
            //            maxmoney = "81929.19";
            //            moneylimit = 500;
            //            rate = 1000;
            //            txcs = 0;提现次数
            //            txzje = 0;当日提现总金额
            //            userbean = 81929197;
            //            minmoney = "81929.19";
            
            
            
            _dictData = [NSDictionary dictionaryWithDictionary:[object valueForKey:@"data"]];
            
            self.bind =[[_dictData valueForKey:@"bind"]integerValue];
            self.subscribe =[[_dictData valueForKey:@"subscribe"]integerValue];
            
            _labelDou.comSizeToTextFit = [NSString stringWithFormat:@"%d", [[_dictData valueForKey:@"userbean"] intValue]];
            
            
            
            _labelJinE.comSizeToTextFit =[self notRounding:[NSString stringWithFormat:@"%@",[_dictData valueForKey:@"maxmoney"]] afterPoint:2];
            
            
            
            
            if ([[_dictData valueForKey:@"maxmoney"] floatValue] >=[[_dictData valueForKey:@"moneylimit"] floatValue]-[[_dictData valueForKey:@"txzje"] floatValue]) {
                _labelTiXian.comSizeToTextFit =[NSString stringWithFormat:@"%.2f", [[_dictData valueForKey:@"moneylimit"] floatValue]-[[_dictData valueForKey:@"txzje"] floatValue]];
            }else{
                _labelTiXian.comSizeToTextFit =[NSString stringWithFormat:@"%.2f", [[_dictData valueForKey:@"maxmoney"] floatValue]];
                
            }
            
            
            if ([_labelTiXian.text floatValue]<=0) {
                _labelTiXian.text = @"0";
            }
            if ([_labelJinE.text floatValue]<=0) {
                _labelJinE.text = @"0";
            }
            
            
        }else{
            if (initViewModel.code == 403) {
                
                [self popToCanvas:PersonInfo_Canvas withArgument:nil];
                
            }else{
                [self showNotice:initViewModel.msg];
            }
        }
        
        
    } fail:^(id object) {
        
        [self showNoticeInWindow:@"网络连接失败"];
    }];
}
  
-(void)buttonPres:(UIButton*)sener{
    switch (sener.tag) {
        case 11://返回
            [self popCanvasWithArgment:nil];
            break;
        case 12://提现历史
            
        {
                [self pushCanvas:@"TakeBackRecordViewController" withArgument:nil];
        }
            break;
        case 13://提现
        {
            

            if ([[_dictData valueForKey:@"txcs"] intValue]>=[[_dictData valueForKey:@"countlimit"] intValue]) {
                [self showNoticeInWindow:@"今日提现次数已用尽"];
                return;
            }else if ([[_dictData valueForKey:@"txzje"] floatValue] >= [[_dictData valueForKey:@"moneylimit"] floatValue]) {
                [self showNoticeInWindow:@"今日提现金额已用尽"];
                return;
            }else if ([_labelTiXian.text floatValue]<[[_dictData valueForKey:@"minMoney"] floatValue]){
                NSDecimalNumber* total = [[NSDecimalNumber alloc]initWithString:[NSString stringWithFormat:@"%f",[[_dictData valueForKey:@"minMoney"] floatValue] ]] ;
                
                [self showNoticeInWindow:[NSString stringWithFormat:@"可提现金额不足%.2f元",[total floatValue]]];
                return;
            }
            
      
      
     
            
            NSString *canvasName = NSStringFromClass([self class]);
            NSDictionary*param = nil;

            
      
            
            if (_bind==2) {
                param = [NSDictionary dictionaryWithObjectsAndKeys:canvasName,@"className",_labelTiXian.text,@"jinE",[[_dictData valueForKey:@"nickname"] toString],@"wx",[[_dictData valueForKey:@"rate"] toString],@"huiLv",[NSString stringWithFormat:@"%ld",_subscribe]  ,@"subscribe", nil];
                [self pushCanvas:@"TakeBack_2ViewController" withArgument:param];
                return;
            }else if (_bind ==0){
                param = [NSDictionary dictionaryWithObjectsAndKeys:canvasName,@"className",_labelTiXian.text,@"jinE",[[_dictData valueForKey:@"rate"] toString],@"huiLv",[NSString stringWithFormat:@"%ld",_subscribe]  ,@"subscribe", nil];
                [self pushCanvas:@"TakeBack_Auto1ViewController" withArgument:param];
                return;
                
            }else{
                param = [NSDictionary dictionaryWithObjectsAndKeys:canvasName,@"className",_labelTiXian.text,@"jinE",[[_dictData valueForKey:@"rate"] toString],@"huiLv",[[_dictData valueForKey:@"nickname"] toString],@"wx", nil];
                [self pushCanvas:@"TakeBack_AutoBangWXViewController" withArgument:param];
                return;
            }
            
            

                
            
                
           
            
        
            
        }
            break;
            
        default:
            break;
    }
}
#pragma mark -argument
-(void)argumentForCanvas:(id)argumentData
{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
