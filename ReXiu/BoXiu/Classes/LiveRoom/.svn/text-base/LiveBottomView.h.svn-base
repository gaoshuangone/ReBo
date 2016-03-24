//
//  LiveBottomView.h
//  BoXiu
//
//  Created by andy on 15/12/10.
//  Copyright © 2015年 rexiu. All rights reserved.
//

#import "BaseView.h"

typedef enum {
  BottomType_ZhuBo,
    BottomType_GuanZHong
}BottomType;
@interface LiveBottomView : BaseView
@property (strong,nonatomic)UIImageView* imageviewRound;
@property (assign, nonatomic)BottomType type;
@property (nonatomic,copy) void(^LiveBottomViewTouch)(NSInteger tag);
-(id)initView:(CGRect)frame withType:(BottomType)type;
@end
