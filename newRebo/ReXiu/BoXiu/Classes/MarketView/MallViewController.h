//
//  MallViewController.h
//  BoXiu
//
//  Created by andy on 14-7-24.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "ViewController.h"
#import "EWPTabMenuControl.h"

@interface MallViewController : ViewController

@property (nonatomic,strong) EWPTabMenuControl *tabMenuControl;

- (void)showRechargeDialog;
- (void)showRechargeDialogWithClassStr:(NSString*)str;//加参数，点击返回时候用
@end
