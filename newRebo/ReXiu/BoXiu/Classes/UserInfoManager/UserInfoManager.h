//
//  UserInfoManager.h
//  BoXiu
//
//  Created by andy on 14-4-21.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfo.h"
#import "GetUserInfoModel.h"
@interface UserInfoManager : NSObject
@property (nonatomic,strong) UserInfo *currentUserInfo;//只存个人信息
@property (nonatomic,strong) StarInfo *currentStarInfo;//只存star信息，与userInfo可互相转
@property (nonatomic,strong) GetUserInfoModel *getUserInfoModel;
@property (nonatomic,strong) StarInfo *tempStarInfo;//临时变量，储存进入个人中心的主播
@property (nonatomic,strong) StarInfo *tempSelfStarInfo;//临时变量，储存个人信息
@property (nonatomic,strong) UIImage *tempHederImage;//临时变量，储存个人头像
@property (assign, nonatomic) BOOL isHideChatOn;    /**<聊天是否隐藏    */
@property (assign, nonatomic) BOOL isDanMuShowing;  /**<弹幕是否展示    */
@property (assign, nonatomic) BOOL isAudioOn;       /**<音频模式是否打开 */

@property (nonatomic,assign) NSInteger hidden;      //是否隐身
+ (UserInfoManager *)shareUserInfoManager;

//更新当前用户信息
- (void)updateCurrentUserInfo:(UserInfo *)userInfo;

- (void)resetRoomUserInfo;

- (NSArray *)chatMember;

- (NSArray *)giftMember;

- (NSDictionary *)allMemberInfo;

- (void)addChatMember:(UserInfo *)userInfo;//更新聊天成员列表

- (void)addGiftMember:(UserInfo *)userInfo;//更新礼物赠送列表成员列表

- (void)addMemberInfo:(UserInfo *)userInfo;//更新所有成员信息

- (void)setChatHidden:(BOOL)on;     //更新隐藏聊天设置

- (void)setDanMuShowing:(BOOL)on;   //更新弹幕展示按钮

- (void)setAudioMode:(BOOL)on;      //更新音频模式按钮

/*所有的聊天室活跃成员的用户id和昵称，根据隐身用户规则添加的，并不是所有成员都增加的*/
- (NSDictionary *)allUserIdAndNick;

//返回VIP等级个数
- (NSInteger)countOfVip;

/*被踢出房间的用户，从数据里删除*/
- (void)deleteUserIdAndNick:(NSNumber *)userId;

//消费等级图片
- (UIImage *)imageOfconsumerlevelweight:(NSInteger)weight;

//权限等级图片
- (UIImage *)imageOfprivlevelweight:(NSInteger)weight;

//vip等级图片
- (UIImage *)imageOfVip:(NSInteger)weight;

//主播等级
- (UIImage *)imageOfStar:(NSInteger)weight;

//礼物图片
- (UIImage *)imageOfGift:(NSInteger)gift;
//礼物名称
-(NSString *)nameOfGift:(NSInteger)gift;
@end
