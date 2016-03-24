//
//  GetRoomInfoModel.h
//  BoXiu
//
//  Created by andy on 14-5-12.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "BaseHttpModel.h"

@interface RoomInfoData : NSObject
@property (nonatomic,strong) NSString *bigstarstarttime;
@property (nonatomic,strong) NSString *showbegintime;//时间
@property (nonatomic,strong) NSString *roomad;//房间公告
@property (nonatomic,assign) BOOL  attentionflag;//关注状态
@property (nonatomic,assign) BOOL  managerflag;//是否是房管
@property (nonatomic,assign) NSInteger showid;
@property (nonatomic,strong) NSString *liveip;
@property (nonatomic,strong) NSString *livestream;
@property (nonatomic,strong) NSString *serverip;
@property (nonatomic,strong) NSString *serverport;
@property (nonatomic,strong) NSString *privatechatad;//悄悄话
@property (nonatomic,assign) NSInteger publictalkstatus;
@property (nonatomic,assign) NSInteger showtype;//1.视频直播。2.主播相册3.明星直播间，4：禁止普通用户发言
@property (nonatomic,assign) BOOL      openflag;//弹幕开关
@property (nonatomic,assign) NSInteger chatintervalcommon;
@property (nonatomic,assign) NSInteger chatintervalpurplevip;
@property (nonatomic,assign) NSInteger chatintervalyellowvip;
@property (nonatomic,assign) NSInteger pubpraisenotice;//控制公聊区域是否显示点赞信息
@property (nonatomic,assign) NSInteger bigstarstate;//明星直播间状态，1：弹幕2：showtime4：点歌
@property (nonatomic,assign) NSInteger showtimestatus;//0:未开始；1：正在进行;2:已结束
@property (nonatomic,assign) NSInteger enteredcount;//有多少人看过
@end

@interface GetRoomInfoModel : BaseHttpModel
@property (nonatomic,strong) RoomInfoData *roomInfoData;
@end

