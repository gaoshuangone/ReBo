//
//  CrownModel.h
//  BoXiu
//
//  Created by andy on 14-8-14.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "BaseTcpModel.h"

@interface CrownModel : BaseTcpModel
@property (nonatomic,assign) NSInteger chatType;
@property (nonatomic,strong) NSString *nick;
@property (nonatomic,assign) NSInteger staruserid;
@property (nonatomic,assign) NSInteger time;
@property (nonatomic,assign) NSInteger unspeak;
@property (nonatomic,assign) NSInteger userid;
@property (nonatomic,assign) NSInteger hidden;
@property (nonatomic,strong) NSString *hiddenindex;
@property (nonatomic,assign) NSInteger issupermanager;

@end
