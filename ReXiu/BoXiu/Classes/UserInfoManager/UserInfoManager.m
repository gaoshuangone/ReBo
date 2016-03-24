//
//  UserInfoManager.m
//  BoXiu
//
//  Created by andy on 14-4-21.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "UserInfoManager.h"

#define MAX_CHATMEMBER_LISTCOUNT (5)
#define MAX_GIFTMEMBER_LISTCOUNT (5)

@interface UserInfoManager ()

@property (nonatomic,strong) NSMutableArray *chatMemberMArray;

@property (nonatomic,strong) NSMutableArray *giftMemberMArray;

@property (nonatomic,strong) NSMutableDictionary *allMemberMDic;

@property (nonatomic,strong) NSMutableDictionary *userIdAndNickMDic;

@property (nonatomic,strong) NSDictionary *privlevelweightImage;

@property (nonatomic,strong) NSDictionary *consumerweightImage;

@property (nonatomic,strong) NSDictionary *vipImage;

@property (nonatomic,strong) NSDictionary *starLevelImage;

@property (nonatomic,strong) NSDictionary *giftImage;

@property (nonatomic,strong) NSLock *userInfoLock;

@end

@implementation UserInfoManager

+ (UserInfoManager *)shareUserInfoManager
{
    static dispatch_once_t predicate;
    static UserInfoManager* instance;
    dispatch_once(&predicate,^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        _userInfoLock = [[NSLock alloc] init];
        
        [self initConsumerlevelweightImage];
        [self initPrivlevelweightImage];
        [self initVipImage];
        [self initStarlevelImage];
        [self initGiftImage];
    }
    return self;
}

//load消费等级图片
- (void)initConsumerlevelweightImage
{
    _consumerweightImage=@{
                            
                            [NSNumber numberWithInt:0]: [UIImage imageNamed:@"V0.png"],
                            [NSNumber numberWithInt:1]: [UIImage imageNamed:@"V1.png"],
                            [NSNumber numberWithInt:2]: [UIImage imageNamed:@"V2.png"],
                            [NSNumber numberWithInt:3]: [UIImage imageNamed:@"V3.png"],
                            [NSNumber numberWithInt:4]: [UIImage imageNamed:@"V4.png"],
                            [NSNumber numberWithInt:5]: [UIImage imageNamed:@"V5.png"],
                            [NSNumber numberWithInt:6]: [UIImage imageNamed:@"V6.png"],
                            [NSNumber numberWithInt:7]: [UIImage imageNamed:@"V7.png"],
                            [NSNumber numberWithInt:8]: [UIImage imageNamed:@"V8.png"],
                            [NSNumber numberWithInt:9]: [UIImage imageNamed:@"V9.png"],
                            [NSNumber numberWithInt:10]: [UIImage imageNamed:@"V10.png"],
                            [NSNumber numberWithInt:11]: [UIImage imageNamed:@"V11.png"],
                            [NSNumber numberWithInt:12]: [UIImage imageNamed:@"V12.png"],
                            [NSNumber numberWithInt:13]: [UIImage imageNamed:@"V13.png"],
                            [NSNumber numberWithInt:14]: [UIImage imageNamed:@"V14.png"],
                            [NSNumber numberWithInt:15]: [UIImage imageNamed:@"V15.png"],
                            [NSNumber numberWithInt:16]: [UIImage imageNamed:@"V16.png"],
                            [NSNumber numberWithInt:17]: [UIImage imageNamed:@"V17.png"],
                            [NSNumber numberWithInt:18]: [UIImage imageNamed:@"V18.png"],
                            [NSNumber numberWithInt:19]: [UIImage imageNamed:@"V19.png"],
                            [NSNumber numberWithInt:20]: [UIImage imageNamed:@"V20.png"],
                            [NSNumber numberWithInt:21]: [UIImage imageNamed:@"V21.png"],
                            [NSNumber numberWithInt:22]: [UIImage imageNamed:@"V22.png"],
                            [NSNumber numberWithInt:23]: [UIImage imageNamed:@"V23.png"],
                            [NSNumber numberWithInt:24]: [UIImage imageNamed:@"V24.png"],
                            };
}

