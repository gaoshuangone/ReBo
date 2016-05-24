//
//  TakeBack_2ViewController.m
//  BoXiu
//
//  Created by andy on 15/11/30.
//  Copyright © 2015年 rexiu. All rights reserved.
//

#import "TakeBack_2ViewController.h"
#import "ConfirmTxModel.h"
@interface TakeBack_2ViewController ()
@property (strong, nonatomic)UILabel* labelDou;
@property (strong, nonatomic)UILabel* labelJinE;
@property (strong, nonatomic)UILabel* labelTiXian;
@property (nonatomic,strong) UIButton* buttonBack;
@property (nonatomic,strong) UIButton* buttonList;
@property (nonatomic,strong) NSString* strWx;
@property (nonatomic,strong) NSString* strJinE;
@property (nonatomic,strong) NSString* strHuiLv;
@property (nonatomic,strong) EWPButton* buttonDuiHuan;
@end

@implementation TakeBack_2ViewController

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
    
    UILabel* labelTitle = [CommonUtils commonSignleLabelWithText:@"提现信息确认" withFontSize:18 withOriginX:self.view.center.x withOriginY:20+21 isRelativeCoordinate:NO];
    labelTitle.textColor = [CommonUtils colorFromHexRGB:@"454a4d"];
    [self.view addSubview:labelTitle];
    
    UIView* viewLine = [CommonUtils CommonViewLineWithFrame:CGRectMake(0, 63.5, SCREEN_WIDTH, 0.5)];
    viewLine.backgroundColor = [UIColor grayColor];
    [self.view addSubview:viewLine];
    
    
    
    self.view.backgroundColor = [CommonFuction colorFromHexRGB:@"ffffff"];
    
