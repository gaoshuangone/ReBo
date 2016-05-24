//
//  SysytemConfig.m
//  BrandShow
//
//  Created by CaiZetong on 14-10-14.
//  Copyright (c) 2014年 cc. All rights reserved.
//

#import "SystemConfig.h"
#import "AFNetworking.h"

#define APPID           @"910432518"

@implementation SystemConfig


+ (NSString *)appVersion
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *appVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return appVersion;
}

+ (BOOL)isVersion:(NSString *)oldVersion lessthan:(NSString *)newVersion
{
    BOOL result = [oldVersion compare:newVersion options:NSNumericSearch] == NSOrderedAscending;
    return result;
}

+ (void)checkUpdate:(void (^)(BOOL))success failed:(void (^)())failed
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    
    NSString *app_url = [NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@", APPID];
    
    [manager GET:app_url parameters:nil success:^(AFHTTPRequestOperation *operation,id responseObject)
     {
         NSLog(@"Success :%@", responseObject);
         NSArray *infoArray = [responseObject objectForKey:@"results"];
         if ([infoArray count])
         {
             NSDictionary *releaseInfo = [infoArray objectAtIndex:0];
             NSString *lastVersion = [releaseInfo objectForKey:@"version"];
             
             NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
             //CFShow((__bridge CFTypeRef)(infoDic));
             NSString *currentVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
             
             BOOL result = [SystemConfig isVersion:currentVersion lessthan:lastVersion];
             if (success)
             {
                 success(result);
             }
             
         }
     }
         failure:^(AFHTTPRequestOperation *operation,NSError *error)
     {
         NSLog(@"Error = %@",error);
         if (failed)
         {
             failed();
         }
     }];
    
}

@end
