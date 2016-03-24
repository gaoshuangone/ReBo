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
@interface DropList : BaseView

@property (nonatomic,assign) id<DropListDelegate> delegate;
@property (nonatomic,assign) id<DropListDataSource> dataSource;
@property (nonatomic,strong) NSString *selectedText;
@property (nonatomic,assign) NSInteger maxShowCount;
- (void)showList:(BOOL)show;

@end
