//
//  UserInfo.m
//  BoXiu
//
//  Created by Andy on 14-4-2.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "UserInfo.h"
#import "UserInfoManager.h"

@implementation UserProp


@end

@implementation UserInfo

//- (void)setConsumerlevelweight:(int)consumerlevelweight
//{
//    NSInteger tempConsumerlevelweight = consumerlevelweight;
//    if (tempConsumerlevelweight < 11)
//    {
//        tempConsumerlevelweight = 0;
//    }
//    else if (tempConsumerlevelweight <= 20)
//    {
//        tempConsumerlevelweight -= 10;
//    }
//    else if (tempConsumerlevelweight >= 35 && tempConsumerlevelweight <= 110 && (tempConsumerlevelweight % 5) == 0)
//    {
//        NSInteger level = (tempConsumerlevelweight - 35) / 5 + 11;
//        if (level > [[UserInfoManager shareUserInfoManager] countOfVip] - 1)
//        {
//            level = [[UserInfoManager shareUserInfoManager] countOfVip] -1;
//            tempConsumerlevelweight = level;
//        }
//         tempConsumerlevelweight = level;
//    }
//    _consumerlevelweight = tempConsumerlevelweight;
//}

+ (NSInteger)switchConsumerlevelweight:(NSInteger)consumerlevelweight
{
    NSInteger tempConsumerlevelweight = consumerlevelweight;
    if (tempConsumerlevelweight < 11)
    {
        tempConsumerlevelweight = 0;
    }
    else if (tempConsumerlevelweight <= 20)
    {
        tempConsumerlevelweight -= 10;
    }
    else if (tempConsumerlevelweight >= 35 && tempConsumerlevelweight <= 110 && (tempConsumerlevelweight % 5) == 0)
    {
        NSInteger level = (tempConsumerlevelweight - 35) / 5 + 11;
        if (level > [[UserInfoManager shareUserInfoManager] countOfVip] - 1)
        {
            level = [[UserInfoManager shareUserInfoManager] countOfVip] -1;
            tempConsumerlevelweight = level;
        }
        tempConsumerlevelweight = level;
    }
    return tempConsumerlevelweight;

}

@end

@implementation StarInfo


@end