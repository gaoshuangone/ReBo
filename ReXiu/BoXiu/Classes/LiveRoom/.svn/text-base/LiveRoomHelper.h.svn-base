//
//  LiveRoomHelper.h
//  BoXiu
//
//  Created by andy on 15/12/7.
//  Copyright © 2015年 rexiu. All rights reserved.
//
//Helper：静态辅助类,存放liveRoom流程，进入房间，连接tcp，开播，播放等  

#import <Foundation/Foundation.h>
#import "LiveRoomViewController.h"
@interface LiveRoomHelper : NSObject
@property (strong, nonatomic)LiveRoomViewController* rootLiveRoomViewController;
@property (nonatomic,strong) NSMutableDictionary *tabMenuContentViewControllers;
+(instancetype)shareLiveRoomHelper;
-(void)helperShareWithNumber:(NSInteger)number withShareTyep:(NSArray*)TypeArray withParms:(id)parms;
- (void)starid:(NSInteger)starid ButState:(UIButton *)ButState Attention:(NSInteger)attState;   //关注方法 starId 主播id butstate 按钮  attState 关注状态
+(void)canleOauthsWithType:(NSArray*)type;
@end
