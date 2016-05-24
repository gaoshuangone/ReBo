//
//  LogicSerVerInterface.m
//  MemberMarket
//
//  Created by jiangbin on 13-11-13.
//  Copyright (c) 2013年 yiwopai. All rights reserved.
//

#import "HttpSerVerInterface.h"
#import "EWPFramework.h"

#define URL_MemoryCache_Size (8 * 1024 * 1024)//8M
#define URL_DiskCache_Size   (40 * 1024 * 1024)//40M

@interface HttpSerVerInterface ()

@property (nonatomic,strong) NSString *requestType;
@property (nonatomic,strong) AFHTTPRequestOperationManager *httpRequestOperationManager;
@end

@implementation HttpSerVerInterface

+ (id)shareServerInterface
{
    static dispatch_once_t predicate;
    static id instance;
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
        NSURLCache *URLCache = [[NSURLCache alloc] initWithMemoryCapacity:URL_MemoryCache_Size diskCapacity:URL_DiskCache_Size diskPath:nil];
        [NSURLCache setSharedURLCache:URLCache];
        
        self.requestType = @"POST";
        _timeInterval = 15;//default 15s timeout
        _httpRequestOperationManager = [AFHTTPRequestOperationManager manager];
        _httpRequestOperationManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    return self;
}


- (void)requestDataWithBaseUrl:(NSString *)baseUrl requestType:(NSString *)requestType method:(NSString *)method httpHeader:(NSDictionary *)httpHeader params:(NSDictionary *)params success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail
{
    @synchronized(self)
    {
        if (baseUrl == nil)
        {
            return;
        }
        
        if (requestType)
        {
            if ([requestType isEqualToString:@"GET"] || [requestType isEqualToString:@"POST"])
            {
                self.requestType = requestType;
            }
        }

        AFHTTPRequestSerializer *httpRequestSerializer = [AFHTTPRequestSerializer serializer];
        NSError *erro = nil;
        NSMutableString *requestUrl = [NSMutableString stringWithString:baseUrl];
        NSMutableURLRequest *urlRequest = nil;
        if ([self.requestType isEqualToString:@"POST"])
        {
            urlRequest = [httpRequestSerializer requestWithMethod:self.requestType URLString:requestUrl parameters:params error:&erro];
        }
        else
        {
            [requestUrl appendString:method];
            if (params && [params count] > 0)
            {
                for (NSString *key in [params allKeys])
                {
                    NSString *param = [NSString stringWithFormat:@"&%@=%@",key,[params objectForKey:key]];
                    [requestUrl appendString:param];
                }
                urlRequest = [httpRequestSerializer requestWithMethod:self.requestType URLString:requestUrl parameters:nil error:&erro];
            }
        }
        [urlRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        if (httpHeader && [httpHeader count] > 0)
        {
            for (NSString *key in [httpHeader allKeys])
            {
                NSString *value = [httpHeader objectForKey:key];
                [urlRequest addValue:value forHTTPHeaderField:key];
            }
        }

        [urlRequest setTimeoutInterval:_timeInterval];
        
        AFHTTPRequestOperation *httpRequestOperation = [self.httpRequestOperationManager HTTPRequestOperationWithRequest:urlRequest success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if (success)
            {
                if (responseObject && [responseObject length] > 0)
                {
                    NSError *error;
                    JSONDecoder *jsonPaser = [[JSONDecoder alloc] init];
                    NSDictionary *dict = [jsonPaser objectWithData:responseObject error:&error];

                    NSLog(@"\nmethod=%@ \nparams = %@",method,params);
                    DDLogInfo(@"data=%@\n\n",dict);
                  
                    success(dict);
                }
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if (fail)
            {
                fail(error);
            }
        }];
        [httpRequestOperation start];
    }
}

- (void)uploadDataWithBaseUrl:(NSString *)baseUrl fileUrl:(NSString *)fileUrl params:(NSDictionary *)params httpHeader:(NSDictionary *)httpHeader success:(HttpServerInterfaceBlock)success fail:(HttpServerInterfaceBlock)fail;
{
    AFHTTPRequestOperationManager *httpRequestOperationManager = [AFHTTPRequestOperationManager manager];
    httpRequestOperationManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    for (NSString *key in [httpHeader allKeys])
    {
        [httpRequestOperationManager.requestSerializer setValue:[httpHeader objectForKey:key] forHTTPHeaderField:key];
    }
    
    [httpRequestOperationManager POST:baseUrl parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileURL:[NSURL fileURLWithPath:fileUrl] name:@"file" error:nil];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        EWPLog(@"upload success!!!:%@",responseObject);
        if (success)
        {
            if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
                success(responseObject);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        fail(error);
    }];
}

@end
