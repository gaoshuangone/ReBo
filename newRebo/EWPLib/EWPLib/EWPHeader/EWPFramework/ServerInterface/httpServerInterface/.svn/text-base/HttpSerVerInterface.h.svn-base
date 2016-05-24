//
//  HttpSerVerInterface.h
//  MemberMarket
//
//  Created by jiangbin on 13-11-13.
//  Copyright (c) 2013年 yiwopai. All rights reserved.
//


#import "BaseObject.h"

/*网络层基类，是基于第三方库AFNetWorking*/
@class HttpModel;

typedef void(^HttpServerInterfaceBlock)(id object);
@protocol HttpServerInterfaceProtocol <NSObject>

@required
/*请求数据*/
//requestType为POST或者GET
- (void)requestDataWithBaseUrl:(NSString *)baseUrl requestType:(NSString *)requestType method:(NSString *)method httpHeader:(NSDictionary *)httpHeader params:(NSDictionary *)params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail;

- (void)uploadFileWithBaseUrl:(NSString *)baseUrl fileUrl:(NSString *)fileUrl params:(NSDictionary *)params method:(NSString *)method httpHeader:(NSDictionary *)httpHeader success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail;

- (void)uploadDataWithBaseUrl:(NSString *)baseUrl fileUrl:(NSString *)fileUrl params:(NSDictionary *)params httpHeader:(NSDictionary *)httpHeader success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail;
@end

//默认post请求方式
@interface HttpSerVerInterface : BaseObject<HttpServerInterfaceProtocol>

@property (nonatomic,assign) NSTimeInterval timeInterval;
+ (id)shareServerInterface;

@end
