//
//  GiftAnimationView.h
//  BoXiu
//
//  Created by tongmingyu on 14-12-22.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "BaseView.h"

@interface GiftAnimationData : NSObject
@property (nonatomic,assign) BOOL isSelf;
@property (nonatomic,strong) NSString *giftUrl;
@property (nonatomic,strong) NSString *giftMessage;
@property (nonatomic,assign) NSInteger giftType;//1:单个礼物动画；2:多个礼物动画
@end

@protocol GiftAnimationViewDataSource <NSObject>

- (GiftAnimationData *)getGiftAnimationDataFromQueue;

@end
@interface GiftAnimationView : BaseView

@property (nonatomic,assign) id<GiftAnimationViewDataSource> dataSource;

- (void)showGiftAnimation;
- (void)hideGiftAnimation;

@end
