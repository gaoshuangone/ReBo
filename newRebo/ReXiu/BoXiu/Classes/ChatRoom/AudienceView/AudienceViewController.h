//
//  AudienceViewController.h
//  BoXiu
//
//  Created by andy on 15-1-9.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import "ViewController.h"
#import "BaseTableView.h"
#import "ChatmemberModel.h"
#import "UserInfoManager.h"

@class AudienceViewController;
@protocol AudienceViewControllerDelegate <NSObject>

- (void)audienceViewController:(AudienceViewController *)audienceViewController showGift:    (UserInfo *)userInfo;
- (void)audienceViewController:(AudienceViewController *)audienceViewController chatWithUser:(UserInfo *)userInfo;
- (void)audienceViewController:(AudienceViewController *)audienceViewController kickPerson:  (UserInfo *)userInfo;
- (void)audienceViewController:(AudienceViewController *)audienceViewController forbidSpeak: (UserInfo *)userInfo;
- (void)audienceViewController:(AudienceViewController *)audienceViewController report:      (UserInfo *)userInfo;

- (void)updateTouristCount:(NSInteger)touristCount recordCountshowGift:(NSInteger)recordCount;
@optional //新增加的
- (void)showGiftLeft:(UserInfo *)userInfo;
- (void)chatWithUserLeft:(UserInfo *)userInfo;
- (void)kickPersonLeft:(UserInfo *)userInfo;
- (void)forbidSpeakLeft:(UserInfo *)userInfo;
- (void)reportLeft:(UserInfo *)userInfo;

-(void)guanZhuStartView:(BOOL)guanzhu;//liveRoom改变startview的关注，liftroom做代理

-(void)pressedStartHeadImage;

-(void)pressedShowOherTerminalLoggedDialog;//新加的left里边掉liveRoom得多端登录

@end

@interface AudienceViewController : ViewController

@property (nonatomic,assign) id<AudienceViewControllerDelegate> delegate;
@property (nonatomic,assign) NSInteger touristCount;
@property (nonatomic,assign) NSInteger recordCount;
@property (nonatomic,assign) NSInteger roomType;  //3 明星热波间

//如果showtype=3时去掉“送她礼物”选项
- (void)initData:(NSInteger)showType;

- (UserInfo *)userInfoByUserId:(NSInteger )userId;
- (void)deleteUserByUserId:(NSInteger)userId;

@end