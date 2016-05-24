//
//  SheetButton.h
//  BoXiu
//
//  Created by 李杰 on 15/7/18.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    ButtonTypeChat,
    ButtonTypeDanmu,
    ButtonTypeAudio    
}ButtonType;

@interface SheetButton : UIButton

@property (assign, nonatomic) BOOL clicked;//根据是否点击来在SheetView中执行事件 
@property (strong, nonatomic) UIImageView *yellowButtonAboveView;
@property (strong, nonatomic) UIImageView *point;
@property (assign, nonatomic) ButtonType  type;
@property (assign,nonatomic) BOOL hid;
-(void)loadFrame; //初始化界面
-(void)initButtonhide;
-(void)initButtonState;
@end
