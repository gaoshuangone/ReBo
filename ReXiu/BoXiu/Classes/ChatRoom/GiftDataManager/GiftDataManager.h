//
//  GiftDataManager.h
//  BoXiu
//
//  Created by andy on 15-1-9.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import "BaseObject.h"

@interface GiftDataManager : BaseObject

+ (GiftDataManager *)shareInstance;

- (void)queryGiftData;

- (NSDictionary *)baseGiftData;

- (NSArray *)starGiftData;

@end
