//
//  ModelProtocol.h
//  MemberMarket
//
//  Created by jiangbin on 13-11-13.
//  Copyright (c) 2013年 yiwopai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpSerVerInterface.h"

@protocol HttpModelProtocol <NSObject>

@required
/*解析数据,每个model必须实现*/
- (BOOL)analyseData:(NSDictionary *)data;

/*请求数据*/
- (void)requestDataWithParams:(NSDictionary *)params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail;

/*请求数据*/
- (void)requestDataWithMethod:(NSString *)method httpHeader:(NSDictionary *)httpHeader params:(NSDictionary *)params success:(HttpServerInterfaceBlock) success fail:(HttpServerInterfaceBlock)fail;

/*请求数据*/
- (void)requestDataWithMethod:(NSString *)method params:(NSDictionary *) params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail;

//可以选择请求类型
- (void)requestDataWithType:(NSString *)requestType method:(NSString *)method httpHeader:(NSDictionary *)httpHeader params:(NSDictionary *)params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock) fail;
//所有参数
- (void)requestDataWithBaseUrl:(NSString *)baseUrl requestType:(NSString *)requestType method:(NSString *)method httpHeader:(NSDictionary *)httpHeader params:(NSDictionary *)params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail;

//上传文件

- (void)uploadDataWithFileUrl:(NSString *)fileUrl params:(NSDictionary *)params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail;

- (void)uploadDataWithFileUrl:(NSString *)fileUrl params:(NSDictionary *)params method:(NSString *)method success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail;

- (void)uploadDataWithFileUrl:(NSString *)fileUrl params:(NSDictionary *)params method:(NSString *)method httpHeader:(NSDictionary *)httpHeader success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail;

- (void)uploadDataWithBaseUrl:(NSString *)baseUrl fileUrl:(NSString *)fileUrl params:(NSDictionary *)params httpHeader:(NSDictionary *)httpHeader success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail;
- (void)uploadFileWithurl:(NSString *)url fileUrl:(NSString *)fileUrl fileName:(NSString *)fileName httpHeader:(NSDictionary *)httpHeader success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail;
@end
