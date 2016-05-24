//
//  EWPCheckBox.h
//
//
//  Created by andy on 13-7-9.
//  Copyright (c) 2013年 ivan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EWPButton.h"

@protocol EWPCheckBoxDelegate;

@interface EWPCheckBox : EWPButton

@property(nonatomic, assign)id<EWPCheckBoxDelegate> delegate;
@property(nonatomic, assign)BOOL checked;
@property(nonatomic, retain)id userInfo;
@property (nonatomic,assign) NSInteger iconWH;

- (id)initWithDelegate:(id)delegate;

@end

@protocol EWPCheckBoxDelegate <NSObject>

@optional

- (BOOL)ewpCheckBoxShouldCanEditing:(EWPCheckBox *)ewpCheckBox;

- (void)didSelectedCheckBox:(EWPCheckBox *)checkbox checked:(BOOL)checked;

@end
