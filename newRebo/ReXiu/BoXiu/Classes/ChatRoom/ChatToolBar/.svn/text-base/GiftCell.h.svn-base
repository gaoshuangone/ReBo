//
//  GiftCell.h
//  BoXiu
//
//  Created by andy on 14-4-24.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "BaseView.h"
#import "QueryGiftModel.h"

@class GiftCell;
@protocol GiftCellDelegate <NSObject>

- (void)gitfCell:(GiftCell *)giftCell didSelectItemWithTag:(NSInteger)itemTag;

@end


@interface GiftCell : BaseView

@property (nonatomic,assign,setter = SetSelect:) BOOL bSelected;
@property (nonatomic,strong) GiftData *giftData;
@property (nonatomic,assign) id<GiftCellDelegate> delegate;

@end
