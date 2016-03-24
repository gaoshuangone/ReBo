//
//  LiveEndView.h
//  BoXiu
//
//  Created by andy on 15/12/12.
//  Copyright © 2015年 rexiu. All rights reserved.
//

#import "BaseView.h"
#import "LiveRoomViewController.h"
#import "PersonData.h"
#import "LiveRoomUtil.h"
@interface LiveEndView : BaseView
@property (strong , nonatomic)LiveRoomViewController* rootLiveRoomController;
-(void)setGuanZhuCount:(NSString*)count;
@property (strong , nonatomic)PersonData* personData;
@end