- (NSInteger)countOfVip
{
    return [_consumerweightImage count];
}

- (UIImage *)imageOfconsumerlevelweight:(NSInteger)weight
{
    return [_consumerweightImage objectForKey:[NSNumber numberWithInteger:weight]];
}

//load权限等级图片
- (void)initPrivlevelweightImage
{
    _privlevelweightImage=@{
                          
                            
                          };
}

- (UIImage *)imageOfprivlevelweight:(NSInteger)weight
{
     //return [_privlevelweightImage objectForKey:[NSNumber numberWithInt:weight]];
    return [self imageOfStar:weight];
}

//load vip等级图片
- (void)initVipImage
{
    _vipImage=@{
                [NSNumber numberWithInt:10]: [UIImage imageNamed:@"vip1"],
                [NSNumber numberWithInt:14]: [UIImage imageNamed:@"vip2"],
               };
}

- (UIImage *)imageOfVip:(NSInteger)weight
{
     return [_vipImage objectForKey:[NSNumber numberWithInteger:weight]];
}

- (void)initStarlevelImage
{
    _starLevelImage=@{
                            [NSNumber numberWithInt:0]: [UIImage imageNamed:@"star_00.png"],
                            [NSNumber numberWithInt:1]: [UIImage imageNamed:@"star_01.png"],
                            [NSNumber numberWithInt:2]: [UIImage imageNamed:@"star_02.png"],
                            [NSNumber numberWithInt:3]: [UIImage imageNamed:@"star_03.png"],
                            [NSNumber numberWithInt:4]: [UIImage imageNamed:@"star_04.png"],
                            [NSNumber numberWithInt:5]: [UIImage imageNamed:@"star_05.png"],
                            [NSNumber numberWithInt:6]: [UIImage imageNamed:@"star_06.png"],
                            [NSNumber numberWithInt:7]: [UIImage imageNamed:@"star_07.png"],
                            [NSNumber numberWithInt:8]: [UIImage imageNamed:@"star_08.png"],
                            [NSNumber numberWithInt:9]: [UIImage imageNamed:@"star_09.png"],
                            [NSNumber numberWithInt:10]: [UIImage imageNamed:@"star_10.png"],
                            [NSNumber numberWithInt:11]: [UIImage imageNamed:@"star_11.png"],
                            [NSNumber numberWithInt:12]: [UIImage imageNamed:@"star_12.png"],
                            [NSNumber numberWithInt:13]: [UIImage imageNamed:@"star_13.png"],
                            [NSNumber numberWithInt:14]: [UIImage imageNamed:@"star_14.png"],
                            [NSNumber numberWithInt:15]: [UIImage imageNamed:@"star_15.png"],
                            [NSNumber numberWithInt:16]: [UIImage imageNamed:@"star_16.png"],
                            [NSNumber numberWithInt:17]: [UIImage imageNamed:@"star_17.png"],
                            [NSNumber numberWithInt:18]: [UIImage imageNamed:@"star_18.png"],
                            [NSNumber numberWithInt:19]: [UIImage imageNamed:@"star_19.png"],
                            [NSNumber numberWithInt:20]: [UIImage imageNamed:@"star_20.png"],


                            };
}

- (UIImage *)imageOfStar:(NSInteger)weight
{
    if (weight > [_starLevelImage count] - 1)
    {
        return [_starLevelImage objectForKey:[NSNumber numberWithInteger:([_starLevelImage count] - 1)]];
    }
    return [_starLevelImage objectForKey:[NSNumber numberWithInteger:weight]];
}

