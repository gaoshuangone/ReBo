//
//  StartView.h
//  BoXiu
//
//  Created by andy on 15/8/6.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import "BaseView.h"
#import "PersonData.h"
#import "AudienceViewController.h"
@protocol StartViewDelegate <NSObject>

- (void)pressedButtonWithTag;

@end
@interface StartView : BaseView
//@property (nonatomic,assign) id<StartViewDelegate> delege;
@property (nonatomic,strong) PersonData *personData;
@property (nonatomic,assign) BOOL isGuanZhuEd;
@property (nonatomic,strong) UIButton* buttonGuanZhu;
@property (nonatomic,strong) UILabel* labelFans;
@property (nonatomic,strong) UILabel* labelGuanZHu;

@property (assign, nonatomic)id<AudienceViewControllerDelegate> delegate;

@end
