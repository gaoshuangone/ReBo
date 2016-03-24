//
//  PersonNick.h
//  BoXiu
//
//  Created by andy on 15/9/24.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import "BaseView.h"

@interface PersonNick : BaseView
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) UIImage *rightImg;
@property (nonatomic,strong) UIImage *sexImg;
@property (nonatomic,assign) BOOL isSelfUser;

@property(nonatomic,copy) ButtonBlock backButtonBlock;
@property(nonatomic,copy) ButtonBlock navRightBtnBlock;

@end
