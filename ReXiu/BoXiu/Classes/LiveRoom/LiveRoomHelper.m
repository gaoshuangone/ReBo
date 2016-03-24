//
//  LiveRoomHelper.m
//  BoXiu
//
//  Created by andy on 15/12/7.
//  Copyright © 2015年 rexiu. All rights reserved.
//

#import "LiveRoomHelper.h"
#import "PublicMessageVC.h"
#import "SystemMessageVC.h"
#import "UMSocialSnsService.h"
#import "UMSocial.h"
#import "DelAttentionModel.h"
#import "AddAttentModel.h"

@interface LiveRoomHelper()


@end
@implementation LiveRoomHelper
+(instancetype)shareLiveRoomHelper{
    static LiveRoomHelper* util = nil;
    static dispatch_once_t onckToken;
    dispatch_once(&onckToken,^{
        util = [[LiveRoomHelper alloc]init];
        
        
    });
    return util;
}
-(void)helperShareWithNumber:(NSInteger)number withShareTyep:(NSArray*)TypeArray withParms:(id)parms{

    if (number==0) {//直播间内分享
    

    NSString *sharelink = [NSString stringWithFormat:@"http://www.51rebo.cn/%ld",(long)[UserInfoManager shareUserInfoManager].currentStarInfo.idxcode];
    NSString *shareContent = [NSString stringWithFormat:@"“%@”正在直播，快来玩#热波间#在热波搞男神，搞女神，搞笑话，搞怪，搞逗B，热波Star搞一切！最“搞”的全民星直播互动平台，更有千万豪礼大回馈。马上去围观：http://www.51rebo.cn/%ld",[UserInfoManager shareUserInfoManager].currentStarInfo.nick,(long)[UserInfoManager shareUserInfoManager].currentStarInfo.idxcode];
    [UMSocialData defaultData].extConfig.wechatSessionData.url = sharelink;
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = sharelink;
    [UMSocialData defaultData].extConfig.qqData.url = sharelink;
    [UMSocialData defaultData].extConfig.qzoneData.url = sharelink;
    [UMSocialData defaultData].extConfig.title = @"#热波间#最火的全民娱乐直播在线平台，潮人聚集地";
    
    [UMSocialData defaultData].extConfig.wechatTimelineData.title =@"#热波间#最火的全民娱乐直播在线平台，潮人聚集地";
    
        [UMSocialConfig setFinishToastIsHidden:YES position:nil];
     
        UIImage* image = parms;
        if (!image) {
         image =[UIImage imageNamed:@"reboLogo"];
        }
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:TypeArray content:shareContent image:image location:nil urlResource:nil presentedController:self.rootLiveRoomViewController completion:^(UMSocialResponseEntity *response){
        if (response.responseCode == UMSResponseCodeSuccess) {
            [self.rootLiveRoomViewController showNoticeInWindow:@"分享成功"];
            
        }else{
            
            [self.rootLiveRoomViewController showNoticeInWindow:@"分享失败"];
            
        }
    }];
    }

}

- (void)starid:(NSInteger)starid ButState:(UIButton *)ButState Attention:(NSInteger)attState
{
    if (![AppInfo shareInstance].bLoginSuccess)
    {
        [[AppInfo shareInstance]showNoticeInWindow:@"需要先登录哦" duration:1.5];
        return;
    }
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInteger:starid]forKey:@"staruserid"];
    
    if (attState)
    {
        //取消关注
        DelAttentionModel *delAttentionModel = [[DelAttentionModel alloc] init];
        [delAttentionModel requestDataWithParams:dict success:^(id object) {
            /*成功返回数据*/
            if (delAttentionModel.result == 0)
            {
                [AppInfo shareInstance].audienceNumber.text = [NSString stringWithFormat:@"%ld",--[AppInfo shareInstance].fansNumber];

                [[AppInfo shareInstance]showNoticeInWindow:@"已取消对TA的关注" duration:1.5];
                [AppInfo shareInstance].state = 0;
                [ButState setTitle:@"关注" forState:UIControlStateNormal];
            }
            else
            {
                if (delAttentionModel.code == 403)
                {
                    [self.rootLiveRoomViewController pressedShowOherTerminalLoggedDialog];

                }
            }
        } fail:^(id object) {
            
        }];
    }
    else
    {
        //添加关注
        StarInfo *starInfo = [UserInfoManager shareUserInfoManager].currentStarInfo;
        NSString *serverIp= [NSString stringWithFormat:@"http://%@:%ld/mobile/dispatch.mobile",starInfo.serverip,(long)starInfo.serverport];
        if (starInfo.serverip == nil)
        {
            serverIp = [AppInfo shareInstance].requestServerBaseUrl;
        }
        
        AddAttentModel *addAttentionModel = [[AddAttentModel alloc] init];
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict addEntriesFromDictionary:[addAttentionModel signParamWithMethod:AddAttention_Method]];
        [dict setObject:[NSNumber numberWithInteger:starid]forKey:@"staruserid"];
        [addAttentionModel requestDataWithBaseUrl:serverIp requestType:nil method:AddAttention_Method httpHeader:[addAttentionModel httpHeaderWithMethod:AddAttention_Method] params:dict success:^(id object) {
            /*成功返回数据*/
            if (addAttentionModel.result == 0)
            {
                [AppInfo shareInstance].audienceNumber.text = [NSString stringWithFormat:@"%ld",++[AppInfo shareInstance].fansNumber];

                [[AppInfo shareInstance]showNoticeInWindow:@"已成功关注TA" duration:1.5];
                [AppInfo shareInstance].state = 1;
                [ButState setTitle:@"已关注" forState:UIControlStateNormal];
            }
            else
            {
                [[AppInfo shareInstance]showNoticeInWindow:addAttentionModel.data duration:1.5];
            }
            
        } fail:^(id object) {
            
        }];
        
    }

}

+(void)canleOauthsWithType:(NSArray*)type{
    
    
    [[UMSocialDataService defaultDataService] requestUnBindToSnsWithCompletion:^(UMSocialResponseEntity *response) {
        
    }];
    for (NSString* strType in type) {
        
        if ([strType isEqualToString:@"qq"]) {
            [[UMSocialDataService defaultDataService]requestUnOauthWithType:UMShareToQQ completion:^(UMSocialResponseEntity *response) {
                
            }];
        }else if ([strType isEqualToString:@"qzone"]) {
            [[UMSocialDataService defaultDataService]requestUnOauthWithType:UMShareToQzone completion:^(UMSocialResponseEntity *response) {
                
            }];
        }
        else if ([strType isEqualToString:@"sina"]) {
            [[UMSocialDataService defaultDataService]requestUnOauthWithType:UMShareToSina completion:^(UMSocialResponseEntity *response) {
                
            }];
        }
        else if ([strType isEqualToString:@"wxsession"]) {//微信
            [[UMSocialDataService defaultDataService]requestUnOauthWithType:UMShareToWechatSession completion:^(UMSocialResponseEntity *response) {
                
            }];
        }
        else if ([strType isEqualToString:@"wxtimeline"]) {//朋友圈
            [[UMSocialDataService defaultDataService]requestUnOauthWithType:UMShareToWechatTimeline completion:^(UMSocialResponseEntity *response) {
                
            }];
        }
     
     
    }
    
    

}
@end
