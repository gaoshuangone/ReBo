//
//  LiveRoomUtil.h
//  BoXiu
//
//  Created by andy on 15/12/7.
//  Copyright © 2015年 rexiu. All rights reserved.
//
//Util：工具类，非静态，存放liveRoom与其它obj交互，代理交互，通知，等
#import <Foundation/Foundation.h>
#import "LiveRoomViewController.h"
@interface LiveRoomUtil : NSObject
@property(strong, nonatomic) LiveRoomViewController* rootLiveRoomViewController;
@property (nonatomic,strong) void (^utilGetLiveRoomDataBlock)(id responseObject,NSString* serverMothod);

+(instancetype)shartLiveRoonUtil;
-(void)utilGetDataFromRoomUtilWithParams:(id)Params withServerMothod:(NSString*)serverMothod;
-(void)utilGetDataFromRoomUtilWithParams:(id)Params withServerMothod:(NSString*)serverMothod bolock:(void(^)(id responseObject))block;

@end