- (void)initGiftImage
{
    _giftImage=@{
                            
                 [NSNumber numberWithInt:1]: @{@"name":@"南瓜马车",@"image":[UIImage imageNamed:@"gift1.png"]},
                 [NSNumber numberWithInt:2]: @{@"name":@"口红",@"image":[UIImage imageNamed:@"gift2.gif"]},
                 [NSNumber numberWithInt:3]: @{@"name":@"奶茶",@"image":[UIImage imageNamed:@"gift3.png"]},
                 [NSNumber numberWithInt:4]: @{@"name":@"巧克力",@"image":[UIImage imageNamed:@"gift4.png"]},
                 [NSNumber numberWithInt:5]: @{@"name":@"情书",@"image":[UIImage imageNamed:@"gift5.png"]},
                 [NSNumber numberWithInt:6]: @{@"name":@"比基尼",@"image":[UIImage imageNamed:@"gift6.png"]},
                 [NSNumber numberWithInt:7]: @{@"name":@"风车",@"image":[UIImage imageNamed:@"gift7.gif"]},
                 [NSNumber numberWithInt:8]: @{@"name":@"红宝石",@"image":[UIImage imageNamed:@"gift8.png"]},
                 [NSNumber numberWithInt:9]: @{@"name":@"爆米花",@"image":[UIImage imageNamed:@"gift9.gif"]},
                 [NSNumber numberWithInt:10]: @{@"name":@"拖拉机",@"image":[UIImage imageNamed:@"gift10.png"]},
                 [NSNumber numberWithInt:11]: @{@"name":@"UFO",@"image":[UIImage imageNamed:@"gift11.png"]},
                 [NSNumber numberWithInt:12]: @{@"name":@"棒棒糖",@"image":[UIImage imageNamed:@"gift12.gif"]},
                 [NSNumber numberWithInt:13]: @{@"name":@"蛋糕",@"image":[UIImage imageNamed:@"gift13.png"]},
                 [NSNumber numberWithInt:14]: @{@"name":@"新款跑车",@"image":[UIImage imageNamed:@"gift14.jpg"]},
                 [NSNumber numberWithInt:15]: @{@"name":@"战斗机",@"image":[UIImage imageNamed:@"gift15.png"]},
                 [NSNumber numberWithInt:16]: @{@"name":@"CD",@"image":[UIImage imageNamed:@"gift16.gif"]},
                 [NSNumber numberWithInt:17]: @{@"name":@"玫瑰",@"image":[UIImage imageNamed:@"gift17.gif"]},
                 [NSNumber numberWithInt:18]: @{@"name":@"红心",@"image":[UIImage imageNamed:@"gift18.gif"]},
                 [NSNumber numberWithInt:19]: @{@"name":@"游艇",@"image":[UIImage imageNamed:@"gift19.png"]},
                 [NSNumber numberWithInt:20]: @{@"name":@"飞吻",@"image":[UIImage imageNamed:@"gift20.gif"]},
                 [NSNumber numberWithInt:21]: @{@"name":@"旋转木马",@"image":[UIImage imageNamed:@"gift21.gif"]}
                 
                 };
}

- (UIImage *)imageOfGift:(NSInteger)gift
{
    return [[_giftImage objectForKey:[NSNumber numberWithInteger:gift]] objectForKey:@"image"];
}

-(NSString *)nameOfGift:(NSInteger)gift
{
    return [[_giftImage objectForKey:[NSNumber numberWithInteger:gift]] objectForKey:@"name"];
}

- (void)resetRoomUserInfo
{
    if (_chatMemberMArray)
    {
        [_chatMemberMArray removeAllObjects];
    }
    if (_giftMemberMArray)
    {
        [_giftMemberMArray removeAllObjects];
    }
    
    if (_allMemberMDic)
    {
        [_allMemberMDic removeAllObjects];
    }
    
    if (_userIdAndNickMDic)
    {
        [_userIdAndNickMDic removeAllObjects];
    }
    
}

