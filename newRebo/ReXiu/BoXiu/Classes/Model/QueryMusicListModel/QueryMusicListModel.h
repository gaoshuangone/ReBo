//
//  QueryMusicListModel.h
//  BoXiu
//
//  Created by tongmingyu on 14-12-26.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "BaseHttpModel.h"

@interface MusicData : NSObject

@property (nonatomic,assign) NSInteger musiceId;
@property (nonatomic,assign) NSInteger livescheduleid;
@property (nonatomic,strong) NSString *musicname;

@property (nonatomic,assign) NSInteger roomid;
@property (nonatomic,assign) NSInteger staruserid;
@property (nonatomic,assign) NSInteger status;
@property (nonatomic,assign) NSInteger ticket;

@end

@interface QueryMusicListModel : BaseHttpModel

@property (nonatomic,assign) NSInteger canOperate;
@property (nonatomic,strong) NSMutableArray *musicDataArray;

@end
