//
//  InviterFriend.h
//  BoXiu
//
//  Created by tongmingyu on 15-5-7.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import "ViewController.h"
#import "EWPTabMenuControl.h"
#import "ChatRoomViewController.h"
#import "UserInfoManager.h"
#import "UMSocialSnsService.h"
#import "UserInfo.h"

@interface InviterFriendViewController : ViewController

@property (nonatomic,strong ) UITableView *table;

@property (nonatomic,strong) EWPTabMenuControl *tabMenuControl;

- (void)showRechargeDialog;

@end
