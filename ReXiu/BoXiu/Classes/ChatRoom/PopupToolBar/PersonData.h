//
//  PersonData.h
//  BoXiu
//
//  Created by andy on 14-5-12.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonData : NSObject

@property (nonatomic,assign) NSInteger userId;
@property (nonatomic,strong) NSString *userImg;
@property (nonatomic,assign) NSInteger idxcode;
@property (nonatomic,strong) NSString *nick;
@property (nonatomic,strong) NSString *showbegintime;
@property (nonatomic,strong) NSString *notice;
@property (nonatomic,assign) NSInteger privlevelweight;
@property (nonatomic,strong) NSString *privatechatad;
@property (nonatomic,assign) NSInteger starlevelid;
@property (nonatomic,assign) BOOL attented;//yes为已关注，no为未关注
@property (nonatomic,assign) BOOL  playNotice;//YES为已添加开播通知，否则未添加
@property (nonatomic,assign) NSInteger showid;
@property (nonatomic,assign) NSInteger consumerlevelweight;
@end
