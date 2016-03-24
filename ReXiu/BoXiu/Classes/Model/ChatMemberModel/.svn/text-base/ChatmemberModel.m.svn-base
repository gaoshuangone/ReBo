//
//  ChatmemberModel.m
//  BoXiu
//
//  Created by andy on 14-5-16.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "ChatmemberModel.h"
#import "UserInfo.h"

@implementation ChatMember

@end

@implementation ChatmemberModel


- (void)requestDataWithServerIp:(NSString *)serverIp params:(NSDictionary *)params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    NSDictionary *header = [self httpHeaderWithMethod:Get_ChatMember_Method];
    [self requestDataWithBaseUrl:serverIp requestType:nil method:Get_ChatMember_Method httpHeader:header params:params success:success fail:fail];
}

- (BOOL)analyseData:(NSDictionary *)data
{
    if (![super analyseData:data])
    {
        return NO;
    }
    if (self.result == 0)
    {
        NSDictionary *dataDic = [data objectForKey:@"data"];
        if (dataDic && [dataDic count] > 0)
        {
            self.recordCount = [[dataDic objectForKey:@"recordCount"] integerValue];
            self.pageSize = [[dataDic objectForKey:@"pageSize"] integerValue];
            self.pagination = [[dataDic objectForKey:@"pagination"] boolValue];
            self.pageIndex = [[dataDic objectForKey:@"pageIndex"] integerValue];
            NSArray *dataArray = [dataDic objectForKey:@"data"];
            
            if (_chatMemberMArray == nil)
            {
                _chatMemberMArray = [NSMutableArray array];
            }
            [_chatMemberMArray removeAllObjects];
            
            for (int nIndex = 0; nIndex < [dataArray count]; nIndex++)
            {
                NSDictionary *chatMemberDic = [dataArray objectAtIndex:nIndex];
                UserInfo *userInfo = [[UserInfo alloc] init];
//                userInfo.clientId = [chatMemberDic objectForKey:@"clientId"];
                userInfo.clientId = [chatMemberDic objectForKey:@"clientId"];
                userInfo.hidden = [[chatMemberDic objectForKey:@"hidden"] integerValue];
                userInfo.hiddenindex = [chatMemberDic objectForKey:@"hiddenindex"];
                userInfo.issupermanager = [[chatMemberDic objectForKey:@"issupermanager"] boolValue];
                userInfo.consumerlevelweight = [UserInfo switchConsumerlevelweight:[[chatMemberDic objectForKey:@"consumerlevelweight"] integerValue]];//[[chatMemberDic objectForKey:@"consumerlevelweight"] integerValue];
                userInfo.levelWeight = [[chatMemberDic objectForKey:@"levelWeight"] integerValue];
                userInfo.nick = [chatMemberDic objectForKey:@"nick"];
                userInfo.photo = [chatMemberDic objectForKey:@"photo"];
                userInfo.privlevelweight = [[chatMemberDic objectForKey:@"privlevelweight"] integerValue];
//                userInfo.realUserId = [[chatMemberDic objectForKey:@"realUserId"] integerValue];
//                userInfo.time = [[chatMemberDic objectForKey:@"time"] longLongValue];
                userInfo.userId = [[chatMemberDic objectForKey:@"userId"] integerValue];
                userInfo.staruserid = [[chatMemberDic objectForKey:@"staruserid"] integerValue];
                userInfo.idxcode = [[chatMemberDic objectForKey:@"idxcode"] integerValue];
                   userInfo.isPurpleVip = [[chatMemberDic objectForKey:@"isPurpleVip"] boolValue];
                 userInfo.isYellowVip = [[chatMemberDic objectForKey:@"isYellowVip"] boolValue];
                
                [self.chatMemberMArray addObject:userInfo];
            }
            
            NSDictionary *propsDic = [dataDic objectForKey:@"props"];
            if (propsDic && [propsDic count])
            {
                self.maxViewerCount = [[propsDic objectForKey:@"maxViewerCount"] integerValue];
                self.touristCount = [[propsDic objectForKey:@"touristCount"] integerValue];
                self.memberCount = [[propsDic objectForKey:@"memberCount"] integerValue];
            }
        }
        return YES;
    }
    return NO;
}
@end
