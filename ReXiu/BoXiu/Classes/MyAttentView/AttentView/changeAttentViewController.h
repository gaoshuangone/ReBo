//
//  changeAttentViewController.h
//  BoXiu
//
//  Created by tongmingyu on 14-5-8.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "ViewController.h"

@protocol changeAttentViewControllerDelegate <NSObject>

- (void)closeChangeAttentDilaog;

@end

@interface changeAttentViewController : ViewController

@property(nonatomic,strong) ViewController *presentingBaseCanvasControlle;
@property (nonatomic,assign) id<changeAttentViewControllerDelegate> delegate;

@end
