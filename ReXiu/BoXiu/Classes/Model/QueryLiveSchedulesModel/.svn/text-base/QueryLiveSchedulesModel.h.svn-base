//
//  QueryLiveSchedulesModel.h
//  BoXiu
//
//  Created by tongmingyu on 14-10-27.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "BaseHttpModel.h"

@interface LiveSchedulesData : NSObject

@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, assign) long long endTimeInMillis;
@property (nonatomic, strong) NSString *endTime;
@property (nonatomic, assign) NSInteger pid;
@property (nonatomic, assign) NSInteger lintype;
@property (nonatomic, strong) NSString *liveName;
@property (nonatomic, assign) NSInteger liveprogramid;
@property (nonatomic, strong) NSString *mobileImg;
@property (nonatomic, strong) NSString *mobileUrl;
@property (nonatomic, strong) NSString *pcImg;
@property (nonatomic, strong) NSString *pcUrl;
@property (nonatomic, strong) NSString *starIdxcode;

@property (nonatomic, assign) long long starTimeInMillis;
@property (nonatomic, strong) NSString *startTime;
@property (nonatomic, assign) NSInteger userid;
@property (nonatomic, assign) NSString *photo;
@property (nonatomic, assign) NSString *adphoto;
@property (nonatomic, assign) NSInteger attentionflag;
@property (nonatomic, assign) NSInteger recommendno;

//节目置顶需要添加的字段
@property (nonatomic, strong) NSString *nick;
@property (nonatomic, assign) NSInteger onlineflag;

@property (nonatomic, strong) NSString *roomposter;
@property (nonatomic, strong) NSString *showDate;
@property (nonatomic, strong) NSString *showDateTitle;
@property (nonatomic, strong) NSString *showTime;
@property (nonatomic, strong) NSString *starbigimg;
@property (nonatomic, assign) NSInteger topflag;
@property (nonatomic, assign) NSInteger showusernum;
@property (nonatomic, assign) NSInteger starlevelid;

//增加当天是否开播状态，服务器不下发，本地增加
@property (nonatomic,assign) BOOL startInCurrentDate;
@end

@interface QueryLiveSchedulesModel : BaseHttpModel

@property (nonatomic, strong) NSMutableArray *todayMary;
@property (nonatomic, strong) NSMutableArray *tomorrowMary;
@property (nonatomic, strong) NSMutableArray *liveSchedMutable;
@property (nonatomic, strong) NSMutableArray *photoMary;


@end
