//
//  BaseViewController.h
//  EWPLib
//
//  Created by andy on 14-8-29.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "IViewControllerProtocol.h"
#import "HttpSerVerInterface.h"
#import "EWPAlertView.h"
#import "EWPActionSheet.h"
#import "BaseTableView.h"

typedef enum _BaseViewType
{
    kbaseViewType,
    kbaseScroolViewType,
    kbaseTableViewType,
}BaseViewType;

typedef void (^NavigationTouchButton)(id sender);
typedef void (^ProgressViewBlock)(BOOL showProgressView);

@class BaseView;
@interface BaseViewController : UIViewController<IViewControllerProtocol,UIScrollViewDelegate>

@property (nonatomic,assign) BOOL bFirstViewWillAppear;//主要用于tabMenu里，scrollView addsubView时,会调用viewWIllAppear.

/*与系统parentView类似，但是这个手动设置上一级viewcontroller*/
@property (nonatomic,assign) BaseViewController *rootViewController;
/*默认类型是BaseViewType，是没有scrollview，此时scrollview为空*/
@property (nonatomic,assign) BaseViewType baseViewType;

/*如果基于scrollview的话，将内容加到scrollview，不需要手动创建*/
@property (nonatomic,strong) UIScrollView *scrollView;

/*如果子视图包含tableview的话，默认tableview的大小和view的大小一样，可以自己设置大小*/
@property (nonatomic,strong) BaseTableView *tableView;
///*当是类型为kbaseTableViewType时，子视图包含tableview，并且默认是支持上拉加载，下拉刷新*/
@property (nonatomic,assign) BOOL refresh;
@property (nonatomic,assign) BOOL loadMore;

@property (nonatomic,assign) BOOL hideProgressHud;

@property (nonatomic,copy) ProgressViewBlock progressViewBlock;
//只有用EWPTabMenu框架时候，此变量才会有值
@property (nonatomic,strong) BaseView *baseTabMenuControl;
@property (nonatomic,assign) BOOL isShouldPop;

/*设置navigationcontroller左右按钮*/
- (void)setNavigationBarLeftItem:(NSString *) title itemNormalImg:(UIImage *)itemImg  itemHighlightImg:(UIImage *)highlightImg withBlock:(NavigationTouchButton) block;
- (void)setNavigationBarRightItem:(NSString *) title itemNormalImg:(UIImage *)itemImg  itemHighlightImg:(UIImage *)highlightImg withBlock:(NavigationTouchButton) block;

/*Canvas http请求数据接口*/
- (void)requestDataWithAnalyseModel:(Class )analyseModel params:(NSDictionary *) params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail;

/*上传文件接口*/
- (void)uploadDataWithAnalyseModel:(Class )analyseModel fileUrl:(NSString *)fileUrl params:(NSDictionary *)params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail;

/*AlertView*/
- (void)showAlertView:(NSString *)title message:(NSString *)message confirm:(AlertViewBlock)confirm cancel:(AlertViewBlock)cancel;

/*ActionSheetView*/
- (void)showActionSheetView:(NSString *)title buttonTitles:(NSArray *)buttonTitles actionSheetBlock:(ActionSheetBlock)actionSheetBlock;

/*自定义短暂性提示框*/
- (void)showNotice:(NSString *)message;

/*对提示框显示时长的优化*/
- (void)showNotice:(NSString *)message duration:(CGFloat)duration;

//显示在window层
- (void)showNoticeInWindow:(NSString *)message;

/*显示在window层的弹出提示框*/
- (void)showNoticeInWindow:(NSString *)message duration:(CGFloat)duration;

//增加键盘监测功能，
- (void)addNotifyKeyBoard;
//界面消失需要调用移除监测
- (void)removeNotifyKeyBoard;
- (void)addTableViewWithFrame:(CGRect)frame style:(UITableViewStyle)style;

@end
