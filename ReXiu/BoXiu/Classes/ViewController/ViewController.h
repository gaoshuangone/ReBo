//
//  ViewController.h
//  BoXiu
//
//  Created by andy on 14-9-15.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseHttpModel.h"
#import "CanvasType.h"
#import "AppDelegate.h"
#import "AppInfo.h"
#import "EWPFramework.h"

#define Count_Per_Page (10)

@interface ViewController : BaseViewController

@property (nonatomic,strong) UIView *tipLabel;
@property (nonatomic, assign) CGPoint imageViewPoint;


@property (nonatomic,strong) UILabel *tipLabeltext;
@property(nonatomic,strong) UIImageView *contentImg;
@property(nonatomic,strong) UILabel *tipContent2;
@property(nonatomic,strong) UIImageView *updateView;
@property(nonatomic,strong) UIView *networkview;
@property(nonatomic,strong) UIImageView *networkImg;
@property(nonatomic,strong) UILabel *networklabel;
@property (nonatomic, assign) BOOL isShouldReturnMain;

@property (nonatomic, assign) BOOL showingLoginAlertView;
@property (nonatomic, assign) BOOL showingLoginMoreAlertView;
@property (nonatomic,copy) void (^netViewTouchEd)(void);

@property (nonatomic,assign)BOOL isFirstRequestData;//是否是第一次用波纹加载

//比如按下按钮 60秒后 才能继续点击。
- (void) buttonPressed:(CGRect)LabelFrame;

- (void)startAnimating;

- (void)stopAnimating;

- (void)startLoadProgram;

- (void)stopLoadProgram;

//判断是否登录，如果没登录弹对话框
- (BOOL)showLoginDialog;

//显示其他终端已登录弹出框
- (void)showOherTerminalLoggedDialog;

- (void)getServerTimeWithBlock:(void(^)(long long serverTime))serverTimeBlock;
-(void)changetipLabelFrameWithRect:(CGRect)rect;
@end
