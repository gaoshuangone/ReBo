//
//  GiftView.h
//  BoXiu
//
//  Created by andy on 14-11-17.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "BaseView.h"

@protocol GiftViewDelegate <NSObject>

- (void)giftView:(BaseView *)giftView giveGiftInfo:(NSDictionary *)giftInfo;

- (void)goToRecharge;

@end

@interface GiftView : BaseView
@property (nonatomic,assign) id<GiftViewDelegate> delegate;

- (void)viewWillAppear;

- (void)viewwillDisappear;

@end
