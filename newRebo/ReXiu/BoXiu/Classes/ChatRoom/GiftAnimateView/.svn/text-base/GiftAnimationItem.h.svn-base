//
//  GiftAnimationItem.h
//  BoXiu
//
//  Created by tongmingyu on 14-12-22.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "BaseView.h"

typedef void(^GiftAnimationComplete)();

@protocol IGiftAnimationItem <NSObject>

- (void)startAnimationWithMessage:(NSString *)message giftUrl:(NSString *)giftUrl animationComplete:(GiftAnimationComplete)animationComplete;

@end

@interface GiftAnimationItem : BaseView<IGiftAnimationItem>

@property (nonatomic,copy) GiftAnimationComplete animationComplete;

@end
