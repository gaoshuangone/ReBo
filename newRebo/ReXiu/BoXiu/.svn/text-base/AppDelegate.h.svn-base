//
//  AppDelegate.h
//  BoXiu
//
//  Created by Andy on 14-3-27.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EWPSliderMenuViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic,strong) EWPSliderMenuViewController *lrSliderMenuViewController;
@property (nonatomic,assign) BOOL showingLeftMenu;

@property (nonatomic,assign)BOOL isNeedReturnLiveRoom;//注册成功返回，临时用于替换showingLeftMenu
@property (nonatomic,assign)BOOL isSelfWillLive;//注册成功返回，临时用于替换showingLeftMenu


@property (nonatomic,strong) UINavigationController *navigationController;//这个保存起来可以快速显示主页,暂时不用

+ (AppDelegate *)shareAppDelegate;
-(void)enter:(NSDictionary *)launchOptions;
- (void)showHomeView;
@end
