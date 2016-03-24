//
//  BaseTableView.h
//  EWPLib
//
//  Created by andy on 14-8-29.
//  Copyright (c) 2014年 jiangbin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "MJRefresh.h"

@class BaseTableView;

@protocol BaseTableViewDataSoure <NSObject>

@required

- (NSInteger)numberOfSectionsInBaseTableView:(BaseTableView *)baseTableView;

- (NSInteger)baseTableView:(BaseTableView *)baseTableView numberOfRowsInSection:(NSInteger)section;

- (UITableViewCell *)baseTableView:(BaseTableView *)baseTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@optional
- (BOOL)baseTableView:(BaseTableView *)baseTableView canEditRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)baseTableView:(BaseTableView *)baseTableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;

- (NSString *)baseTableView:(BaseTableView *)baseTableView titleForHeaderInSection:(NSInteger)section;

@end

@protocol BaseTableViewDelegate <NSObject>
@optional

- (NSIndexPath *)baseTableView:(BaseTableView *)baseTableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath;

- (NSIndexPath *)baseTableView:(BaseTableView *)baseTableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath;

- (CGFloat)baseTableView:(BaseTableView *)baseTableView heightForHeaderInSection:(NSInteger)section;

- (CGFloat)baseTableView:(BaseTableView *)baseTableView heightForFooterInSection:(NSInteger)section;

- (UIView *)baseTableView:(BaseTableView *)baseTableView viewForHeaderInSection:(NSInteger)section;

@required

- (void)baseTableView:(BaseTableView *)baseTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

- (CGFloat)baseTableView:(BaseTableView *)baseTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

@optional
/*上拉加载更多数据*/
- (void)loadMorData;

/*下拉刷新最新数据*/
- (void)refreshData;

@end

/*TableViewde的基类，包含上拉加载，下拉刷新，提示语*/
@interface BaseTableView : UITableView<UITableViewDelegate,UITableViewDataSource,MJRefreshBaseViewDelegate>

/*当是类型为kbaseTableViewType时，子视图包含tableview，并且默认是支持上拉加载，下拉刷新*/
/*控制tableviewheader*/
@property (nonatomic,assign) BOOL refresh;
/*控制tableview foot*/
@property (nonatomic,assign) BOOL loadMore;

/*当前页*/
@property(nonatomic,assign) NSInteger curentPage;
/*总页数*/
@property(nonatomic,assign) NSInteger totalPage;

/*数据为空提示语*/
@property(nonatomic,strong) UILabel *tipContent;
@property(nonatomic,strong) UIImageView *contentImg;
@property(nonatomic,strong) UILabel *tipContent2;
@property(nonatomic,strong) UIImageView *updateView;


@property (nonatomic,strong) UIView *tipLabel;
@property (nonatomic,strong) UILabel *tipLabeltext;



/*数据为空的view*/
@property(nonatomic,strong) UIControl *controlNoDataView;


@property(nonatomic,weak) id<BaseTableViewDataSoure> baseDataSource;
@property(nonatomic,weak) id<BaseTableViewDelegate>  baseDelegate;

- (void)free;
@end
