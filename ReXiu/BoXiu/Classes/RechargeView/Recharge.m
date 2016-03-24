//
//  Recharge.m
//  BoXiu
//
//  Created by andy on 14-7-10.
//  Copyright (c) 2014年 rexiu. All rights reserved.
//

#import "Recharge.h"
//#import "AlixPayOrder.h"
#import "DataVerifier.h"
//#import "AlixPayResult.h"
#import <AlipaySDK/AlipaySDK.h>
#import "DataSigner.h"
//#import "AlixLibService.h"
#import "NSData+DES.h"
#import "NSString+DES.h"
#import "JSONKit.h"
#import "WXApi.h"
#import "WXApiObject.h"
#import "UPPayPlugin.h"
#import "UPPayPluginDelegate.h"
#import "RMStore.h"
#import "NSData+GTMBase64.h"
#import "UserInfoManager.h"
#import "VerifyAppStoreRechargeModel.h"
#import "PhoneCardPayModel.h"

@interface Recharge ()<UPPayPluginDelegate,WXApiDelegate>
@property (nonatomic,assign) SEL result;//这里声明为属性方便在于外部传入。
@property (nonatomic,copy) PayResult aliPayResult;
@property (nonatomic,copy) PayResult upPayResult;
@property (nonatomic,copy) PayResult weixinPayResult;
@property (nonatomic,copy) PayResult phonePayResult;
@property (nonatomic,copy) PayResult appstorePayResult;
@end

@implementation Recharge

+ (Recharge *)shareRechargeInstance
{
    static dispatch_once_t predicate;
    static Recharge* instance;
    dispatch_once(&predicate,^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (id)init
{
    self = [super init];
    if (self)
    {
       
    }
    return self;
}

#pragma mark-支付宝支付
- (void)alipayWithDataSign:(NSString *)dataSign payResult:(PayResult)payResult
{
    NSString *appScheme = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"AppScheme"];
    
    [[AlipaySDK defaultService] payOrder:dataSign fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        NSLog(@"reslut = %@",resultDic);
        NSString *resultStatus = [resultDic objectForKey:@"resultStatus"];
        if (resultStatus)
        {
            NSInteger resultStatusCode = [resultStatus integerValue];
            if (resultStatusCode == 9000)
            {
                //交易成功
                [[AppInfo shareInstance] refreshCurrentUserInfo:^{
                    if (payResult)
                    {
                        //成功返回0
                        payResult(0,@"充值处理中，请稍后刷新查看");
                    }
                }];
            }
            else
            {
                NSString *memo = [resultDic objectForKey:@"memo"];
                //交易失败
                if (payResult)
                {
                    //成功返回0
                    payResult(1,memo);
                }
            }
        }
        else
        {
            //交易失败
            if (payResult)
            {
                //成功返回0
                payResult(1,@"充值失败");
            }

        }
        
    }];
}

#pragma mark - 银行卡支付
- (void)uppayWithOrderId:(NSString *)orderId mode:(NSString *)mode PayResult:(PayResult)payResult
{
    [UPPayPlugin startPay:orderId mode:mode viewController:[AppDelegate shareAppDelegate].lrSliderMenuViewController delegate:self];
    if (payResult)
    {
        self.upPayResult = payResult;
    }
}

#pragma mark - UPPayPluginDelegate

-(void)UPPayPluginResult:(NSString*)result
{
    if (result && [result length])
    {
        if ([result isEqualToString:@"success"])
        {
            [[AppInfo shareInstance] refreshCurrentUserInfo:^{
                if (_upPayResult)
                {
                    _upPayResult(0,@"充值处理中，请稍后刷新查看");
                }
            }];
            
        }
        else if ([result isEqualToString:@"fail"])
        {
            if (_upPayResult)
            {
                _upPayResult(1,@"充值失败");
            }
        }
        else if ([result isEqualToString:@"cancel"])
        {
            if (_upPayResult)
            {
                _upPayResult(1,@"取消充值");
            }
        }
    }

}

#pragma mark-微信支付
- (void)weixinpayWithparam:(NSDictionary *)param PayResult:(PayResult)payResult
{
    PayReq *req = [[PayReq alloc] init];
    req.openID = [param objectForKey:@"appid"];
    req.partnerId = [param objectForKey:@"partnerid"];
    req.prepayId = [param objectForKey:@"prepayid"];
    req.nonceStr = [param objectForKey:@"noncestr"];
    req.timeStamp = [[param objectForKey:@"timestamp"] intValue];
    req.package = [param objectForKey:@"package"];
    req.sign = [param objectForKey:@"sign"];
    [WXApi sendReq:req];
    if (payResult)
    {
        self.weixinPayResult = payResult;
    }
}

#pragma mark __微信支付结果回调处理
- (void)wxpay:(NSURL *)url application:(UIApplication*)application
{
    [WXApi handleOpenURL:url delegate:self];
}

