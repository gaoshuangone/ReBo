
//
//  InviterFriendModel.m
//  BoXiu
//
//  Created by tongmingyu on 15-5-15.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import "InviterFriendModel.h"

@implementation InviterReward

@end

@implementation Reward


@end

@implementation InviterFriendModel

- (void)requestDataWithParams:(NSDictionary *)params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    [self requestDataWithMethod:Rewards_Method params:params success:success fail:fail];

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
        if (dataDic)
        {
            self.successCount = [[dataDic objectForKey:@"successCount"] integerValue];
            NSArray *inviterRewards = [dataDic objectForKey:@"inviterRewards"];
            if (inviterRewards && [inviterRewards count])
            {
                for (int nIndex = 0; nIndex < [inviterRewards count]; nIndex++)
                {
                    if (_inviterRewards == nil)
                    {
                        _inviterRewards = [NSMutableArray array];
                    }
                    
                    NSDictionary *inviterRewardDic = [inviterRewards objectAtIndex:nIndex];
                    if (inviterRewardDic)
                    {
                        InviterReward *inviterReward = [[InviterReward alloc] init];
                        inviterReward.count = [[inviterRewardDic objectForKey:@"count"] integerValue];
                        inviterReward.type = [[inviterRewardDic objectForKey:@"type"] integerValue];
                        
                        NSArray *rewards = [inviterRewardDic objectForKey:@"rewards"];
                        if (rewards && [rewards count])
                        {
                            if (inviterReward.rewards == nil)
                            {
                                inviterReward.rewards = [NSMutableArray array];
                            }
                            
                            for (int nSubIndex = 0; nSubIndex < [rewards count]; nSubIndex++)
                            {
                                NSDictionary *rewardDic = [rewards objectAtIndex:nSubIndex];
                                if (rewardDic)
                                {
                                    Reward *reward = [[Reward alloc] init];
                                    reward.count = [[rewardDic objectForKey:@"count"] integerValue];
                                    reward.rewardId = [[rewardDic objectForKey:@"id"] integerValue];
                                    reward.imgsrc = [rewardDic objectForKey:@"imgsrc"];
                                    reward.name = [rewardDic objectForKey:@"name"];
                                    reward.type = [rewardDic objectForKey:@"type"];
                                    reward.unit = [[rewardDic objectForKey:@"unit"] integerValue];
                                    [inviterReward.rewards addObject:reward];
                                }
                            }

                        }
                        [_inviterRewards addObject:inviterReward];
                    }
                }
            }
        }
    }
    return YES;
 }



@end
