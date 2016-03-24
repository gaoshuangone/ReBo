//
//  NSString+GTMBase64.h
//  MemberMarket
//
//  Created by andy on 13-12-3.
//  Copyright (c) 2013年 yiwopai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (GTMBase64)

- (NSString *)encodeBase64String;
- (NSString *)decodeBase64String;

@end
