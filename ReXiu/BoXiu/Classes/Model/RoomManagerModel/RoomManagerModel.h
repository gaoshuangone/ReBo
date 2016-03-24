//
//  RoomManagerModel.h
//  BoXiu
//
//  Created by andy on 14-7-23.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "BaseTcpModel.h"

@interface RoomManagerModel : BaseTcpModel
@property (nonatomic,assign) NSInteger chatType;
@property (nonatomic,assign) NSInteger userid;
@property (nonatomic,strong) NSString *nick;
@property (nonatomic,assign) NSInteger staruserid;
@end
