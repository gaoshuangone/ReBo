//
//  LiveShareView.h
//  BoXiu
//
//  Created by andy on 15/12/19.
//  Copyright © 2015年 rexiu. All rights reserved.
//

#import "BaseView.h"
#import "LiveBottomView.h"
#import "LiveRoomViewController.h"
@interface LiveShareView : BaseView
@property (strong, nonatomic)LiveRoomViewController* rootLiveRoomViewController;
@property (copy, nonatomic) void(^liveShareViewTouche)(NSInteger tag);
@property (assign, nonatomic) BOOL isAVCaptureTorchModeOn;
@property (assign, nonatomic) CGRect frameTemp;

-(void)hidSelfWithisHid:(BOOL)isHid;
@end
