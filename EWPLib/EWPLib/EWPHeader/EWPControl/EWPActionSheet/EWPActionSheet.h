//
//  EWPActionSheet.h
//  MemberMarket
//
//  Created by jiangbin on 13-11-18.
//  Copyright (c) 2013年 yiwopai. All rights reserved.
//

#import <UIKit/UIKit.h>

/*actionsheetblock*/
typedef void(^ActionSheetBlock)(int nButtonIndex);

/*对actiono扩展，buttonTitles为按钮标题数组，actionSheetBlock为响应block*/
@interface EWPActionSheet : UIActionSheet<UIActionSheetDelegate>

@property(nonatomic,copy) ActionSheetBlock actionSheetBlock;

- (id)initWithTitle:(NSString *)title buttonTitles:(NSArray *)buttonTitles actionSheetBlock:(ActionSheetBlock)actionSheetBlock;

- (void)show;
@end
