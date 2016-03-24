//
//  ScrollMessageModel.h
//  BoXiu
//
//  Created by andy on 14-5-21.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "RoomMessageModel.h"

@interface ScrollMessageModel : RoomMessageModel
@property (nonatomic,assign) int fromuserid;
@property (nonatomic,strong) NSString *fromnick;
@property (nonatomic,assign) int touserid;
@property (nonatomic,strong) NSString *tonick;
@property (nonatomic,strong) NSString *giftname;
@property (nonatomic,strong) NSString *giftimg;
@property (nonatomic,assign) int giftnum;
@property (nonatomic,strong) NSString *giftunit;


@end
