//
//  StarGiftView.h
//  BoXiu
//
//  Created by andy on 15-1-7.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import "BaseView.h"
#import "GiftView.h"

@interface StarGiftView : BaseView
@property (nonatomic,assign) id<GiftViewDelegate> delegate;

- (void)viewWillAppear;

- (void)viewwillDisappear;
@end
