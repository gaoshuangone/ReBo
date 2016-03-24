//
//  LiveRoomLeftView.h
//  BoXiu
//
//  Created by andy on 15/6/11.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import "BaseView.h"
#import "BaseTableView.h"
#import "ViewController.h"
#import "BaseTableView.h"
#import "ChatmemberModel.h"
#import "UserInfoManager.h"
#import "AudienceViewController.h"
#import "AudieceToolCell.h"
#import "PersonData.h"
#import "StartView.h"
@interface LiveRoomLeftView : BaseView<AudienceToolDelegate,StartViewDelegate>
@property (nonatomic,assign) NSInteger touristCount;//游客
@property (nonatomic,assign) NSInteger recordCount;//用户
@property (nonatomic,assign) NSInteger roomType;  //3 明星热波间
@property (nonatomic,strong) UIView *bkView;
@property (assign, nonatomic)id<AudienceViewControllerDelegate> delegate;
@property (nonatomic,strong) BaseTableView *tableView;
@property (nonatomic,strong) PersonData *personData;
- (void)initData;
-(void)removeNoti;
@end
