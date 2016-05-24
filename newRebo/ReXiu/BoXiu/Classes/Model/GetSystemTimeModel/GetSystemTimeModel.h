//
//  GetSystemTimeModel.h
//  BoXiu
//
//  Created by andy on 15-1-15.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import "BaseHttpModel.h"

@interface GetSystemTimeModel : BaseHttpModel
@property (nonatomic,assign) long long systemTime;//毫秒，转换为时间需要除以1000
@end
