//
//  ToolBar.h
//  BoXiu
//
//  Created by Andy on 14-3-31.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "BaseView.h"
#import "PersonData.h"
#import "SofaCell.h"

@class ToolBar;

@protocol ToolBarDelegate <NSObject>

- (void)toolBar:(ToolBar *)toolBar robSofa:(SofaData *)sofaData;

@end

@interface ToolBar : BaseView
@property (nonatomic,assign) id<ToolBarDelegate> delegate;
@property (nonatomic,assign) BOOL bRobbingSofa;//正在抢沙发

- (void)setPersonData:(PersonData *)personData;

- (void)setSofaData:(SofaData *)sofaData;

@end