-(void)onResp:(BaseResp*)resp
{
    NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
    NSString *strTitle;
    
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        strTitle = [NSString stringWithFormat:@"发送媒体消息结果"];
    }
    if([resp isKindOfClass:[PayResp class]])
    {
        //支付返回结果，实际支付结果需要去微信服务器端查询
        strTitle = [NSString stringWithFormat:@"支付结果"];
        
        switch (resp.errCode)
        {
            case WXSuccess:
            {
                [[AppInfo shareInstance] refreshCurrentUserInfo:^{
                    if (_weixinPayResult)
                    {
                        _weixinPayResult(0,@"充值处理中，请稍后刷新查看");
                    }
                }];
                
            }
                break;
            default:
            {
                if (_weixinPayResult)
                {
                    _weixinPayResult(1,resp.errStr);
                }
                strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
                NSLog(@"错误，retcode = %d, retstr = %@,  strMsg = %@", resp.errCode,resp.errStr,strMsg);
            }
                break;
        }
    }
}

/**
 *  手机卡支付
 */
- (void)phonepayWithParam:(NSDictionary *)param PayResult:(PayResult)payResult
{
    if (payResult)
    {
        self.phonePayResult = payResult;
    }
    
    PhoneCardPayModel *model = [[PhoneCardPayModel alloc] init];
    [model requestDataWithParams:param success:^(id object) {
        if (model.result == 0)
        {
            [[AppInfo shareInstance] refreshCurrentUserInfo:^{
                if (_phonePayResult)
                {
                    _phonePayResult(0,model.msg);
                }
            }];
        }
        else
        {
            if (_phonePayResult)
            {
                _phonePayResult(1,model.msg);
            }
        }
    } fail:^(id object) {
        if (_phonePayResult)
        {
            _phonePayResult(1,@"网络错误,请重试");
        }
    }];
}

/**
 *  appStore充值
 */
- (void)appstorepayWithProductID:(NSString *)productID PayResult:(PayResult)payResult
{
    if (payResult)
    {
        self.appstorePayResult = payResult;
    }
    [[RMStore defaultStore] restoreTransactions];
    [[RMStore defaultStore] addPayment:productID success:^(SKPaymentTransaction *transaction) {
        [self performSelectorOnMainThread:@selector(verifyRechargeWithServer:) withObject:transaction waitUntilDone:NO];
    } failure:^(SKPaymentTransaction *transaction, NSError *error) {

    }];
}

- (void)verifyRechargeWithServer:(SKPaymentTransaction *)transaction
{
    NSArray *moneyArray = @[@"6",@"30",@"68",@"98",@"198",@"488"];
    NSArray *productIdentifers = @[@"com.ReXiu.ReBo.BoXiu.coin600",@"com.ReXiu.ReBo.BoXiu.coin3000",@"com.ReXiu.ReBo.BoXiu.coin6800",
                           @"com.ReXiu.ReBo.BoXiu.coin9800",@"com.ReXiu.ReBo.BoXiu.coin19800",@"com.ReXiu.ReBo.BoXiu.coin48800"];

    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[[NSBundle mainBundle] appStoreReceiptURL]];
    NSError *error = nil;
    NSData *receiptData = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:nil error:&error];
    NSString *receipt = [receiptData  encodeBase64Data];
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    [dictionary setObject:receipt forKey:@"receiptdata"];
    NSInteger nIndex = [productIdentifers indexOfObject:transaction.payment.productIdentifier];
    NSString *money = [moneyArray objectAtIndex:nIndex];
    [dictionary setObject:money forKey:@"costmoney"];
    [dictionary setObject:transaction.transactionIdentifier forKey:@"tradeno"];
    
    //保存到本地
    AppStoreRechargeInfo *appStoreRechargeInfo = [[AppStoreRechargeInfo alloc] init];
    appStoreRechargeInfo.userId = [UserInfoManager shareUserInfoManager].currentUserInfo.userId;
    appStoreRechargeInfo.tradeno = transaction.transactionIdentifier;
    appStoreRechargeInfo.costmoney = money;
    appStoreRechargeInfo.receiptdata = receipt;
    [[AppInfo shareInstance] saveAppStoreRecharegeInfo:appStoreRechargeInfo];
    
    VerifyAppStoreRechargeModel *model = [[VerifyAppStoreRechargeModel alloc] init];
    [model requestDataWithParams:dictionary success:^(id object) {

        if (model.result == 0)
        {
            [[AppInfo shareInstance] refreshCurrentUserInfo:^{
                if (_appstorePayResult)
                {
                    _appstorePayResult(0,@"充值处理中，请稍后刷新查看");
                }
            }];
            [[AppInfo shareInstance] deleteLocalAppstoreRechargeInfo:appStoreRechargeInfo];
            
        }
        else
        {
            if (_appstorePayResult)
            {
                _appstorePayResult(1,model.msg);
            }
        }
    } fail:^(id object) {
        if (_appstorePayResult)
        {
            _appstorePayResult(1,@"网络繁忙，请稍后重试");
        }
    }];
}

@end
