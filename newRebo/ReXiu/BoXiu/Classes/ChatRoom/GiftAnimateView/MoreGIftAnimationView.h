//
//  MoreGIftAnimationView.h
//  BoXiu
//
//  Created by tongmingyu on 14-12-22.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "GiftAnimationItem.h"

@interface MoreGIftAnimationView : GiftAnimationItem

//监测是否超过指定位置
@property (nonatomic,assign) CGPoint fixedLocation;

@property (nonatomic,assign,readonly) BOOL isExceedLocation;

@end
