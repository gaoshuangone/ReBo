//
//  LiveRoomUtil.m
//  BoXiu
//
//  Created by andy on 15/12/7.
//  Copyright © 2015年 rexiu. All rights reserved.
//

#import "LiveRoomUtil.h"
#import "BaseHttpModel.h"
#import "updateIntroductionmodel.h"//更新海报
#import "ChatmemberModel.h"//获取观众列表
#import "DelAttentionModel.h"//取消关注
#import "AddAttentModel.h"//关注
@implementation LiveRoomUtil

+(instancetype)shartLiveRoonUtil{
    static LiveRoomUtil* util = nil;
    static dispatch_once_t onckToken;
    dispatch_once(&onckToken,^{
        util = [[LiveRoomUtil alloc]init];
    
    
    });
    return util;
}

-(void)utilGetDataFromRoomUtilWithParams:(id)Params withServerMothod:(NSString*)serverMothod{
    
    
#pragma mark - 更新海报
    
    if ([serverMothod isEqualToString:UpdateIntroduction]) {
        UpdateIntroductionmodel *updateIntroductionmodel = [[UpdateIntroductionmodel alloc] init];
        NSString *tempDir = NSTemporaryDirectory ();
        NSString *tempFile = [NSString stringWithFormat:@"%@/TempHaiB.png",tempDir];
        
        [updateIntroductionmodel uploadDataWithFileUrl:tempFile params:nil success:^(id object) {
            
            
            if (updateIntroductionmodel.result == 0)
            {//此处刷新数据放在main和liveroom里边
                
                [AppInfo shareInstance].isHaiBaoUp = YES;
                
                  [UserInfoManager shareUserInfoManager].getUserInfoModel.userInfo.adphoto = @"有值";
                self.utilGetLiveRoomDataBlock (updateIntroductionmodel,serverMothod);
                
             
                
            }else{
             
                    self.utilGetLiveRoomDataBlock (updateIntroductionmodel,serverMothod);
               
            }
        } fail:^(id object) {
        
                self.utilGetLiveRoomDataBlock (nil,serverMothod);
         
        }];
        
    }
#pragma mark - 获取观众列表
    if ([serverMothod  isEqualToString:Get_ChatMember_Method]) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:[NSNumber numberWithBool:YES] forKey:@"isPagination"];//是不是页码
        [dict setObject:Params forKey:@"pageIndex"];  //页面索引
//        if ([Params integerValue]==0||[Params integerValue]==1) {
               [dict setObject:[NSNumber numberWithInt:50] forKey:@"pageSize"];//页面大小
//        }else{
//            [dict setObject:[NSNumber numberWithInt:50] forKey:@"pageSize"];//页面大小
//
//        }
     
        [dict setObject:[NSNumber numberWithInteger:[UserInfoManager shareUserInfoManager].currentStarInfo.userId] forKey:@"staruserid"];//当前主播的id
        
        StarInfo *starInfo = [UserInfoManager shareUserInfoManager].currentStarInfo; //当前主播信息
        ChatmemberModel *model = [[ChatmemberModel alloc] init];    //聊天者信息
        NSString *serverIp= [NSString stringWithFormat:@"http://%@:%ld/mobile/dispatch.mobile",starInfo.serverip,(long)starInfo.serverport];
        
        if (starInfo.serverip == nil)
        {
            serverIp = [AppInfo shareInstance].requestServerBaseUrl;
        }
        [dict addEntriesFromDictionary:[model signParamWithMethod:Get_ChatMember_Method]];
        [model requestDataWithBaseUrl:serverIp requestType:nil method:Get_ChatMember_Method httpHeader:[model httpHeaderWithMethod:Get_ChatMember_Method] params:dict success:^(id object)
         {
        self.utilGetLiveRoomDataBlock (model,serverMothod);
         
         } fail:^(id object) {
        self.utilGetLiveRoomDataBlock (nil,serverMothod);
         }];
    }
#pragma mark - 取消关注
    if ([serverMothod isEqualToString:@"DelAttentionModel"]) {
        
        
        //取消关注
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:[NSNumber numberWithInteger:[Params intValue] ]forKey:@"staruserid"];
        DelAttentionModel *delAttentionModel = [[DelAttentionModel alloc] init];
        [delAttentionModel requestDataWithParams:dict success:^(id object) {
            
        self.utilGetLiveRoomDataBlock (delAttentionModel,serverMothod);

        } fail:^(id object) {
            
            self.utilGetLiveRoomDataBlock (nil,serverMothod);
            
        }];
    }
         
#pragma mark - 关注
    
    if ([serverMothod isEqualToString:AddAttention_Method]) {
        StarInfo *starInfo = [UserInfoManager shareUserInfoManager].currentStarInfo;
        NSString *serverIp= [NSString stringWithFormat:@"http://%@:%ld/mobile/dispatch.mobile",starInfo.serverip,(long)starInfo.serverport];
        if (starInfo.serverip == nil)
        {
            serverIp = [AppInfo shareInstance].requestServerBaseUrl;
        }
        
        AddAttentModel *addAttentionModel = [[AddAttentModel alloc] init];
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict addEntriesFromDictionary:[addAttentionModel signParamWithMethod:AddAttention_Method]];
        [dict setObject:[NSNumber numberWithInteger:[Params intValue]]forKey:@"staruserid"];
        [addAttentionModel requestDataWithBaseUrl:serverIp requestType:nil method:AddAttention_Method httpHeader:[addAttentionModel httpHeaderWithMethod:AddAttention_Method] params:dict success:^(id object) {
            self.utilGetLiveRoomDataBlock (addAttentionModel,serverMothod);
            
        } fail:^(id object) {
            
            self.utilGetLiveRoomDataBlock (nil,serverMothod);
            
        }];
    }
    
 

    
   
}
-(void)utilGetDataFromRoomUtilWithParams:(id)Params withServerMothod:(NSString*)serverMothod bolock:(void(^)(id responseObject))block{
#pragma mark - 获取系统参数
    
    if ([serverMothod isEqualToString:@"selectByParamname"]) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:@"flyscreen_price" forKey:@"paramname"];
        BaseHttpModel *model = [[BaseHttpModel alloc] init];

        [  model requestDataWithMethod:@"admin/param/selectByParamname" params:dict success:^(id object) {
            
                        block(model);
            
        } fail:^(id object) {
            
                     block(nil);
            
        }];
        
    }
}
@end
