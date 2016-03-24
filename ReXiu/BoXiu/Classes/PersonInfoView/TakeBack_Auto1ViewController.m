//
//  TakeBack_Auto1ViewController.m
//  BoXiu
//
//  Created by andy on 15/12/18.
//  Copyright © 2015年 rexiu. All rights reserved.
//

#import "TakeBack_Auto1ViewController.h"
#import "WXApi.h"
#import "UMSocial.h"
#import "ConfirmTxModel.h"
#import "InitViewModel.h"
@interface TakeBack_Auto1ViewController ()
@property (nonatomic,strong) UIButton* buttonBack;
@property (nonatomic,strong) NSString* strJInE;
@property (nonatomic,strong) NSString* strwx;
@property (nonatomic,strong) NSString* strHuiLV;
@property (nonatomic,strong) NSString* strSubscribe;
@end

@implementation TakeBack_Auto1ViewController
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
    _buttonBack = [UIButton buttonWithType:UIButtonTypeCustom];
    [_buttonBack setImage:[UIImage imageNamed:@"navB_Nor.png"] forState:UIControlStateHighlighted];
    [_buttonBack setImage:[UIImage imageNamed:@"backNew.png"] forState:UIControlStateNormal];
    _buttonBack.frame = CGRectMake(0, 20, 50, 40);
    _buttonBack.tag = 11;
    [_buttonBack addTarget:self action:@selector(buttonPres:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_buttonBack];
    
    UILabel* labelTitle = [CommonUtils commonSignleLabelWithText:@"绑定微信" withFontSize:18 withOriginX:self.view.center.x withOriginY:20+21 isRelativeCoordinate:NO];
    labelTitle.textColor = [CommonUtils colorFromHexRGB:@"454a4d"];
    [self.view addSubview:labelTitle];
    
    UIView* viewLine = [CommonUtils CommonViewLineWithFrame:CGRectMake(0, 63.5, SCREEN_WIDTH, 0.5)];
    viewLine.backgroundColor = [UIColor grayColor];
    [self.view addSubview:viewLine];
    
    
    
    self.view.backgroundColor = [CommonFuction colorFromHexRGB:@"ffffff"];
    
    
    UILabel* labeWxContent1 = [CommonUtils commonSignleLabelWithText:@"请绑定微信" withFontSize:17 withOriginX:self.view.center.x withOriginY:466/2+15 isRelativeCoordinate:NO];
    labeWxContent1.textColor = [CommonUtils colorFromHexRGB:@"454a4d"];
    [self.view addSubview:labeWxContent1];
    
    
    
    
    UILabel* labeWxContent2 = [CommonUtils commonSignleLabelWithText:@"绑定的微信将成为您的提现账户" withFontSize:14 withOriginX:self.view.center.x withOriginY:536/2+12 isRelativeCoordinate:NO];
    labeWxContent2.textColor = [CommonUtils colorFromHexRGB:@"959596"];
    [self.view addSubview:labeWxContent2];
    
    
    UIButton* buttonTiXian = [[EWPButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH- 396/2)/2, 862/2, 396/2, 38)];
    [buttonTiXian setTitle:@"绑定" forState:UIControlStateNormal];
    buttonTiXian.titleLabel.textColor = [CommonFuction colorFromHexRGB:@"ffffff"];
    [buttonTiXian setBackgroundImage:IMAGE_SUBJECT_NOR(396/2, 38) forState:UIControlStateNormal];
    [buttonTiXian setBackgroundImage:IMAGE_SUBJECT_SEL(396/2, 38) forState:UIControlStateHighlighted];
    buttonTiXian.layer.masksToBounds = YES;
    buttonTiXian.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    buttonTiXian.layer.cornerRadius = 19.0f;
    [self.view addSubview:buttonTiXian];
    buttonTiXian.tag = 13;
    [buttonTiXian addTarget:self action:@selector(buttonPres:) forControlEvents:UIControlEventTouchUpInside];
    
    

    // Do any additional setup after loading the view.
}
-(void)buttonPres:(UIButton*)sener{
    switch (sener.tag) {
        case 11://返回
            [self popCanvasWithArgment:nil];
            break;
        case 13://绑定
        {
            
            if (![WXApi isWXAppInstalled])
            {
                EWPAlertView *alertView = [[EWPAlertView alloc] initWithTitle:@"提示" message:@"未检测到微信客户端,是否现在安装" leftBtnTitle:@"暂不安装" rightBtnTitle:@"马上安装" clickBtnBlock:^(NSInteger nIndex) {
                    if (nIndex == 0)
                    {
                        
                    }
                    else if(nIndex == 1)
                    {
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[WXApi getWXAppInstallUrl]]];
                    }
                }];
                [alertView show];
                
                return;
            }
            UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession];
            if (snsPlatform == nil)
            {
                return;
            }
            snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response)
                                          {
                                              
                                              
                                              
                                              
                                              NSLog(@"login response is %@",response);
                                              //          获取微博用户名、uid、token等
                                              if (response.responseCode == UMSResponseCodeSuccess) {
                                                  UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToWechatSession];
                                                  
                                                  
                                                  if (snsAccount)
                                                  {
                                                     
                                                      
                                                      //得到的数据在回调Block对象形参respone的data属性
                                                      [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToWechatSession  completion:^(UMSocialResponseEntity *response){
                                                          NSLog(@"SnsInformation is %@",response.data);
                                                          
                                                          NSString* gender  = [[response.data valueForKey:@"gender"]toString];
                                                          
                                                          NSDictionary* parms = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%ld",(long)[UserInfoManager shareUserInfoManager].getUserInfoModel.userInfo.userId],@"userid",gender ,@"sex",[response.data valueForKey:@"screen_name"],@"nickname",snsAccount.openId,@"openid",snsAccount.unionId,@"unionid",snsAccount.iconURL,@"iconuri", nil];
                                                          self.strwx =[response.data valueForKey:@"screen_name"];
                                                          
                                                          __weak typeof(self) weakSelf = self;
                                                          BaseHttpModel* model = [[BaseHttpModel alloc]init];
                                                          [model requestDataWithMethod:@"wechat/bindToWechatApi" params:parms success:^(id object) {
                                                              __strong typeof(weakSelf) strongSelf = self;
                                                              NSDictionary* dict = (NSDictionary*)object;
                                                              if (model.result==0) {
//                                                                  NSDictionary* param = [NSDictionary dictionaryWithObjectsAndKeys:_strJInE,@"jinE",_strwx,@"wx",_strHuiLV,@"huiLv", nil];
                                                                  
                                                                  strongSelf.strwx =[response.data valueForKey:@"screen_name"];
                                                                  
//                                                                  if ([strongSelf.strSubscribe integerValue]==0) {
//                                                                      
//                                                         
//                                                                      [self pushCanvas:@"TakeBack_AutoBangWXViewController" withArgument:param];
//                                                                  }else{
//                                                                      [self pushCanvas:@"TakeBack_2ViewController" withArgument:param];
//                                                                  }
                                                                  [strongSelf notiRefarch];
                                                                  
                                                              }else{
                                                                  if ([[dict valueForKey:@"code"] integerValue] == 403) {
                                                                      [self popToCanvas:PersonInfo_Canvas withArgument:nil];
                                                                      
                                                                  }else{
                                                                      
                                                                      [self showNoticeInWindow:[dict valueForKey:@"msg"]];
                                                                  }
                                                                  
                                                              }
                                                              
                                                              
                                                          } fail:^(id object) {
                                                              [self showNoticeInWindow:@"确认失败"];
                                                          }];

                                                      }];
                                                      
                                                  }
                                                  
                                              }
                                          });
            

                   }
            
            break;
            
        default:
            break;
    }
}
-(void)notiRefarch{
    InitViewModel* initViewModel = [[InitViewModel alloc]init];
    [initViewModel requestDataWithParams:nil success:^(id object) {
        if (initViewModel.result == 0)
        {
            

            NSDictionary* dict = [NSDictionary dictionaryWithDictionary:[object valueForKey:@"data"]];
            
            
            //            self.subscribe =[[dict valueForKey:@"subscribe"]integerValue];
            
            NSInteger bind = [[dict valueForKey:@"bind"]integerValue];

            
    
            
              NSDictionary* param = [NSDictionary dictionaryWithObjectsAndKeys:_strJInE,@"jinE",_strwx,@"wx",_strHuiLV,@"huiLv", nil];
            if (bind==2) {
                
              
              [self pushCanvas:@"TakeBack_2ViewController" withArgument:param];
                return;
            }else if (bind ==0){
          NSLog(@"出错了，重复关注！！！");
                return;
                
            }else{
                   [self pushCanvas:@"TakeBack_AutoBangWXViewController" withArgument:param];
                return;
            }

            
            
            
            
        }
    } fail:^(id object) {
        
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -argument
-(void)argumentForCanvas:(id)argumentData
{
    
    if ([[argumentData valueForKey:@"className"]isEqualToString:@"TakeBackViewController"]) {
        self.strJInE = [argumentData valueForKey:@"jinE"];
        self.strwx = [argumentData valueForKey:@"wx"];
        self.strHuiLV = [argumentData valueForKey:@"huiLv"];
        self.strSubscribe =[argumentData valueForKey:@"subscribe"];
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
