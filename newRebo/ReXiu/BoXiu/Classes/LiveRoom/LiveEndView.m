//
//  LiveEndView.m
//  BoXiu
//
//  Created by andy on 15/12/12.
//  Copyright © 2015年 rexiu. All rights reserved.
//

#import "LiveEndView.h"
#import "DelAttentionModel.h"
#import "AddAttentModel.h"
#import "UMSocialSnsService.h"
#import "UMSocial.h"
#import "LiveRoomHelper.h"
@interface LiveEndView()
@property (strong, nonatomic)UILabel* labelCount;
@property (strong , nonatomic) UIButton* buttonGuanZhu;
@property (strong, nonatomic) LiveRoomUtil* livrRoomUtil;
@property (nonatomic,strong) EWPSimpleDialog *dialogliveEnd;
@end
@implementation LiveEndView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
- (void)initView:(CGRect)frame
{
    _livrRoomUtil = [[LiveRoomUtil alloc]init];
    self.backgroundColor = [CommonUtils colorFromHexRGB:@"141414"];
    UILabel* labelCount =[CommonUtils commonSignleLabelWithText:@"直播结束" withFontSize:34 withOriginX:self.center.x withOriginY:246/2+22 isRelativeCoordinate:NO];
    labelCount.textColor = [CommonUtils colorFromHexRGB:@"d14c49"];
    [self addSubview:labelCount];
    
 
    
    UILabel* labelCount1 =[CommonUtils commonSignleLabelWithText:@"人看过" withFontSize:16 withOriginX:self.center.x withOriginY:356/2 isRelativeCoordinate:YES];
    labelCount1.center = CGPointMake(self.center.x+17, 356/2+labelCount1.boundsHeight/2);
    labelCount1.textColor = [CommonUtils colorFromHexRGB:@"ffffff"];
    [self addSubview:labelCount1];
    
    _labelCount = [CommonUtils commonSignleLabelWithText:@"1132" withFontSize:18 withOriginX:0 withOriginY:0 isRelativeCoordinate:NO];
    _labelCount.center = CGPointMake(CGRectGetMinX(labelCount1.frame)-_labelCount.boundsWide/2-5, labelCount1.center.y);
    _labelCount.textColor = [CommonUtils colorFromHexRGB:@"ffd178"];
    [self addSubview:_labelCount];
    
    
    NSInteger hideSwitch = [[[AppInfo shareInstance].hideSwitch substringFromIndex:1] integerValue];//官方审核开关
    if (hideSwitch != 1 )
    {
        
      
    
    UILabel* labelShare = [CommonUtils commonSignleLabelWithText:@"分享到" withFontSize:15 withOriginX:self.center.x withOriginY:0 isRelativeCoordinate:NO];
    labelShare.center = CGPointMake(self.center.x, 614/2+labelShare.frameHeight/2);
    labelShare.textColor = [CommonUtils colorFromHexRGB:@"959596"];
    [self addSubview:labelShare];
    
    NSArray* arrayImages =[NSArray arrayWithObjects:@"LR01WX.png",@"LR02epngyouquan.png",@"LR03QQ.png",@"LR04kongjian.png",@"LR05weibo.png", nil];
    
    for (int i =0 ; i<[arrayImages count]; i++) {
        UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake((SCREEN_WIDTH-(5*35+4*23))/2+(35+23)*i, 678/2, 35, 35);
        [button setImage: [UIImage imageNamed:[arrayImages objectAtIndex:i]] forState:UIControlStateNormal];
        button.tag = i;
        [button addTarget:self action:@selector(buttonPre:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
    }
    
    _buttonGuanZhu = [UIButton buttonWithType:UIButtonTypeCustom];
    _buttonGuanZhu.frame = CGRectMake((SCREEN_WIDTH-500/2)/2, 854/2, 250, 40);
  
    [_buttonGuanZhu setTitleColor:[CommonFuction colorFromHexRGB:@"ffffff"] forState:UIControlStateNormal];
    _buttonGuanZhu.titleLabel.font = [UIFont systemFontOfSize:17.0f];
    _buttonGuanZhu.layer.cornerRadius = 20;
    _buttonGuanZhu.layer.masksToBounds = YES;
    
 
  
    _buttonGuanZhu.layer.borderWidth = 1.0;
    _buttonGuanZhu.layer.borderColor = [CommonFuction colorFromHexRGB:@"ffffff"].CGColor;
    [_buttonGuanZhu addTarget:self action:@selector(buttonPre:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_buttonGuanZhu];
    
    UIButton* buttonBack = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonBack.frame = CGRectMake((SCREEN_WIDTH-500/2)/2, 854/2+40+11, 250, 40);
    [buttonBack setTitle:@"返回" forState:UIControlStateNormal];
    [buttonBack setTitleColor:[CommonFuction colorFromHexRGB:@"ffffff"] forState:UIControlStateNormal];
    buttonBack.titleLabel.font = [UIFont systemFontOfSize:17.0f];
    buttonBack.layer.cornerRadius = 20;
    buttonBack.layer.masksToBounds = YES;
    buttonBack.tag =7;
    buttonBack.layer.borderWidth = 1.0;
    buttonBack.layer.borderColor = [CommonFuction colorFromHexRGB:@"ffffff"].CGColor;
    [buttonBack addTarget:self action:@selector(buttonPre:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:buttonBack];
        __weak UIButton* button = _buttonGuanZhu;
    __weak typeof(self) weakself = self;
    _livrRoomUtil.utilGetLiveRoomDataBlock =^(id modelUil,NSString* strname){

        LiveRoomViewController* lr = (LiveRoomViewController*)weakself.rootLiveRoomController;
    
        if ([strname isEqualToString:@"DelAttentionModel"]) {
            DelAttentionModel* model =(DelAttentionModel*)modelUil;
            if ( model.result==0) {
                      [button setTitle:@"关注TA" forState:UIControlStateNormal];
                button.tag = 5;
                [lr showNoticeInWindow:@"已取消对TA的关注"];//已成功关注TA
            }else{
                if (model.code == 403) {
                    [lr showOherTerminalLoggedDialog];
                    [[AppInfo shareInstance]loginOut];
                }else{
                      [lr showNoticeInWindow:model.msg];
                }
            }
        }else{
            AddAttentModel* model =(AddAttentModel*)modelUil;
            if ( model.result==0) {
          
                [button setTitle:@"取消关注" forState:UIControlStateNormal];
                button.tag =6;
                 [lr showNoticeInWindow:@"已成功关注TA"];//已取消对TA的关注
            }else{
                if (model.code == 403) {
                    [lr showOherTerminalLoggedDialog];
                    [[AppInfo shareInstance]loginOut];
                }else{
                [lr showNoticeInWindow:model.msg];
                }
            }

        }
        
     
        
        
        
    };

    
}
//-(void)setRootLiveRoomController:(LiveRoomViewController *)rootLiveRoomController{
//    _rootLiveRoomController = rootLiveRoomController;
//}
-(void)setPersonData:(PersonData *)personData{
   _personData = personData;

    if (self.personData.attented) {
        [_buttonGuanZhu setTitle:@"取消关注" forState:UIControlStateNormal];
        _buttonGuanZhu.tag =6;
    }else{
        [_buttonGuanZhu setTitle:@"关注TA" forState:UIControlStateNormal];
        _buttonGuanZhu.tag =5;
    }
}
-(void)setGuanZhuCount:(NSString*)count{
    _labelCount.comSizeToTextFit = count;

}
-(void)buttonPre:(UIButton*)sender{

     NSArray* array = nil;
    switch (sender.tag) {
        case 0:
                 array = @[UMShareToWechatSession];
            break;
        case 1:
                 array = @[UMShareToWechatTimeline];
            break;
        case 2:
                 array = @[UMShareToQQ];
            break;
        case 3:
                 array = @[UMShareToQzone];
            break;
        case 4:
                 array = @[UMShareToSina];
            break;
        case 5:
        {
      

            [_livrRoomUtil utilGetDataFromRoomUtilWithParams:[NSNumber numberWithInteger:self.personData.userId] withServerMothod:AddAttention_Method];
            return;
        }
            break;
        case 6:{
          
            [_livrRoomUtil utilGetDataFromRoomUtilWithParams:[NSNumber numberWithInteger:self.personData.userId] withServerMothod:@"DelAttentionModel"];
            return;
        }
            break;
        case 7:
        {
                        
            
            
            LiveRoomViewController* lr = (LiveRoomViewController*)self.rootLiveRoomController;
            
            
          
            [lr stopPlayingautoExitRoom];
        }
            
            break;
     
         
        default:
            break;
    }
    NSLog(@"%@",array);
   




    
    NSString *sharelink = [NSString stringWithFormat:@"http://www.51rebo.cn/%ld",(long)[UserInfoManager shareUserInfoManager].currentStarInfo.idxcode];
    NSString *shareContent = [NSString stringWithFormat:@"快来玩#热波间#在热波搞男神，搞女神，搞笑话，搞怪，搞逗B，热波Star搞一切！最“搞”的全民星直播互动平台，更有千万豪礼大回馈。马上去围观：http://www.51rebo.cn/%ld",(long)[UserInfoManager shareUserInfoManager].currentStarInfo.idxcode];
    [UMSocialData defaultData].extConfig.wechatSessionData.url = sharelink;
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = sharelink;
    [UMSocialData defaultData].extConfig.qqData.url = sharelink;
    [UMSocialData defaultData].extConfig.qzoneData.url = sharelink;
    [UMSocialData defaultData].extConfig.title = @"#热波间#最火的全民娱乐直播在线平台，潮人聚集地";
    
  
    
    [UMSocialData defaultData].extConfig.wechatTimelineData.title =@"#热波间#最火的全民娱乐直播在线平台，潮人聚集地";
          [UMSocialConfig setFinishToastIsHidden:YES position:nil];
    
   __weak LiveRoomViewController* lr = (LiveRoomViewController*)self.rootLiveRoomController;
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:array content:shareContent image:[UIImage imageNamed:@"reboLogo"] location:nil urlResource:nil presentedController:lr completion:^(UMSocialResponseEntity *response){
        if (response.responseCode == UMSResponseCodeSuccess) {
            [lr showNoticeInWindow:@"分享成功"];
    
        }else{
        
            [lr  showNoticeInWindow:@"分享失败"];
            
        }
        
    }];

 
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)viewWillAppear
{
    [super viewWillAppear];
}


- (void)viewwillDisappear
{
    [super viewwillDisappear];
}
@end
