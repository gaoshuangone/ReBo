//
//  MainViewController.h
//  XiuBo
//
//  Created by Andy on 14-3-20.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//


#import "ViewController.h"
#import "EWPTabMenuControl.h"


@interface CategoryMenu : NSObject
@property (nonatomic,assign) NSInteger categoryId;
@property (nonatomic,strong) NSString *title;
@end
@interface MainViewController : ViewController
@property (nonatomic,strong) NSMutableArray *AdImgUrlArray;

@property (nonatomic,strong) EWPTabMenuControl *tabMenuControl;
+ (void)initConfigInfo;

@end