- (void)addMemberInfo:(UserInfo *)userInfo
{
    if (self.allMemberMDic == nil)
    {
        _allMemberMDic = [[NSMutableDictionary alloc] initWithCapacity:0];
    }
    [self.allMemberMDic setObject:userInfo forKey:[NSNumber numberWithInteger:userInfo.userId]];
    [self addUserIdAndNick:userInfo];
}

- (void)setCurrentUserInfo:(UserInfo *)currentUserInfo
{
    [_userInfoLock lock];
    _currentUserInfo = currentUserInfo;
    if (_currentUserInfo)
    {
        if (currentUserInfo.token && [currentUserInfo.token length])
        {
            [AppInfo shareInstance].token = currentUserInfo.token;
        }
        
        [AppInfo shareInstance].bOldLoginState = [AppInfo shareInstance].bLoginSuccess;
        [AppInfo shareInstance].bLoginSuccess = YES;
      

    }
    else
    {
        [AppInfo shareInstance].token = nil;
        [AppInfo shareInstance].bOldLoginState = [AppInfo shareInstance].bLoginSuccess;
        [AppInfo shareInstance].bLoginSuccess = NO;
    }
    [_userInfoLock unlock];
}

////////////////////////////////////////////////////////////////////////////////////////
//增加聊天室活跃用户userid和昵称，检索，为了用户颜色突出
- (void)addUserIdAndNick:(UserInfo *)userInfo
{
    if (userInfo)
    {
        if (_userIdAndNickMDic == nil)
        {
            _userIdAndNickMDic = [NSMutableDictionary dictionary];
        }
        
        UserInfo *currentUserInfo = [UserInfoManager shareUserInfoManager].currentUserInfo;
        if (currentUserInfo)
        {
            if(userInfo.userId == currentUserInfo.userId)
            {
                if (userInfo.hidden == 2)
                {

//                    [_userIdAndNickMDic setObject:[NSString stringWithFormat:@"%@",userInfo.hiddenindex] forKey:[NSNumber numberWithInteger:userInfo.userId]];
                       [_userIdAndNickMDic setObject:[NSString stringWithFormat:@"%@",@"神秘用户"] forKey:[NSNumber numberWithInteger:userInfo.userId]];
                }
                else
                {
//                    [_userIdAndNickMDic setObject:[NSString stringWithFormat:@"我「%@」",userInfo.nick] forKey:[NSNumber numberWithInteger:userInfo.userId]];
                    [_userIdAndNickMDic setObject:[NSString stringWithFormat:@"%@",userInfo.nick] forKey:[NSNumber numberWithInteger:userInfo.userId]];
                }
            }
            else
            {
                if (userInfo.hidden == 2)
                {
                    if ([UserInfoManager shareUserInfoManager].currentUserInfo.issupermanager)
                    {
                        if (userInfo.issupermanager)
                        {
//                            [_userIdAndNickMDic setObject:[NSString stringWithFormat:@"「%@」",userInfo.hiddenindex] forKey:[NSNumber numberWithInteger:userInfo.userId]];
                            [_userIdAndNickMDic setObject:[NSString stringWithFormat:@"%@",userInfo.hiddenindex] forKey:[NSNumber numberWithInteger:userInfo.userId]];
                        }
                        else
                        {
//                            [_userIdAndNickMDic setObject:[NSString stringWithFormat:@"「%@」「%@」",userInfo.nick,userInfo.hiddenindex] forKey:[NSNumber numberWithInteger:userInfo.userId]];
                            [_userIdAndNickMDic setObject:[NSString stringWithFormat:@"%@ %@",userInfo.nick,userInfo.hiddenindex] forKey:[NSNumber numberWithInteger:userInfo.userId]];
                        }
                    }
                    else
                    {
//                        [_userIdAndNickMDic setObject:[NSString stringWithFormat:@"「%@」",userInfo.hiddenindex] forKey:[NSNumber numberWithInteger:userInfo.userId]];
                        [_userIdAndNickMDic setObject:[NSString stringWithFormat:@"%@",userInfo.hiddenindex] forKey:[NSNumber numberWithInteger:userInfo.userId]];
                    }
                }
                else
                {
//                    [_userIdAndNickMDic setObject:[NSString stringWithFormat:@"「%@」",userInfo.nick] forKey:[NSNumber numberWithInteger:userInfo.userId]];
                    [_userIdAndNickMDic setObject:[NSString stringWithFormat:@"%@",userInfo.nick] forKey:[NSNumber numberWithInteger:userInfo.userId]];
                }

            }
            
        }
        else
        {
            //游客进入
            if (userInfo.hidden == 2)
            {
//                [_userIdAndNickMDic setObject:[NSString stringWithFormat:@"「%@」",userInfo.hiddenindex] forKey:[NSNumber numberWithInteger:userInfo.userId]];
                [_userIdAndNickMDic setObject:[NSString stringWithFormat:@"%@",userInfo.hiddenindex] forKey:[NSNumber numberWithInteger:userInfo.userId]];
            }
            else
            {
//                [_userIdAndNickMDic setObject:[NSString stringWithFormat:@"「%@」",userInfo.nick] forKey:[NSNumber numberWithInteger:userInfo.userId]];
                 [_userIdAndNickMDic setObject:[NSString stringWithFormat:@"%@",userInfo.nick] forKey:[NSNumber numberWithInteger:userInfo.userId]];
            }
        }
       
    }
}

