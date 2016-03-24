//
//  GiftDataManager.m
//  BoXiu
//
//  Created by andy on 15-1-9.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import "GiftDataManager.h"
#import "QueryGiftModel.h"
#import "UserInfoManager.h"

@interface GiftDataManager ()

@property (nonatomic,strong) NSMutableDictionary *baseGiftDataMDic;
@property (nonatomic,strong) NSMutableArray *starGiftDataMArray;

@property (nonatomic,strong) NSArray *baseGiftCategory;
@end

@implementation GiftDataManager

/**
 *  获取所有礼物数据
 *
 *  @return 单实例
 */
+ (GiftDataManager *)shareInstance
{
    static dispatch_once_t predicate;
    static GiftDataManager *instance;
    dispatch_once(&predicate,^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        _baseGiftCategory = @[@"1",@"2",@"3",@"4"];

    }
    return self;
}

- (void)queryGiftData
{
    [self queryBaseGiftData];
    [self queryStarGiftData];
}

- (void)queryBaseGiftData
{
    if (_baseGiftDataMDic == nil)
    {
        _baseGiftDataMDic = [NSMutableDictionary dictionary];
    }
    else
    {
        if (_baseGiftDataMDic.count)
        {
            return;
        }
    }
    
    for (NSString *giftcategory in _baseGiftCategory)
    {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:giftcategory forKey:@"giftcategory"];
        
        QueryGiftModel *model = [[QueryGiftModel alloc] init];
        [model requestDataWithParams:dict success:^(id sender)
         {
             if (model.result ==  0)
             {
                 NSArray *giftArray = [NSArray arrayWithArray:model.giftMArray];
                 [self.baseGiftDataMDic setObject:giftArray forKey:giftcategory];
             }
         }
        fail:^(id sender)
         {
             
         }];

    }
}

- (void)queryStarGiftData
{
    if (_starGiftDataMArray == nil)
    {
        _starGiftDataMArray = [NSMutableArray array];
    }
    //每次查询最新得
    [_starGiftDataMArray removeAllObjects];
    
    StarInfo *starInfo = [UserInfoManager shareUserInfoManager].currentStarInfo;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInteger:starInfo.userId] forKey:@"staruserid"];
    
    QueryGiftModel *model = [[QueryGiftModel alloc] init];
    [model requestDataWithMethod:Query_StarRoomGift_Method params:dict success:^(id object) {
        if (model.result == 0)
        {
            [self.starGiftDataMArray addObjectsFromArray:model.giftMArray];
        }
    } fail:^(id object) {
        
    }];

}

- (NSDictionary *)baseGiftData
{
    return self.baseGiftDataMDic;
}

- (NSArray *)starGiftData
{
    return self.starGiftDataMArray;
}

@end
