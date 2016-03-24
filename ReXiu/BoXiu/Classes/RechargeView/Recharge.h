//
//  Recharge.h
//  BoXiu
//
//  Created by andy on 14-7-10.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RechargeViewController.h"

typedef void(^PayResult)(NSInteger resultCode,NSString *resultMsg);

@interface Recharge : NSObject

@property (nonatomic,strong) RechargeViewController *viewController;

+ (Recharge *)shareRechargeInstance;

//微信支付回调结果
- (void)wxpay:(NSURL *)url application:(UIApplication*)application;

/**
 *  支付宝支付
 *
 *  @return
 */
- (void)alipayWithDataSign:(NSString *)dataSign payResult:(PayResult)payResult;

/**
 *  银行卡支付
 */
- (void)uppayWithOrderId:(NSString *)orderId mode:(NSString *)mode PayResult:(PayResult)payResult;

//微信支付
- (void)weixinpayWithparam:(NSDictionary *)param  PayResult:(PayResult)payResult;

//手机卡充值
- (void)phonepayWithParam:(NSDictionary *)param  PayResult:(PayResult)payResult;

//appStore充值
- (void)appstorepayWithProductID:(NSString *)productID PayResult:(PayResult)payResult;

@end