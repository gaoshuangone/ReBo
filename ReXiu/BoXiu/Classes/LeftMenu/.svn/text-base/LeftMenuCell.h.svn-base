//
//  LeftMenuCell.h
//  BoXiu
//
//  Created by andy on 14-8-8.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LeftMenuCell;
@class MenuData;

@protocol LeftMenuCellDelegate <NSObject>

- (void)didSelectLeftMenu:(LeftMenuCell *)leftMenu;
@end

@interface MenuData : NSObject

@property (nonatomic,strong) NSString *menuTitle;
@property (nonatomic,assign) NSInteger menuId;
@property (nonatomic,assign) BOOL bSelected;
@property (nonatomic,assign) NSInteger indexRow;
@property (nonatomic,strong) UIImage *normalImg;
@end

@interface LeftMenuCell : UITableViewCell
@property (nonatomic,assign) id<LeftMenuCellDelegate> delegate;
@property (nonatomic,strong) MenuData *menuData;

@end
