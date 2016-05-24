//
//  EmotionManager.m
//  BoXiu
//
//  Created by andy on 14-12-3.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "EmotionManager.h"


@interface EmotionManager ()

@property (nonatomic,strong) NSMutableArray *emotionGroupMArray;

@property (nonatomic,strong) NSMutableDictionary *allEmotionMDic;
@end

@implementation EmotionManager

/**
 *  获取所有表情数据
 *
 *  @return 单实例
 */
+ (EmotionManager *)shareInstance
{
    static dispatch_once_t predicate;
    static EmotionManager *instance;
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
        [self queryAllEmotion];
    }
    return self;
}

/**
 *  查询所有表情数据
 */
- (void)queryAllEmotion
{
    if (_emotionGroupMArray && _emotionGroupMArray.count)
    {
        return;
    }
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        QueryAllEmotionModel *model = [[QueryAllEmotionModel alloc] init];
        [model requestDataWithParams:nil success:^(id object) {
            if (model.result == 0)
            {
                if (_emotionGroupMArray == nil)
                {
                    _emotionGroupMArray = [NSMutableArray array];
                }
                [_emotionGroupMArray removeAllObjects];
                
                [_emotionGroupMArray addObjectsFromArray:model.emotionGroupMArray];
                
                if (_allEmotionMDic == nil)
                {
                    _allEmotionMDic = [NSMutableDictionary dictionary];
                }
                [_allEmotionMDic setValuesForKeysWithDictionary:model.allEmotionMDic];
            }
        } fail:^(id object) {
            
        }];
    });
    if (_dictLocalImage == nil) {
        NSString* plistfile1 = [[NSBundle mainBundle]pathForResource:@"LocalImageList" ofType:@"plist"];
        _dictLocalImage = [[NSDictionary alloc]initWithContentsOfFile:plistfile1];
    }
    
    
  
    
}

/**
 *  返回所有类型的表情
 *
 *  @return 返回所有类型的表情
 */
- (NSArray *)allGroupEmotion
{
    return self.emotionGroupMArray;
}


/**
 *  返回所有表情数据
 *
 *  @return 字典
 */
- (NSDictionary *)allEmotion
{
    return self.allEmotionMDic;
}

- (EmotionGroupData *)emotionOfGroupType:(EmotionType)emotionType
{
    if (_emotionGroupMArray)
    {
        for (EmotionGroupData *emotionGroupData in _emotionGroupMArray)
        {
            if (emotionGroupData.emotionType == emotionType)
            {
                return emotionGroupData;
            }
        }
    }
    return nil;
}



@end
