//
//  EWPGuideViewController.h
//  BoXiu
//
//  Created by andy on 14-11-19.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "BaseViewController.h"

@class EWPGuideViewController;
@protocol EWPGuideViewDelegate <NSObject>

- (void)guideViewController:(EWPGuideViewController *)guideViewController clickAtIndex:(NSInteger)index;

- (void)guideViewScrollFinsh;

@end

typedef enum _InitType
{
    eLocalImgName,
    eImgUrl,
    eLocalImgData
}InitType;

@interface EWPGuideViewController : BaseViewController

@property (nonatomic,assign) BOOL autoScroll;

@property (nonatomic,assign) id<EWPGuideViewDelegate> delegate;

//用本地图片名称初始化
- (id)initWithImgNameArray:(NSArray *)imgArray;

//用网络图片初始化
- (id)initWithImgUrlArray:(NSArray *)imgUrlArray;

//用本地图片图片数据
- (id)initWithImgDataArray:(NSArray *)imgDataArray;

- (void)showGuideView;

@end
