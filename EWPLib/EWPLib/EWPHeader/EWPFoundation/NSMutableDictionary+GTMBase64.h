//
//  NSMutableDictionary+GTMBase64.h
//  MemberMarket
//
//  Created by jiangbin on 13-11-27.
//  Copyright (c) 2013年 yiwopai. All rights reserved.
//

#import <Foundation/Foundation.h>

/*对NSDictionary扩展,对Value值base64编码*/
@interface NSMutableDictionary (GTMBase64)

- (void)setBase64Object:(id)value forKey:(NSString *)key;

- (id)ObjectFromBase64ForKey:(NSString *)key;


@end
