//
//  ChatRoomViewController.h
//  XiuBo
//
//  Created by Andy on 14-3-21.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "ViewController.h"
#import "EWPSegmentedControl.h"
#import "ChatToolBar.h"
#import "UserInfo.h"
#import "GetRoomInfoModel.h"

@interface ChatRoomViewController : ViewController

@property (nonatomic,strong) RoomInfoData *roomInfoData;
@property (nonatomic,assign) NSInteger staruserid;//主播id
@property (nonatomic,assign) BOOL showTimeInProgress;//判断明星直播间是否正在进行，开始了就可以免费点赞，未开始或结束都不能点赞
@property (nonatomic,assign) NSInteger showTimeTotalApproveCount;//明星热波间送给主播说有的赞，要保存在本地

@property (nonatomic,strong) EWPSegmentedControl *tabMenuBar;
- (NSDictionary *)chatMemberDic;

//需要直播间跳出弹出框，一种情况是从大厅进入，一种是从左右菜单进入，这样navigationcontroller会不一样

/**
 *  显示充值页面对话框
 */
- (void)showRechargeDialog;

/**
 *  显示跳转到商城对话框
 */
-(void)showMarketDialogWithTitle:(NSString *)title message:(NSString *)message buyVipBlock:(void(^)())buyVipBlock cancelBlock:(void (^)())cancelBlock;

//跳转到充值界面
- (void)goToRechargeView;

//showtime点赞时候实时传输数据
- (void)setStarApproveCount:(NSInteger)approveCount;

//定时发送积累的赞
- (void)sendStarApproveWithPraiseType:(NSInteger)praiseType;

//举报功能
- (void)reportUser:(UserInfo *)userInfo;
@end
