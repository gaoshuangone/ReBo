//
//  AudienceHeaderView.h
//  BoXiu
//
//  Created by andy on 15/12/8.
//  Copyright © 2015年 rexiu. All rights reserved.
//

#import "BaseView.h"
#import "LiveRoomViewController.h"
#import "UserEnterRoomModel.h"
@interface AudienceHeaderView : BaseView<UIScrollViewDelegate>

@property (strong, nonatomic)LiveRoomViewController* rootLiveRoomViewController;
@property (nonatomic, copy) void(^audienceHeaderViewTouch)(UserInfo* userInfo);
-(void)initAudienceHeaderViewData;
-(void)addAudienceHeaderWithModel:(UserEnterRoomModel*)model;
-(void)delAudienceHeaderWithModel:(UserEnterRoomModel*)model;
-(void)cleanAudienceHeaderData;

@end
