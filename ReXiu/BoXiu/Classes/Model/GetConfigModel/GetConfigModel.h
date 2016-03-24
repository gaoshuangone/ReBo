//
//  GetConfigModel.h
//  BoXiu
//
//  Created by andy on 14-5-5.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "BaseHttpModel.h"

@interface GetConfigModel : BaseHttpModel
@property (nonatomic,strong) NSString *res_server;
@property (nonatomic,assign) long heart_time;
@property (nonatomic,assign) NSInteger online_stars_location;
@end
