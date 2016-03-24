//
//  QueryAllEmotionModel.h
//  BoXiu
//
//  Created by andy on 14-12-3.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "BaseHttpModel.h"

typedef enum _EmotionType
{
    eGeneralType = 1,
    eVipType,
    eSuperManagerType,
}EmotionType;

@interface EmotionData : NSObject

@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *link;
@property (nonatomic,strong) NSString *mlink;//移动端表情
@property (nonatomic,assign) CGFloat height;//主要用于解析时候获取图片尺寸快
@property (nonatomic,assign) CGFloat width;//主要用于解析时候获取图片尺寸快
@property (nonatomic,assign) EmotionType emotionType;//表情类型,主要用于点击表情判断类型
@end

@interface EmotionGroupData : NSObject
@property (nonatomic,assign) CGFloat mheight;
@property (nonatomic,assign) CGFloat mwidth;
@property (nonatomic,assign) CGFloat height;
@property (nonatomic,assign) CGFloat width;
@property (nonatomic,strong) NSString *link;
@property (nonatomic,strong) NSString *mlink;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,assign) EmotionType emotionType;//表情类型
@property (nonatomic,strong) NSMutableArray *emotionDataMArray;//存放emotionData数据

@end

@interface QueryAllEmotionModel : BaseHttpModel

@property (nonatomic,strong) NSMutableArray *emotionGroupMArray;//存放EmotionGroupData
@property (nonatomic,strong) NSMutableDictionary *allEmotionMDic;//所有表情主要用于解析时候快速查找

@end
