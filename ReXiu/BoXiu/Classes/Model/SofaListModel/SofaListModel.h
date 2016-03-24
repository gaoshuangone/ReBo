//
//  SofaListModel.h
//  BoXiu
//
//  Created by andy on 14-6-4.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "BaseHttpModel.h"

@interface SofaCellData : NSObject
@property (nonatomic,assign) NSInteger coin;
@property (nonatomic,strong) NSString *datetime;
@property (nonatomic,assign) NSInteger sofaid;
@property (nonatomic,strong) NSString *nick;
@property (nonatomic,assign) NSInteger num;
@property (nonatomic,strong) NSString *photo;
@property (nonatomic,assign) NSInteger roomid;
@property (nonatomic,assign) NSInteger showid;
@property (nonatomic,assign) NSInteger sofano;
@property (nonatomic,assign) NSInteger userid;
@property (nonatomic,assign) NSInteger hidden;
@property (nonatomic,strong) NSString *hiddenindex;
@property (nonatomic,assign) BOOL issupermanager;
@end

@interface SofaListModel : BaseHttpModel
@property (nonatomic,strong) NSMutableArray *sofaMArray;
@end
