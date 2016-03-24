//
//  GetOneLevelCategoryModel.h
//  BoXiu
//
//  Created by andy on 14-8-8.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "BaseHttpModel.h"

@interface OneLevelCategoryData : NSObject
@property (nonatomic,strong) NSString *createtime;
@property (nonatomic,assign) NSInteger categoryId;
@property (nonatomic,assign) NSInteger levelno;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *icon;
@property (nonatomic,assign) NSInteger orderno;
@property (nonatomic,assign) NSInteger ordertype;
@property (nonatomic,assign) NSInteger pid;
@property (nonatomic,assign) NSInteger status;
@end

@interface GetOneLevelCategoryModel : BaseHttpModel
@property (nonatomic,strong) NSMutableArray *OneLevelCategoryMArray;
@end
