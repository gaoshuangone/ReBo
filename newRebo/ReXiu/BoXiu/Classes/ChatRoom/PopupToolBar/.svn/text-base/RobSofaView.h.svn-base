//
//  RobSofaView.h
//  BoXiu
//
//  Created by andy on 14-4-17.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "BaseView.h"
#import "SofaCell.h"

@class RobSofaView;
@protocol RobSofaViewDelegate <NSObject>

- (void)robSofaView:(RobSofaView *) robSofaView sofaData:(SofaData *)sofaData;

@end

@interface RobSofaView : BaseView

@property (nonatomic,assign) id<RobSofaViewDelegate> delegate;

- (void)setSofaData:(SofaData *)sofaData;

@end