- (void)deleteUserIdAndNick:(NSNumber *)userId
{
    if (userId != 0)
    {
        if (_userIdAndNickMDic)
        {
            [_userIdAndNickMDic removeObjectForKey:userId];
        }
    }
}

- (NSDictionary *)allUserIdAndNick
{
    return _userIdAndNickMDic;
}
////////////////////////////////////////////////////////////////////////////////////////////

- (void)addChatMember:(UserInfo *)userInfo
{
    if (_chatMemberMArray == nil)
    {
        _chatMemberMArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    if ([self.chatMemberMArray count] == MAX_CHATMEMBER_LISTCOUNT)
    {
        [self.chatMemberMArray removeObjectAtIndex:1];
    }
    
    BOOL bHasUserInfo = NO;
    for (UserInfo *user in self.chatMemberMArray)
    {
        if (userInfo.userId == user.userId)
        {
            bHasUserInfo = YES;
            break;
        }
    }
    if (!bHasUserInfo)
    {
        [self.chatMemberMArray addObject:userInfo];
    }
    //每次更新信息
    [self addMemberInfo:userInfo];
}

- (void)addGiftMember:(UserInfo *)userInfo
{
    if (_giftMemberMArray == nil)
    {
        _giftMemberMArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    
    for (UserInfo *info in self.giftMemberMArray)
    {
        if (info && info.userId == userInfo.userId)
        {
            [self.giftMemberMArray removeObject:info];
            break;
        }
    }
    if ([self.giftMemberMArray count] == MAX_GIFTMEMBER_LISTCOUNT)
    {
        [self.giftMemberMArray removeObjectAtIndex:0];
    }
    
    [self.giftMemberMArray addObject:userInfo];
    [self addMemberInfo:userInfo];
}

- (NSArray *)chatMember
{
    return self.chatMemberMArray;
}

- (NSArray *)giftMember
{
    return self.giftMemberMArray;
}

- (NSDictionary *)allMemberInfo
{
    return self.allMemberMDic;
}

- (void)updateCurrentUserInfo:(UserInfo *)userInfo
{
    if (userInfo)
    {
        
    }
}

- (void)setChatHidden:(BOOL)on     //更新隐藏聊天设置
{
    _isHideChatOn = on;
}

- (void)setDanMuShowing:(BOOL)on   //更新弹幕展示按钮
{
    _isDanMuShowing = on;
}

- (void)setAudioMode:(BOOL)on      //更新音频模式按钮
{
    _isAudioOn = on;
}
@end
