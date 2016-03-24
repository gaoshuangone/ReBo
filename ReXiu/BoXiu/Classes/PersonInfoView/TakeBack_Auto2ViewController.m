//
//  TakeBack_Auto2ViewController.m
//  BoXiu
//
//  Created by andy on 15/12/18.
//  Copyright © 2015年 rexiu. All rights reserved.
//

#import "TakeBack_Auto2ViewController.h"

@interface TakeBack_Auto2ViewController ()

@end

@implementation TakeBack_Auto2ViewController

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
    
    self.view.backgroundColor = [CommonUtils colorFromHexRGB:@"ffffff"];
    
    UILabel* labelTitle = [CommonUtils commonSignleLabelWithText:@"提交成功" withFontSize:18 withOriginX:self.view.center.x withOriginY:20+21 isRelativeCoordinate:NO];
    labelTitle.textColor = [CommonUtils colorFromHexRGB:@"454a4d"];
    [self.view addSubview:labelTitle];
    
    UIView* viewLine = [CommonUtils CommonViewLineWithFrame:CGRectMake(0, 63.5, SCREEN_WIDTH, 0.5)];
    viewLine.backgroundColor = [UIColor grayColor];
    [self.view addSubview:viewLine];
    
    UIImageView* iamgeViewSuccess = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-60)/2, 386/2, 60, 60)];
    iamgeViewSuccess.image = [UIImage imageNamed:@"TBsuccess.png"];
    [self.view addSubview:iamgeViewSuccess];
    
    UILabel* labeCount1 = [CommonUtils commonSignleLabelWithText:@"提现申请已提交" withFontSize:17 withOriginX:self.view.center.x withOriginY:546/2+15 isRelativeCoordinate:NO];
    labeCount1.textColor = [CommonUtils colorFromHexRGB:@"454a4d"];
    [self.view addSubview:labeCount1];
    
    UILabel* labelCount2 = [CommonUtils commonSignleLabelWithText:@"请到微信领取红包" withFontSize:17 withOriginX:self.view.center.x withOriginY:546/2+15 isRelativeCoordinate:NO];
    labelCount2.center = CGPointMake(self.view.center.x, CGRectGetMaxY(labeCount1.frame)+labelCount2.boundsHeight/2+4.5);
    labelCount2.textColor = [CommonUtils colorFromHexRGB:@"454a4d"];
    [self.view addSubview:labelCount2];

    
    
    UIButton* buttonTiXian = [[EWPButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH- 396/2)/2, SCREEN_HEIGHT-276/2, 396/2, 38)];
    [buttonTiXian setTitle:@"完成" forState:UIControlStateNormal];
    buttonTiXian.titleLabel.textColor = [CommonFuction colorFromHexRGB:@"ffffff"];
    [buttonTiXian setBackgroundImage:IMAGE_SUBJECT_NOR(396/2, 38) forState:UIControlStateNormal];
    [buttonTiXian setBackgroundImage:IMAGE_SUBJECT_SEL(396/2, 38) forState:UIControlStateHighlighted];
    buttonTiXian.layer.masksToBounds = YES;
    buttonTiXian.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    buttonTiXian.layer.cornerRadius = 19.0f;
    [self.view addSubview:buttonTiXian];
    buttonTiXian.tag = 13;
    [buttonTiXian addTarget:self action:@selector(buttonPres:) forControlEvents:UIControlEventTouchUpInside];

    UILabel* labeTemp = [CommonUtils commonSignleLabelWithText:@"预计24小时内到账" withFontSize:11 withOriginX:self.view.center.x withOriginY:SCREEN_HEIGHT-172/2+10 isRelativeCoordinate:NO];
    labeTemp.textColor = [CommonUtils colorFromHexRGB:@"959596"];
    [self.view addSubview:labeTemp];
    
    // Do any additional setup after loading the view.
}
-(void)buttonPres:(UIButton*)sender{
    [self popToCanvas:@"TakeBackViewController" withArgument:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
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
