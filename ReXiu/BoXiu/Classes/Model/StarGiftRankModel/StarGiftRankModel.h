//
//  StarGiftRankModel.h
//  BoXiu
//
//  Created by andy on 14-12-29.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "BaseHttpModel.h"

@interface StarGiftRankItemData : NSObject
@property (nonatomic,strong) NSString *giftname;
@property (nonatomic,strong) NSString *nick;
@property (nonatomic,assign) NSInteger giftid;
@property (nonatomic,strong) NSString *giftimg;
@property (nonatomic,assign) NSInteger idxcode;
@property (nonatomic,assign) NSInteger count;
@property (nonatomic,strong) NSString *giftimgbig;
@property (nonatomic,assign) NSInteger userid;
@end

@interface StarGiftRankModel : BaseHttpModel

@property (nonatomic,strong) NSMutableArray *dataMArray;

@end
