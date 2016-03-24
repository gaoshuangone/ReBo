//
//  QueryStarModel.h
//  BoXiu
//
//  Created by andy on 14-5-6.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "BaseHttpModel.h"

@interface QueryStarModel : BaseHttpModel
@property (nonatomic,assign) NSInteger pageIndex;
@property (nonatomic,assign) NSInteger pageSize;
@property (nonatomic,assign) BOOL      pagination;
@property (nonatomic,assign) NSInteger recordCount;
@property (nonatomic,strong) NSMutableArray *starMArray;
@end
