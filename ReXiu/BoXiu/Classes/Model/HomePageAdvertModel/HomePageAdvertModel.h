//
//  HomePageAdvertModel.h
//  BoXiu
//
//  Created by tongmingyu on 14-12-30.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "BaseHttpModel.h"

@interface HomePageAdData : NSObject

@property (nonatomic,assign) NSInteger actiontype;
@property (nonatomic,strong) NSString *createtime;
@property (nonatomic,strong) NSString *data;
@property (nonatomic,strong) NSString *datetime;
@property (nonatomic,assign) NSInteger devicetype;
@property (nonatomic,strong) NSString *endtime;
@property (nonatomic,assign) NSInteger adId;

@property (nonatomic,strong) NSString *imgurl;
@property (nonatomic,assign) NSInteger postertype;
@property (nonatomic,assign) NSInteger seq;
@property (nonatomic,strong) NSString *starttime;
@property (nonatomic,assign) NSInteger status;
@property (nonatomic,strong) NSString *title;


@end

@interface HomePageAdvertModel : BaseHttpModel

@property (nonatomic,strong) NSMutableArray *adMarray;

@end
