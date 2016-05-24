//
//  EmotionManager.h
//  BoXiu
//
//  Created by andy on 14-12-3.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "BaseObject.h"
#import "QueryAllEmotionModel.h"


@interface EmotionManager : BaseObject
@property(retain,nonatomic)NSDictionary* dictLocalImage;
+ (EmotionManager *)shareInstance;

/**
 *  查询所有表情数据
 */
- (void)queryAllEmotion;

/**
 *  返回所有类型表情
 *
 *  @return 返回数组类型，包含每一组表情
 */
- (NSArray *)allGroupEmotion;

/**
 *  所有的表情数据都在这里，可以快速查找
 *
 *  @return 返回字典，每一个表情对应一个表情的数据
 */
- (NSDictionary *)allEmotion;
/**
 *  返回指定表情类型的数据
 *
 *  @param emotionType 表情类型
 *
 *  @return 数组
 */
- (EmotionGroupData *)emotionOfGroupType:(EmotionType)emotionType;


@end
