//
//  VipSofaView.h
//  BoXiu
//
//  Created by 李杰 on 15/7/16.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SheetButton.h"
typedef enum
{
    EnterTypeVipSofa,
    EnterTypeRank,
    EnterTypeRoomSetting
}EnterType;

@class SofaData;

@protocol SheetViewDelegate <NSObject>

@optional
- (void)sheetViewSofDidSelectAtIndex:(NSInteger)index;

@end

@interface SheetView : BaseView<UIScrollViewDelegate>

@property (assign,nonatomic) EnterType enterType;

@property (assign, nonatomic) BOOL isHideChatOn;    /**<聊天是否隐藏    */
@property (assign, nonatomic) BOOL isDanMuShowing;  /**<弹幕是否展示    */
@property (assign, nonatomic) BOOL isAudioOn;       /**<音频模式是否打开 */
@property (assign,nonatomic) id<SheetViewDelegate> delegate;


- (void)initSheetView;
- (void)initSofaList;
- (void)setSofaData:(SofaData *)sofaData;
- (void)getRoomRankData;
+(instancetype)shareRoomSettingView;

@end
