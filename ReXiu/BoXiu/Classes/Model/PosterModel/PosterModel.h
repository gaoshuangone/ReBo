//
//  PosterModel.h
//  BoXiu
//
//  Created by andy on 14-7-7.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "BaseHttpModel.h"

@interface PosterData : NSObject
@property (nonatomic,assign) NSInteger actiontype;
@property (nonatomic,strong) NSString *data;
@property (nonatomic,strong) NSString *datetime;
@property (nonatomic,assign) NSInteger devicetype;
@property (nonatomic,assign) NSInteger posterid;
@property (nonatomic,strong) NSString *imgurl;
@property (nonatomic,assign) NSInteger postertype;
@property (nonatomic,assign) NSInteger seq;
@property (nonatomic,assign) NSInteger status;

@end

@interface PosterModel : BaseHttpModel
@property (nonatomic,strong) NSMutableArray *posterMArray;
@end
