//
//  DropList.h
//  BoXiu
//
//  Created by andy on 14-4-14.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfo.h"
#import "BaseView.h"

@class DropList;

@protocol DropListDelegate <NSObject>

- (void)dropList:(DropList *)dropList didSelectedIndex:(NSInteger )index;

@end

@protocol DropListDataSource <NSObject>

@required
- (NSInteger)numberOfRowsInDropList:(DropList *)dropList;

- (NSString *)dropList:(DropList *)dropList textOfRow:(NSInteger)row;

@optional
- (CGFloat)dropList:(DropList *)dropList heightOfRow:(NSInteger)row;

@end

@interface DropListCell : UITableViewCell
@property (nonatomic,assign) BOOL hideLineImg;
@end

@interface DropList : BaseView

@property (nonatomic,assign) id<DropListDelegate> delegate;
@property (nonatomic,assign) id<DropListDataSource> dataSource;
@property (nonatomic,strong) NSString *selectedText;
@property (nonatomic,assign) NSInteger maxShowCount;
@property (nonatomic,strong) UIColor *selectTextColor;
@property (nonatomic,strong) UIColor *selectBackColor;

@property (nonatomic,strong) UIColor *listTextColor;
@property (nonatomic,strong) UIColor *listBackColor;
@property(nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIImage *listDownArrowImg;
@property (nonatomic,strong) UIImage *listUpArrowImg;
@property(nonatomic,strong) UIImageView *backView;
@property (nonatomic,assign) BOOL isDictDown;//drop方向，默认为NO = 朝上

@property (strong, nonatomic)NSString* strControllerNeeded;
- (void)showList:(BOOL)show;

@end
