//
//  PropView.h
//  BoXiu
//
//  Created by andy on 14-7-15.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "BaseView.h"

@interface PropData : NSObject

@property (nonatomic,assign) NSInteger type;//0:vip,1:座驾；2：增加
@property (nonatomic,strong) NSString *imgUrl;
@property (nonatomic,assign) NSInteger useflag;
@property (nonatomic,assign) NSInteger carID;

@end

@protocol PropViewDelegate <NSObject>

- (void)buyVip;
- (void)propDidTouch:(NSString*)propData;

@end
@interface PropView : BaseView

@property (nonatomic,strong) NSMutableArray *dataMArray;
@property (nonatomic,assign) BOOL isSelfUserInfo;
@property (nonatomic,assign) id<PropViewDelegate> delegate;
@property (nonatomic,assign) BOOL isFromPersonInfo;

@property (nonatomic,assign) BOOL isChanged;
@end
