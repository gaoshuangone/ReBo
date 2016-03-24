//
//  TheCarModel.h
//  BoXiu
//
//  Created by tongmingyu on 14-8-29.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "BaseHttpModel.h"


@interface MallCarData : NSObject
@property (nonatomic,strong) NSString *brandimg;
@property (nonatomic,strong) NSString *carimg;
@property (nonatomic,strong) NSString *carimgbig;
@property (nonatomic,strong) NSString *carName;
@property (nonatomic,strong) NSString *carunit;
@property (nonatomic,assign) long long coin;
@property (nonatomic,assign) NSInteger pid;
@property (nonatomic,strong) NSString *mark;
@property (nonatomic,assign) NSInteger propsno;
@property (nonatomic,assign) NSInteger propstype;
@property (nonatomic,assign) NSInteger timenum;
@property (nonatomic,assign) NSInteger timeunit;

@end

@interface TheCarModel : BaseHttpModel

@property (nonatomic, strong) NSMutableArray *CarMarray;

@end
