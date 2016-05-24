//
//  AttentionModel.h
//  BoXiu
//
//  Created by tongmingyu on 14-5-7.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "BaseHttpModel.h"

@interface AttentionModel : BaseHttpModel

@property (nonatomic,assign) NSInteger pageIndex;
@property (nonatomic,assign) NSInteger pageSize;
@property (nonatomic,assign) BOOL pagination;
@property (nonatomic,assign) NSInteger recordCount;
@property (nonatomic,assign) NSInteger praisecount;

@property (nonatomic,strong) NSMutableArray *starUserMArray;
@end

@interface ChangeAttentionModel : AttentionModel
@end