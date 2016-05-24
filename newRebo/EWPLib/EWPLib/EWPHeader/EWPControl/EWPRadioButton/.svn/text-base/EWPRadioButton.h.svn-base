//
//  EWPRadioButton.h
//  
//
//  Created by andy on 13-7-9.
//  Copyright (c) 2013年 ivan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EWPRadioButtonDelegate;

@interface EWPRadioButton : UIButton

@property(nonatomic, assign)id<EWPRadioButtonDelegate>   delegate;
@property(nonatomic, copy, readonly)NSString            *groupId;
@property(nonatomic, assign)BOOL checked;
@property(nonatomic, assign)BOOL bReadOnly;
@property (nonatomic,assign) NSInteger iconWH;
- (id)initWithDelegate:(id)delegate groupId:(NSString*)groupId;

@end

@protocol EWPRadioButtonDelegate <NSObject>

@optional

- (BOOL)ewpRadioButtonShouldCanEditing:(EWPRadioButton *)ewpRadioButton;

- (void)didSelectedRadioButton:(EWPRadioButton *)radio groupId:(NSString *)groupId;

@end
