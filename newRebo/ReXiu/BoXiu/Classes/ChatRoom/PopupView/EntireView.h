//
//  EntireView.h
//  BoXiu
//
//  Created by tongmingyu on 15-5-25.
//  Copyright (c) 2015年 rexiu. All rights reserved.
//

#import "BaseView.h"
#import "PersonData.h"
#import "SofaCell.h"

@class EntireView;

@protocol RobSofaViewDelegate <NSObject>

- (void)robSofaView:(EntireView *)entire sofaData:(SofaData *)sofaData;

@end


@interface EntireView : BaseView
@property (nonatomic,strong) PersonData *personData;
@property (nonatomic,assign) id<RobSofaViewDelegate> delega;
@property (nonatomic,assign) BOOL bRobbingSofa;//正在抢沙发

- (void)setSofaData:(SofaData *)sofaData;

@end
