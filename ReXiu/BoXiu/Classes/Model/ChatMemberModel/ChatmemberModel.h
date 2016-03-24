//
//  ChatmemberModel.h
//  BoXiu
//
//  Created by andy on 14-5-16.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "BaseHttpModel.h"

@interface ChatMember : NSObject

@property (nonatomic,strong) NSString *clientId;
@property (nonatomic,assign) NSInteger consumerlevelweight;
@property (nonatomic,assign) NSInteger deviceType;
@property (nonatomic,assign) NSInteger hidden;
@property (nonatomic,assign) BOOL issupermanager;
@property (nonatomic,assign) NSInteger privlevelweight;
@property (nonatomic,assign) NSInteger realUserId;
@property (nonatomic,strong) NSString *photo;
@property (nonatomic,assign) NSInteger levelWeight;
@property (nonatomic,strong) NSString *nick;
@property (nonatomic,assign) long long time;
@property (nonatomic,assign) NSInteger userId;
@property (nonatomic,assign) NSInteger idxcode;
@property (nonatomic,assign) NSInteger staruserid;
@property (nonatomic,assign) NSInteger starlevelid;
@property (nonatomic,assign) BOOL isPurpleVip;  //紫色会员
@property (nonatomic,assign) BOOL isYellowVip;  //黄色会员

@end

@interface ChatmemberModel : BaseHttpModel
@property (nonatomic,strong) NSMutableArray *chatMemberMArray;
@property (nonatomic,assign) NSInteger recordCount;
@property (nonatomic,assign) NSInteger pageSize;
@property (nonatomic,assign) BOOL pagination;
@property (nonatomic,assign) NSInteger pageIndex;
@property (nonatomic,assign) NSInteger touristCount;//游客数
@property (nonatomic,assign) NSInteger memberCount;//真实数量
@property (nonatomic,assign) NSInteger maxViewerCount;//最大房间人数

@end
