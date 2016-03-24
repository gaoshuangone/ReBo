//
//  QueryGiftModel.h
//  BoXiu
//
//  Created by andy on 14-5-6.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "BaseHttpModel.h"

@interface GiftData : NSObject

@property (nonatomic,assign) NSInteger coin;
@property (nonatomic,strong) NSString *flashurl;
@property (nonatomic,strong) NSString *giftimg;
@property (nonatomic,strong) NSString *giftimgbig;
@property (nonatomic,strong) NSString *giftimgsmall;
@property (nonatomic,strong) NSString *giftname;
@property (nonatomic,assign) NSInteger gifttype;
@property (nonatomic,assign) int giftid;
@property (nonatomic,assign) NSInteger luckyflag;  //1幸运礼物  0 不是
@property (nonatomic,assign) NSInteger usergetcoin;
@end

@interface QueryGiftModel : BaseHttpModel

@property (nonatomic,strong) NSMutableArray *giftMArray;//存放gift

@end
