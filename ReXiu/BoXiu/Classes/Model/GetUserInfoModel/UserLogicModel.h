//
//  UserLogicModel.h
//  BoXiu
//
//  Created by tongmingyu on 14-5-23.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "BaseHttpModel.h"
#import "UserInfo.h"

@interface UserLogicModel : BaseHttpModel

- (BOOL)analyseUserData:(NSDictionary *)dataDic toInfo:(UserInfo *)userInfo;

- (BOOL)analyseStarData:(NSDictionary *)dataDic toInfo:(StarInfo *)starInfo;

@end
