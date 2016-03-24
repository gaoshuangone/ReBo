//
//  UserEnterRoomModel.h
//  BoXiu
//
//  Created by andy on 14-8-5.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "BaseTcpModel.h"

@interface CarData : NSObject
@property (nonatomic,strong) NSString *brandimg;
@property (nonatomic,strong) NSString *carimgsmall;
@property (nonatomic,strong) NSString *carunit;
@property (nonatomic,strong) NSString *carname;
@property (nonatomic,assign) NSInteger carId;
@property (nonatomic,strong) NSString *flashurl;
@end

@interface MemberData : NSObject
@property (nonatomic,strong) NSString *clientId;
@property (nonatomic,assign) NSInteger consumerlevelweight;
@property (nonatomic,assign) NSInteger deviceType;
@property (nonatomic,assign) NSInteger hidden;
@property (nonatomic,strong) NSString *hiddenindex;
@property (nonatomic,assign) NSInteger idxcode;
@property (nonatomic,assign) BOOL issupermanager;
@property (nonatomic,assign) NSInteger levelWeight;
@property (nonatomic,strong) NSString *nick;
@property (nonatomic,strong) NSString *photo;
@property (nonatomic,assign) NSInteger privlevelweight;
@property (nonatomic,assign) NSInteger starlevelid;
@property (nonatomic,assign) NSInteger staruserid;
@property (nonatomic,assign) long long time;
@property (nonatomic,assign) NSInteger type;
@property (nonatomic,assign) NSInteger userId;
@end

@interface UserEnterRoomModel : BaseTcpModel
@property (nonatomic,strong) CarData *carData;
@property (nonatomic,strong) MemberData *memberData;
@property (nonatomic,assign) long long time;
@property (nonatomic,assign) NSInteger touristCount;
@property (nonatomic,assign) NSInteger type;
@end