//    CGFloat UpDis = 180/2;
//    CGFloat leftDis =(SCREEN_WIDTH- 172-90)/2;
//    
//    UIButton* button1 = [UIButton buttonWithType:UIButtonTypeCustom];
//    button1.frame = CGRectMake(leftDis, UpDis, 45, 45);
//    button1.layer. masksToBounds = YES;
//        button1.layer.borderColor = [CommonUtils colorFromHexRGB:@"f7c250"].CGColor;
//        button1.layer.borderWidth = 1;
//    button1.layer.cornerRadius = 45/2;
//    [button1 setTitle:@"1" forState:UIControlStateNormal];
//    button1.backgroundColor =[CommonUtils colorFromHexRGB:@"ffffff"];
//    [button1 setTitleColor:[CommonUtils colorFromHexRGB:@"f7c250"] forState:UIControlStateNormal];
//    button1.titleLabel.font = [UIFont systemFontOfSize:19];
//    [self.view addSubview:button1];
//    
//    UILabel* label1 =[CommonUtils commonSignleLabelWithText:@"提交信息" withFontSize:11 withOriginX:button1.center.x withOriginY:292/2+4 isRelativeCoordinate:NO];
//    label1.textColor = [CommonUtils colorFromHexRGB:@"454a4d"];
//    [self.view addSubview:label1];
//
//    
//    UIButton* button2 = [UIButton buttonWithType:UIButtonTypeCustom];
//    button2.frame = CGRectMake(self.view.center.x-45/2, UpDis, 45, 45);
//    button2.layer. masksToBounds = YES;
//    button2.layer.borderColor = [CommonUtils colorFromHexRGB:@"f7c250"].CGColor;
//    button2.layer.borderWidth = 1;
//    button2.layer.cornerRadius = 45/2;
//    [button2 setTitle:@"2" forState:UIControlStateNormal];
//    button2.backgroundColor =[CommonUtils colorFromHexRGB:@"f7c250"];
//    [button2 setTitleColor:[CommonUtils colorFromHexRGB:@"ffffff"] forState:UIControlStateNormal];
//    button2.titleLabel.font = [UIFont systemFontOfSize:19];
//    [self.view addSubview:button2];
//    
//    UILabel* label2 =[CommonUtils commonSignleLabelWithText:@"tixianxinxi" withFontSize:11 withOriginX:button2.center.x withOriginY:292/2+4 isRelativeCoordinate:NO];
//    label2.textColor = [CommonUtils colorFromHexRGB:@"454a4d"];
//    [self.view addSubview:label2];
//    
//    
//    UIButton* button3 = [UIButton buttonWithType:UIButtonTypeCustom];
//    button3.frame = CGRectMake(SCREEN_WIDTH- leftDis-45, UpDis, 45, 45);
//    button3.layer. masksToBounds = YES;
//    button3.layer.borderColor = [CommonUtils colorFromHexRGB:@"f7c250"].CGColor;
//    button3.layer.borderWidth = 1;
//    button3.layer.cornerRadius = 45/2;
//    [button3 setTitle:@"3" forState:UIControlStateNormal];
//    button3.backgroundColor =[CommonUtils colorFromHexRGB:@"ffffff"];
//    [button3 setTitleColor:[CommonUtils colorFromHexRGB:@"f7c250"] forState:UIControlStateNormal];
//    button3.titleLabel.font = [UIFont systemFontOfSize:19];
//    [self.view addSubview:button3];
//    
//    UILabel* label3 =[CommonUtils commonSignleLabelWithText:@"添加微信" withFontSize:11 withOriginX:button3.center.x withOriginY:292/2+5 isRelativeCoordinate:NO];
//    label3.textColor = [CommonUtils colorFromHexRGB:@"454a4d"];
//    [self.view addSubview:label3];
//    
//    UIView* viewline1 =[CommonUtils CommonViewLineWithFrame:CGRectMake(CGRectGetMaxX(button1.frame), CGRectGetMidY(button1.frame), CGRectGetMinX(button2.frame)-CGRectGetMaxX(button1.frame), 1)];
//    viewline1.alpha=1;
//    viewline1.backgroundColor = [CommonUtils colorFromHexRGB:@"f7c250"];
//    [self.view addSubview:viewline1];
//    
//    UIView* viewline2 =[CommonUtils CommonViewLineWithFrame:CGRectMake(CGRectGetMaxX(button2.frame), CGRectGetMidY(button1.frame), CGRectGetMinX(button3.frame)-CGRectGetMaxX(button2.frame), 1)];
//    viewline2.alpha=1;
//    viewline2.backgroundColor = [CommonUtils colorFromHexRGB:@"f7c250"];
//    [self.view addSubview:viewline2];
    

    UIImageView* imageViewHead =[[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-74)/2, 418/2, 74, 74)];
    imageViewHead.image =[UserInfoManager shareUserInfoManager].tempHederImage;
    imageViewHead.layer.masksToBounds = YES;
    imageViewHead.layer.cornerRadius = 74/2;
    [self.view addSubview:imageViewHead];
    
    UILabel* labelNick = [CommonUtils commonSignleLabelWithText:[UserInfoManager shareUserInfoManager].currentUserInfo.nick withFontSize:14 withOriginX:self.view.center.x withOriginY:602/2+8 isRelativeCoordinate:NO];
    labelNick.textColor = [CommonFuction colorFromHexRGB:@"454a4d"];
    [self.view addSubview:labelNick];
    
    UILabel* labelJinE = [CommonUtils commonSignleLabelWithText:@"提现金额:" withFontSize:12 withOriginX:148/2 withOriginY:686/2 isRelativeCoordinate:YES];
    labelJinE.textColor = [CommonUtils colorFromHexRGB:@"959596"];
    [self.view addSubview:labelJinE];
    
    UILabel* labelWZ = [CommonUtils commonSignleLabelWithText:@"提现微信号:" withFontSize:12 withOriginX:148/2 withOriginY:CGRectGetMaxY(labelJinE.frame)+7 isRelativeCoordinate:YES];
    labelWZ.textColor = [CommonUtils colorFromHexRGB:@"959596"];

   
    [self.view addSubview:labelWZ];
    
    UILabel* labelMoney = [CommonUtils commonSignleLabelWithText:self.strJinE withFontSize:21 withOriginX:CGRectGetMaxX(labelJinE.frame)+6 withOriginY:686/2-7 isRelativeCoordinate:YES];
    labelMoney.textColor = [CommonUtils colorFromHexRGB:@"f7c250"];
    [self.view addSubview:labelMoney];
    
    UILabel* labelMoneyText = [CommonUtils commonSignleLabelWithText:@"元" withFontSize:10 withOriginX:CGRectGetMaxX(labelMoney.frame) withOriginY:686/2+2 isRelativeCoordinate:YES];
    labelMoneyText.textColor = [CommonUtils colorFromHexRGB:@"f7c250"];
    [self.view addSubview:labelMoneyText];
    
    NSInteger intFont =0;
    if ([CommonUtils checkStringNumbersWithlettersWithString:self.strWx]) {
        intFont = 12;
    }else{
          intFont = 13;
    }
    UILabel* labelWXNumber =[CommonUtils commonSignleLabelWithText:self.strWx withFontSize:intFont withOriginX:CGRectGetMaxX(labelWZ.frame)+6 withOriginY:CGRectGetMinY(labelWZ.frame) isRelativeCoordinate:YES];
    labelWXNumber.textAlignment = NSTextAlignmentLeft;
    labelWXNumber.bounds = CGRectMake(labelWXNumber.frameX, labelWXNumber.frameY, 120, labelWXNumber.frameHeight);
    labelWXNumber.center = CGPointMake(CGRectGetMaxX(labelWZ.frame)+6+labelWXNumber.boundsWide/2, CGRectGetMinY(labelWZ.frame)+labelWXNumber.frameHeight/2);
    labelWXNumber.textColor = [CommonUtils colorFromHexRGB:@"959596"];
    [self.view addSubview:labelWXNumber];
    
    _buttonDuiHuan = [[EWPButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH- 396/2)/2, 862/2, 396/2, 38)];
    [_buttonDuiHuan setTitle:@"确认" forState:UIControlStateNormal];
    _buttonDuiHuan.titleLabel.textColor = [CommonFuction colorFromHexRGB:@"ffffff"];
    [_buttonDuiHuan setBackgroundImage:IMAGE_SUBJECT_NOR(396/2, 38) forState:UIControlStateNormal];
    [_buttonDuiHuan setBackgroundImage:IMAGE_SUBJECT_SEL(396/2, 38) forState:UIControlStateHighlighted];
    _buttonDuiHuan.layer.masksToBounds = YES;
    _buttonDuiHuan.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    _buttonDuiHuan.layer.cornerRadius = 19.0f;
    [self.view addSubview:_buttonDuiHuan];
    
    __weak typeof(self) safeSelf = self;
    
    __weak EWPButton* button = _buttonDuiHuan;
    [_buttonDuiHuan setButtonBlock:^(id sender)
     {
    
         button.userInteractionEnabled = NO;
         
         
         [safeSelf returnData];
         

     }];

    // Do any additional setup after loading the view.
}
-(void)returnData{
      __weak typeof(self) safeSelf = self;

    [self startAnimating];
    NSDictionary* dict = [NSDictionary dictionaryWithObjectsAndKeys:self.strWx,@"accountname",self.strJinE,@"receiveMoney",self.strHuiLv,@"receiveRate", nil];
    ConfirmTxModel* confirmTxModel = [[ConfirmTxModel alloc]init];

    [confirmTxModel requestDataWithParams:dict success:^(id object) {
        __strong typeof(safeSelf) strongSelf = safeSelf;
        [self stopAnimating];
        if (confirmTxModel.result == 0)
        {

    
        [self pushCanvas:@"TakeBack_Auto2ViewController" withArgument:nil];
            
            
        }else{
            if (confirmTxModel.code == 403) {
              [self popToCanvas:PersonInfo_Canvas withArgument:nil];
                
            }else{
            
                [self showNoticeInWindow:confirmTxModel.msg];
            }
        }
        
            [self stopAnimating];
        strongSelf.buttonDuiHuan.userInteractionEnabled = YES;
    } fail:^(id object) {
            __strong typeof(safeSelf) strongSelf = safeSelf;
         [self stopAnimating];
        [self showNotice:@"网络连接失败"];
          strongSelf.buttonDuiHuan.userInteractionEnabled = YES;
    }];

}

-(void)buttonPres:(UIButton*)sener{
    switch (sener.tag) {
        case 11://返回
        
            [self popToCanvas:@"TakeBackViewController" withArgument:nil];
            break;
        case 12://提现历史
            break;
        case 13://提现
//            [self pushCanvas:@"TakeBack_3ViewController" withArgument:nil];
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
    self.strWx = [argumentData valueForKey:@"wx"];
        self.strJinE = [argumentData valueForKey:@"jinE"];
     self.strHuiLv = [argumentData valueForKey:@"huiLv"];
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
