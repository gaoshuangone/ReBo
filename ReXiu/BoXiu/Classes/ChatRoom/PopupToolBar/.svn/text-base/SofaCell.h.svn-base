//
//  SofaCell.h
//  BoXiu
//
//  Created by andy on 14-5-14.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SofaData  : NSObject

@property (nonatomic,assign) NSInteger robSofaNum;//将要抢沙发的币数
@property (nonatomic,assign) NSInteger num;//100的倍数
@property (nonatomic,assign) long long coin;//单位默认100
@property (nonatomic,assign) NSInteger sofano;//几号沙发
@property (nonatomic,assign) NSInteger userid;
@property (nonatomic,strong) NSString *nick;
@property (nonatomic,strong) NSString *photo;
@property (nonatomic,assign) NSInteger hidden;
@property (nonatomic,strong) NSString *hiddenindex;
@property (nonatomic,assign) BOOL issupermanager;

@end

@class SofaCell;
@protocol SofaCellDelegate <NSObject>

- (void)sofaCell:(SofaCell *)sofaCell sofaData:(SofaData *)sofaData;

@end

@interface SofaCell : UIView
@property (nonatomic,assign) id<SofaCellDelegate> delegate;
@property (nonatomic,strong) SofaData *sofaData;
@end
